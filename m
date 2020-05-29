Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E335AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 22:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B95AE2065F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 22:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="As730tVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgE2WZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 18:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbgE2WZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 18:25:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969B9C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 15:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EAQtx8ywsa1fD3NzR5GGh84KBN25dRPzifCzFwNJPHg=; b=As730tVrSxRaA4+GmFkdcV2jjs
        NYY/O9CQTWtgXX9qmY1htY15TQzkzZTQ0GBVCvJdhczJzB0ddXR1WgkMDtRZOWooLXksiOaQTQnz1
        EHcYOcupzgUdd4NXhXwJ7k8jDF53Egc0V6M3MAmVzFa9DBXccMEtw5v0HgDlpd+FXjrzm0SWb7xSJ
        71ZqIzkQN0vc8I5mtmokVhHLwq4L9DyZozQF6bkaAgeFU+oT1VaQIt1H+xAZ/JvtcbzVCp7bg9yVe
        a6aaKdQQeXZ5Pppn2jqEESr0wnLzbFTTVgEs+XoWwLzOEnh67x7S5i1udGgZCZ6N2E2QhxN0RPMuD
        Oi/8EnBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jenR6-0008Dt-7v; Fri, 29 May 2020 22:25:08 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B46089834CF; Sat, 30 May 2020 00:25:05 +0200 (CEST)
Date:   Sat, 30 May 2020 00:25:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, luto@amacapital.net,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, andrew.cooper3@citrix.com,
        daniel.thompson@linaro.org, a.darwish@linutronix.de,
        bigeasy@linutronix.de
Subject: Re: [PATCH 13/14] lockdep: Prepare for NMI IRQ state tracking
Message-ID: <20200529222505.GW2483@worktop.programming.kicks-ass.net>
References: <20200529212728.795169701@infradead.org>
 <20200529213321.471984676@infradead.org>
 <20200529181401.1f01bdc5@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529181401.1f01bdc5@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 06:14:01PM -0400, Steven Rostedt wrote:
> On Fri, 29 May 2020 23:27:41 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > There is no reason not to always, accurately, track IRQ state.
> > 
> > This change also makes IRQ state tracking ignore lockdep_off().
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/locking/lockdep.c |   33 ++++++++++++++++++++++++++++++---
> >  1 file changed, 30 insertions(+), 3 deletions(-)
> > 
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -3646,7 +3646,13 @@ static void __trace_hardirqs_on_caller(v
> >   */
> >  void lockdep_hardirqs_on_prepare(unsigned long ip)
> >  {
> > -	if (unlikely(!debug_locks || current->lockdep_recursion))
> 
> Why remove the check for debug_locks? Isn't that there to disable
> everything at once to prevent more warnings to be printed?

Yeah, maybe. I was thinking we could keep IRQ state running. But you're
right, if we mess up the IRQ state itself this might generate a wee
mess.

> Also, isn't there other ways that we could have recursion besides NMIs?
> Say we do a printk inside here, or call something that may also enable
> interrupts? I thought the recursion check was also to prevent lockdep
> infrastructure calling something that lockdep monitors being a problem?
> 
> Or am I missing something?

> > +	/*
> > +	 * NMIs do not (and cannot) track lock dependencies, nothing to do.
> > +	 */
> > +	if (in_nmi())
> > +		return;
> > +
> > +	if (DEBUG_LOCKS_WARN_ON(current->lockdep_recursion & LOCKDEP_RECURSION_MASK))
> >  		return;

^^ there's your regular recursion check.
