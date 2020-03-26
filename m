Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8712CC2D0E9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616182083E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I3dsSZ/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgCZTqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:46:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38782 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgCZTqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5Q75xKuG8dNiikuKrJ6gtT2+XtHbO0iF+mSgFEjuqec=; b=I3dsSZ/VC/OCv4Rf0nN5VG8nW8
        HKmro5XNVh59WfmUxeEPZ/wS8t4aUqMHw2+TJs2LszDUeAQZRS18Y/BilQw8+dq0xas1LjFFVnFvw
        iFquPsMHAyCjziniuC7/bNpzhqbCTfLigz6hlc49eXY4xFZuMPc34TQIeOJmuZ1VBD4wGo/z6Dph7
        E19TICePUDuBElBwAwzD/bYa2ht7GYDfmD8KbtIGhM9ThnGraV6RzngBBTD9euLKjDwGDAy5QlH6W
        8UgW5aQrcIRLKWfFS6IZCRzx9yObXh/Hx5I7y5K19S567Zzm0f2CUKdWoJbHRgdRKwkRh6vT58Y2s
        OqT76UeA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHYSB-0003Sv-NO; Thu, 26 Mar 2020 19:46:11 +0000
Date:   Thu, 26 Mar 2020 12:46:11 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Cannon Matthews <cannonmatthews@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Salman Qazi <sqazi@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] mm: clear 1G pages with streaming stores on x86
Message-ID: <20200326194611.GN22483@bombadil.infradead.org>
References: <20200307010353.172991-1-cannonmatthews@google.com>
 <20200309000820.f37opzmppm67g6et@box>
 <20200309090630.GC8447@dhcp22.suse.cz>
 <20200309153831.GK1454533@tassilo.jf.intel.com>
 <20200309183704.GA1573@bombadil.infradead.org>
 <CAJfu=UfPKZwqjGR5AdhFRo_je7X5q2=zpBSBQkrbh2KhYrOJiA@mail.gmail.com>
 <20200311005447.jkpsaghrpk3c4rwu@box>
 <20200316101856.GH11482@dhcp22.suse.cz>
 <20200316121955.tqmhu57evzafc2cl@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316121955.tqmhu57evzafc2cl@box>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 03:19:55PM +0300, Kirill A. Shutemov wrote:
> On Mon, Mar 16, 2020 at 11:18:56AM +0100, Michal Hocko wrote:
> > While this might be true, isn't that easily solveable by the existing
> > ALTERNATIVE and cpu features framework. Can we have a feature bit to
> > tell that movnti is worthwile for large data copy routines. Probably
> > something for x86 maintainers.
> 
> It still need somody to test which approach is better for the CPU.
> See X86_FEATURE_REP_GOOD.

How about inverting the sense of the bit?  Set it on Broadwell-and-
earlier CPUs, where it definitely improves performance by a huge amount,
and new microarches can set it if it still outperforms rep mov?
