Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB71C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D48420835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591975948;
	bh=1bzFs/3D9de07O+VVT9Y1Exb8KtBe+TWOs5uYgeoTAs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=U/9Yu3HF1oYO9fpYsScnUs6TOh8MNvpjuqz7hWYADr0Uhf3Kg6kJ65mScyFpOoTv3
	 LX/8oyk3gbLnGB5psOW0rg30RqfxKx5F7pS1EAwrOlUvkb1ajINbrSxjfBwyVO5fFa
	 rtQvt3KgEt/LbWifRCf/DIFdyKCag9oGkq6nJz94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgFLPc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:32:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgFLPc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 11:32:27 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DCDB20897
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 15:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591975946;
        bh=1bzFs/3D9de07O+VVT9Y1Exb8KtBe+TWOs5uYgeoTAs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t/BJGapHgyyVp0rAEapRuPoZCWwU9+VAHlCvOKkUD1WLOOAqzV1TofaFn4eixuiTb
         wW3NXMUj+GKBzxbCdX4YvJLIsvoeSS+QqOnELPRBiSDsEFKZYoNTiIMDVR4Lb7YbEc
         HnFDylLPtVaKl7IFOYeDkFzvbeacoITpPU0JARPQ=
Received: by mail-wr1-f46.google.com with SMTP id l10so10149265wrr.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 08:32:26 -0700 (PDT)
X-Gm-Message-State: AOAM533dv1If+7XXGud5apYRVyZwcnS1O2RemzHejlFH3D7sNZaj5z/a
        aSyBIlBzBgjUg5SlvJRa4nYLX2nNtTzDClwLRq8WSA==
X-Google-Smtp-Source: ABdhPJzQB9LssgQGmvqHFwk9xZh2VrVhNFjOs6eTIw1uvdewBQcpNsBpLgMhosfLlEhD0545J0Q0fO+qWejcN9qscNA=
X-Received: by 2002:a5d:49c5:: with SMTP id t5mr15864784wrs.18.1591975944724;
 Fri, 12 Jun 2020 08:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200611235305.GA32342@paulmck-ThinkPad-P72> <CALCETrWo-zpiDsYGtKvm8LzW6CQ5L19a3+Ag_9g8aL4wHaJj9g@mail.gmail.com>
 <871rmkzcc8.fsf@nanos.tec.linutronix.de> <87wo4cxubv.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87wo4cxubv.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 12 Jun 2020 08:32:13 -0700
X-Gmail-Original-Message-ID: <CALCETrUCAeVGQv34bM2TT-KTemYQ6fA2v8JngCKOZCjMCydvug@mail.gmail.com>
Message-ID: <CALCETrUCAeVGQv34bM2TT-KTemYQ6fA2v8JngCKOZCjMCydvug@mail.gmail.com>
Subject: Re: [PATCH x86/entry: Force rcu_irq_enter() when in idle task
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 6:55 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The idea of conditionally calling into rcu_irq_enter() only when RCU is
> not watching turned out to be not completely thought through.
>
> Paul noticed occasional premature end of grace periods in RCU torture
> testing. Bisection led to the commit which made the invocation of
> rcu_irq_enter() conditional on !rcu_is_watching().
>
> It turned out that this conditional breaks RCU assumptions about the idle
> task when the scheduler tick happens to be a nested interrupt. Nested
> interrupts can happen when the first interrupt invokes softirq processing
> on return which enables interrupts. If that nested tick interrupt does not
> invoke rcu_irq_enter() then the nest accounting in RCU claims that this is
> the first interrupt which might mark a quiescient state and end grace
> periods prematurely.
>
> Change the condition from !rcu_is_watching() to is_idle_task(current) which
> enforces that interrupts in the idle task unconditionally invoke
> rcu_irq_enter() independent of the RCU state.
>
> This is also correct vs. user mode entries in NOHZ full scenarios because
> user mode entries bring RCU out of EQS and force the RCU irq nesting state
> accounting to nested. As only the first interrupt can enter from user mode
> a nested tick interrupt will enter from kernel mode and as the nesting
> state accounting is forced to nesting it will not do anything stupid even
> if rcu_irq_enter() has not been invoked.

Acked-by: Andy Lutomirski <luto@kernel.org>
