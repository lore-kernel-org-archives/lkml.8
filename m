Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA31C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 06:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9675620716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 06:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pf9+Egvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgA2G5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 01:57:46 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47067 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgA2G5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 01:57:46 -0500
Received: by mail-pg1-f196.google.com with SMTP id z124so8316599pgb.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 22:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4Vt2Aqkg/R7zTsybACOEGE3vp2GaBTi2UK3kITyWRgs=;
        b=pf9+Egvdq2fsOww8uv4qog07L54mIDZpa1b7UUxmXe9zPsDKoOqPZTG11ICsD2jGbQ
         MRvi3pCGhdgyYmPt+F/3ih8uz109NMBEVa/aruioiWIz7asb1Y2qmhYYeeLIMO2C5sP9
         QjFrjupxrd8K3pjxT43DTPjUqFOZYreqGavG9+miTl2WabJn6vFpS9BO07nlnKaaLxpa
         eMCh1MEIn3mLAn1gqYQSF23hoXu6dkCBgVn8PJMmk/58thKxRgKP04swUYikNKG3eV3c
         RAqKlrjEzv899nXk3Kub1WNxRbxjEYBaRwTV/erOpJh+DagS5FGS/WjgUBiXwwCpOsEz
         K6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Vt2Aqkg/R7zTsybACOEGE3vp2GaBTi2UK3kITyWRgs=;
        b=BaFbp+v85hIar+sOq0UTgI+SSUXli83JuG+pFrIclICR+NxIWKd/VT3kQTFKbC2nPy
         NSyFbNRduNBzuMbxX/MG5NJzDC6NoCk4vlsupSDKdL92gq9LZlZ2q0UCZ2fs15FgeyxA
         Xxq41Acjyg5Cxk1+Wiz3/NvkIfahUXvZ/GrArBReHx7qqxW9MiD/wjglvQyXJBbDbP7H
         JgsCg63B6gouI0fRXyiSF1+Sb7okxX6svEsJsofsoAxcRa3MOxjXtXgtH1/e8nG/+3T5
         7Hm53X2LvVuC1v3KJ/UGsY1vt/zuv6+THmF5DQVqwYxH4Wa3V3ZOI4k8WjutTRLmT/0U
         UV8A==
X-Gm-Message-State: APjAAAWuHQIkarXIVNb/Kq9VzFYgoOY0qs84f4kDt7BBUboIo42Knvvg
        JZgAXEB1ycz3F0vgi5RwX/g=
X-Google-Smtp-Source: APXvYqzkSiAX18kbjvXpkNuPb3q3++T6V7dP7MsbkTfbLALxTBgUnpdOBTU8ALjrfnPu2w6tUFAT/g==
X-Received: by 2002:a62:6c6:: with SMTP id 189mr7969753pfg.224.1580281065467;
        Tue, 28 Jan 2020 22:57:45 -0800 (PST)
Received: from workstation-portable ([146.196.37.139])
        by smtp.gmail.com with ESMTPSA id o11sm1117716pjs.6.2020.01.28.22.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 22:57:44 -0800 (PST)
Date:   Wed, 29 Jan 2020 12:27:38 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     Jann Horn <jannh@google.com>
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
Subject: Re: [PATCH] cred: Use RCU primitives to access RCU pointers
Message-ID: <20200129065738.GA17486@workstation-portable>
References: <20200128072740.21272-1-frextrite@gmail.com>
 <CAG48ez3ZcO+kVPJVG6XpCPyGUKF2o4UJ6AVdgZXGQ6XJJpcdmg@mail.gmail.com>
 <20200128170426.GA10277@workstation-portable>
 <CAG48ez3bLC3dzXn7Ep0YmBENg7wp6TMrocGa6q2RLtYoOdUSxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3bLC3dzXn7Ep0YmBENg7wp6TMrocGa6q2RLtYoOdUSxg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 08:09:17PM +0100, Jann Horn wrote:
> On Tue, Jan 28, 2020 at 6:04 PM Amol Grover <frextrite@gmail.com> wrote:
> > On Tue, Jan 28, 2020 at 10:30:19AM +0100, Jann Horn wrote:
> > > On Tue, Jan 28, 2020 at 8:28 AM Amol Grover <frextrite@gmail.com> wrote:
> > > > task_struct.cred and task_struct.real_cred are annotated by __rcu,
> > >
> > > task_struct.cred doesn't actually have RCU semantics though, see
> > > commit d7852fbd0f0423937fa287a598bfde188bb68c22. For task_struct.cred,
> > > it would probably be more correct to remove the __rcu annotation?
> > >
> >
> > Hi Jann,
> >
> > I went through the commit you mentioned. If I understand it correctly,
> > ->cred was not being accessed concurrently (via RCU), hence, a non_rcu
> > flag was introduced, which determined if the clean-up should wait for
> > RCU grace-periods or not. And since, the changes were 'thread local'
> > there was no need to wait for an entire RCU GP to elapse.
> 
> Yeah.
> 
> > The commit too, as you said, mentions the removal of __rcu annotation.
> > However, simply removing the annotation won't work, as there are quite a
> > few instances where RCU primitives are used. Even get_current_cred()
> > uses RCU APIs to get a reference to ->cred.
> 
> Luckily, there aren't too many places that directly access ->cred,
> since luckily there are helper functions like get_current_cred() that
> will do it for you. Grepping through the kernel, I see:
> 
> Places that need adjustment:
> 
> include/linux/cred.h:   rcu_dereference_protected(current->cred, 1)
> kernel/auditsc.c: * the only situations where tsk->cred may be
> accessed without an rcu read lock.
> kernel/auditsc.c:       cred = rcu_dereference_check(tsk->cred, tsk ==
> current || task_creation);
> kernel/cred.c:  rcu_assign_pointer(task->cred, new);
> kernel/cred.c:  rcu_assign_pointer(current->cred, new);
> kernel/cred.c:  rcu_assign_pointer(current->cred, old);
> 
> 
> Places that already don't use RCU accessors:
> 
> drivers/virt/vboxguest/vboxguest_linux.c:       if
> (from_kuid(current_user_ns(), current->cred->uid) == 0)
> kernel/cred.c:  BUG_ON(cred == current->cred);
> kernel/cred.c:  kdebug("exit_creds(%u,%p,%p,{%d,%d})", tsk->pid,
> tsk->real_cred, tsk->cred,
> kernel/cred.c:         atomic_read(&tsk->cred->usage),
> kernel/cred.c:         read_cred_subscribers(tsk->cred));
> kernel/cred.c:  cred = (struct cred *) tsk->cred;
> kernel/cred.c:  tsk->cred = NULL;
> kernel/cred.c:  old = task->cred;
> kernel/cred.c:          !p->cred->thread_keyring &&
> kernel/cred.c:          p->real_cred = get_cred(p->cred);
> kernel/cred.c:          get_cred(p->cred);
> kernel/cred.c:          alter_cred_subscribers(p->cred, 2);
> kernel/cred.c:                 p->cred, atomic_read(&p->cred->usage),
> kernel/cred.c:                 read_cred_subscribers(p->cred));
> kernel/cred.c:          atomic_inc(&p->cred->user->processes);
> kernel/cred.c:  p->cred = p->real_cred = get_cred(new);
> kernel/cred.c:  BUG_ON(task->cred != old);
> kernel/cred.c:  const struct cred *old = current->cred;
> kernel/cred.c:   * '->cred' pointer, not the '->real_cred' pointer that is
> kernel/cred.c:  const struct cred *override = current->cred;
> kernel/cred.c:         cred == tsk->cred ? "[eff]" : "");
> kernel/cred.c:  if (tsk->cred == tsk->real_cred) {
> kernel/cred.c:          if (unlikely(read_cred_subscribers(tsk->cred) < 2 ||
> kernel/cred.c:                       creds_are_invalid(tsk->cred)))
> kernel/cred.c:                       read_cred_subscribers(tsk->cred) < 1 ||
> kernel/cred.c:                       creds_are_invalid(tsk->cred)))
> kernel/cred.c:  if (tsk->cred != tsk->real_cred)
> kernel/cred.c:          dump_invalid_creds(tsk->cred, "Effective", tsk);
> kernel/cred.c:         tsk->real_cred, tsk->cred,
> kernel/cred.c:         atomic_read(&tsk->cred->usage),
> kernel/cred.c:         read_cred_subscribers(tsk->cred));
> kernel/fork.c:  atomic_dec(&p->cred->user->processes);
> security/security.c:    lsm_early_cred((struct cred *) current->cred);
> security/smack/smack_lsm.c:     struct cred *cred = (struct cred *)
> current->cred;
> security/tomoyo/common.c:           (!uid_eq(task->cred->uid,
> GLOBAL_ROOT_UID) ||
> security/tomoyo/common.c:            !uid_eq(task->cred->euid,
> GLOBAL_ROOT_UID)))
> 
> 
> Places that don't use RCU and are broken:
> 
> security/smack/smack_lsm.c:     struct smack_known *tkp =
> smk_of_task(smack_cred(tsk->cred));
> 
> So actually, the number of places that already don't use RCU accessors
> is much higher than the number of places that use them.
> 
> > So, currently, maybe we
> > should continue to use RCU APIs and leave the __rcu annotation in?
> > (Until someone who takes it on himself to remove __rcu annotation and
> > fix all the instances). Does that sound good? Or do you want me to
> > remove __rcu annotation and get the process started?
> 
> I don't think it's a good idea to add more uses of RCU APIs for
> ->cred; you shouldn't "fix" warnings by making the code more wrong.
> 
> If you want to fix this, I think it would be relatively easy to fix
> this properly - as far as I can tell, there are only seven places that
> you'll have to change, although you may have to split it up into three
> patches.

Thank you for the detailed analysis. I'll try my best and send you a
patch. But before I start I want to make sure one thing. The changes
done by the commit you mentioned (which introduced non_rcu flag), should
be now reverted, right?  Since, prior to the commit RCU semantics were
there and RCU was being used (which was unnecessary) and the fix merely,
removed these (unnecessary) RCU usages (with checks to either use them
or not, but now we actually don't use RCU for subjective credentials).

So, now what's left is the unused RCU code (which needs to be removed)
and the changes done in the temporary fix (which would be reverted since
we don't want to use RCU).

Thanks
Amol
