Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AACC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 06:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D68246B4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 06:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583131662;
	bh=SiDpeCdDbzUvN9oPIojdN2kmTEqmOZp2IG2xnnVOft8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PRhDQc9IwVkwqyfv4AGr4W3ou+3PsrKtdz0Pf4ldb8/jNnaL+0+l/n5yBMK2OHIco
	 6boS3OJ7DLJ1/rUwbLhp6QlUcXy2Mf7XnQQJj//86hWXB/Ivv6TdjbDFO2M7DAmLG9
	 C4uGzBySGFcG1dpBAkHA/d3DF70X1E0z19rzeUwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCBGrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 01:47:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:52606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgCBGrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 01:47:40 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3999C2468E;
        Mon,  2 Mar 2020 06:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583131660;
        bh=SiDpeCdDbzUvN9oPIojdN2kmTEqmOZp2IG2xnnVOft8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NKjr2d3DxDMLcPJBgA9vJTBKLdy4YP1n78Se5Y9V/IRzObU5ys+SjAk+BNg6bFUBg
         UsUQNWL68Na6zySoskZgDJLpccJWaCR0fPQ4R3c6AiMbcv9jQdm/Sjc6Ha9dZkKZgr
         swofh+c0qWcAJuSwU1Fp2Tubdg/jVZRTrDBm6WNk=
Date:   Mon, 2 Mar 2020 15:47:34 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@amacapital.net>, paulmck@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [patch 4/8] x86/entry: Move irq tracing on syscall entry to
 C-code
Message-Id: <20200302154734.42e538c66261146a6e69f064@kernel.org>
In-Reply-To: <20200301193501.0a850859@oasis.local.home>
References: <20200301193034.GY2935@paulmck-ThinkPad-P72>
        <5BCFDB36-26B6-4881-94D9-4AB0731F8DC5@amacapital.net>
        <20200301193501.0a850859@oasis.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Mar 2020 19:35:01 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 1 Mar 2020 11:39:42 -0800
> Andy Lutomirski <luto@amacapital.net> wrote:
> 
> > > On Mar 1, 2020, at 11:30 AM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > 
> > > ﻿On Sun, Mar 01, 2020 at 10:54:23AM -0800, Andy Lutomirski wrote:  
> > >>> On Sun, Mar 1, 2020 at 10:26 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >>> 
> > >>> On Sun, Mar 01, 2020 at 07:12:25PM +0100, Thomas Gleixner wrote:  
> > >>>> Andy Lutomirski <luto@kernel.org> writes:  
> > >>>>> On Sun, Mar 1, 2020 at 7:21 AM Thomas Gleixner <tglx@linutronix.de> wrote:  
> > >>>>>> Andy Lutomirski <luto@amacapital.net> writes:  
> > >>>>>>>> On Mar 1, 2020, at 2:16 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > >>>>>>>> Ok, but for the time being anything before/after CONTEXT_KERNEL is unsafe
> > >>>>>>>> except trace_hardirq_off/on() as those trace functions do not allow to
> > >>>>>>>> attach anything AFAICT.  
> > >>>>>>> 
> > >>>>>>> Can you point to whatever makes those particular functions special?  I
> > >>>>>>> failed to follow the macro maze.  
> > >>>>>> 
> > >>>>>> Those are not tracepoints and not going through the macro maze. See
> > >>>>>> kernel/trace/trace_preemptirq.c  
> > >>>>> 
> > >>>>> That has:
> > >>>>> 
> > >>>>> void trace_hardirqs_on(void)
> > >>>>> {
> > >>>>>        if (this_cpu_read(tracing_irq_cpu)) {
> > >>>>>                if (!in_nmi())
> > >>>>>                        trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
> > >>>>>                tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
> > >>>>>                this_cpu_write(tracing_irq_cpu, 0);
> > >>>>>        }
> > >>>>> 
> > >>>>>        lockdep_hardirqs_on(CALLER_ADDR0);
> > >>>>> }
> > >>>>> EXPORT_SYMBOL(trace_hardirqs_on);
> > >>>>> NOKPROBE_SYMBOL(trace_hardirqs_on);
> > >>>>> 
> > >>>>> But this calls trace_irq_enable_rcuidle(), and that's the part of the
> > >>>>> macro maze I got lost in.  I found:
> > >>>>> 
> > >>>>> #ifdef CONFIG_TRACE_IRQFLAGS
> > >>>>> DEFINE_EVENT(preemptirq_template, irq_disable,
> > >>>>>             TP_PROTO(unsigned long ip, unsigned long parent_ip),
> > >>>>>             TP_ARGS(ip, parent_ip));
> > >>>>> 
> > >>>>> DEFINE_EVENT(preemptirq_template, irq_enable,
> > >>>>>             TP_PROTO(unsigned long ip, unsigned long parent_ip),
> > >>>>>             TP_ARGS(ip, parent_ip));
> > >>>>> #else
> > >>>>> #define trace_irq_enable(...)
> > >>>>> #define trace_irq_disable(...)
> > >>>>> #define trace_irq_enable_rcuidle(...)
> > >>>>> #define trace_irq_disable_rcuidle(...)
> > >>>>> #endif
> > >>>>> 
> > >>>>> But the DEFINE_EVENT doesn't have the "_rcuidle" part.  And that's
> > >>>>> where I got lost in the macro maze.  I looked at the gcc asm output,
> > >>>>> and there is, indeed:  
> > >>>> 
> > >>>> DEFINE_EVENT
> > >>>>  DECLARE_TRACE
> > >>>>    __DECLARE_TRACE
> > >>>>       __DECLARE_TRACE_RCU
> > >>>>         static inline void trace_##name##_rcuidle(proto)
> > >>>>            __DO_TRACE
> > >>>>               if (rcuidle)
> > >>>>                  ....
> > >>>>   
> > >>>>> But I also don't see why this is any different from any other tracepoint.  
> > >>>> 
> > >>>> Indeed. I took a wrong turn at some point in the macro jungle :)
> > >>>> 
> > >>>> So tracing itself is fine, but then if you have probes or bpf programs
> > >>>> attached to a tracepoint these use rcu_read_lock()/unlock() which is
> > >>>> obviosly wrong in rcuidle context.  
> > >>> 
> > >>> Definitely, any such code needs to use tricks similar to that of the
> > >>> tracing code.  Or instead use something like SRCU, which is OK with
> > >>> readers from idle.  Or use something like Steve Rostedt's workqueue-based
> > >>> approach, though please be very careful with this latter, lest the
> > >>> battery-powered embedded guys come after you for waking up idle CPUs
> > >>> too often.  ;-)  
> > >> 
> > >> Are we okay if we somehow ensure that all the entry code before
> > >> enter_from_user_mode() only does rcuidle tracing variants and has
> > >> kprobes off?  Including for BPF use cases?  
> > > 
> > > That would work, though if BPF used SRCU instead of RCU, this would
> > > be unnecessary.  Sadly, SRCU has full memory barriers in each of
> > > srcu_read_lock() and srcu_read_unlock(), but we are working on it.
> > > (As always, no promises!)
> > >   
> > >> It would be *really* nice if we could statically verify this, as has
> > >> been mentioned elsewhere in the thread.  It would also probably be
> > >> good enough if we could do it at runtime.  Maybe with lockdep on, we
> > >> verify rcu state in tracepoints even if the tracepoint isn't active?
> > >> And we could plausibly have some widget that could inject something
> > >> into *every* kprobeable function to check rcu state.  

I'm still not clear about this point, should I check rcuidle in kprobes
int3 handler or jump optimized handler? (int3 handler will run in
irq context so is not able to use srcu anyway...) Maybe I missed the point.

> > > 
> > > Or just have at least one testing step that activates all tracepoints,
> > > but with lockdep enabled?  
> > 
> > Also kprobe.
> > 
> > I don’t suppose we could make notrace imply nokprobe.  Then all
> > kprobeable functions would also have entry/exit tracepoints, right?
> 
> There was some code before that prevented a kprobe from being allowed
> in something that was not in the ftrace mcount table (which would make
> this happen). But I think that was changed because it was too
> restrictive.

Would you mean CONFIG_KPROBE_EVENTS_ON_NOTRACE? By default notrace
means noprobe too now. With CONFIG_KPROBE_EVENTS_ON_NOTRACE=y, we can
put kprobe events on notrace functions. So if you unsure, we can put
a kprobe on those functions and see what happens.
(Note that this is only for kprobe event, not kprobes itself)

It is actually very restrictive, but it is hard to make a whitelist
maually, especially if the CC_FLAGS_FTRACE is removed while building.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
