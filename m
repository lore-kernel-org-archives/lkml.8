Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBDBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1D362065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="X24JRh3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgENBWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 21:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725943AbgENBWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 21:22:09 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2753FC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 18:22:09 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x10so531397plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 18:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=VD8Mh+Zu25loZd3eIZEvguIOjhQMdb9v1tRfNrEYMdw=;
        b=X24JRh3lPbmUOn1qNM97Jr2bsHZN90c55eYkVyEU+rh0cxeBc1XRL0xUVq3JqffW1/
         qgCSl05s4Ogp8dhbR/JWZ0uOGmjza45j63mMlSyidsSsKMPDrRR2MQcrf0iMmp8nPX0y
         ropTBDRw8y3LNR3h1Z45LbzhHnCzdx56cGLHImg5FWYs0G3oLFWJC/2nQPZCIs59ebDL
         LUqfqFGhKXRNePB9A33fERLEcNXIcUTDWzzsT28NTH8gRTdZS4TunIOM1GQuZQvCnzOW
         TSfSfRnf7Z/Eha6UDk0S4WNV+2cQsx8i4rKrAWD1NK1MP/au5SnvcG+X+yWmgOgNbpus
         EkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=VD8Mh+Zu25loZd3eIZEvguIOjhQMdb9v1tRfNrEYMdw=;
        b=pVvhP+tZ6W+d55rmPfbUNf7WtRmD66UQpBS5Ge6oioY9u+HO/QNvatbV1vO23eFu8y
         KSgznWJgn6eG+WOWNyWXblSrvDggCq0QuHlEaCqxxYmbXcj60xMTAUjcZCtU+EPgc8B2
         VZWeiUxv07C7Noi4nvAqB+Oa6oKFQQLnvTeM8kHrotvw2y94C495RMiHW8IExfw78FUW
         AtQ2ntmeh+bm8MVefXkomjjF1a1WxdQH/xm2lTMxgUQvfrLvMD/oipbhGPelCMxA2myZ
         ZM/uS8h1EMHHTbf7zaRIxAZ1yvJcXWP5wNwh7hFYFbq3ognQMK8CxaijkPx1+gMLSysB
         AgpA==
X-Gm-Message-State: AGi0PuaPd/37V40TLNi1DeOC3DLuBmJkYB3gzz0+gjFHCItnz4X0xSzJ
        DgU4mv6QLq+scQNQ5k3Eq4+7yA==
X-Google-Smtp-Source: APiQypL5Bbjggza8/WuOl8kcrOIQ/wf1rMiD3jDFpF8TQn4zC3rPva8Wc1xsCFoIef4+3rMTEJP0bg==
X-Received: by 2002:a17:90a:f108:: with SMTP id cc8mr38157615pjb.198.1589419328671;
        Wed, 13 May 2020 18:22:08 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:4dac:bfc1:d4fa:716f? ([2601:646:c200:1ef2:4dac:bfc1:d4fa:716f])
        by smtp.gmail.com with ESMTPSA id j13sm16845527pje.1.2020.05.13.18.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 18:22:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [patch V4 part 1 05/36] x86/entry: Flip _TIF_SIGPENDING and _TIF_NOTIFY_RESUME handling
Date:   Wed, 13 May 2020 18:22:05 -0700
Message-Id: <21988538-1533-4C4B-A8B0-B298BC4517BB@amacapital.net>
References: <87v9kzz862.fsf@nanos.tec.linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, paulmck <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <JGross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <87v9kzz862.fsf@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 13, 2020, at 5:12 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> =EF=BB=BFSteven, Mathieu
>=20
> (combo reply)
>=20
> Steven Rostedt <rostedt@goodmis.org> writes:
>> On Wed, 13 May 2020 16:56:41 -0400 (EDT)
>>>> +        /* deal with pending signal delivery */
>>>> +        if (cached_flags & _TIF_SIGPENDING)
>>>> +            do_signal(regs);
>>=20
>> Looking deeper into this, it appears that do_signal() can freeze or kill t=
he
>> task.
>>=20
>> That is, it wont go back to user space here, but simply schedule out (bei=
ng
>> traced) or even exit (killed).
>>=20
>> Before the resume hooks would never be called in such cases, and now they=

>> are.
>=20
> It theoretically matters because pending task work might kill the
> task. That's the concern Andy and Peter had. Assume the following:
>=20
> usermode
>=20
> -> exception
>    set not fatal signal
>=20
>    -> exception
>        queue task work to kill task
>    <- return
>=20
>  <- return
>=20
> The same could happen when the non fatal signal is set from a remote CPU.
>=20
> So in theory that would result in:
>=20
>   handle non fatal signal first
>=20
>   handle task work which kills task
>=20
> which would be the wrong order.
>=20
> But that's just illusion.
>=20
>>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>=20
>>> Also, color me confused: is "do_signal()" actually running any user-spac=
e,
>>> or just setting up the user-space stack for eventual return to signal
>>> handler ?
>=20
> I'm surprised that you can't answer that question yourself. How did you
> ever make rseq work and how did rseq_signal_deliver() end up in
> setup_rt_frame()?
>=20
> Hint: Tracing might answer that question
>=20
> And to cut it short:
>=20
>    Exit to user space happnes only through ONE channel, i.e. leaving
>    prepare_exit_to usermode().
>=20
>      exit_to_usermode_loop <-prepare_exit_to_usermode
>      do_signal <-exit_to_usermode_loop
>      get_signal <-do_signal
>      setup_sigcontext <-do_signal
>      do_syscall_64 <-entry_SYSCALL_64_after_hwframe
>      syscall_trace_enter <-do_syscall_64
>=20
>      sys_rt_sigreturn()
>      restore_altstack <-__ia32_sys_rt_sigreturn
>      syscall_slow_exit_work <-do_syscall_64
>      exit_to_usermode_loop <-do_syscall_64
>=20
>>> Also, it might be OK, but we're changing the order of two things which
>>> have effects on each other: restartable sequences abort fixup for preemp=
tion
>>> and do_signal(), which also have effects on rseq abort.
>>>=20
>>> Because those two will cause the abort to trigger, I suspect changing
>>> the order might be OK, but we really need to think this through.
>=20
> That's a purely academic problem. The order is completely
> irrelevant. You have to handle any order anyway:
>=20
> usermode
>=20
>  -> exception / syscall
>       sets signal
>=20
>   <- return
>=20
>  prepare_exit_to_usemode()
>      cached_flags =3D READ_ONCE(t->flags);
>      exit_to_user_mode_loop(regs, cached_flags) {
>        while (cached_flags) {
>           local_irq_enable();
>=20
>           handle(cached_flags & RESCHED);
>           handle(cached_flags & UPROBE);
>           handle(cached_flags & PATCHING);
>           handle(cached_flags & SIGNAL);
>           handle(cached_flags & NOTIFY_RESUME);
>           handle(cached_flags & RETURN_NOTIFY);
>=20
>           local_irq_disable();
>=20
>           cached_flags =3D READ_ONCE(t->flags);
>         }
>=20
> cached_flag is a momentary snapshot when attempting to return to user
> space.
>=20
> But after reenabling interrupts any of the relevant flag bits can be set
> by an exception/interrupt or from remote. If preemption is enabled the
> task can be scheduled out, migrated at any point before disabling
> interrupts again. Even after disabling interrupts and before re-reading
> cached flags there might be a remote change of flags.
>=20
> That said, even for the case Andy and Peter were looking at (MCE) the
> ordering is completely irrelevant.
>=20
> I should have thought about this before, so thanks to both of you for
> making me look at it again for the very wrong reasons.
>=20
> Consider the patch dropped.

I disagree.

There is only one relevant MCE case: #MC hits user code and tries to recover=
.

Right now, this works via the ist_begin_non_atomic hack. But the series chan=
ges it so that it uses task_work(). So now the kernel ends up in prepare_exi=
t_to_usermode() and the machine check work is pending, but a signal might *a=
lso* be pending due to another CPU setting the bit.

If we process the signal first, we could block on userfaultfd or whatever, a=
nd now we could take forever to finish.

Heck, even with the order changed, we could get preempted, return to another=
 user task, and get a new machine check. Ick.

So I agree that this patch is problematic, and it doesn=E2=80=99t fully fix t=
he problem, but I do believe that the task_work thing is problematic.

Rumor has it that it gets improved a bit farther along in the series, but I=E2=
=80=99m still plodding through.



>=20
> Thanks,
>=20
>        tglx
