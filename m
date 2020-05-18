Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E88BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29C812081A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589843477;
	bh=xX9YfoYmxYyOJ69qH6Ee5gH/4eN27opzhktx1dOtpN4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Rh/gHdOgH1Pt70EzAYXP/h4TIbNnEpSZCqtt1Z7Lu49gbewaAgeCS8MA1kWQfBSJ7
	 Jkan6S2baCcMbBDDKxDtyqmYYRyvkWSrDa4FVDe0+pmoe4GkzBoMGMW6o12fPSUh9Q
	 0P3miYx2WS0TsDQVmzS73CmGyxmMb8ce2oUr5u1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgERXLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 19:11:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgERXLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:11:16 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E807620853
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 23:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589843475;
        bh=xX9YfoYmxYyOJ69qH6Ee5gH/4eN27opzhktx1dOtpN4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y2Xt3Ywkl3reOGb0+wVDlkms4WeBnm5AtvgHqOdRbe62vEPION2XfD+dCxtB1utWU
         0GfEwdnKo5j927pXEQXQTogyv52bI3nj13xo6bmfJGPzY4BqOf2cQ7FCXGs2vMYPUl
         c9cnooKm7gcW8f9jczUF1VDfdTHjm7Bn/GsG34t0=
Received: by mail-wm1-f52.google.com with SMTP id w64so1300041wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:11:14 -0700 (PDT)
X-Gm-Message-State: AOAM5306vMaRRa8Ff9nDBBrdH3Z5KUXUJFvVJwBmKcKWcRzyzEbOc29B
        nUp2QxaVgvU0dpzA3HoHEIca8guAghI8sRsqZja9Gg==
X-Google-Smtp-Source: ABdhPJz2Y7ZIN/8i741vk9CxsJVjuakpnJaR4tu1Pc0Dh1LgQw6wA4CTbBOzqQrAu+lt+BPXQ2pv0M22Fm7OxT9pTWE=
X-Received: by 2002:a05:600c:2299:: with SMTP id 25mr1844040wmf.138.1589843473331;
 Mon, 18 May 2020 16:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235125.110889386@linutronix.de>
In-Reply-To: <20200515235125.110889386@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 18 May 2020 16:11:02 -0700
X-Gmail-Original-Message-ID: <CALCETrXPDAPtWMS6_KX8_GUsnPs1osmFsLokeGYczJwXZisLvg@mail.gmail.com>
Message-ID: <CALCETrXPDAPtWMS6_KX8_GUsnPs1osmFsLokeGYczJwXZisLvg@mail.gmail.com>
Subject: Re: [patch V6 07/37] x86/entry: Provide helpers for execute on irqstack
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 5:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>
> Device interrupt handlers and system vector handlers are executed on the
> interrupt stack. The stack switch happens in the low level assembly entry
> code. This conflicts with the efforts to consolidate the exit code in C to
> ensure correctness vs. RCU and tracing.
>
> As there is no way to move #DB away from IST due to the MOV SS issue, the
> requirements vs. #DB and NMI for switching to the interrupt stack do not
> exist anymore. The only requirement is that interrupts are disabled.
>
> That allows to move the stack switching to C code which simplifies the
> entry/exit handling further because it allows to switch stacks after
> handling the entry and on exit before handling RCU, return to usermode and
> kernel preemption in the same way as for regular exceptions.
>
> The initial attempt of having the stack switching in inline ASM caused too
> much headache vs. objtool and the unwinder. After analysing the use cases
> it was agreed on that having the stack switch in ASM for the price of an
> indirect call is acceptable as the main users are indirect call heavy
> anyway and the few system vectors which are empty shells (scheduler IPI and
> KVM posted interrupt vectors) can run from the regular stack.
>
> Provide helper functions to check whether the interrupt stack is already
> active and whether stack switching is required.
>
> 64 bit only for now. 32 bit has a variant of that already. Once this is
> cleaned up the two implementations might be consolidated as a cleanup on
> top.
>

Acked-by: Andy Lutomirski <luto@kernel.org>

Have you tested by forcing a stack trace from the IRQ stack and making
sure it unwinds all the way out?
