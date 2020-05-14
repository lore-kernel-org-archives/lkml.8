Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0E2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1BF420659
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589417485;
	bh=49N3tnGzYfynuhivy6pFC5ffxFQNIVTg7hv5pYpj+EU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qTTiN0kNteUFGRWNw/YKAzyRB8mrSwEu8ylehA3Ysw5DChRaipJXQsuk43tST8ARP
	 GDST21kPJy5LKFyCuvDGOKnYUtsur0as1fjHU3h6fisgTLtQhIt75+yS14AKw3M/JC
	 N6laEtm9JcFZMRhIex2r7kUsFUt2MOHeWtjuuP2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbgENAvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 20:51:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729581AbgENAvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 20:51:24 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E87832065D
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 00:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589417484;
        bh=49N3tnGzYfynuhivy6pFC5ffxFQNIVTg7hv5pYpj+EU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fWXbc6mjAB1ZwEMpb9Dfq5aEYcQArbyd4kz4PqVvgC88emogqx0HkKzDLJzMgbQYU
         dGt/opfj6F+eQBifN41GKWvB2O3/ojuqCJ8Wy8NzT5XqSpVzQmVnT8Vv6aXsQISyPG
         wBcvZex31mYm/tQ9mLGmvBedhAASxNKVlCuHBCuI=
Received: by mail-wr1-f46.google.com with SMTP id 50so1684758wrc.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:51:23 -0700 (PDT)
X-Gm-Message-State: AOAM530vrVjprKJtBtp+O8IkYKHpjayBQk04MBglySzigexjXuImTsH6
        zbQY9XHxZvzhRZC25V01t9JAIPWiI0uiNynz1YKpVA==
X-Google-Smtp-Source: ABdhPJz1EVZgNOzE7uS6NZJZIoPYL6e9g7OrvHjAPBY7WEEDwRnavZKhqDJZIOB9qnb9qp7VVWizTmjpk5Sf/Iz7vb4=
X-Received: by 2002:adf:a298:: with SMTP id s24mr2213634wra.184.1589417482134;
 Wed, 13 May 2020 17:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134904.457578656@linutronix.de>
 <CALCETrXwuxtZgniJxKZOy5ryqXSbbGMHMBwgEb400Pn9XpynzQ@mail.gmail.com>
 <874ksm7n5d.fsf@nanos.tec.linutronix.de> <CALCETrX6p6o0NJszjon7R8Tb+fFa=Jw5=CQQ56yZi+YVggopiQ@mail.gmail.com>
 <87o8qu5n5l.fsf@nanos.tec.linutronix.de> <875zd15c98.fsf@nanos.tec.linutronix.de>
In-Reply-To: <875zd15c98.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 17:51:10 -0700
X-Gmail-Original-Message-ID: <CALCETrXSySuUs07mQjBTnEo0VFJitO8LXq+mhtfBDkbT8W6cJg@mail.gmail.com>
Message-ID: <CALCETrXSySuUs07mQjBTnEo0VFJitO8LXq+mhtfBDkbT8W6cJg@mail.gmail.com>
Subject: Re: [patch V6 part 3 12/29] x86/entry/common: Provide idtentry_enter/exit()
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

On Tue, May 12, 2020 at 9:50 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Thomas Gleixner <tglx@linutronix.de> writes:
> > Andy Lutomirski <luto@kernel.org> writes:
> >> WARN_ON_ONCE(!on_thread_stack() && (regs->flags & X86_FLAGS_IF) &&
> >> preempt_count() == 0);
> >>
> >> IOW, the actual condition we want is that, if the idtenter_entry/exit
> >> code might schedule or if a cond_local_irq_enable() path might
> >> schedule, we had better be on the correct stack.
> >>
> >> Sorry for causing confusion.
> >
> > Nothing to be sorry about. I could have thought about it myself :)
> > Let me try again.
>
> Move it into the actual preemption condition. Most natural place.

Nice!  This way the logic is clear and the warning will fire even if
no actual preemption occurs.

Acked-by: Andy Lutomirski <luto@kernel.org>
