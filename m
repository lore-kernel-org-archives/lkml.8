Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0A2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 665A120722
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u+lnrCuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgENM1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725955AbgENM1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:27:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33880C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 05:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aA5M/XpaRV+Oml4TIMxh30lFTbOlhWVBMWNdlNQaq7w=; b=u+lnrCuCpJW0P9fqCJ9vD5pQI7
        ArUpPU4ofZ1iu8SrNSHp6Ml4DI1vQ35tM3hOTouwLdXXr1TJHZeOPX/fzWEzrOjnbSJNJEOWYRd+N
        sET5/QxruF4X2BTxZI9yV2hzPATx0UFz8zjVw6lnO4PczdxYhM5zCWQRa/1JNyzfxCZ/LWwJ1J5Fm
        kxCb+27POcYtNa6GvHpqalqlWHCc1vtQI8PAsM3NCYmEdabrl2OKJDKO9s/V9npNKr7gJjBuPEXBs
        cAuUlu9ZLyYVZ8WZdvyAXwj8Np66bi5VDruaGDz0puo2Aln75wQSR2iD7aD+M3sof5/tt7v0VDXAk
        ayFFRFTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZCxe-00061v-2k; Thu, 14 May 2020 12:27:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A247C301205;
        Thu, 14 May 2020 14:27:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9593E213C8B5D; Thu, 14 May 2020 14:27:35 +0200 (CEST)
Date:   Thu, 14 May 2020 14:27:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200514122735.GW2978@hirez.programming.kicks-ass.net>
References: <CANpmjNNeSnrAgfkskE5Y0NNu3-DS6hk+SwjkBunrr8FRxwwT-Q@mail.gmail.com>
 <20200513111057.GN2957@hirez.programming.kicks-ass.net>
 <CANpmjNMariz3-keqwUsLHVrpk2r7ThLSKtkhHxTDa3SEGeznhA@mail.gmail.com>
 <20200513123243.GO2957@hirez.programming.kicks-ass.net>
 <20200513124021.GB20278@willie-the-truck>
 <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
 <20200513132440.GN2978@hirez.programming.kicks-ass.net>
 <CANpmjNM5dD1VH0hoQwsZYEL=mhWunKwAEJMQgASzHSN019OCnw@mail.gmail.com>
 <20200514112142.GV2978@hirez.programming.kicks-ass.net>
 <20200514120104.GD4280@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514120104.GD4280@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 01:01:04PM +0100, Will Deacon wrote:

> > +#if __has_feature(undefined_sanitizer)
> 
> Hmm, this might want to be __has_feature(undefined_behavior_sanitizer)
> (and damn is that hard for a Brit to type out!)

(I know right, it should be behaviour, dammit!)

I tried without the condition, eg.:

+#define __no_sanitize_undefined \
+               __attribute__((no_sanitize("undefined")))

and it still generated UBSAN gunk.
