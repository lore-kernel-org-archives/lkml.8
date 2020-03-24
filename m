Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24802C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7AD206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055763;
	bh=NKkceryTMuai4X1AFLt/xoV5nKReHREJqxrtUSrhY+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ucRmYVjYVt9F7mSJdEioG+JHOvJEZFNZh4XIoLAn7+bnNp+HCb9KYUWoI5fbJWag3
	 a5NKKF3dltkdVammcitEdyScY71iH1+gNkvFsgfbcYcIDB5SPI/UCAGdq/F3EV9gna
	 4ovhKYQbSImY3XP++pq4whBWmbIeocygT2WpWTI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgCXNQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:16:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727843AbgCXNP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:15:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4660E206F6;
        Tue, 24 Mar 2020 13:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055757;
        bh=NKkceryTMuai4X1AFLt/xoV5nKReHREJqxrtUSrhY+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eUyEFEGdtl58MV3xIdzd/dQVz4DQfzDu4w6+6hpC7RLbGOaAir5y7CAQ8+kmyd0IN
         seDU87GfuvT63OZTGEV5JJk43Kn6Auxz7PeMRCA9Pb5ezdnb+8Zov+kSMvuJAwtlot
         eyqbSf/pWlDnRtz1i0O0Di2zI/xfQ9Zy/FM/1TJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, yangerkun <yangerkun@huawei.com>,
        NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 002/102] locks: reinstate locks_delete_block optimization
Date:   Tue, 24 Mar 2020 14:09:54 +0100
Message-Id: <20200324130806.734419667@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130806.544601211@linuxfoundation.org>
References: <20200324130806.544601211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit dcf23ac3e846ca0cf626c155a0e3fcbbcf4fae8a ]

There is measurable performance impact in some synthetic tests due to
commit 6d390e4b5d48 (locks: fix a potential use-after-free problem when
wakeup a waiter). Fix the race condition instead by clearing the
fl_blocker pointer after the wake_up, using explicit acquire/release
semantics.

This does mean that we can no longer use the clearing of fl_blocker as
the wait condition, so switch the waiters over to checking whether the
fl_blocked_member list_head is empty.

Reviewed-by: yangerkun <yangerkun@huawei.com>
Reviewed-by: NeilBrown <neilb@suse.de>
Fixes: 6d390e4b5d48 (locks: fix a potential use-after-free problem when wakeup a waiter)
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/file.c |  3 ++-
 fs/locks.c     | 54 ++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 0dbe47e897208..35c55cf38a358 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1173,7 +1173,8 @@ cifs_posix_lock_set(struct file *file, struct file_lock *flock)
 	rc = posix_lock_file(file, flock, NULL);
 	up_write(&cinode->lock_sem);
 	if (rc == FILE_LOCK_DEFERRED) {
-		rc = wait_event_interruptible(flock->fl_wait, !flock->fl_blocker);
+		rc = wait_event_interruptible(flock->fl_wait,
+					list_empty(&flock->fl_blocked_member));
 		if (!rc)
 			goto try_again;
 		locks_delete_block(flock);
diff --git a/fs/locks.c b/fs/locks.c
index 426b55d333d5b..b8a31c1c4fff3 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -725,7 +725,6 @@ static void __locks_delete_block(struct file_lock *waiter)
 {
 	locks_delete_global_blocked(waiter);
 	list_del_init(&waiter->fl_blocked_member);
-	waiter->fl_blocker = NULL;
 }
 
 static void __locks_wake_up_blocks(struct file_lock *blocker)
@@ -740,6 +739,13 @@ static void __locks_wake_up_blocks(struct file_lock *blocker)
 			waiter->fl_lmops->lm_notify(waiter);
 		else
 			wake_up(&waiter->fl_wait);
+
+		/*
+		 * The setting of fl_blocker to NULL marks the "done"
+		 * point in deleting a block. Paired with acquire at the top
+		 * of locks_delete_block().
+		 */
+		smp_store_release(&waiter->fl_blocker, NULL);
 	}
 }
 
@@ -753,11 +759,42 @@ int locks_delete_block(struct file_lock *waiter)
 {
 	int status = -ENOENT;
 
+	/*
+	 * If fl_blocker is NULL, it won't be set again as this thread "owns"
+	 * the lock and is the only one that might try to claim the lock.
+	 *
+	 * We use acquire/release to manage fl_blocker so that we can
+	 * optimize away taking the blocked_lock_lock in many cases.
+	 *
+	 * The smp_load_acquire guarantees two things:
+	 *
+	 * 1/ that fl_blocked_requests can be tested locklessly. If something
+	 * was recently added to that list it must have been in a locked region
+	 * *before* the locked region when fl_blocker was set to NULL.
+	 *
+	 * 2/ that no other thread is accessing 'waiter', so it is safe to free
+	 * it.  __locks_wake_up_blocks is careful not to touch waiter after
+	 * fl_blocker is released.
+	 *
+	 * If a lockless check of fl_blocker shows it to be NULL, we know that
+	 * no new locks can be inserted into its fl_blocked_requests list, and
+	 * can avoid doing anything further if the list is empty.
+	 */
+	if (!smp_load_acquire(&waiter->fl_blocker) &&
+	    list_empty(&waiter->fl_blocked_requests))
+		return status;
+
 	spin_lock(&blocked_lock_lock);
 	if (waiter->fl_blocker)
 		status = 0;
 	__locks_wake_up_blocks(waiter);
 	__locks_delete_block(waiter);
+
+	/*
+	 * The setting of fl_blocker to NULL marks the "done" point in deleting
+	 * a block. Paired with acquire at the top of this function.
+	 */
+	smp_store_release(&waiter->fl_blocker, NULL);
 	spin_unlock(&blocked_lock_lock);
 	return status;
 }
@@ -1350,7 +1387,8 @@ static int posix_lock_inode_wait(struct inode *inode, struct file_lock *fl)
 		error = posix_lock_inode(inode, fl, NULL);
 		if (error != FILE_LOCK_DEFERRED)
 			break;
-		error = wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
+		error = wait_event_interruptible(fl->fl_wait,
+					list_empty(&fl->fl_blocked_member));
 		if (error)
 			break;
 	}
@@ -1435,7 +1473,8 @@ int locks_mandatory_area(struct inode *inode, struct file *filp, loff_t start,
 		error = posix_lock_inode(inode, &fl, NULL);
 		if (error != FILE_LOCK_DEFERRED)
 			break;
-		error = wait_event_interruptible(fl.fl_wait, !fl.fl_blocker);
+		error = wait_event_interruptible(fl.fl_wait,
+					list_empty(&fl.fl_blocked_member));
 		if (!error) {
 			/*
 			 * If we've been sleeping someone might have
@@ -1638,7 +1677,8 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 
 	locks_dispose_list(&dispose);
 	error = wait_event_interruptible_timeout(new_fl->fl_wait,
-						!new_fl->fl_blocker, break_time);
+					list_empty(&new_fl->fl_blocked_member),
+					break_time);
 
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
@@ -2122,7 +2162,8 @@ static int flock_lock_inode_wait(struct inode *inode, struct file_lock *fl)
 		error = flock_lock_inode(inode, fl);
 		if (error != FILE_LOCK_DEFERRED)
 			break;
-		error = wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
+		error = wait_event_interruptible(fl->fl_wait,
+				list_empty(&fl->fl_blocked_member));
 		if (error)
 			break;
 	}
@@ -2399,7 +2440,8 @@ static int do_lock_file_wait(struct file *filp, unsigned int cmd,
 		error = vfs_lock_file(filp, cmd, fl, NULL);
 		if (error != FILE_LOCK_DEFERRED)
 			break;
-		error = wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
+		error = wait_event_interruptible(fl->fl_wait,
+					list_empty(&fl->fl_blocked_member));
 		if (error)
 			break;
 	}
-- 
2.20.1



