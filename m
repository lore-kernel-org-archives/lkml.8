Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492ECC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 19:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21E2A2072A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 19:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gj5uH8D4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbgG3T0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 15:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgG3T0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 15:26:39 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC177C061575
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 12:26:38 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id d131so19352354qke.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 12:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fWc6OJCig1UgfvHtWplz+nD9vozoDKzNVIvYHPTkg44=;
        b=gj5uH8D4Swjos7n2MMJejn1TAY3/L82VroaxdW/TCkIJ79VyK0QF+7je5BWTh2VdbP
         S5EJcY/69Oah1CX+JxuEJQFQiERjk/P36vSs5VY/IAzzXXFTcElypDb5ad2LCfKgg07p
         bxmXzb+N1u0FJ/kmrnEpOysUXavSYtx5LY2CqEkI9v108NbkONilghGgiQFXGU6ZnOQS
         tV4PACfZgq/MYzgVSxp7OsSRh4PVZC9+HRmf49Eutm2q6iUHcHMvbPFTIqgYorCXg0F3
         6Rxksb9qwD2MmW8j0Y9pUDSrTzgxYA1mNCTFcqttpvKe9S03LbVAvGFse0CBzYiYrZDF
         25FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fWc6OJCig1UgfvHtWplz+nD9vozoDKzNVIvYHPTkg44=;
        b=Yl7EUcjG6/pZF42RwEc8MCwtdkVPWBfI7TGTzowWnwmi2W837KcvPNSgLvukoOm/kG
         /6fK8sjev0Y8O2iqpBygfzv98UrJXbI01OASIiKU/I0/c3cyHLcg34gkUJkdm982Tk2w
         HFAe798T7vP7vReOYgc5aw/nOhAs4nc4Ctn1W7SXSuR0mJmzwDAKe6LfCv0kB4fMvEZN
         /bpDuPv5aPBczH/fDpHYJ9wdr/m8fDJQGPFbw5GhHks1HVybzYBrT4rkEVBzP8+186H/
         YzJ1j7e9dIdkKMZkOtaNSQjiq4IxgZehYHl8aQ9GOFQlWoHbb4EPvkp9Moloc+tKob9V
         9FIg==
X-Gm-Message-State: AOAM530s4yir5lE8ZP8Yaajg+mn0pJUitLl+i9YzHwDxNIzonexLFSNY
        RnENBfCseJPxNC/M3jUlv9tpj+a9YA8=
X-Google-Smtp-Source: ABdhPJzEMZe4ramJ8Ov7HBdblAvH3a+W031fHCnG32znIrk4AscZJPDQJ3jlVI/1fwnUZWE1mXm5diLdqiM=
X-Received: by 2002:ad4:40cb:: with SMTP id x11mr702214qvp.176.1596137197459;
 Thu, 30 Jul 2020 12:26:37 -0700 (PDT)
Date:   Thu, 30 Jul 2020 12:26:32 -0700
Message-Id: <20200730192632.3088194-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v2 1/1] staging: android: ashmem: Fix lockdep warning for
 write operation
From:   Suren Baghdasaryan <surenb@google.com>
To:     surenb@google.com
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        hridya@google.com, mhocko@kernel.org, hdanton@sina.com,
        ebiggers@kernel.org, devel@driverdev.osuosl.org,
        linux-mm@kvack.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        syzbot+7a0d9d0b26efefe61780@syzkaller.appspotmail.com
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

Reported-by: syzbot+7a0d9d0b26efefe61780@syzkaller.appspotmail.com
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
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
2.28.0.163.g6104cc2f0b6-goog

