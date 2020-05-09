Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E0BC47247
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 00:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD72218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 00:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588983026;
	bh=erSdpvEBA/OBZrmfaYKkP+jqxEzq0wGxMfSHU3w7sVQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=n9fkgGdPwbUkiRF3vnldNko+FC3ACE+pBaDqXAatBe6FeqyB4IVfZ5va7/PMesMEk
	 6V/Xb9Ti/iN7x4TIrtFMXPoT1gnD6pFrJipwle4wzv9XDrpJhzc3QvNCH6BY6Qg8EM
	 BQe+XIx5WCFQoseNLYi0PK90GQHdhjAHbVQliTU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgEIAKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 20:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728361AbgEIAKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 20:10:23 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 646BB24967
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 00:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588983022;
        bh=erSdpvEBA/OBZrmfaYKkP+jqxEzq0wGxMfSHU3w7sVQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1qEQFAXwYuggWIen30j4GN1aByRgNZ0uMRePYR8b49xv3+tJ8jnvtW/FhNd19UB6G
         80o0X7JZPrVoYzbw3QJx7O6pmvCkDn2AR9IT2aE4KxId3dv9f0OP4SFr/5E8FaRtU/
         oCg6tVjo3XhV9FVkS02h/BYlQ/nyNLbFJ3voSi+4=
Received: by mail-wm1-f44.google.com with SMTP id u127so12529462wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 17:10:22 -0700 (PDT)
X-Gm-Message-State: AGi0PubXcpZy2wj40qanfSMUxMeQN7DEFeCeg6HHTeIX/SsTroNPAabf
        Mdp0WxI043Cp9Ac5ldf1otqZ37tYMjdQX6qt1d7qxg==
X-Google-Smtp-Source: APiQypJQM9LZdB3eqz0cvhVChsH5letETrciK672WbbZCbkDpOcOSZhpit7wEC539rK+AmI7mUxw6rDxd9eBgWh233g=
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr17996836wmk.36.1588983020820;
 Fri, 08 May 2020 17:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134112.272268764@linutronix.de> <20200505134341.087595319@linutronix.de>
In-Reply-To: <20200505134341.087595319@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 8 May 2020 17:10:09 -0700
X-Gmail-Original-Message-ID: <CALCETrVpSj9fVyUHp-Q_tT-xLgTfYR5JFv52AsOuGJsDYeN3-Q@mail.gmail.com>
Message-ID: <CALCETrVpSj9fVyUHp-Q_tT-xLgTfYR5JFv52AsOuGJsDYeN3-Q@mail.gmail.com>
Subject: Re: [patch V4 part 2 10/18] x86/entry/64: Check IF in
 __preempt_enable_notrace() thunk
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
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 7:14 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The preempt_enable_notrace() ASM thunk is called from tracing, entry code
> RCU and other places which are already in or going to be in the noinstr
> section which protects sensitve code from being instrumented.

This text and $SUBJECT agree that you're talking about
preempt_enable_notrace(), but:

> +       THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace, check_if=1

You actually seem to be changing preempt_schedule_notrace().

The actual code in question has this comment:

/**
 * preempt_schedule_notrace - preempt_schedule called by tracing
 *
 * The tracing infrastructure uses preempt_enable_notrace to prevent
 * recursion and tracing preempt enabling caused by the tracing
 * infrastructure itself. But as tracing can happen in areas coming
 * from userspace or just about to enter userspace, a preempt enable
 * can occur before user_exit() is called. This will cause the scheduler
 * to be called when the system is still in usermode.
 *
 * To prevent this, the preempt_enable_notrace will use this function
 * instead of preempt_schedule() to exit user context if needed before
 * calling the scheduler.
 */

Which is no longer really applicable to x86 -- in the state that this
comment nonsensically refers to as "userspace", x86 *always* has IRQs
off, which means that preempt_enable() will not schedule.

So I'm guessing that the issue you're solving is that we have
redundant preempt disable/enable pairs somewhere in the bowels of
tracing code that is called with IRQs off, and objtool is now
complaining.  Could the actual code in question be fixed to assert
that IRQs are off instead of disabling preemption?  If not, can you
fix the $SUBJECT and changelog and perhaps add a comment to the code
as to *why* you're checking IF?  Otherwise some intrepid programmer is
going to notice it down the road, wonder if it's optimizing anything
useful at all, and get rid of it.
