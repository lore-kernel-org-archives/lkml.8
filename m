Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C111C18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90E921927
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cdjbkqx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgCIShV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:37:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56394 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbgCIShV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KmL9v01Y7Y0oMfjm6X16Ug0l30XbHRppMW/KHHbJMNA=; b=Cdjbkqx2vXTi3NkkdkaOC1YdIk
        BPAE2As3/CcJO/wmgya6KD8gYMvmqIYf8RlfVbPWhQ6gkulTDjhRac+kQXfPUQzHg6h07xNx18Cwk
        vYlOdFuy96VGd6S9Co90qEWVQRskeKhUnjt+fuMUNEkbT7cbCfh6QWz/hWzHAW1M8BnD3F4YhnDpB
        RHXdgRP1dYUgktpf0FbvcYrYIjYhtchjJoX93/AeoHH2Nr0d2ABpTsliJvd6xGWO+OIs93O51j31F
        oI5wp0fN1Eo0r+heCYT+E2Wek2pLFYbl++PS5NaPKP3PgdWJy6Z29fiybxpSxVAOtp/pDPCtCy2XK
        6sR7w3gQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jBNGy-0004vS-Qe; Mon, 09 Mar 2020 18:37:04 +0000
Date:   Mon, 9 Mar 2020 11:37:04 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Cannon Matthews <cannonmatthews@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Salman Qazi <sqazi@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] mm: clear 1G pages with streaming stores on x86
Message-ID: <20200309183704.GA1573@bombadil.infradead.org>
References: <20200307010353.172991-1-cannonmatthews@google.com>
 <20200309000820.f37opzmppm67g6et@box>
 <20200309090630.GC8447@dhcp22.suse.cz>
 <20200309153831.GK1454533@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309153831.GK1454533@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 08:38:31AM -0700, Andi Kleen wrote:
> > Gigantic huge pages are a bit different. They are much less dynamic from
> > the usage POV in my experience. Micro-optimizations for the first access
> > tends to not matter at all as it is usually pre-allocation scenario. On
> > the other hand, speeding up the initialization sounds like a good thing
> > in general. It will be a single time benefit but if the additional code
> > is not hard to maintain then I would be inclined to take it even with
> > "artificial" numbers state above. There really shouldn't be other downsides
> > except for the code maintenance, right?
> 
> There's a cautious tale of the old crappy RAID5 XOR assembler functions which
> were optimized a long time ago for the Pentium1, and stayed around,
> even though the compiler could actually do a better job.
> 
> String instructions are constantly improving in performance (Broadwell is
> very old at this point) Most likely over time (and maybe even today
> on newer CPUs) you would need much more sophisticated unrolled MOVNTI variants
> (or maybe even AVX-*) to be competitive.

Presumably you have access to current and maybe even some unreleased
CPUs ... I mean, he's posted the patches, so you can test this hypothesis.
