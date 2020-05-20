Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E1BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4671420759
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590016913;
	bh=WwJNj5w/54NjB1ri+DkJJcorVEhoVNcHPfB3LzjxW0E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IzAaGWAcq8g4yEDfl7NEIXuc17WE5WpUBI9TQ+WK/e9Es+lB+y7WSSyEvSNMYKg8J
	 1I3qMYi50zldBe5REdgAAhDv2FnguHqLgNcZJ3A912nupJtv/b7QNep6gCWuxQm+uK
	 NeuWcObNM7oE03Hqc8xI9UA+7/tlb4+RrkEIYQOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgETXVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:21:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728694AbgETXVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:21:50 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EDB820C56
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 23:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590016909;
        bh=WwJNj5w/54NjB1ri+DkJJcorVEhoVNcHPfB3LzjxW0E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wip68iPVRN/1kE7eGetNhcgk3qhXGso1NSPAD3vnVBXMLtFtO2tAErmsPcKdu/ZyU
         9IhXJBRv7wJpLAv3SrE/gnN36uBQyYG9gGE2cdhk3FwQZGiEvs+RmKtIy/gcPUxBIe
         nn9YSl1ykQDYvSb08Xk5aSfXicvNSiOINR11D9qk=
Received: by mail-wm1-f45.google.com with SMTP id u188so4598103wmu.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:21:49 -0700 (PDT)
X-Gm-Message-State: AOAM533Tdun+aq5sQdG4aB2LK0TUEpaZT9eSeqRnMxc4q6EMy1RVIQ5p
        /bHmG8Sb9o26ER7JZTaxepFLGZL+KkBmkS0Z0O+QEA==
X-Google-Smtp-Source: ABdhPJynzyEtBDxtXZsGNmVJtcNhxS+BO9Pf3Crs8l7l7L8Yiqs0lgITY4XiltjeURyPkDKem+4pxrINEGrYoDkMK+8=
X-Received: by 2002:a1c:8141:: with SMTP id c62mr6385044wmd.21.1590016907726;
 Wed, 20 May 2020 16:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235125.425810667@linutronix.de>
 <CALCETrUqK6hv4AuGL=GtK+12TCmr5nBA7CBy=X7TNA=w_Jk0Qw@mail.gmail.com>
 <87imgr7nwp.fsf@nanos.tec.linutronix.de> <CALCETrW4BxfTVzv8mXntNXiAPnKxqdMEv7djUknGZcrno2WJHg@mail.gmail.com>
 <87y2pm4ruh.fsf@nanos.tec.linutronix.de> <CALCETrUvH5DQvL6Lo6EkM04pr7wWj+7eZbTg3H_eLNXcZsH0FA@mail.gmail.com>
 <CALCETrX4Zy2iuc39XTifYd_mvezCEUtW2ax3=ec1TF=yZxAHDg@mail.gmail.com> <871rnewh5w.fsf@nanos.tec.linutronix.de>
In-Reply-To: <871rnewh5w.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 20 May 2020 16:21:36 -0700
X-Gmail-Original-Message-ID: <CALCETrU4xaawDfFkYCLzaEFf3TJ2JTcD3ba_q5jbqhmJQ7qV0A@mail.gmail.com>
Message-ID: <CALCETrU4xaawDfFkYCLzaEFf3TJ2JTcD3ba_q5jbqhmJQ7qV0A@mail.gmail.com>
Subject: Re: [patch V6 10/37] x86/entry: Switch XEN/PV hypercall entry to IDTENTRY
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
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

On Wed, May 20, 2020 at 12:17 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Andy Lutomirski <luto@kernel.org> writes:
> > Andrew Cooper pointed out that there is too much magic in Xen for this
> > to work.  So never mind.
>
> :)
>
> But you made me stare more at that stuff and I came up with a way
> simpler solution. See below.

I like it, but I bet it can be even simpler if you do the
tickle_whatever_paulmck_call_it() change:

> +__visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
> +{
> +       struct pt_regs *old_regs;
> +       bool inhcall;
> +
> +       idtentry_enter(regs);
> +       old_regs = set_irq_regs(regs);
> +
> +       run_on_irqstack(__xen_pv_evtchn_do_upcall, NULL, regs);
> +
> +       set_irq_regs(old_regs);
> +
> +       inhcall = get_and_clear_inhcall();
> +       __idtentry_exit(regs, inhcall);
> +       restore_inhcall(inhcall);

How about:

       inhcall = get_and_clear_inhcall();
       if (inhcall) {
        if (!WARN_ON_ONCE((regs->flags & X86_EFLAGS_IF) || preempt_count()) {
          local_irq_enable();
          cond_resched();
          local_irq_disable();
        }
     }
     restore_inhcall(inhcall);
     idtentry_exit(regs);

This could probably be tidied up by having a xen_maybe_preempt() that
does the inhcall and resched mess.

The point is that, with the tickle_nohz_ stuff, there is nothing
actually preventing IRQ handlers from sleeping as long as they aren't
on the IRQ stack and as long as the interrupted context was safe to
sleep in.

--Andy
