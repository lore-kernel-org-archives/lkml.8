Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB882C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 02:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C50BD20787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 02:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AGBvyE3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgGPCpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 22:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgGPCpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 22:45:36 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B75C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 19:45:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r17so5414616ybj.22
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 19:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xWu7gPZztNAK+TxJrFnoSXXwBfp6shDBhGamt8B80c8=;
        b=AGBvyE3KJbosodgTS9w19CA1M+qXplTx2t0WHQsXS12u2LmGODvao6q4grprQiMr+Z
         E++7i3g9dwDbM8KkF4cfYRMP5vEfinEzTWGR/BsVG/Ptw8Von+PtKX7kIMbQ+SRIqwBN
         f/baF9a8zwUVDIGaa7sQErP7Z20PkIAieTYAll6VA3JQY/WMOm8Vq6+rDUhSLGj6FgS7
         4XTo6hrI/g5XlTAJ0ShVcNtfBgjQyr3rzy4JZe5wLS5QvGzZodg/pdiyONk2D1TehBto
         /NXRBhV11U4yRk/QzrEe5o7zq+WutrxqZzF5HcV+eWyBgQrrn7FFHh+7ZdTs6zOAKMiu
         GguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xWu7gPZztNAK+TxJrFnoSXXwBfp6shDBhGamt8B80c8=;
        b=Qp7Y7oM5uF/sWUU6DpGjldQIt4dtvqsZn3ypPdnih1FwcfS68t5Hm5HuqC5kfLUEAs
         Tk+TWchdYks79O+J3HuHRfInY/pz1yQ/OOjVSfoS7zaDVnbS8/EDANthchlpUV4U5xKq
         BvPdzCoju3fTUtGn1lgGJSShZGy7yoPogtVo4x+hush1RZo1/y4HpOiOOqOAahnMe4to
         XdqHlsLFdNANjHKBrZsFwuve8G8l9M82OZJXLBlADHggYZF5PK5TH6rvGDPi6gFRP/PE
         WAjC8qDAcZDKQcJ2GOO2enNfk3+Bcv5uolsN0CZjcSJed6VydMcyjlou2zgWNmwVA8Ti
         yswQ==
X-Gm-Message-State: AOAM531eibzUykop7ZhflDOXIa+9SaymYKt6QWxEdedBo74hV8cN/QMW
        m0O92wqSc49HlwmD0nABCfzHFHjS7Jk=
X-Google-Smtp-Source: ABdhPJwIAGAziDbNA7/jYqZZpWADP6cnWXnwe2nm5sHqpT+EewgRttLsf0e6DqpfxRS3toIODLp/aELaaK4=
X-Received: by 2002:a25:7689:: with SMTP id r131mr3513121ybc.125.1594867534900;
 Wed, 15 Jul 2020 19:45:34 -0700 (PDT)
Date:   Wed, 15 Jul 2020 19:45:27 -0700
Message-Id: <20200716024527.4009170-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 1/1] staging: android: ashmem: Fix lockdep warning for write operation
From:   Suren Baghdasaryan <surenb@google.com>
To:     surenb@google.com
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        hridya@google.com, mhocko@kernel.org, hdanton@sina.com,
        ebiggers@kernel.org, devel@driverdev.osuosl.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot report [1] describes a deadlock when write operation against an
ashmem fd executed at the time when ashmem is shrinking its cache results
in the following lock sequence:

Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(fs_reclaim);
                                lock(&sb->s_type->i_mutex_key#13);
                                lock(fs_reclaim);
   lock(&sb->s_type->i_mutex_key#13);

kswapd takes fs_reclaim and then inode_lock while generic_perform_write
takes inode_lock and then fs_reclaim. However ashmem does not support
writing into backing shmem with a write syscall. The only way to change
its content is to mmap it and operate on mapped memory. Therefore the race
that lockdep is warning about is not valid. Resolve this by introducing a
separate lockdep class for the backing shmem inodes.

[1]: https://lkml.kernel.org/lkml/0000000000000b5f9d059aa2037f@google.com/

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 drivers/staging/android/ashmem.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index c05a214191da..10b4be1f3e78 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -95,6 +95,15 @@ static DEFINE_MUTEX(ashmem_mutex);
 static struct kmem_cache *ashmem_area_cachep __read_mostly;
 static struct kmem_cache *ashmem_range_cachep __read_mostly;
 
+/*
+ * A separate lockdep class for the backing shmem inodes to resolve the lockdep
+ * warning about the race between kswapd taking fs_reclaim before inode_lock
+ * and write syscall taking inode_lock and then fs_reclaim.
+ * Note that such race is impossible because ashmem does not support write
+ * syscalls operating on the backing shmem.
+ */
+static struct lock_class_key backing_shmem_inode_class;
+
 static inline unsigned long range_size(struct ashmem_range *range)
 {
 	return range->pgend - range->pgstart + 1;
@@ -396,6 +405,7 @@ static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
 	if (!asma->file) {
 		char *name = ASHMEM_NAME_DEF;
 		struct file *vmfile;
+		struct inode *inode;
 
 		if (asma->name[ASHMEM_NAME_PREFIX_LEN] != '\0')
 			name = asma->name;
@@ -407,6 +417,8 @@ static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
 			goto out;
 		}
 		vmfile->f_mode |= FMODE_LSEEK;
+		inode = file_inode(vmfile);
+		lockdep_set_class(&inode->i_rwsem, &backing_shmem_inode_class);
 		asma->file = vmfile;
 		/*
 		 * override mmap operation of the vmfile so that it can't be
-- 
2.28.0.rc0.105.gf9edc3c819-goog

