Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159CBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 19:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC7FD20714
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 19:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ccJZoZAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbgFOTpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 15:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgFOTpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 15:45:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732BCC061A0E;
        Mon, 15 Jun 2020 12:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xBOByS3E0Zys2CPBDIgxUeZbWA4Bggf7qnRRJFZDgbg=; b=ccJZoZAJS7S+exDFb7nwytDFaz
        jMY9z+wNIHCwcVBo5f6lLYxF4r+7koFDk5eaZG5VVHJhTUPaIlTz6Rox/3u3g8adfDUPxollIE9bk
        6aKS/j5V2d6yQQAw4RIWYR0kFAGpg2LQmTQwBJp+zg2wj2IqNE3JeYBnzum+14hiJbpkaMw5YVAgO
        I/oXCCZtVNxEqIanK3xz5UJijXZy4KvEPQTWx4Z139hHwvDrYhpbiQHxNImlMbUKxvQe7wa3pF3Lp
        VsaDeRDWqTg5m2uDjj2bwMDN10SSt0YG6tSBMjtH2u10GpD4ukK1VZd4Oa+ZT4Be0tPhIIeL2qtmd
        YutHTJhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkv2S-0008J0-KF; Mon, 15 Jun 2020 19:45:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C9CB3028C8;
        Mon, 15 Jun 2020 21:44:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6724E203D5DB2; Mon, 15 Jun 2020 21:44:58 +0200 (CEST)
Date:   Mon, 15 Jun 2020 21:44:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
Subject: Re: [tip: x86/entry] x86/entry: Treat BUG/WARN as NMI-like entries
Message-ID: <20200615194458.GL2531@hirez.programming.kicks-ass.net>
References: <f8fe40e0088749734b4435b554f73eee53dcf7a8.1591932307.git.luto@kernel.org>
 <159199140855.16989.18012912492179715507.tip-bot2@tip-bot2>
 <20200615145018.GU2531@hirez.programming.kicks-ass.net>
 <CALCETrWhbg_61CTo9_T6s1NDFvOgUx7ebSzhXj7O_m8htePwKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWhbg_61CTo9_T6s1NDFvOgUx7ebSzhXj7O_m8htePwKA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 10:06:20AM -0700, Andy Lutomirski wrote:
> On Mon, Jun 15, 2020 at 7:50 AM Peter Zijlstra <peterz@infradead.org> wrote:

> Hmm.  IMO you're making two changes here, and this is fiddly enough
> that it might be worth separating them for bisection purposes.

Sure, can do.

> > ---
> >
> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > index af75109485c26..a47e74923c4c8 100644
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -218,21 +218,22 @@ static inline void handle_invalid_op(struct pt_regs *regs)
> >
> >  DEFINE_IDTENTRY_RAW(exc_invalid_op)
> >  {
> > -       bool rcu_exit;
> > -
> >         /*
> >          * Handle BUG/WARN like NMIs instead of like normal idtentries:
> >          * if we bugged/warned in a bad RCU context, for example, the last
> >          * thing we want is to BUG/WARN again in the idtentry code, ad
> >          * infinitum.
> >          */
> > -       if (!user_mode(regs) && is_valid_bugaddr(regs->ip)) {
> > -               enum bug_trap_type type;
> > +       if (!user_mode(regs)) {
> > +               enum bug_trap_type type = BUG_TRAP_TYPE_NONE;
> >
> >                 nmi_enter();
> >                 instrumentation_begin();
> >                 trace_hardirqs_off_finish();
> > -               type = report_bug(regs->ip, regs);
> > +
> > +               if (is_valid_bugaddr(regs->ip))
> > +                       type = report_bug(regs->ip, regs);
> > +
> 
> Sigh, this is indeed necessary.

:-)

> >                 if (regs->flags & X86_EFLAGS_IF)
> >                         trace_hardirqs_on_prepare();
> >                 instrumentation_end();
> > @@ -249,13 +250,16 @@ DEFINE_IDTENTRY_RAW(exc_invalid_op)
> >                  * was just a normal #UD, we want to continue onward and
> >                  * crash.
> >                  */
> > -       }
> > +               handle_invalid_op(regs);
> 
> But this is really a separate change.  This makes handle_invalid_op()
> be NMI-like even for non-BUG/WARN kernel #UD entries.  One might argue
> that this doesn't matter, and that's probably right, but I think it
> should be its own change with its own justification.  With just my
> patch, I intentionally call handle_invalid_op() via the normal
> idtentry_enter_cond_rcu() path.

All !user exceptions really should be NMI-like. If you want to go
overboard, I suppose you can look at IF and have them behave interrupt
like when set, but why make things complicated.

Anyway, let me to smaller and proper patches for this.
