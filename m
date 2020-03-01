Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078B3C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 19:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD8B246A1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 19:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="FCHmboGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCATjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 14:39:46 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51976 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgCATjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 14:39:46 -0500
Received: by mail-pj1-f66.google.com with SMTP id fa20so3479876pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 11:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=hSDVMSmzOS7ylOuTZ6FXa1uo871ERa+zxdWp8lSFUCI=;
        b=FCHmboGY7JQ46MxOMdAMl7PP1Fty1OX8yn5WOH93/o0pDocyywe9XaWSPuWSQsHUQx
         w1WW0z0G97FNWT7afasu2BMxbkBeCYm0B/j3GjdaaZ56Rwq+1bd2WA0xL91/bgr1ODw4
         CAswHJzGm/RnfQCFpEcF9ofYwzX8wECUIlgSP3LPfwMA+G4ZgNeyKZ2tMoXLs8OZAJb6
         fvtY3xes48m2wO8uZ29/DrOiJpWcoSbB9R/Red6YMoHJDVnza2QravwHvLWzoLsSyzHj
         cQ7LVujjU7yZnZNTWpoLJXT23s/rQEJLdAm9lL8Exgm/ViRG/jxnCLGoDp6jQZjAd0Sm
         S4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=hSDVMSmzOS7ylOuTZ6FXa1uo871ERa+zxdWp8lSFUCI=;
        b=M+1jmcPTr0WaKqRDievnPq/lIzu9UsqAkOKf8xK3iepMeNv5+T3cH/GvzozFTVRjqZ
         IAlwiTBYJs69tsRXrl/LKxF1kVN/5Kv6igNhpiOfwmp56is594yFpp1deZZRcQjXsRwi
         crj8k6yei4WJCyoLgErvOfpV6d6uJWa0bJo3XEGdLgXf3l3f0NkPXie9jDQD1pe4UDlL
         BD1lSo3lSEtfx2ggGJVxx0pg86AK/9q02ubYNGEsE/Ha2yFJpd798dSbPFfUz3EwGpgQ
         2rezFbDyvehB2WXZkZ8zD/p3nosLDoRoj8oSbDrdTv7wFtoHgEBV5iyGqZB3VndkI54l
         Nbiw==
X-Gm-Message-State: APjAAAVpR54e0/7ZbZyfKKgGRoqACOsNobwS+NhaVu+OJ6VmQiRVoAfV
        Znzv73kmYStLAllqF7nT6pJ+NQ==
X-Google-Smtp-Source: APXvYqy6IrDFaT6UphfmrtcsL64Se1cpfp1uTEhpAXBRArNH3D59k4THkeb18BErLq43ZgBvtc4H4Q==
X-Received: by 2002:a17:902:8bc1:: with SMTP id r1mr14718000plo.279.1583091585459;
        Sun, 01 Mar 2020 11:39:45 -0800 (PST)
Received: from ?IPv6:2600:1010:b069:8a27:f0bb:e3c9:d875:6efc? ([2600:1010:b069:8a27:f0bb:e3c9:d875:6efc])
        by smtp.gmail.com with ESMTPSA id p7sm6126411pfb.135.2020.03.01.11.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2020 11:39:44 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 4/8] x86/entry: Move irq tracing on syscall entry to C-code
Date:   Sun, 1 Mar 2020 11:39:42 -0800
Message-Id: <5BCFDB36-26B6-4881-94D9-4AB0731F8DC5@amacapital.net>
References: <20200301193034.GY2935@paulmck-ThinkPad-P72>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20200301193034.GY2935@paulmck-ThinkPad-P72>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 1, 2020, at 11:30 AM, Paul E. McKenney <paulmck@kernel.org> wrote:
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
>>=20
>> Are we okay if we somehow ensure that all the entry code before
>> enter_from_user_mode() only does rcuidle tracing variants and has
>> kprobes off?  Including for BPF use cases?
>=20
> That would work, though if BPF used SRCU instead of RCU, this would
> be unnecessary.  Sadly, SRCU has full memory barriers in each of
> srcu_read_lock() and srcu_read_unlock(), but we are working on it.
> (As always, no promises!)
>=20
>> It would be *really* nice if we could statically verify this, as has
>> been mentioned elsewhere in the thread.  It would also probably be
>> good enough if we could do it at runtime.  Maybe with lockdep on, we
>> verify rcu state in tracepoints even if the tracepoint isn't active?
>> And we could plausibly have some widget that could inject something
>> into *every* kprobeable function to check rcu state.
>=20
> Or just have at least one testing step that activates all tracepoints,
> but with lockdep enabled?

Also kprobe.

I don=E2=80=99t suppose we could make notrace imply nokprobe.  Then all kpro=
beable functions would also have entry/exit tracepoints, right?=
