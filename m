Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2169AC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 05:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3402206B1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 05:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m79lNpOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgCOFyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 01:54:25 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45336 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgCOFyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 01:54:25 -0400
Received: by mail-qt1-f195.google.com with SMTP id z8so7987213qto.12
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 22:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P0PhmrWeYl62ooXY9u66tmOzjBc59eyH8e2oVcv2a7c=;
        b=m79lNpOHHSDx2lT8mnquQ6YULXxg+AAU5CS/1Ja4BZcXjEpRk6VIsXEOHcO5Vm/MbH
         K+U8Q9CB5VtkIzKLZSTvDpS/neXNWJhTRtqZM7yAADKbttr3jLeqrSzO0yJDuIHg0R41
         h1ayMebv1ZYhCdsoqszPFGUHYqiPX9n9bVwde0LxD2YacQe/M92lLF/b960b5nmbUort
         h7Jbn7U+oYbkCI7q98Uz+SeKCescRgiH0OnjUB+LhJT5TCaID6JhVVMbzlPl1RWrgnL0
         TbkZY8/1w30H02Im67KcMjiv9b+82TtYFu1pdTZdeVgQ/rcjLFBhSzhJU8TTxUorD1QQ
         kHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P0PhmrWeYl62ooXY9u66tmOzjBc59eyH8e2oVcv2a7c=;
        b=gN9Wgbjz5XVXctqnnN26iwXrDqoYHXQPIBVerWTl70PRs68Gm5CecKW+pjsKSoorlF
         ueiTGty5oZBFcovd1Qj6rSNEdAwae8vAv2+Caf+kyual+EIiyZnkSmjxhj3VXrgvcEOT
         DfhyhRHV8ZYK/Odl8i4l1Unwqlh1vZwWJNNv4U2SoxHmQy9SOReEiRNruJ00bbh/smG5
         9URdnSf+avYxWEznFYc6ottLphiklOenlPAzqRQP6xEP+fBK1vhzjuh6DcQo+wB6r4U1
         2/Wqkc43m3BbWF9bAlXW9TWnmVsgw9SAnlUH/hekv33x7D34Iml6bPQN9ME7900SxvD0
         JMpQ==
X-Gm-Message-State: ANhLgQ0d2ajQDDKVvtyzNnnY96R7W/I42UQWFoCLgx270+yKNHktN/H3
        tuSLOhzQSrsNA62+5fx2AJc/HPmLBVwcyrTeZ4FmfA==
X-Google-Smtp-Source: ADFU+vuLS+MRFOI4yDq1e0EY5BK/oeTo7K7UN2ogG5TWl9GMUgjO84Bth010w/kG+V2wEOGKmtnt1vyUKwuuEIGW+3E=
X-Received: by 2002:ac8:6697:: with SMTP id d23mr19728067qtp.257.1584251661560;
 Sat, 14 Mar 2020 22:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200307135822.3894-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <6f2e27de-c820-7de3-447d-cd9f7c650add@suse.com> <20200308065258.GE3983392@kroah.com>
 <3e9f47f7-a6c1-7cec-a84f-e621ae5426be@suse.com> <CACT4Y+a6KExbggs4mg8pvoD554PcDqQNW4sM15X-tc=YONCzYw@mail.gmail.com>
 <20200311101115.53139149@gandalf.local.home> <CACT4Y+Z5co4HyQBj6-uUdqT2Vk=6jgT-aQXuPtjx3qV4C_pZ7g@mail.gmail.com>
 <7e0d2bbf-71c2-395c-9a42-d3d6d3ee4fa4@i-love.sakura.ne.jp> <20200312182935.70ed6516@gandalf.local.home>
In-Reply-To: <20200312182935.70ed6516@gandalf.local.home>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 15 Mar 2020 06:54:10 +0100
Message-ID: <CACT4Y+Zg4nCUrXnLXtBeaPRiBNp9XZqNzMnxGzzNEQ8n+h16wA@mail.gmail.com>
Subject: Re: [PATCH v2] Add kernel config option for fuzz testing.
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 11:29 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 13 Mar 2020 06:59:22 +0900
> Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> > On 2020/03/13 4:23, Dmitry Vyukov wrote:
> > >> Or teach the fuzz tool not to do specific bad things.
> > >
> > > We do some of this.
> > > But generally it's impossible for anything that involves memory
> > > indirections, or depends on the exact type of fd (e.g. all ioctl's),
> > > etc. Boils down to halting problem and ability to predict exact
> > > behavior of arbitrary programs.
> >
> > I would like to enable changes like below only if CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING=y .
> >
> > Since TASK_RUNNING threads are not always running on CPUs (in syzbot, the kernel is
> > tested on a VM with only 2 CPUs, which means that many threads are simply waiting for
> > CPU time to be assigned), dumping locks held by all threads gives us more clue when
> > e.g. khungtask fired. But since lockdep_print_held_locks() is racy, I assume that
> > this change won't be accepted unless CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING=y .
> >
> > Also, for another example, limit number of memory pages /dev/ion driver can consume only if
> > CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING=y ( https://github.com/google/syzkaller/issues/1267 ),
> > for limiting number of memory pages is a user-visible change while we need to avoid false
> > alarms caused by consuming all memory pages.
> >
> > In other words, while majority of things CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING=y would
> > do "disable this", there would be a few "enable this" and "change this".
>
> I still fear that people will just disable large sections. I've seen this
> before. Developers take the easy way out, and when someone adds a new
> feature that may be dangerous, they will just say "oh turn off fuzzing" and
> be done with it.
>
> As Linus likes to say, when you need to make changes to the kernel to test
> it, you are no longer testing production kernels.


Well, it's tradeoffs all the way down.
For example, KASAN also radically affects the kernel (changes just
every line of code). There still should be final testing of the actual
production build of course. But I would say generally one wants to
test with KASAN enabled all the time.
Or, it also depends on the baseline. If our baseline is "everybody is
crazy about testing, ready to prioritize it on top of everything else
and spend infinite amounts of time on it", then there may be better
solutions. But if our baseline is "no testing at all", or "we have to
disable whole subsystems b/c we don't have better realistic options
and only few people willing to spend at least some time on it", then
it may be a good practical solution ;)


> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index 32406ef0d6a2..1bc7878768fc 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -695,6 +695,7 @@ static void print_lock(struct held_lock *hlock)
> >  static void lockdep_print_held_locks(struct task_struct *p)
> >  {
> >       int i, depth = READ_ONCE(p->lockdep_depth);
> > +     bool unreliable;
> >
> >       if (!depth)
> >               printk("no locks held by %s/%d.\n", p->comm, task_pid_nr(p));
> > @@ -705,10 +706,12 @@ static void lockdep_print_held_locks(struct task_struct *p)
> >        * It's not reliable to print a task's held locks if it's not sleeping
> >        * and it's not the current task.
> >        */
> > -     if (p->state == TASK_RUNNING && p != current)
> > -             return;
> > +     unreliable = p->state == TASK_RUNNING && p != current;
> >       for (i = 0; i < depth; i++) {
> > -             printk(" #%d: ", i);
> > +             if (unreliable)
> > +                     printk(" #%d?: ", i);
> > +             else
> > +                     printk(" #%d: ", i);
>
> Have you tried submitting this? Has Peter nacked it?
>
> -- Steve
>
> >               print_lock(p->held_locks + i);
> >       }
> >  }
>
