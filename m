Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B765C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 05:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AA12468A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 05:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="abipDnHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCBFku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 00:40:50 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39495 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBFkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 00:40:49 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so3747768plp.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 21:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=xK54wpBjhhPCKHq5bPwj5L5HDhnV7cO975LXVFh+sqI=;
        b=abipDnHQLnsT57CZbh5HFY4GiofNEy9vpzTYRZZ/Z01qTRmk+sBrOy6HMrtTqzqBDB
         u8nYgzYOB0kHsdC0JB6lcHqVK9jYKmMKb76xzJnVmY3hFFWzUMEXq3oMq35fJBOZcSST
         UUM0AvbBnqKO5frqUtb/4/L5eDq3UyCiInx1AuD+Bhj6PgefKAeQWdEbPA/2LdeSMB16
         O1WwVRfuww+SpIBIc28GOoWbdwbOpLXGH287CDjZm2KuczYMV+s/3YHfj9fV2KyT33xn
         c7bmSmQleMA+dOzUrlnT/mSOPgB1OzvODSgCum8vNK0M9dMXuOnktAbwPChg3wErhumt
         nywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=xK54wpBjhhPCKHq5bPwj5L5HDhnV7cO975LXVFh+sqI=;
        b=Qo0l5jKqvKlugIpTrFBKHRXOyy2GP3exaQ9IUPTGJJhe16C4Z14IuFCJ4ISLR7iCAD
         7IBzUsNfR+9Bx6GENDGRv5ERToPARyNomJBtgKuMLUVvEGq9Dz83/dV9IdMl8G5F4HyK
         W+I4UkvQtW0JI3LfXOD52Y4Yn9jrmSx9045WVuBEQLCQiq2YbbYgXZfjdtg+pD3BNaNX
         9xSRBf+pzZp3MN8F4mqAokr/J8ZQBcDC9WMRzuFvfTiriRT66UQ0ZoUvvV0GZJ/eLKxQ
         hy8kcgrbXM2nJCMY6zT5S1YgNJ08nEg9l2bTs+ak50XytPF0bdtAMClNtDA60zeqVGTC
         wksg==
X-Gm-Message-State: APjAAAUre6duvLUs7EGDlp+3e46+5b9GktEBTVAh81KiRrIReoOlPcPe
        8rhZa5MJCuxx1NQCItoTtyPIQQ==
X-Google-Smtp-Source: APXvYqweIeYYaHNvjBaQyEJRjsvX357u6WJ/NpCPrS6o+VD7pcNxfAxD636xsycGRwy17+KZ1s2S5A==
X-Received: by 2002:a17:90a:8509:: with SMTP id l9mr16517640pjn.43.1583127647605;
        Sun, 01 Mar 2020 21:40:47 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:684d:4af9:90bb:68eb? ([2601:646:c200:1ef2:684d:4af9:90bb:68eb])
        by smtp.gmail.com with ESMTPSA id r10sm16046654pgv.25.2020.03.01.21.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2020 21:40:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 4/8] x86/entry: Move irq tracing on syscall entry to C-code
Date:   Sun, 1 Mar 2020 21:40:44 -0800
Message-Id: <17A440F1-A89D-4CA4-902C-8AE8B73519CF@amacapital.net>
References: <20200302023654.GA211042@google.com>
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
In-Reply-To: <20200302023654.GA211042@google.com>
To:     Joel Fernandes <joel@joelfernandes.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 1, 2020, at 6:36 PM, Joel Fernandes <joel@joelfernandes.org> wrote:=

>=20
> =EF=BB=BFOn Sun, Mar 01, 2020 at 06:18:51PM -0800, Andy Lutomirski wrote:
>>=20
>>=20
>>>> On Mar 1, 2020, at 5:10 PM, Joel Fernandes <joel@joelfernandes.org> wro=
te:
>>>=20
>>> =EF=BB=BFOn Sun, Mar 01, 2020 at 10:54:23AM -0800, Andy Lutomirski wrote=
:
>>>>> On Sun, Mar 1, 2020 at 10:26 AM Paul E. McKenney <paulmck@kernel.org> w=
rote:
>>>>>=20
>>>>> On Sun, Mar 01, 2020 at 07:12:25PM +0100, Thomas Gleixner wrote:
>>>>>> Andy Lutomirski <luto@kernel.org> writes:
>>>>>>> On Sun, Mar 1, 2020 at 7:21 AM Thomas Gleixner <tglx@linutronix.de> w=
rote:
>>>>>>>> Andy Lutomirski <luto@amacapital.net> writes:
>>>>>>>>>> On Mar 1, 2020, at 2:16 AM, Thomas Gleixner <tglx@linutronix.de> w=
rote:
>>>>>>>>>> Ok, but for the time being anything before/after CONTEXT_KERNEL i=
s unsafe
>>>>>>>>>> except trace_hardirq_off/on() as those trace functions do not all=
ow to
>>>>>>>>>> attach anything AFAICT.
>>>>>>>>>=20
>>>>>>>>> Can you point to whatever makes those particular functions special=
?  I
>>>>>>>>> failed to follow the macro maze.
>>>>>>>>=20
>>>>>>>> Those are not tracepoints and not going through the macro maze. See=

>>>>>>>> kernel/trace/trace_preemptirq.c
>>>>>>>=20
>>>>>>> That has:
>>>>>>>=20
>>>>>>> void trace_hardirqs_on(void)
>>>>>>> {
>>>>>>>       if (this_cpu_read(tracing_irq_cpu)) {
>>>>>>>               if (!in_nmi())
>>>>>>>                       trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_=
ADDR1);
>>>>>>>               tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
>>>>>>>               this_cpu_write(tracing_irq_cpu, 0);
>>>>>>>       }
>>>>>>>=20
>>>>>>>       lockdep_hardirqs_on(CALLER_ADDR0);
>>>>>>> }
>>>>>>> EXPORT_SYMBOL(trace_hardirqs_on);
>>>>>>> NOKPROBE_SYMBOL(trace_hardirqs_on);
>>>>>>>=20
>>>>>>> But this calls trace_irq_enable_rcuidle(), and that's the part of th=
e
>>>>>>> macro maze I got lost in.  I found:
>>>>>>>=20
>>>>>>> #ifdef CONFIG_TRACE_IRQFLAGS
>>>>>>> DEFINE_EVENT(preemptirq_template, irq_disable,
>>>>>>>            TP_PROTO(unsigned long ip, unsigned long parent_ip),
>>>>>>>            TP_ARGS(ip, parent_ip));
>>>>>>>=20
>>>>>>> DEFINE_EVENT(preemptirq_template, irq_enable,
>>>>>>>            TP_PROTO(unsigned long ip, unsigned long parent_ip),
>>>>>>>            TP_ARGS(ip, parent_ip));
>>>>>>> #else
>>>>>>> #define trace_irq_enable(...)
>>>>>>> #define trace_irq_disable(...)
>>>>>>> #define trace_irq_enable_rcuidle(...)
>>>>>>> #define trace_irq_disable_rcuidle(...)
>>>>>>> #endif
>>>>>>>=20
>>>>>>> But the DEFINE_EVENT doesn't have the "_rcuidle" part.  And that's
>>>>>>> where I got lost in the macro maze.  I looked at the gcc asm output,=

>>>>>>> and there is, indeed:
>>>>>>=20
>>>>>> DEFINE_EVENT
>>>>>> DECLARE_TRACE
>>>>>>   __DECLARE_TRACE
>>>>>>      __DECLARE_TRACE_RCU
>>>>>>        static inline void trace_##name##_rcuidle(proto)
>>>>>>           __DO_TRACE
>>>>>>              if (rcuidle)
>>>>>>                 ....
>>>>>>=20
>>>>>>> But I also don't see why this is any different from any other tracep=
oint.
>>>>>>=20
>>>>>> Indeed. I took a wrong turn at some point in the macro jungle :)
>>>>>>=20
>>>>>> So tracing itself is fine, but then if you have probes or bpf program=
s
>>>>>> attached to a tracepoint these use rcu_read_lock()/unlock() which is
>>>>>> obviosly wrong in rcuidle context.
>>>>>=20
>>>>> Definitely, any such code needs to use tricks similar to that of the
>>>>> tracing code.  Or instead use something like SRCU, which is OK with
>>>>> readers from idle.  Or use something like Steve Rostedt's workqueue-ba=
sed
>>>>> approach, though please be very careful with this latter, lest the
>>>>> battery-powered embedded guys come after you for waking up idle CPUs
>>>>> too often.  ;-)
>>>>>=20
>>>>=20
>>>> Are we okay if we somehow ensure that all the entry code before
>>>> enter_from_user_mode() only does rcuidle tracing variants and has
>>>> kprobes off?  Including for BPF use cases?
>>>>=20
>>>> It would be *really* nice if we could statically verify this, as has
>>>> been mentioned elsewhere in the thread.  It would also probably be
>>>> good enough if we could do it at runtime.  Maybe with lockdep on, we
>>>> verify rcu state in tracepoints even if the tracepoint isn't active?
>>>> And we could plausibly have some widget that could inject something
>>>> into *every* kprobeable function to check rcu state.
>>>=20
>>> You are talking about verifying that a non-rcuidle tracepoint is not cal=
led
>>> into when RCU is not watching right? I think that's fine, though I feel
>>> lockdep kernels should not be slowed down any more than they already are=
. I
>>> feel over time if we add too many checks to lockdep enabled kernels, the=
n it
>>> becomes too slow even for "debug" kernels. May be it is time for a
>>> CONFIG_LOCKDEP_SLOW or some such? And then anyone who wants to go crazy o=
n
>>> runtime checking can do so. I myself want to add a few.
>>>=20
>>> Note that the checking is being added into "non rcu-idle" tracepoints ma=
ny of
>>> which are probably always called when RCU is watching, making such check=
ing
>>> useless for those tracepoints (and slowing them down however less).
>>>=20
>>=20
>> Indeed. Static analysis would help a lot here.
>>=20
>>> Also another note would be that the whole reason we are getting rid of t=
he
>>> "make RCU watch when rcuidle" logic in DO_TRACE is because it is slow fo=
r
>>> tracepoints that are frequently called into. Another reason to do it is
>>> because tracepoint callbacks are expected to know what they are doing an=
d
>>> turn on RCU watching as appropriate (as consensus on the matter suggests=
).
>>=20
>> Whoa there. We arch people need crystal clear rules as to what tracepoint=
s
>> can be called in what contexts and what is the responsibility of the
>> callbacks.
>>=20
>=20
> The direction that Peter, Mathieu and Steve are going is that callbacks
> registered on "rcu idle" tracepoints need to turn on "RCU watching"
> themselves. Such as perf. Turning on "RCU watching" is non-free as I teste=
d
> in 2017 and we removed it back then, but it was added right back when perf=

> started splatting. Now it is being removed again, and the turning on of RC=
U's
> eyes happens in the perf callback itself since perf uses RCU.
>=20
> If you are calling trace_.._rcuidle(), can you not ensure that RCU is
> watching by calling the appropriate RCU APIs in your callbacks? Or did I m=
iss
> the point?

Unless I=E2=80=99ve misunderstood you, the problem is that the callback and t=
he caller are totally different subsystems. I can count the number of people=
 who know which tracepoints need RCU turned on in their callbacks without us=
ing any fingers (tglx and I are still at least a bit confused=E2=80=94 I=E2=80=
=99m not convinced *anyone* knows for sure).

I think we need some credible rule for which events need special handling in=
 their callbacks, and then we need to ensure that all subsystems that instal=
l callbacks, including BPF, follow the rule.  It should not be up to the aut=
hor of a BPF program to get this right.

>=20
> thanks,
>=20
> - Joel
>=20
