Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2259DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0180F206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgFLOr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:47:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38646 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgFLOrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 10:47:52 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jjky8-0003HN-V9; Fri, 12 Jun 2020 14:47:45 +0000
Date:   Fri, 12 Jun 2020 16:47:44 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     Andrei Vagin <avagin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: vdso_join_timens() question
Message-ID: <20200612144744.orw4yiaosghqlv4w@wittgenstein>
References: <20200611110221.pgd3r5qkjrjmfqa2@wittgenstein>
 <97732762-de71-e015-3989-b87d6e5c4dd4@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97732762-de71-e015-3989-b87d6e5c4dd4@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 08:17:12PM +0100, Dmitry Safonov wrote:
> Hi Christian,
> 
> On 6/11/20 12:02 PM, Christian Brauner wrote:
> > Hey,
> > 
> > I'm about to finish a patch to add CLONE_NEWTIME support to setns().
> > Since setns() now allows to attach to a multiple namespaces at the same
> > time I've also reworked it to be atomic (already upstream). Either all
> > namespaces are switched or no namespace is switched. All namespaces
> > basically now have a commit mode after which installation should ideally
> > not fail anymore. That could work for CLONE_NEWTIME too, I think. The
> > only blocker to this is vdso_join_timens() which can fail due to
> > mmap_write_lock_killable().
> > 
> > Is it possible to change this to mmap_write_lock()? So sm like:
> > 
> > diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> > index ea7c1f0b79df..5c5b4cc61fce 100644
> > --- a/arch/x86/entry/vdso/vma.c
> > +++ b/arch/x86/entry/vdso/vma.c
> > @@ -144,8 +144,7 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
> >         struct mm_struct *mm = task->mm;
> >         struct vm_area_struct *vma;
> > 
> > -       if (mmap_write_lock_killable(mm))
> > -               return -EINTR;
> > +       mmap_write_lock(mm);
> > 
> >         for (vma = mm->mmap; vma; vma = vma->vm_next) {
> >                 unsigned long size = vma->vm_end - vma->vm_start;
> 
> I think, it should be fine.

Great! :)

> 
> I'm thinking if it actually could be downgraded to mmap_read_lock()..
> Probably, write lock was being over-cautious.

Let's use mmap_write_lock() for now and revisit this later, I guess.

> 
> > vdso_join_timens() is called in two places. Once during fork() and once
> > during timens_install(). I would only need the mmap_write_lock() change
> > for the latter. So alternatively we could have:
> > 
> > __vdso_join_timens_unlocked()
> > 
> > and then have/expose:
> > 
> > vdso_join_timens_fork()
> > {
> >         if (mmap_write_lock_killable(mm))
> >                 return -EINTR;
> > 	__vdso_join_timens_unlocked()
> > 	mmap_write_unlock(mm);
> > }
> > 
> > and 
> > 
> > vdso_join_timens_install()
> > {
> >         mmap_write_lock(mm);
> > 	__vdso_join_timens_unlocked()
> > 	mmap_write_unlock(mm);
> > }
> 
> I think it's not needed. On fork() it's called on creation of new timens:
> 
> :	if (nsproxy->time_ns == nsproxy->time_ns_for_children)
> :		return 0;
> 
> So the vdso_join_timens() is called on setns() or on creation of new
> namespace, which both are quite heavy operations themselves (in sense of
> locking).

Ok, great. It'll like be the week after next until I can send the
patchset for setns(<nsfd>/<pidfd>, CLONE_NEWTIME) out.

Thanks!
Christian
