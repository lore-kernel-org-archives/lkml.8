Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AB6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B694F20829
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589920078;
	bh=JnJNNgYcMhrKz88UBpA/6enF19eGRatiGjSZo+KP/aU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=swKzD3jjuEzsFj98W9JAsYB+1NWLRgUs88CldbQtypb+BYgxasdrN8kxbumM90whj
	 FiEjTT1hrllH9yAbtsJvES+g7Z+R109trcR1S6ZqBlRQvxlnqUVZKz1MXTiJQ3nsBW
	 vFHOql8hSYDWwtMsr1OlJYHLn9dVE/6ESirpDcd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgESU15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:27:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgESU15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:27:57 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DCDF20842
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 20:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589920076;
        bh=JnJNNgYcMhrKz88UBpA/6enF19eGRatiGjSZo+KP/aU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KtKXURiqlf9KNqpSwo/grNL3vSyk7L/h5fq//A0hLNv9Ab0PzA9paYSlcvQVVDJyB
         3WeZW5s+/qbtCXuhoZ5L9U3RirfKvSwnHAzHritxoCwqt5Lbn3hVpGDHBEZ/NDS7KM
         2fV76TIh/MMXIpB4/qqo7g4JIKIvzeoP9wBC9aO8=
Received: by mail-wm1-f42.google.com with SMTP id m185so632233wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:27:56 -0700 (PDT)
X-Gm-Message-State: AOAM532GKahq58luqIyAXRT+XXee/IcLQM3MrL09TKC79O0ZYoSk9Fcm
        BUdBNWyCuS6Zg/nkQhZUynHZs1KQJIw0hxnwmwqQcQ==
X-Google-Smtp-Source: ABdhPJx2KqyKhU0NRQeaUdnyxxhuHiBHdYFrHXGfD1F6LD5nouaESKzvUxVSfxYQ/5AwaARfeG+1Qevz7ezuEHwInS4=
X-Received: by 2002:a1c:2bc2:: with SMTP id r185mr1199978wmr.49.1589920074921;
 Tue, 19 May 2020 13:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235126.522540101@linutronix.de>
In-Reply-To: <20200515235126.522540101@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 13:27:43 -0700
X-Gmail-Original-Message-ID: <CALCETrWNBNCuNv==ZTBom5+X-Wyp+4_tsy=C_at-orv=0H3kuA@mail.gmail.com>
Message-ID: <CALCETrWNBNCuNv==ZTBom5+X-Wyp+4_tsy=C_at-orv=0H3kuA@mail.gmail.com>
Subject: Re: [patch V6 21/37] x86/entry: Add IRQENTRY_IRQ macro
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
> Provide a seperate IDTENTRY macro for device interrupts. Similar to
> IDTENTRY_ERRORCODE with the addition of invoking irq_enter/exit_rcu() and
> providing the errorcode as a 'u8' argument to the C function, which
> truncates the sign extended vector number.

Acked-by: Andy Lutomirski <luto@kernel.org>

with a minor minor optimization suggestion:

> +.macro idtentry_irq vector cfunc
> +       .p2align CONFIG_X86_L1_CACHE_SHIFT
> +SYM_CODE_START_LOCAL(asm_\cfunc)
> +       ASM_CLAC
> +       SAVE_ALL switch_stacks=1
> +       ENCODE_FRAME_POINTER
> +       movl    %esp, %eax
> +       movl    PT_ORIG_EAX(%esp), %edx         /* get the vector from stack */

You could save somewhere between 0 and 1 cycles by using movzbl here...

> +       __##func (regs, (u8)error_code);                                \

And eliminating this cast.  Totally worth it, right?
