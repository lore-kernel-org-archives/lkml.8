Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC727C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE14F20709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589908101;
	bh=ZRQfONnJwtpomVOO8Zd/9FiIEAk/evWtcrThANVc1XQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1OJoCFiG9PD4Ac0h/mYI1hKrV4GrDmYMYSIWCRcSX0ifovFDpbM6eivvHDyel+0Yv
	 tR9VL9DiAy//DKnF50laVhsJ7XbyGpLrztQyg+QweQpIMnyiQiG0u+oAV8LjkkeOMs
	 EmE96VV1NK9ndHutHfwiJX5Vgl9GUstJxOkcKB34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgESRIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 13:08:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729001AbgESRIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 13:08:20 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4CC1207D3
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589908100;
        bh=ZRQfONnJwtpomVOO8Zd/9FiIEAk/evWtcrThANVc1XQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xb11TjnlZYzwFwGJztIHJgDke3Z7j52DBrCf3WxLHIr1Nr8BPK9qsuGct9oWa2OL0
         a5QIVylXbRDRblzzJztzgjLufhuKQipcQAW3pOTukc24QbongMsyKLXK806fxv3zl9
         iw8vRWYYOiH4k1j0HkBWK1ttOs7gzn4orur/4Mjk=
Received: by mail-wm1-f54.google.com with SMTP id w64so4475788wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 10:08:19 -0700 (PDT)
X-Gm-Message-State: AOAM531Is6WEiC2s8/F7w6VwliiUGn0YXSHuCanrSxKf1EtU0hI8F4R5
        USP1qQymK6eeNUjMDd3Q3/W+d6dslr91rQjdvQ1+Ow==
X-Google-Smtp-Source: ABdhPJxQTRDkrcw+mdqNl2stZUTz9TW1dIsEThrOlL9VDryjj5MnX2CjB1hBcJfJBBPNYlJWMPUywRcjAcfzgqD0Abs=
X-Received: by 2002:a1c:2bc2:: with SMTP id r185mr396501wmr.49.1589908098366;
 Tue, 19 May 2020 10:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235125.628629605@linutronix.de>
In-Reply-To: <20200515235125.628629605@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 10:08:06 -0700
X-Gmail-Original-Message-ID: <CALCETrWnkuwvTuJKr8Vuecgr_q+1ReBDrTv4XOqGaw7-ZpEeQQ@mail.gmail.com>
Message-ID: <CALCETrWnkuwvTuJKr8Vuecgr_q+1ReBDrTv4XOqGaw7-ZpEeQQ@mail.gmail.com>
Subject: Re: [patch V6 12/37] x86/entry: Provide idtentry_entry/exit_cond_rcu()
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
> The pagefault handler cannot use the regular idtentry_enter() because that
> invokes rcu_irq_enter() if the pagefault was caused in the kernel. Not a
> problem per se, but kernel side page faults can schedule which is not
> possible without invoking rcu_irq_exit().
>
> Adding rcu_irq_exit() and a matching rcu_irq_enter() into the actual
> pagefault handling code would be possible, but not pretty either.
>
> Provide idtentry_entry/exit_cond_rcu() which calls rcu_irq_enter() only
> when RCU is not watching. The conditional RCU enabling is a correctness
> issue: A kernel page fault which hits a RCU idle reason can neither
> schedule nor is it likely to survive. But avoiding RCU warnings or RCU side
> effects is at least increasing the chance for useful debug output.
>
> The function is also useful for implementing lightweight reschedule IPI and
> KVM posted interrupt IPI entry handling later.

Why is this conditional?  That is, couldn't we do this for all
idtentry_enter() calls instead of just for page faults?  Evil things
like NMI shouldn't go through this path at all.

--Andy
