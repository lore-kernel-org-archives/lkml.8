Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E2EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1580D206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aOxHYxBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgE2IAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgE2IAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:00:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F7BC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z6N+AyF//kWKUxyY54RXv1ce3V0l/RXLH14GaVL9d8U=; b=aOxHYxBiL/Ty9S649/vsGw6Y0P
        iY10FrvXQwRLvHw4+IyGPBPk3BcXLT/7rr4IOI+ljCD4FtYDpvkHlTN2Cz3MkBfOtjo2Zy37W08CC
        wB2zNxFxD5USgi+/LyGh8Q58B+lPZa2JOpAEPqr4d1YO9ieKkHibmdDCDWnWT9KiH3CHKAG+IBLfq
        DlTZTMehshT+kghaINdZ22FG0UupONxTxN12Pal0ZBHZx2e7AEIpYpMnlIFAW2/yuJsgN09gQeTNc
        mi75VXM0EJKZg0czEeCPpBhHXT9nhkfjJj8sRPoRrZ1blaagAlFpWgn1hhIW2XM+p96qU1gQKZFB+
        yboAM+0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeZwV-0001mS-3R; Fri, 29 May 2020 08:00:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2DD8B3069A1;
        Fri, 29 May 2020 10:00:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0D965200895A2; Fri, 29 May 2020 10:00:36 +0200 (CEST)
Date:   Fri, 29 May 2020 10:00:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        andrew.cooper3@citrix.com, daniel.thompson@linaro.org
Subject: Re: [PATCH 0/6] x86/entry: disallow #DB more
Message-ID: <20200529080036.GH706495@hirez.programming.kicks-ass.net>
References: <20200528201937.038455891@infradead.org>
 <CAJhGHyCua-oTww9U26CJvfojxdfQGewH1T-JUro7gLKucT2+kw@mail.gmail.com>
 <20200528224835.GU2483@worktop.programming.kicks-ass.net>
 <CAJhGHyAZVVyQx_3gEtcxF_NaOov4=oR9kN4qO4FAR==hTNa+4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyAZVVyQx_3gEtcxF_NaOov4=oR9kN4qO4FAR==hTNa+4Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 07:05:54AM +0800, Lai Jiangshan wrote:
> On Fri, May 29, 2020 at 6:48 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, May 29, 2020 at 06:42:46AM +0800, Lai Jiangshan wrote:
> > > On Fri, May 29, 2020 at 4:25 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > These patches disallow #DB during NMI/#MC and allow removing a lot of fugly code.
> > > >
> > >
> > > Hello
> > >
> > > Will #DB be allowed in #DF?
> >
> > No, that whole thing is noinstr.
> 
> But it calls many functions, including die(), panic().
> We don't want #DB to interfere how it die() and panic().
> Since it is in fragile #DF, the #DB may mess it up and
> make #DF fails to report and die.

The only recoverable #DF is the ESPFIX shit. If we do not take that,
we're on the way to panic(), I really can't be arsed if you crash the
box before that, we're going to die anyway.
