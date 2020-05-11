Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B6CC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C49B206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589211097;
	bh=gSFwgi6KRNOf6GXeGdW9MNXB6P4io37niSrrQMmZOVA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=t+r/aAvDxOjers50TV0v2P9L1/hAw/64voPWP8zMJtD0KYKCJ+XLB5YXi6xp9DjoY
	 /yU1sOq9CP0TIF+GyuV/ZqPqlGuzyH0DtATRxx7jTcQIlXc2pJ1etZ1yNqGqnjmcdb
	 px9wUB4a4Cla6IM2HWWylFrJsQ4NbFb98RUFyzdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbgEKPbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:31:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727019AbgEKPbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:31:36 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 555D220722
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 15:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589211095;
        bh=gSFwgi6KRNOf6GXeGdW9MNXB6P4io37niSrrQMmZOVA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jES46bsxQhNuWgu9nt3PSsoehA/8Ww43cjESs9Weung5mg3SY7yHvdoMQ+pvWBMiX
         5nLI29a8ojfwZBxxNnnYpAI7Vnher8EnHkaJxokzchnPnASIxBzGpJW5Qe79znCeUz
         DnzA8arCY4gUTBZSipwlGJRDmuDRIBaeYmYBz64w=
Received: by mail-wm1-f50.google.com with SMTP id g14so7139651wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:31:35 -0700 (PDT)
X-Gm-Message-State: AGi0PuYNum0UgmQLuvi2DRfHQGnZEN4vumdgVvT/yrReC6xhAZM/vEqQ
        TObtSZNS7pHNZriq00CKgRpvhWIT/i/25piVkRTE4A==
X-Google-Smtp-Source: APiQypLkWQv937HjGWl7ohAEq4ql5ydjQobOuLsHlzx87rge3rk+D7KiOlkKTAdtLocRQqkPs0rAdRCu+utc7TJQgGU=
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr31085022wmk.36.1589211093752;
 Mon, 11 May 2020 08:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134904.457578656@linutronix.de>
 <CALCETrXwuxtZgniJxKZOy5ryqXSbbGMHMBwgEb400Pn9XpynzQ@mail.gmail.com> <874ksm7n5d.fsf@nanos.tec.linutronix.de>
In-Reply-To: <874ksm7n5d.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 11 May 2020 08:31:22 -0700
X-Gmail-Original-Message-ID: <CALCETrX6p6o0NJszjon7R8Tb+fFa=Jw5=CQQ56yZi+YVggopiQ@mail.gmail.com>
Message-ID: <CALCETrX6p6o0NJszjon7R8Tb+fFa=Jw5=CQQ56yZi+YVggopiQ@mail.gmail.com>
Subject: Re: [patch V5 part 3 12/29] x86/entry/common: Provide idtentry_enter/exit()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
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
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 3:59 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Andy Lutomirski <luto@kernel.org> writes:
> >> + * Invoked by all exception/interrupt IDTENTRY handlers which are not
> >> + * returning through the paranoid exit path (all except NMI, #DF and the IST
> >> + * variants of #MC and #DB).
> >

> +void noinstr idtentry_exit(struct pt_regs *regs)
> +{
> +       lockdep_assert_irqs_disabled();
> +
> +       if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
> +               WARN_ON_ONCE(!on_thread_stack());

Whoops.  After sleeping on this, this is obviously wrong.  If this is
something like a page fault, we can be on an IST or IRQ stack.
Perhaps the actual condition should be:

WARN_ON_ONCE(!on_thread_stack() && (regs->flags & X86_FLAGS_IF) &&
preempt_count() == 0);

IOW, the actual condition we want is that, if the idtenter_entry/exit
code might schedule or if a cond_local_irq_enable() path might
schedule, we had better be on the correct stack.

Sorry for causing confusion.
