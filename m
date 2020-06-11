Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6428C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 928122081A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgFKLCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:02:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45904 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgFKLCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:02:32 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jjKyU-0007kK-ER; Thu, 11 Jun 2020 11:02:22 +0000
Date:   Thu, 11 Jun 2020 13:02:21 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: vdso_join_timens() question
Message-ID: <20200611110221.pgd3r5qkjrjmfqa2@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I'm about to finish a patch to add CLONE_NEWTIME support to setns().
Since setns() now allows to attach to a multiple namespaces at the same
time I've also reworked it to be atomic (already upstream). Either all
namespaces are switched or no namespace is switched. All namespaces
basically now have a commit mode after which installation should ideally
not fail anymore. That could work for CLONE_NEWTIME too, I think. The
only blocker to this is vdso_join_timens() which can fail due to
mmap_write_lock_killable().

Is it possible to change this to mmap_write_lock()? So sm like:

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index ea7c1f0b79df..5c5b4cc61fce 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -144,8 +144,7 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
        struct mm_struct *mm = task->mm;
        struct vm_area_struct *vma;

-       if (mmap_write_lock_killable(mm))
-               return -EINTR;
+       mmap_write_lock(mm);

        for (vma = mm->mmap; vma; vma = vma->vm_next) {
                unsigned long size = vma->vm_end - vma->vm_start;

vdso_join_timens() is called in two places. Once during fork() and once
during timens_install(). I would only need the mmap_write_lock() change
for the latter. So alternatively we could have:

__vdso_join_timens_unlocked()

and then have/expose:

vdso_join_timens_fork()
{
        if (mmap_write_lock_killable(mm))
                return -EINTR;
	__vdso_join_timens_unlocked()
	mmap_write_unlock(mm);
}

and 

vdso_join_timens_install()
{
        mmap_write_lock(mm);
	__vdso_join_timens_unlocked()
	mmap_write_unlock(mm);
}

Thanks!
Christian
