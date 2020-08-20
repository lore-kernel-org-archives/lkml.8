Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAE7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EFBE20855
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597922701;
	bh=RBmrsqYJE1VOmNErin+yCTp5FmI8o19mCee+EBGo8nU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=koybr38e0M5MyQPyP06IVGeI6JDiyDJxx8iFzp5J58nvyNRuYAAEwl/aBj/0h+XMv
	 I3xK9vWIyi7kXzlNtbVH11UIrTeX8BLLyOX/t9M8gs0PMIevIgAlZJYQocZ9s0LZx0
	 SvXAyURbz4YUC3BwHUkTtih6fO0Cs3HDB9gjT1WA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgHTLY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:24:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730514AbgHTKG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:06:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6939C206DA;
        Thu, 20 Aug 2020 10:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918015;
        bh=RBmrsqYJE1VOmNErin+yCTp5FmI8o19mCee+EBGo8nU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QCUy2FGPNqoaEG6PvikPU8O3XQ/JWcYxCktUlItfUwhm5AwDqGseWsCsfbPZNKT0E
         mUPOaBENPrX+3PqOGUx8/fwdfDTyW6IxmgGPEabbp7KoG3/BXt7+QcJ5wSm5gGbVEF
         koAHci23+0Nq7GSz//GeXltwqPTtEX8sdya5kLZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+7a0d9d0b26efefe61780@syzkaller.appspotmail.com,
        Suren Baghdasaryan <surenb@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 4.14 007/228] staging: android: ashmem: Fix lockdep warning for write operation
Date:   Thu, 20 Aug 2020 11:19:42 +0200
Message-Id: <20200820091607.890615373@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suren Baghdasaryan <surenb@google.com>

commit 3e338d3c95c735dc3265a86016bb4c022ec7cadc upstream.

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
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Link: https://lore.kernel.org/r/20200730192632.3088194-1-surenb@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/android/ashmem.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -100,6 +100,15 @@ static DEFINE_MUTEX(ashmem_mutex);
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
@@ -406,6 +415,7 @@ static int ashmem_mmap(struct file *file
 	if (!asma->file) {
 		char *name = ASHMEM_NAME_DEF;
 		struct file *vmfile;
+		struct inode *inode;
 
 		if (asma->name[ASHMEM_NAME_PREFIX_LEN] != '\0')
 			name = asma->name;
@@ -417,6 +427,8 @@ static int ashmem_mmap(struct file *file
 			goto out;
 		}
 		vmfile->f_mode |= FMODE_LSEEK;
+		inode = file_inode(vmfile);
+		lockdep_set_class(&inode->i_rwsem, &backing_shmem_inode_class);
 		asma->file = vmfile;
 		/*
 		 * override mmap operation of the vmfile so that it can't be


