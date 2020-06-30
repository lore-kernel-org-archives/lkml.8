Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B1AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F2720774
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zg1PSEX9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+zw99FP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733281AbgF3MBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:01:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54974 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732746AbgF3MBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:01:02 -0400
X-Greylist: delayed 5913 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jun 2020 08:01:02 EDT
Date:   Tue, 30 Jun 2020 14:00:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593518461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qgnrybG2OslXjy+mHoLg62UfvNjCsSTc6swzuIPA9nA=;
        b=Zg1PSEX9eAg0idNefX0ymPyDemrl7pZ1V/pqk2wD2wPT0Gd6gN7h/HTZ6Z0puEgyBs819Y
        2CO0SZoNgvpujfod/iS+cjnyNW/iQIRJysaJYniWBcy9IAVmWwgYYl86N7MW05RJbaJMgR
        r3Dvw9cRspfz86I7dMsEcgNBrpgdqfwpTHvoOks4IyDsgKpvzFZ2TvzCFbrGeodzI8esPz
        yUCbbINqvUtisoQuL7fl2brJmsUkn6vGrCVEUPRCp4fr9vjbfqKTfgeVsR5BmWpcMy/Z78
        BX6COTlos7H3xvLrnj9B7OIHgExbjF4nI5Oh9zasyZffUD+gg6jL8hM6T3v9Dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593518461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qgnrybG2OslXjy+mHoLg62UfvNjCsSTc6swzuIPA9nA=;
        b=+zw99FP6yn6lVWbVXm8eHgddaRlE6EMcvP7b0alytqiVcGdcVigVWGm0CNaRmPgCGlsiSx
        sJdE3Mzaks1vxhAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin " <hpa@zytor.com>
Subject: Re: [PATCH 1/2] x86/entry: Use should_resched() in
 idtentry_exit_cond_resched()
Message-ID: <20200630120059.x5p6uh4hzgqrgwuo@linutronix.de>
References: <20200630102209.1143072-1-bigeasy@linutronix.de>
 <20200630102209.1143072-2-bigeasy@linutronix.de>
 <20200630111012.GM4800@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200630111012.GM4800@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-30 13:10:12 [+0200], Peter Zijlstra wrote:
> > --- a/arch/x86/entry/common.c
> > +++ b/arch/x86/entry/common.c
> > @@ -612,13 +612,12 @@ bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs)
> >  
> >  static void idtentry_exit_cond_resched(struct pt_regs *regs, bool may_sched)
> >  {
> > -	if (may_sched && !preempt_count()) {
> > +	if (may_sched && should_resched(0)) {
> >  		/* Sanity check RCU and thread stack */
> >  		rcu_irq_exit_check_preempt();
> >  		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
> >  			WARN_ON_ONCE(!on_thread_stack());
> 
> This was done on purpose, your change avoids hitting this WARN.
> 
> The thing is, if we could preempt (but not nessecarily have to) we want
> to validate we're on the thread stack.

Okay then.

Sebastian
