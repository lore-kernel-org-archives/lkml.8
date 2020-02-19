Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D67EC5ACC4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F20624670
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582150349;
	bh=Edxw1/Xj6IDMQRRULmBb4YHseF9jGQhpofWf9k5TxeE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pL2JUAsTp3T4sWi0dd+cqrWjz8AHrCSkJAvbV6wI0TZrlI8m7+PrHw8j+VONIqDDu
	 N7VAhuAV8Lf0ITAkoo3nDPPvLX89elwzXGHg0ExBLxeFdNv9J5jgDyap5BWd6IjlWb
	 qVquk3JSgSB1IsGghuobwKuYcXL1W+hnEvj6X2E8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgBSWM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 17:12:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:53838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727232AbgBSWM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 17:12:27 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DFC62467E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 22:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582150346;
        bh=Edxw1/Xj6IDMQRRULmBb4YHseF9jGQhpofWf9k5TxeE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fdAQGROs0G4kvMof9V31M9lffdCcs3Dagxfh3LVPbOsVmDlGtla+YkezvbO4iYJp+
         X6tEJehQOEnbt4571mJzKnBGWpJiGnjjjOL8Re6yhyqF9UsbJlDPj94iPgEt2zXz4d
         nEvdIfNQMqBe3gHHVxPHzWeNh+Iz9kEWJUIu5vNk=
Received: by mail-wr1-f52.google.com with SMTP id y11so2380186wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 14:12:26 -0800 (PST)
X-Gm-Message-State: APjAAAXkpqy30HjKqpbEpXV1CuFUgCgLmwdwri8TeX7U5tGP0MpAgvdZ
        VgE0fZa17kAFFd5JBI7hoKFmC77EV5Mo7eza9sYEtg==
X-Google-Smtp-Source: APXvYqw9mumzTmIZKMTrJ8akhQtHuopoTYY+e3SanNp+3VZDeZX8YRgKlahhu91qcNwWHp7w9FySQS8wTxuP8/tMeOc=
X-Received: by 2002:adf:ea85:: with SMTP id s5mr37297631wrm.75.1582150344766;
 Wed, 19 Feb 2020 14:12:24 -0800 (PST)
MIME-Version: 1.0
References: <20200219144724.800607165@infradead.org> <20200219150744.488895196@infradead.org>
 <20200219171309.GC32346@zn.tnic> <CALCETrWBEDjenqze3wVc6TkUt_g+OFx9TQbYysLH+6fku=aWjQ@mail.gmail.com>
 <20200219173358.GP18400@hirez.programming.kicks-ass.net>
In-Reply-To: <20200219173358.GP18400@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 19 Feb 2020 14:12:13 -0800
X-Gmail-Original-Message-ID: <CALCETrVdNCRoToO2-mxhPxO2zaRU6urTffBn7iSTgHaGpB523Q@mail.gmail.com>
Message-ID: <CALCETrVdNCRoToO2-mxhPxO2zaRU6urTffBn7iSTgHaGpB523Q@mail.gmail.com>
Subject: Re: [PATCH v3 02/22] x86,mce: Delete ist_begin_non_atomic()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg KH <gregkh@linuxfoundation.org>, gustavo@embeddedor.com,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 9:34 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Feb 19, 2020 at 09:21:48AM -0800, Andy Lutomirski wrote:
> > On Wed, Feb 19, 2020 at 9:13 AM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > On Wed, Feb 19, 2020 at 03:47:26PM +0100, Peter Zijlstra wrote:
> > > > Subject: Re: [PATCH v3 02/22] x86,mce: Delete ist_begin_non_atomic()
> > >
> > > x86/mce: ...
> > >
> > > > It is an abomination; and in prepration of removing the whole
> > > > ist_enter() thing, it needs to go.
> > > >
> > > > Convert #MC over to using task_work_add() instead; it will run the
> > > > same code slightly later, on the return to user path of the same
> > > > exception.
> > >
> > > That's fine because the error happened in userspace.
> >
> > Unless there is a signal pending and the signal setup code is about to
> > hit the same failed memory.  I suppose we can just treat cases like
> > this as "oh well, time to kill the whole system".
> >
> > But we should genuinely agree that we're okay with deferring this handling.
>
> It doesn't delay much. The moment it does that local_irq_enable() it's
> subject to preemption, just like it is on the return to user path.
>
> Do you really want to create code that unwinds enough of nmi_enter() to
> get you to a preemptible context? *shudder*

Well, there's another way to approach this:

void notrace nonothing do_machine_check(struct pt_regs *regs)
{
  if (user_mode(regs))
    do_sane_machine_check(regs);
  else
    do_awful_machine_check(regs);
}

void do_sane_machine_check(regs)
{
  nothing special here.  just a regular exception, more or less.
}

void do_awful_macine_check(regs)
{
  basically an NMI.  No funny business, no recovery possible.
task_work_add() not allowed.
}

Or, even better, depending on how tglx's series shakes out, we could
build on this patch:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/idtentry&id=ebd8303dda34ea21476e4493cee671d998e83a48

and actually have two separate do_machine_check entry points.  So we'd
do, roughly:

idtentry_ist ... normal_stack_entry=do_sane_machine_check
ist_stack_entry=do_awful_machine_check

and now there's no chance for confusion.

All of the above has some issues when Tony decides that he wants to
recover from specially annotated recoverable kernel memory accesses.
Then task_word_add() is a nonstarter, but the current
stack-switch-from-usermode *also* doesn't work.  I floated the idea of
also doing the stack switch if we come from an IF=1 context, but
that's starting to get nasty.

One big question here: are memory failure #MC exceptions synchronous
or can they be delayed?   If we get a memory failure, is it possible
that the #MC hits some random context and not the actual context where
the error occurred?

I suppose the general consideration I'm trying to get at is: is
task_work_add() actually useful at all here?  For the case when a
kernel thread does memcpy_mcsafe() or similar, task work registered
using task_work_add() will never run.

--Andy
