Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3436EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20EF20708
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OjMQ2XmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgA1TJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 14:09:45 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46095 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgA1TJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 14:09:44 -0500
Received: by mail-ot1-f68.google.com with SMTP id g64so13075060otb.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 11:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0uDY2QBhfEUdWOh6cPotJ77cqPe1RSmXYbfImdKMurk=;
        b=OjMQ2XmTWVstZOf1eyavV2tz0/5ffAvoB3yOj3xIx5xzt3CKWH8L2jQLHKoUsXQCQv
         XoTJPvBAF2gGaG1UhrSnqQXYiLfmnOFe8E0RoMbZwdJoo4dgAJFQBenA+XtU0o6T0EgF
         HYITPw6U+8nEcY4PoWY+NNr1Eq+Jv3a6MCyzmdzjzvSh/QaUSsRR6FVq76JJ6VDHEJr8
         UIgg29EKhzl/lzCba8uvoxh7lizoJjJvy9DkECKCgiRpzre3XFtqIaCjjPi3eUTGpRQ7
         ZG/2KQ6YHj4mo752Lh+DR0TA4Y5bUn9DSW49bsstpefiCr+eMQzlIwcnrZjkSQ69NtEm
         fz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0uDY2QBhfEUdWOh6cPotJ77cqPe1RSmXYbfImdKMurk=;
        b=MH/KZQafvwbm/yerGt3DGzxgmgXG4v/Jn0AenxXESvrZ9UZ0oR9xnG9QSLrNJoDhBH
         4yTXTyEg6l4yq05REvwXxtpcCKKwy3NdvFWFMFbUc/6N0KVI8N3fyTfHU8I3xJcOb+Zv
         uzV4h2qACH3OzlKJf9j5Q4k8kBZ5JTKFvFZHOt/civ7yX9X4rkMOfrAyCMUKDqoR3ATW
         eFlSmghuFtAt28JsBkHvIj63klLIk7wdFp1ThMrCjAlfBPU+7+NejfUDuZHV/dwk7r40
         IfT3tfg2NUMR0NrAiRlx+5mdYV3pmXrvAYOGkdkrlTJiHaJRf3W2eQo00UkpDTCJVHyH
         7gJg==
X-Gm-Message-State: APjAAAW8rao5uDInSb9NcPjCK/mOiHsWTVbBxOXRScLqFNBFJ4BXvfEN
        9/6WBTT6kqJCW9SmMU7jnJEqPtTWVZZ8gOXw7pNVxA==
X-Google-Smtp-Source: APXvYqxjKWcfc3GV8OqegAQiDhrMSPEn/uhrhF1Cn4ZvDGrMCFrF0cIwz7KuLZSNRhR352hCbncAiGQMDxO2ihfFQN4=
X-Received: by 2002:a05:6830:1d6e:: with SMTP id l14mr17212146oti.32.1580238583961;
 Tue, 28 Jan 2020 11:09:43 -0800 (PST)
MIME-Version: 1.0
References: <20200128072740.21272-1-frextrite@gmail.com> <CAG48ez3ZcO+kVPJVG6XpCPyGUKF2o4UJ6AVdgZXGQ6XJJpcdmg@mail.gmail.com>
 <20200128170426.GA10277@workstation-portable>
In-Reply-To: <20200128170426.GA10277@workstation-portable>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 28 Jan 2020 20:09:17 +0100
Message-ID: <CAG48ez3bLC3dzXn7Ep0YmBENg7wp6TMrocGa6q2RLtYoOdUSxg@mail.gmail.com>
Subject: Re: [PATCH] cred: Use RCU primitives to access RCU pointers
To:     Amol Grover <frextrite@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 6:04 PM Amol Grover <frextrite@gmail.com> wrote:
> On Tue, Jan 28, 2020 at 10:30:19AM +0100, Jann Horn wrote:
> > On Tue, Jan 28, 2020 at 8:28 AM Amol Grover <frextrite@gmail.com> wrote:
> > > task_struct.cred and task_struct.real_cred are annotated by __rcu,
> >
> > task_struct.cred doesn't actually have RCU semantics though, see
> > commit d7852fbd0f0423937fa287a598bfde188bb68c22. For task_struct.cred,
> > it would probably be more correct to remove the __rcu annotation?
> >
>
> Hi Jann,
>
> I went through the commit you mentioned. If I understand it correctly,
> ->cred was not being accessed concurrently (via RCU), hence, a non_rcu
> flag was introduced, which determined if the clean-up should wait for
> RCU grace-periods or not. And since, the changes were 'thread local'
> there was no need to wait for an entire RCU GP to elapse.

Yeah.

> The commit too, as you said, mentions the removal of __rcu annotation.
> However, simply removing the annotation won't work, as there are quite a
> few instances where RCU primitives are used. Even get_current_cred()
> uses RCU APIs to get a reference to ->cred.

Luckily, there aren't too many places that directly access ->cred,
since luckily there are helper functions like get_current_cred() that
will do it for you. Grepping through the kernel, I see:

Places that need adjustment:

include/linux/cred.h:   rcu_dereference_protected(current->cred, 1)
kernel/auditsc.c: * the only situations where tsk->cred may be
accessed without an rcu read lock.
kernel/auditsc.c:       cred = rcu_dereference_check(tsk->cred, tsk ==
current || task_creation);
kernel/cred.c:  rcu_assign_pointer(task->cred, new);
kernel/cred.c:  rcu_assign_pointer(current->cred, new);
kernel/cred.c:  rcu_assign_pointer(current->cred, old);


Places that already don't use RCU accessors:

drivers/virt/vboxguest/vboxguest_linux.c:       if
(from_kuid(current_user_ns(), current->cred->uid) == 0)
kernel/cred.c:  BUG_ON(cred == current->cred);
kernel/cred.c:  kdebug("exit_creds(%u,%p,%p,{%d,%d})", tsk->pid,
tsk->real_cred, tsk->cred,
kernel/cred.c:         atomic_read(&tsk->cred->usage),
kernel/cred.c:         read_cred_subscribers(tsk->cred));
kernel/cred.c:  cred = (struct cred *) tsk->cred;
kernel/cred.c:  tsk->cred = NULL;
kernel/cred.c:  old = task->cred;
kernel/cred.c:          !p->cred->thread_keyring &&
kernel/cred.c:          p->real_cred = get_cred(p->cred);
kernel/cred.c:          get_cred(p->cred);
kernel/cred.c:          alter_cred_subscribers(p->cred, 2);
kernel/cred.c:                 p->cred, atomic_read(&p->cred->usage),
kernel/cred.c:                 read_cred_subscribers(p->cred));
kernel/cred.c:          atomic_inc(&p->cred->user->processes);
kernel/cred.c:  p->cred = p->real_cred = get_cred(new);
kernel/cred.c:  BUG_ON(task->cred != old);
kernel/cred.c:  const struct cred *old = current->cred;
kernel/cred.c:   * '->cred' pointer, not the '->real_cred' pointer that is
kernel/cred.c:  const struct cred *override = current->cred;
kernel/cred.c:         cred == tsk->cred ? "[eff]" : "");
kernel/cred.c:  if (tsk->cred == tsk->real_cred) {
kernel/cred.c:          if (unlikely(read_cred_subscribers(tsk->cred) < 2 ||
kernel/cred.c:                       creds_are_invalid(tsk->cred)))
kernel/cred.c:                       read_cred_subscribers(tsk->cred) < 1 ||
kernel/cred.c:                       creds_are_invalid(tsk->cred)))
kernel/cred.c:  if (tsk->cred != tsk->real_cred)
kernel/cred.c:          dump_invalid_creds(tsk->cred, "Effective", tsk);
kernel/cred.c:         tsk->real_cred, tsk->cred,
kernel/cred.c:         atomic_read(&tsk->cred->usage),
kernel/cred.c:         read_cred_subscribers(tsk->cred));
kernel/fork.c:  atomic_dec(&p->cred->user->processes);
security/security.c:    lsm_early_cred((struct cred *) current->cred);
security/smack/smack_lsm.c:     struct cred *cred = (struct cred *)
current->cred;
security/tomoyo/common.c:           (!uid_eq(task->cred->uid,
GLOBAL_ROOT_UID) ||
security/tomoyo/common.c:            !uid_eq(task->cred->euid,
GLOBAL_ROOT_UID)))


Places that don't use RCU and are broken:

security/smack/smack_lsm.c:     struct smack_known *tkp =
smk_of_task(smack_cred(tsk->cred));

So actually, the number of places that already don't use RCU accessors
is much higher than the number of places that use them.

> So, currently, maybe we
> should continue to use RCU APIs and leave the __rcu annotation in?
> (Until someone who takes it on himself to remove __rcu annotation and
> fix all the instances). Does that sound good? Or do you want me to
> remove __rcu annotation and get the process started?

I don't think it's a good idea to add more uses of RCU APIs for
->cred; you shouldn't "fix" warnings by making the code more wrong.

If you want to fix this, I think it would be relatively easy to fix
this properly - as far as I can tell, there are only seven places that
you'll have to change, although you may have to split it up into three
patches.
