Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0D7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE179207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589994797;
	bh=aBnQahn6Rx4syCQPw6nXrqo1bJDUJ1S1WtEdZT9KUVU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qnKRwpwwU0UENtTTLuooBnHTkFEzn4JbbiFnjSvs6Rk5PQRbUMOiclcw/zVpsNsIS
	 3aiQydvt32E11AfvPrA+6y6PwerdPG4SHL587iivbk60GKBfJYqE6GW/wpr9sTb/0S
	 kqsLRAtbbt6aaRWM4nlU42b07Fahw1gDzHhzi84o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgETRNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 13:13:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgETRNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:13:16 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7E162070A
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 17:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589994796;
        bh=aBnQahn6Rx4syCQPw6nXrqo1bJDUJ1S1WtEdZT9KUVU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rn6dTu/QCsIPsOlSXLkiFei4+NqNuuqFItyUj6DdLTF34ZlAaZDFIkQOMJQA7U+Nk
         oqNXL0qad5AFDjx7MV0m86sudtZbzrhw+JDDLoPLfl2W1um0wYcfyZR72QRKOzs63a
         HwcCIMSjA6Bram1Uq1Y2yu4M6c5cm0GG6pnDXEoI=
Received: by mail-wm1-f42.google.com with SMTP id g14so483614wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 10:13:15 -0700 (PDT)
X-Gm-Message-State: AOAM533kyldfMU3mEyYOpGnolM+fIFCPwUHrSp8hpIinXoLFWTDzygA1
        Rw5Z2qsLtfo+HadusBe8IotuUJDVTVo3M/bnmB++fw==
X-Google-Smtp-Source: ABdhPJyqE73tj45GgRcuRENdcBFo/oFYikprLfZkfLqP5QSlvVEuV3i4EoHFUJ9qCHMejxr93zIxieuEnsbiXY8vsqs=
X-Received: by 2002:a1c:9893:: with SMTP id a141mr3075808wme.176.1589994794103;
 Wed, 20 May 2020 10:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235127.996226788@linutronix.de>
 <CALCETrVwTZA6OwrMDhhaNgpkvwsn9ajfuwrfH6xYExvCsFcXjQ@mail.gmail.com> <87lflm4owm.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87lflm4owm.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 20 May 2020 10:13:02 -0700
X-Gmail-Original-Message-ID: <CALCETrVCBMjEZmohRmJ0=F26LjYxyxP0L_x=c68ExGUampVk3g@mail.gmail.com>
Message-ID: <CALCETrVCBMjEZmohRmJ0=F26LjYxyxP0L_x=c68ExGUampVk3g@mail.gmail.com>
Subject: Re: [patch V6 36/37] x86/entry: Move paranoid irq tracing out of ASM code
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

On Wed, May 20, 2020 at 8:17 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Andy Lutomirski <luto@kernel.org> writes:
>
> > On Fri, May 15, 2020 at 5:11 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > I think something's missing here.  With this patch applied, don't we
> > get to exc_debug_kernel() -> handle_debug() without doing
> > idtentry_enter() or equivalent?  And that can even enable IRQs.
> >
> > Maybe exc_debug_kernel() should wrap handle_debug() in some
> > appropriate _enter() / _exit() pair?
>
> I'm the one who is missing something here, i.e. the connection of this
> patch to #DB. exc_debug_kernel() still looks like this:
>
>         nmi_enter_notrace();
>         handle_debug(regs, dr6, false);
>         nmi_exit_notrace();
>
> Confused.
>

Hmm.  I guess the code is correct-ish or at least as correct as it
ever was.  But $SUBJECT says "Move paranoid irq tracing out of ASM
code" but you didn't move it into all the users.  So now the NMI code
does trace_hardirqs_on_prepare() but the #DB code doesn't.  Perhaps
the changelog should mention this.

exc_kernel_debug() is an atrocity.  Every now and then I get started
on cleanup it up and so far I always get mired in the giant amount of
indirection.

So Acked-by: Andy Lutomirski <luto@kernel.org> if you write a credible
changelog.
