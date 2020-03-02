Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABE7C3F2CE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 02:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8484A246B4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 02:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="g3UURMjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgCBCg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 21:36:58 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40128 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgCBCg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 21:36:57 -0500
Received: by mail-qk1-f193.google.com with SMTP id m2so8681714qka.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 18:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qcPTQG2KnQofromzd4MmbJcnvlIptZhM3yjyeDq9A8k=;
        b=g3UURMjSPzN4HUfsWShr2L691CVYAHoPjm0L82y9CeVu62/q3SSn9CT3wwdFgEmSpJ
         xFutzcjB4aC44zY/s8qQ+8CQu8yXpWNwO2yTOGzUzv3qGVTbIl553/vVyLPoR1SokBqM
         GzrbgFacmVIgMS5adEdd2qCZ+/iAS9WbweYj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qcPTQG2KnQofromzd4MmbJcnvlIptZhM3yjyeDq9A8k=;
        b=AZmujImad69Ketk1lWtc4aMEp0VtW1NVWZs9l8S33YFaG/GHPZtmfleNg5uYfZlrQV
         if/0k7Ytm1zxBicQZDgKXR79xip6gmZ9f/Tx8bQ2qlQ5rC4am/w3ZvBFOyszOoDAK69n
         Cb5UJvBAEIJ90/YPvyYcMoe5xTz+vLPJxd3a0Aqsr/hRHCMsrawTtGCqm4848aC6ic+x
         lTN5obfO9wMFl8lp8ZI+LksqvbdMjZ0wkkj2/WCSFeJdhMQuuP8Lmao7ceKsYOsL+9RS
         b+h8GasBVfxK0byB92Up2/+TDDriKGETHyHYg1J5Bjqw4GZeCCYYwP5uDlxiPt62PPbU
         msMw==
X-Gm-Message-State: ANhLgQ1RpHxTtmqDzYC5zhe148ai4vYihhNvz2ikhaHsbwuJBxGtQVR9
        GYGq/i9TYcxoblLEg7DIMvgGDQ==
X-Google-Smtp-Source: ADFU+vta+w6HnSBVFNxaegb3NR8qV4ALQ3m8rNtJlhSrec6y42dc+sCTAYnggReEDXL+SPEKGokjGg==
X-Received: by 2002:a05:620a:806:: with SMTP id s6mr5948549qks.235.1583116614988;
        Sun, 01 Mar 2020 18:36:54 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 11sm9558974qkr.101.2020.03.01.18.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 18:36:54 -0800 (PST)
Date:   Sun, 1 Mar 2020 21:36:54 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 4/8] x86/entry: Move irq tracing on syscall entry to
 C-code
Message-ID: <20200302023654.GA211042@google.com>
References: <20200302011018.GA161499@google.com>
 <DC74BDD5-C71D-4083-A13C-BA066C8C56F8@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DC74BDD5-C71D-4083-A13C-BA066C8C56F8@amacapital.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 06:18:51PM -0800, Andy Lutomirski wrote:
> 
> 
> > On Mar 1, 2020, at 5:10 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > 
> > ﻿On Sun, Mar 01, 2020 at 10:54:23AM -0800, Andy Lutomirski wrote:
> >>> On Sun, Mar 1, 2020 at 10:26 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >>> 
> >>> On Sun, Mar 01, 2020 at 07:12:25PM +0100, Thomas Gleixner wrote:
> >>>> Andy Lutomirski <luto@kernel.org> writes:
> >>>>> On Sun, Mar 1, 2020 at 7:21 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >>>>>> Andy Lutomirski <luto@amacapital.net> writes:
> >>>>>>>> On Mar 1, 2020, at 2:16 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >>>>>>>> Ok, but for the time being anything before/after CONTEXT_KERNEL is unsafe
> >>>>>>>> except trace_hardirq_off/on() as those trace functions do not allow to
> >>>>>>>> attach anything AFAICT.
> >>>>>>> 
> >>>>>>> Can you point to whatever makes those particular functions special?  I
> >>>>>>> failed to follow the macro maze.
> >>>>>> 
> >>>>>> Those are not tracepoints and not going through the macro maze. See
> >>>>>> kernel/trace/trace_preemptirq.c
> >>>>> 
> >>>>> That has:
> >>>>> 
> >>>>> void trace_hardirqs_on(void)
> >>>>> {
> >>>>>        if (this_cpu_read(tracing_irq_cpu)) {
> >>>>>                if (!in_nmi())
> >>>>>                        trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
> >>>>>                tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
> >>>>>                this_cpu_write(tracing_irq_cpu, 0);
> >>>>>        }
> >>>>> 
> >>>>>        lockdep_hardirqs_on(CALLER_ADDR0);
> >>>>> }
> >>>>> EXPORT_SYMBOL(trace_hardirqs_on);
> >>>>> NOKPROBE_SYMBOL(trace_hardirqs_on);
> >>>>> 
> >>>>> But this calls trace_irq_enable_rcuidle(), and that's the part of the
> >>>>> macro maze I got lost in.  I found:
> >>>>> 
> >>>>> #ifdef CONFIG_TRACE_IRQFLAGS
> >>>>> DEFINE_EVENT(preemptirq_template, irq_disable,
> >>>>>             TP_PROTO(unsigned long ip, unsigned long parent_ip),
> >>>>>             TP_ARGS(ip, parent_ip));
> >>>>> 
> >>>>> DEFINE_EVENT(preemptirq_template, irq_enable,
> >>>>>             TP_PROTO(unsigned long ip, unsigned long parent_ip),
> >>>>>             TP_ARGS(ip, parent_ip));
> >>>>> #else
> >>>>> #define trace_irq_enable(...)
> >>>>> #define trace_irq_disable(...)
> >>>>> #define trace_irq_enable_rcuidle(...)
> >>>>> #define trace_irq_disable_rcuidle(...)
> >>>>> #endif
> >>>>> 
> >>>>> But the DEFINE_EVENT doesn't have the "_rcuidle" part.  And that's
> >>>>> where I got lost in the macro maze.  I looked at the gcc asm output,
> >>>>> and there is, indeed:
> >>>> 
> >>>> DEFINE_EVENT
> >>>>  DECLARE_TRACE
> >>>>    __DECLARE_TRACE
> >>>>       __DECLARE_TRACE_RCU
> >>>>         static inline void trace_##name##_rcuidle(proto)
> >>>>            __DO_TRACE
> >>>>               if (rcuidle)
> >>>>                  ....
> >>>> 
> >>>>> But I also don't see why this is any different from any other tracepoint.
> >>>> 
> >>>> Indeed. I took a wrong turn at some point in the macro jungle :)
> >>>> 
> >>>> So tracing itself is fine, but then if you have probes or bpf programs
> >>>> attached to a tracepoint these use rcu_read_lock()/unlock() which is
> >>>> obviosly wrong in rcuidle context.
> >>> 
> >>> Definitely, any such code needs to use tricks similar to that of the
> >>> tracing code.  Or instead use something like SRCU, which is OK with
> >>> readers from idle.  Or use something like Steve Rostedt's workqueue-based
> >>> approach, though please be very careful with this latter, lest the
> >>> battery-powered embedded guys come after you for waking up idle CPUs
> >>> too often.  ;-)
> >>> 
> >> 
> >> Are we okay if we somehow ensure that all the entry code before
> >> enter_from_user_mode() only does rcuidle tracing variants and has
> >> kprobes off?  Including for BPF use cases?
> >> 
> >> It would be *really* nice if we could statically verify this, as has
> >> been mentioned elsewhere in the thread.  It would also probably be
> >> good enough if we could do it at runtime.  Maybe with lockdep on, we
> >> verify rcu state in tracepoints even if the tracepoint isn't active?
> >> And we could plausibly have some widget that could inject something
> >> into *every* kprobeable function to check rcu state.
> > 
> > You are talking about verifying that a non-rcuidle tracepoint is not called
> > into when RCU is not watching right? I think that's fine, though I feel
> > lockdep kernels should not be slowed down any more than they already are. I
> > feel over time if we add too many checks to lockdep enabled kernels, then it
> > becomes too slow even for "debug" kernels. May be it is time for a
> > CONFIG_LOCKDEP_SLOW or some such? And then anyone who wants to go crazy on
> > runtime checking can do so. I myself want to add a few.
> > 
> > Note that the checking is being added into "non rcu-idle" tracepoints many of
> > which are probably always called when RCU is watching, making such checking
> > useless for those tracepoints (and slowing them down however less).
> > 
> 
> Indeed. Static analysis would help a lot here.
> 
> > Also another note would be that the whole reason we are getting rid of the
> > "make RCU watch when rcuidle" logic in DO_TRACE is because it is slow for
> > tracepoints that are frequently called into. Another reason to do it is
> > because tracepoint callbacks are expected to know what they are doing and
> > turn on RCU watching as appropriate (as consensus on the matter suggests).
> 
> Whoa there. We arch people need crystal clear rules as to what tracepoints
> can be called in what contexts and what is the responsibility of the
> callbacks.
> 

The direction that Peter, Mathieu and Steve are going is that callbacks
registered on "rcu idle" tracepoints need to turn on "RCU watching"
themselves. Such as perf. Turning on "RCU watching" is non-free as I tested
in 2017 and we removed it back then, but it was added right back when perf
started splatting. Now it is being removed again, and the turning on of RCU's
eyes happens in the perf callback itself since perf uses RCU.

If you are calling trace_.._rcuidle(), can you not ensure that RCU is
watching by calling the appropriate RCU APIs in your callbacks? Or did I miss
the point?

thanks,

 - Joel

