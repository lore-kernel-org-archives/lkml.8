Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C41C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B82020849
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589919171;
	bh=dm7c/PyhRA6o/NhWdeeaUTaSSreTvd7rk1Haxi9PuAY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BaeLt84jeIfXn+CKVfDEBW2ODB2XTiRRQXy9bUgRuzyKJHarRZRu4/VbsgGM4k+DP
	 89rb/5Kyc2lapsTVPicN7cn1ylVsBEINtWxvetEgDObwK6xkFu2v1/LakBj1fR9Aib
	 SduH4tqrHnvfW8DrzpVrelsCDYXnHn+TYcU7Ea3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgESUMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:12:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgESUMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:12:49 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D62D220849
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 20:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589919169;
        bh=dm7c/PyhRA6o/NhWdeeaUTaSSreTvd7rk1Haxi9PuAY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qgobloz2hoqtUhX21QrByAcwSZxXc0hs8LQiA538i0qnV8HKGPry7Al6JMLJCyFhQ
         bQUHqqUnw5PRG4YXJ0UUhssmY4WmTeepxwW3kd4aLnNXk1+R2uWJrBN3JbjFdCNRxL
         Cwh8E7yWcZZkRoY/iniIJhiVNLiM9GxdzINDNE5I=
Received: by mail-wr1-f54.google.com with SMTP id h17so782261wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:12:48 -0700 (PDT)
X-Gm-Message-State: AOAM5301kkeP+UIBF4y2cgpRW3jk0rmbNSWWBLfmy1XoLqDP1IPat4yE
        3fmjtNq1AyJZV4hzH9NAWlOSYm9jECIPgyxsmvYZ+Q==
X-Google-Smtp-Source: ABdhPJzOVtt5Rxab/C2Bm6gUm9YpjP+XGSVEmE/akdzY0RAS3xHV+e5jW0iBi4n8cvPFIdoVsLUhVxtfk2PEObmUdHE=
X-Received: by 2002:adf:a298:: with SMTP id s24mr616360wra.184.1589919167261;
 Tue, 19 May 2020 13:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235125.720736582@linutronix.de>
In-Reply-To: <20200515235125.720736582@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 13:12:35 -0700
X-Gmail-Original-Message-ID: <CALCETrUv0N5Lc2-JVpmw1pXKg0QmZO0yziVZXCVopuCHpzUzug@mail.gmail.com>
Message-ID: <CALCETrUv0N5Lc2-JVpmw1pXKg0QmZO0yziVZXCVopuCHpzUzug@mail.gmail.com>
Subject: Re: [patch V6 13/37] x86/entry: Switch page fault exception to IDTENTRY_RAW
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
> Convert page fault exceptions to IDTENTRY_RAW:
>   - Implement the C entry point with DEFINE_IDTENTRY_RAW
>   - Add the CR2 read into the exception handler
>   - Add the idtentry_enter/exit_cond_rcu() invocations in
>     in the regular page fault handler and use the regular
>     idtentry_enter/exit() for the async PF part.
>   - Emit the ASM stub with DECLARE_IDTENTRY_RAW
>   - Remove the ASM idtentry in 64bit
>   - Remove the CR2 read from 64bit
>   - Remove the open coded ASM entry code in 32bit
>   - Fixup the XEN/PV code
>   - Remove the old prototypes
>

Acked-by: Andy Lutomirski <luto@kernel.org>

although if you make the irq_enter_cond_rcu() mode unconditional, then
this comment can go away too:

> +       /*
> +        * Entry handling for valid #PF from kernel mode is slightly
> +        * different: RCU is already watching and rcu_irq_enter() must not
> +        * be invoked because a kernel fault on a user space address might
> +        * sleep.
> +        *
> +        * In case the fault hit a RCU idle region the conditional entry
> +        * code reenabled RCU to avoid subsequent wreckage which helps
> +        * debugability.
> +        */
> +       rcu_exit = idtentry_enter_cond_rcu(regs);

--Andy
