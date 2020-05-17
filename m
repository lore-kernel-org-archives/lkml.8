Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0383C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 05:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF6B42067D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 05:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589693831;
	bh=Q5JOORAgFjJINGCBacajTvqUgliOjpbJB0rVNrTkx9g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wle9Bqvi8LtKAJhVKvKDaSJ9V7bl0v4fyjP265sK9/ELL9yOs+omtIChFVSg9dwQs
	 yvrcL55xGysQgPOtoVhVUqu+GZnqrTxXftBaUXRsCmyDZfadLnCHEw16NCcoZf90Ro
	 ctAyfUlNYjH9e4XwRWEVgKZxaOcaG8Qcho1uMj6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgEQFhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 01:37:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgEQFhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 01:37:10 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF9D7207F5
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 05:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589693830;
        bh=Q5JOORAgFjJINGCBacajTvqUgliOjpbJB0rVNrTkx9g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EEzGI5OSGU5h+W2756RDp09wHippUuEcC9xLRJN//nAKhepuqaIGXAzl26DN+g7w5
         fUV7cmCV1qwnKGsOFUkD2c3YHPbxGoLX73IMVEbwyv6zVqD9X36I2ZQo7PaB4p2jbT
         5iZ49nJRgktGbYropGbit/4q90e+/X0sb+KlAAyc=
Received: by mail-wr1-f52.google.com with SMTP id l11so8007284wru.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 22:37:09 -0700 (PDT)
X-Gm-Message-State: AOAM531cM8mIAugFSQYV6vB6tLqiNs1bpZ12cPyQakDxPBeNRzApU5IF
        nDfn3ogqtiZ11zc/7LwL5SuPRT76ynE1B5qxkHoamA==
X-Google-Smtp-Source: ABdhPJxabyBe5VXC+uSpFQtBIbsioCXzbDZMAEGm3KRmQf+2eLcttRc6KbfcYsc6itH/XTlQi6c3RSidoOaJo9YIwkI=
X-Received: by 2002:adf:a389:: with SMTP id l9mr12959069wrb.18.1589693828439;
 Sat, 16 May 2020 22:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235124.783722942@linutronix.de>
In-Reply-To: <20200515235124.783722942@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 16 May 2020 22:36:57 -0700
X-Gmail-Original-Message-ID: <CALCETrW2negGYRSQ8dqFVdiWGtYpYf6nKe5_hkotNv0e5mNBxA@mail.gmail.com>
Message-ID: <CALCETrW2negGYRSQ8dqFVdiWGtYpYf6nKe5_hkotNv0e5mNBxA@mail.gmail.com>
Subject: Re: [patch V6 04/37] x86: Make hardware latency tracing explicit
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
> The hardware latency tracer calls into trace_sched_clock and ends up in
> various instrumentable functions which is problemeatic vs. the kprobe
> handling especially the text poke machinery. It's invoked from
> nmi_enter/exit(), i.e. non-instrumentable code.
>
> Use nmi_enter/exit_notrace() instead. These variants do not invoke the
> hardware latency tracer which avoids chasing down complex callchains to
> make them non-instrumentable.
>
> The real interesting measurement is the actual NMI handler. Add an explicit
> invocation for the hardware latency tracer to it.
>
> #DB and #BP are uninteresting as they really should not be in use when
> analzying hardware induced latencies.
>

> @@ -849,7 +851,7 @@ static void noinstr handle_debug(struct
>  static __always_inline void exc_debug_kernel(struct pt_regs *regs,
>                                              unsigned long dr6)
>  {
> -       nmi_enter();
> +       nmi_enter_notrace();

Why can't exc_debug_kernel() handle instrumentation?  We shouldn't
recurse into #DB since we've already cleared DR7, right?
