Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4F2C3F34D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5802469D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812998;
	bh=2JMkD/HWo90XFdZlBpJPpG2NNB3Mc1ED70yWqMKB/ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cR+WzTCizD3Guenhjfp8fzQs+w4wE55GduR2512vdJYOrpwOtBUlKG0byojMv+5rQ
	 ocKxUfDsPCr3Cz/+trxONjXMC8e2+hz0KqzGHAaSmQ1u4ywktTPuHBHPJZaFJwIS9i
	 3SM8HTJ9Bl7XMIzEd29dGRhgeabN7FM7kOrTxLSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389558AbgB0OQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:16:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389513AbgB0OQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:16:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED0C320801;
        Thu, 27 Feb 2020 14:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812995;
        bh=2JMkD/HWo90XFdZlBpJPpG2NNB3Mc1ED70yWqMKB/ck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CV9Js69xyEnTmlgjVVpLj1AJrhL3HfdEMIRtp38ljeDTq79dX8W8G+wk03S8RYMPC
         M8tJT8auae70AJ5HFqtIf6dGr0xwzupthZz5bwHPEJFGVrg6bUHoVkFElAeuUCfzKC
         eAqJoFHOAt6Qa3Uo6brE9hYd9XLi0uVjn6IxiaXg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        stable@kernel.org
Subject: [PATCH 5.5 095/150] ext4: rename s_journal_flag_rwsem to s_writepages_rwsem
Date:   Thu, 27 Feb 2020 14:37:12 +0100
Message-Id: <20200227132246.874239534@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit bbd55937de8f2754adc5792b0f8e5ff7d9c0420e upstream.

In preparation for making s_journal_flag_rwsem synchronize
ext4_writepages() with changes to both the EXTENTS and JOURNAL_DATA
flags (rather than just JOURNAL_DATA as it does currently), rename it to
s_writepages_rwsem.

Link: https://lore.kernel.org/r/20200219183047.47417-2-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/ext4.h  |    2 +-
 fs/ext4/inode.c |   14 +++++++-------
 fs/ext4/super.c |    6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1554,7 +1554,7 @@ struct ext4_sb_info {
 	struct ratelimit_state s_msg_ratelimit_state;
 
 	/* Barrier between changing inodes' journal flags and writepages ops. */
-	struct percpu_rw_semaphore s_journal_flag_rwsem;
+	struct percpu_rw_semaphore s_writepages_rwsem;
 	struct dax_device *s_daxdev;
 };
 
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2627,7 +2627,7 @@ static int ext4_writepages(struct addres
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
 
-	percpu_down_read(&sbi->s_journal_flag_rwsem);
+	percpu_down_read(&sbi->s_writepages_rwsem);
 	trace_ext4_writepages(inode, wbc);
 
 	/*
@@ -2848,7 +2848,7 @@ unplug:
 out_writepages:
 	trace_ext4_writepages_result(inode, wbc, ret,
 				     nr_to_write - wbc->nr_to_write);
-	percpu_up_read(&sbi->s_journal_flag_rwsem);
+	percpu_up_read(&sbi->s_writepages_rwsem);
 	return ret;
 }
 
@@ -2863,13 +2863,13 @@ static int ext4_dax_writepages(struct ad
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
 
-	percpu_down_read(&sbi->s_journal_flag_rwsem);
+	percpu_down_read(&sbi->s_writepages_rwsem);
 	trace_ext4_writepages(inode, wbc);
 
 	ret = dax_writeback_mapping_range(mapping, inode->i_sb->s_bdev, wbc);
 	trace_ext4_writepages_result(inode, wbc, ret,
 				     nr_to_write - wbc->nr_to_write);
-	percpu_up_read(&sbi->s_journal_flag_rwsem);
+	percpu_up_read(&sbi->s_writepages_rwsem);
 	return ret;
 }
 
@@ -5830,7 +5830,7 @@ int ext4_change_inode_journal_flag(struc
 		}
 	}
 
-	percpu_down_write(&sbi->s_journal_flag_rwsem);
+	percpu_down_write(&sbi->s_writepages_rwsem);
 	jbd2_journal_lock_updates(journal);
 
 	/*
@@ -5847,7 +5847,7 @@ int ext4_change_inode_journal_flag(struc
 		err = jbd2_journal_flush(journal);
 		if (err < 0) {
 			jbd2_journal_unlock_updates(journal);
-			percpu_up_write(&sbi->s_journal_flag_rwsem);
+			percpu_up_write(&sbi->s_writepages_rwsem);
 			return err;
 		}
 		ext4_clear_inode_flag(inode, EXT4_INODE_JOURNAL_DATA);
@@ -5855,7 +5855,7 @@ int ext4_change_inode_journal_flag(struc
 	ext4_set_aops(inode);
 
 	jbd2_journal_unlock_updates(journal);
-	percpu_up_write(&sbi->s_journal_flag_rwsem);
+	percpu_up_write(&sbi->s_writepages_rwsem);
 
 	if (val)
 		up_write(&EXT4_I(inode)->i_mmap_sem);
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1018,7 +1018,7 @@ static void ext4_put_super(struct super_
 	percpu_counter_destroy(&sbi->s_freeinodes_counter);
 	percpu_counter_destroy(&sbi->s_dirs_counter);
 	percpu_counter_destroy(&sbi->s_dirtyclusters_counter);
-	percpu_free_rwsem(&sbi->s_journal_flag_rwsem);
+	percpu_free_rwsem(&sbi->s_writepages_rwsem);
 #ifdef CONFIG_QUOTA
 	for (i = 0; i < EXT4_MAXQUOTAS; i++)
 		kfree(get_qf_name(sb, sbi, i));
@@ -4581,7 +4581,7 @@ no_journal:
 		err = percpu_counter_init(&sbi->s_dirtyclusters_counter, 0,
 					  GFP_KERNEL);
 	if (!err)
-		err = percpu_init_rwsem(&sbi->s_journal_flag_rwsem);
+		err = percpu_init_rwsem(&sbi->s_writepages_rwsem);
 
 	if (err) {
 		ext4_msg(sb, KERN_ERR, "insufficient memory");
@@ -4681,7 +4681,7 @@ failed_mount6:
 	percpu_counter_destroy(&sbi->s_freeinodes_counter);
 	percpu_counter_destroy(&sbi->s_dirs_counter);
 	percpu_counter_destroy(&sbi->s_dirtyclusters_counter);
-	percpu_free_rwsem(&sbi->s_journal_flag_rwsem);
+	percpu_free_rwsem(&sbi->s_writepages_rwsem);
 failed_mount5:
 	ext4_ext_release(sb);
 	ext4_release_system_zone(sb);


