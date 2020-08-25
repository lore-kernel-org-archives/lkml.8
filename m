Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD47C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 740032068F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MNRhKl0q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vNvYriJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbgHYK22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 06:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbgHYK21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:28:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CF6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 03:28:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598351305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XGq27nqRzhydXuYXKqM77GLSeoyVZvew8+Gqoyfxaks=;
        b=MNRhKl0qJ3SryZLP4eRQmYXdz3FaBYrzxO8W2bXu0lWcKc+pTA4/j4AH05VewuixcxT4Bj
        6kjUIAB7SE2EzCnBiVSkqc9aAu5QWjDOGnhGBrGvPncGyM88VwRAboHDAWqsyp58rwHj0D
        w1RNrKqMqMxeSXq/Ze7MfoxILzclWU1OKQBEtbL+NUyMOI7Y2F0afqjqVcWaGa5RfuV370
        UwSPnrv681bmj1Y0juMM6ZYKLFxyB3IqhfX8kNSstLMyfkHTYzjZrL74RVMQZYOctDrr/G
        BOLpIDt43lmfSvOYBZGc6AQ9bQuFpNHFDruXaAbM3m3/aXKiRkCTLzgKYvLsWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598351305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XGq27nqRzhydXuYXKqM77GLSeoyVZvew8+Gqoyfxaks=;
        b=vNvYriJpXxiCcZDhrSzCuVO1860RkEGwRvJ24kUFCEevngTqJUnCmG3IUNU7idOSE/CJ5E
        YWArQe2XGyg95+AA==
To:     Alexander Graf <graf@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        avi@scylladb.com, "Herrenschmidt\, Benjamin" <benh@amazon.com>,
        robketr@amazon.de, amos@scylladb.com
Subject: Re: [patch V9 21/39] x86/irq: Convey vector as argument and not in ptregs
In-Reply-To: <f0079706-4cb3-b3e3-9a5e-97aaba0aa0eb@amazon.com>
References: <20200521200513.656533920@linutronix.de> <20200521202118.796915981@linutronix.de> <f0079706-4cb3-b3e3-9a5e-97aaba0aa0eb@amazon.com>
Date:   Tue, 25 Aug 2020 12:28:24 +0200
Message-ID: <87a6yj58af.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex,

On Mon, Aug 24 2020 at 19:29, Alexander Graf wrote:
> I'm currently trying to understand a performance regression with=20
> ScyllaDB on i3en.3xlarge (KVM based VM on Skylake) which we reliably=20
> bisected down to this commit:
>
>    https://github.com/scylladb/scylla/issues/7036
>
> What we're seeing is that syscalls such as membarrier() take forever=20
> (0-10 =C2=B5s would be normal):
...
> That again seems to stem from a vastly slowed down=20
> smp_call_function_many_cond():
>
> Samples: 218K of event 'cpu-clock', 4000 Hz
> Overhead  Shared Object        Symbol
>    94.51%  [kernel]             [k] smp_call_function_many_cond
>     0.76%  [kernel]             [k] __do_softirq
>     0.32%  [kernel]             [k] native_queued_spin_lock_slowpath
> [...]
>
> which is stuck in
>
>         =E2=94=82     csd_lock_wait():
>         =E2=94=82             smp_cond_load_acquire(&csd->flags, !(VAL &
>    0.00 =E2=94=82       mov    0x8(%rcx),%edx
>    0.00 =E2=94=82       and    $0x1,%edx
>         =E2=94=82     =E2=86=93 je     2b9
>         =E2=94=82     rep_nop():
>    0.70 =E2=94=822af:   pause
>         =E2=94=82     csd_lock_wait():
>   92.82 =E2=94=82       mov    0x8(%rcx),%edx
>    6.48 =E2=94=82       and    $0x1,%edx
>    0.00 =E2=94=82     =E2=86=91 jne    2af
>    0.00 =E2=94=822b9: =E2=86=91 jmp    282
>
>
> Given the patch at hand I was expecting lost IPIs, but I can't quite see=
=20
> anything getting lost.

I have no idea how that patch should be related to IPI and smp function
calls. It's changing the way how regular device interrupts and their
spurious counterpart are handled and not the way how IPIs are
handled. They are handled by direct vectors and do not go through
do_IRQ() at all.

Aside of that the commit just changes the way how the interrupt vector
of a regular device interrupt is stored and conveyed. The extra read and
write on the cache hot stack is hardly related to anything IPI.

Thanks,

        tglx


