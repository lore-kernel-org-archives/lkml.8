Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05200C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 02:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C5424697
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 02:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="YqoxAvSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCBCS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 21:18:58 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34446 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgCBCS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 21:18:57 -0500
Received: by mail-pl1-f196.google.com with SMTP id j7so3573789plt.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 18:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=kyo4kbhh23iAcYk7hy9gOFWO01bzwKixpj+i9q2tgto=;
        b=YqoxAvSjjRUoND1kBmgCsMhlNsOVFG/AHQzyxjQB/iuN0//njUMMZhs674kYe0AuLZ
         yhkxukGBbZqpXbnWe9lE/XNvOiHqr7y5mTcPo2QrrFDjc8yXhhA2vRv2l/KuDtQPoJSS
         0NdXu8OkiF4IoiCIBwL69HNiMAWis7s0xphyQi1HMPeK72FH+D+rCDFZu32zsqlzryKb
         58aCb4ouAvS3ecvC2zXaGtYjbjZ+fNw2dVYy67ouw6qvyN3y9IQnN1+QoBDpFyeihiJt
         wLLWlW48jsUjiuUS5fvoLtvNQ/lUd3O8qDK+lhvTRD1ekCXKLLN7txBBjD6+HFKjf256
         SxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=kyo4kbhh23iAcYk7hy9gOFWO01bzwKixpj+i9q2tgto=;
        b=AtP79kTaF6ADrs9wvCpjoRGt1xK1eMl+D/X7j9bJiX2RwG9Zf9W0sDw4LAE5LPo3BL
         xFLdIiIptiS8B0/OH6qcQiPyJyjs9o27Z0DoH8Jwe1U2gzdwIMLlX1V6WNuApjVSiWbA
         oQBYYRWLZ60rGzCOQVh3YaFSewNqxX5O1Dv7mjtMwHfO59w+cZnAjXSy1uIDWKSbrQYi
         2cVxi4/gI7ozSXevRWa3VKkyIlvOnZ3lX03RhwouXvJobfmCtghZc80FMdbK87+U9B9/
         XibZ5zdLo0x/bHFJRrlOrDyNsz11hFiB6jC6ZHSjwrL4hekdDpEJeawcIJGYnqvwZ+an
         Si9w==
X-Gm-Message-State: APjAAAWGOcXLLdPenIp/QOD4ieoemYfRnjwRNKZsJCrLvTLXDHJ7dtKQ
        PDCTBPkB9CZs8NGCt499Ce8pDg==
X-Google-Smtp-Source: APXvYqxuHKFyrb7rC+BLTzSulTPpwKNHGlOUnVt1plQJN+Sg7mkhc65zr49THyPLPerh/EuGJa0kBw==
X-Received: by 2002:a17:902:8b81:: with SMTP id ay1mr14588830plb.275.1583115536430;
        Sun, 01 Mar 2020 18:18:56 -0800 (PST)
Received: from ?IPv6:2600:1010:b069:8a27:f0bb:e3c9:d875:6efc? ([2600:1010:b069:8a27:f0bb:e3c9:d875:6efc])
        by smtp.gmail.com with ESMTPSA id c5sm18456659pfi.10.2020.03.01.18.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2020 18:18:55 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 4/8] x86/entry: Move irq tracing on syscall entry to C-code
Date:   Sun, 1 Mar 2020 18:18:51 -0800
Message-Id: <DC74BDD5-C71D-4083-A13C-BA066C8C56F8@amacapital.net>
References: <20200302011018.GA161499@google.com>
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
In-Reply-To: <20200302011018.GA161499@google.com>
To:     Joel Fernandes <joel@joelfernandes.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 1, 2020, at 5:10 PM, Joel Fernandes <joel@joelfernandes.org> wrote:=

>=20
> =EF=BB=BFOn Sun, Mar 01, 2020 at 10:54:23AM -0800, Andy Lutomirski wrote:
>>> On Sun, Mar 1, 2020 at 10:26 AM Paul E. McKenney <paulmck@kernel.org> wr=
ote:
>>>=20
>>> On Sun, Mar 01, 2020 at 07:12:25PM +0100, Thomas Gleixner wrote:
>>>> Andy Lutomirski <luto@kernel.org> writes:
>>>>> On Sun, Mar 1, 2020 at 7:21 AM Thomas Gleixner <tglx@linutronix.de> wr=
ote:
>>>>>> Andy Lutomirski <luto@amacapital.net> writes:
>>>>>>>> On Mar 1, 2020, at 2:16 AM, Thomas Gleixner <tglx@linutronix.de> wr=
ote:
>>>>>>>> Ok, but for the time being anything before/after CONTEXT_KERNEL is u=
nsafe
>>>>>>>> except trace_hardirq_off/on() as those trace functions do not allow=
 to
>>>>>>>> attach anything AFAICT.
>>>>>>>=20
>>>>>>> Can you point to whatever makes those particular functions special? =
 I
>>>>>>> failed to follow the macro maze.
>>>>>>=20
>>>>>> Those are not tracepoints and not going through the macro maze. See
>>>>>> kernel/trace/trace_preemptirq.c
>>>>>=20
>>>>> That has:
>>>>>=20
>>>>> void trace_hardirqs_on(void)
>>>>> {
>>>>>        if (this_cpu_read(tracing_irq_cpu)) {
>>>>>                if (!in_nmi())
>>>>>                        trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_A=
DDR1);
>>>>>                tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
>>>>>                this_cpu_write(tracing_irq_cpu, 0);
>>>>>        }
>>>>>=20
>>>>>        lockdep_hardirqs_on(CALLER_ADDR0);
>>>>> }
>>>>> EXPORT_SYMBOL(trace_hardirqs_on);
>>>>> NOKPROBE_SYMBOL(trace_hardirqs_on);
>>>>>=20
>>>>> But this calls trace_irq_enable_rcuidle(), and that's the part of the
>>>>> macro maze I got lost in.  I found:
>>>>>=20
>>>>> #ifdef CONFIG_TRACE_IRQFLAGS
>>>>> DEFINE_EVENT(preemptirq_template, irq_disable,
>>>>>             TP_PROTO(unsigned long ip, unsigned long parent_ip),
>>>>>             TP_ARGS(ip, parent_ip));
>>>>>=20
>>>>> DEFINE_EVENT(preemptirq_template, irq_enable,
>>>>>             TP_PROTO(unsigned long ip, unsigned long parent_ip),
>>>>>             TP_ARGS(ip, parent_ip));
>>>>> #else
>>>>> #define trace_irq_enable(...)
>>>>> #define trace_irq_disable(...)
>>>>> #define trace_irq_enable_rcuidle(...)
>>>>> #define trace_irq_disable_rcuidle(...)
>>>>> #endif
>>>>>=20
>>>>> But the DEFINE_EVENT doesn't have the "_rcuidle" part.  And that's
>>>>> where I got lost in the macro maze.  I looked at the gcc asm output,
>>>>> and there is, indeed:
>>>>=20
>>>> DEFINE_EVENT
>>>>  DECLARE_TRACE
>>>>    __DECLARE_TRACE
>>>>       __DECLARE_TRACE_RCU
>>>>         static inline void trace_##name##_rcuidle(proto)
>>>>            __DO_TRACE
>>>>               if (rcuidle)
>>>>                  ....
>>>>=20
>>>>> But I also don't see why this is any different from any other tracepoi=
nt.
>>>>=20
>>>> Indeed. I took a wrong turn at some point in the macro jungle :)
>>>>=20
>>>> So tracing itself is fine, but then if you have probes or bpf programs
>>>> attached to a tracepoint these use rcu_read_lock()/unlock() which is
>>>> obviosly wrong in rcuidle context.
>>>=20
>>> Definitely, any such code needs to use tricks similar to that of the
>>> tracing code.  Or instead use something like SRCU, which is OK with
>>> readers from idle.  Or use something like Steve Rostedt's workqueue-base=
d
>>> approach, though please be very careful with this latter, lest the
>>> battery-powered embedded guys come after you for waking up idle CPUs
>>> too often.  ;-)
>>>=20
>>=20
>> Are we okay if we somehow ensure that all the entry code before
>> enter_from_user_mode() only does rcuidle tracing variants and has
>> kprobes off?  Including for BPF use cases?
>>=20
>> It would be *really* nice if we could statically verify this, as has
>> been mentioned elsewhere in the thread.  It would also probably be
>> good enough if we could do it at runtime.  Maybe with lockdep on, we
>> verify rcu state in tracepoints even if the tracepoint isn't active?
>> And we could plausibly have some widget that could inject something
>> into *every* kprobeable function to check rcu state.
>=20
> You are talking about verifying that a non-rcuidle tracepoint is not calle=
d
> into when RCU is not watching right? I think that's fine, though I feel
> lockdep kernels should not be slowed down any more than they already are. I=

> feel over time if we add too many checks to lockdep enabled kernels, then i=
t
> becomes too slow even for "debug" kernels. May be it is time for a
> CONFIG_LOCKDEP_SLOW or some such? And then anyone who wants to go crazy on=

> runtime checking can do so. I myself want to add a few.
>=20
> Note that the checking is being added into "non rcu-idle" tracepoints many=
 of
> which are probably always called when RCU is watching, making such checkin=
g
> useless for those tracepoints (and slowing them down however less).
>=20

Indeed. Static analysis would help a lot here.

> Also another note would be that the whole reason we are getting rid of the=

> "make RCU watch when rcuidle" logic in DO_TRACE is because it is slow for
> tracepoints that are frequently called into. Another reason to do it is
> because tracepoint callbacks are expected to know what they are doing and
> turn on RCU watching as appropriate (as consensus on the matter suggests).=


Whoa there. We arch people need crystal clear rules as to what tracepoints c=
an be called in what contexts and what is the responsibility of the callback=
s.

>=20
> thanks,
>=20
> - Joel
>=20
