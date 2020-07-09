Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08916C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE92820672
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wrDFEDpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgGIXgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:36:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44254 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgGIXgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:36:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 069NMhMQ133575;
        Thu, 9 Jul 2020 23:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=XDrj4dpxWox4LCUiDc/hJGh6x47og11sLht12gY/T7c=;
 b=wrDFEDpFi5ATx//kIvse/3674YiRLB41UzYUEHGHDi2bD0Ul1CH30CHtYkZ0ZPuLxQN6
 p/QH4sBOIyBJXZj47kSLfO+thSzMF8w2SoXhARUeS4QhHDel7NHkTJaR2UsVLbbmIX2S
 uRltsC4orWSUnT1sYxgBl6QJugQCWI+A9xF9V8nistqOGgTwNLVVy4Zn/IeGGJfavvnM
 qR4QTgBW/c9a+7RBMMd4pL5gbR92RiBLtzITkAVmprBa+9qeDl418KA1Jv6btn3vC2f7
 7Yw/2mXHmgT3/0GU1twxJ3bQFsJ8SfbYBHQCDoSrlI6zoITuqjxm36CSwCBk1uTWahwH GA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 325y0amkr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 09 Jul 2020 23:36:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 069NMQOE063150;
        Thu, 9 Jul 2020 23:36:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 325k417mhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jul 2020 23:36:32 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 069NaV91025610;
        Thu, 9 Jul 2020 23:36:31 GMT
Received: from dhcp-10-159-228-101.vpn.oracle.com (/10.159.228.101)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Jul 2020 16:36:31 -0700
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     linux-raid@vger.kernel.org
Cc:     song@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] md: fix deadlock causing by sysfs_notify
Date:   Thu,  9 Jul 2020 16:35:45 -0700
Message-Id: <20200709233545.67954-1-junxiao.bi@oracle.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9677 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=21
 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007090154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9677 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=21
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007090154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following deadlock was captured. The first process is holding 'kernfs_mutex'
and hung by io. The io was staging in 'r1conf.pending_bio_list' of raid1 device,
this pending bio list would be flushed by second process 'md127_raid1', but
it was hung by 'kernfs_mutex'. Using sysfs_notify_dirent_safe() to replace
sysfs_notify() can fix it. There were other sysfs_notify() invoked from io
path, removed all of them.

 PID: 40430  TASK: ffff8ee9c8c65c40  CPU: 29  COMMAND: "probe_file"
  #0 [ffffb87c4df37260] __schedule at ffffffff9a8678ec
  #1 [ffffb87c4df372f8] schedule at ffffffff9a867f06
  #2 [ffffb87c4df37310] io_schedule at ffffffff9a0c73e6
  #3 [ffffb87c4df37328] __dta___xfs_iunpin_wait_3443 at ffffffffc03a4057 [xfs]
  #4 [ffffb87c4df373a0] xfs_iunpin_wait at ffffffffc03a6c79 [xfs]
  #5 [ffffb87c4df373b0] __dta_xfs_reclaim_inode_3357 at ffffffffc039a46c [xfs]
  #6 [ffffb87c4df37400] xfs_reclaim_inodes_ag at ffffffffc039a8b6 [xfs]
  #7 [ffffb87c4df37590] xfs_reclaim_inodes_nr at ffffffffc039bb33 [xfs]
  #8 [ffffb87c4df375b0] xfs_fs_free_cached_objects at ffffffffc03af0e9 [xfs]
  #9 [ffffb87c4df375c0] super_cache_scan at ffffffff9a287ec7
 #10 [ffffb87c4df37618] shrink_slab at ffffffff9a1efd93
 #11 [ffffb87c4df37700] shrink_node at ffffffff9a1f5968
 #12 [ffffb87c4df37788] do_try_to_free_pages at ffffffff9a1f5ea2
 #13 [ffffb87c4df377f0] try_to_free_mem_cgroup_pages at ffffffff9a1f6445
 #14 [ffffb87c4df37880] try_charge at ffffffff9a26cc5f
 #15 [ffffb87c4df37920] memcg_kmem_charge_memcg at ffffffff9a270f6a
 #16 [ffffb87c4df37958] new_slab at ffffffff9a251430
 #17 [ffffb87c4df379c0] ___slab_alloc at ffffffff9a251c85
 #18 [ffffb87c4df37a80] __slab_alloc at ffffffff9a25635d
 #19 [ffffb87c4df37ac0] kmem_cache_alloc at ffffffff9a251f89
 #20 [ffffb87c4df37b00] alloc_inode at ffffffff9a2a2b10
 #21 [ffffb87c4df37b20] iget_locked at ffffffff9a2a4854
 #22 [ffffb87c4df37b60] kernfs_get_inode at ffffffff9a311377
 #23 [ffffb87c4df37b80] kernfs_iop_lookup at ffffffff9a311e2b
 #24 [ffffb87c4df37ba8] lookup_slow at ffffffff9a290118
 #25 [ffffb87c4df37c10] walk_component at ffffffff9a291e83
 #26 [ffffb87c4df37c78] path_lookupat at ffffffff9a293619
 #27 [ffffb87c4df37cd8] filename_lookup at ffffffff9a2953af
 #28 [ffffb87c4df37de8] user_path_at_empty at ffffffff9a295566
 #29 [ffffb87c4df37e10] vfs_statx at ffffffff9a289787
 #30 [ffffb87c4df37e70] SYSC_newlstat at ffffffff9a289d5d
 #31 [ffffb87c4df37f18] sys_newlstat at ffffffff9a28a60e
 #32 [ffffb87c4df37f28] do_syscall_64 at ffffffff9a003949
 #33 [ffffb87c4df37f50] entry_SYSCALL_64_after_hwframe at ffffffff9aa001ad
     RIP: 00007f617a5f2905  RSP: 00007f607334f838  RFLAGS: 00000246
     RAX: ffffffffffffffda  RBX: 00007f6064044b20  RCX: 00007f617a5f2905
     RDX: 00007f6064044b20  RSI: 00007f6064044b20  RDI: 00007f6064005890
     RBP: 00007f6064044aa0   R8: 0000000000000030   R9: 000000000000011c
     R10: 0000000000000013  R11: 0000000000000246  R12: 00007f606417e6d0
     R13: 00007f6064044aa0  R14: 00007f6064044b10  R15: 00000000ffffffff
     ORIG_RAX: 0000000000000006  CS: 0033  SS: 002b

 PID: 927    TASK: ffff8f15ac5dbd80  CPU: 42  COMMAND: "md127_raid1"
  #0 [ffffb87c4df07b28] __schedule at ffffffff9a8678ec
  #1 [ffffb87c4df07bc0] schedule at ffffffff9a867f06
  #2 [ffffb87c4df07bd8] schedule_preempt_disabled at ffffffff9a86825e
  #3 [ffffb87c4df07be8] __mutex_lock at ffffffff9a869bcc
  #4 [ffffb87c4df07ca0] __mutex_lock_slowpath at ffffffff9a86a013
  #5 [ffffb87c4df07cb0] mutex_lock at ffffffff9a86a04f
  #6 [ffffb87c4df07cc8] kernfs_find_and_get_ns at ffffffff9a311d83
  #7 [ffffb87c4df07cf0] sysfs_notify at ffffffff9a314b3a
  #8 [ffffb87c4df07d18] md_update_sb at ffffffff9a688696
  #9 [ffffb87c4df07d98] md_update_sb at ffffffff9a6886d5
 #10 [ffffb87c4df07da8] md_check_recovery at ffffffff9a68ad9c
 #11 [ffffb87c4df07dd0] raid1d at ffffffffc01f0375 [raid1]
 #12 [ffffb87c4df07ea0] md_thread at ffffffff9a680348
 #13 [ffffb87c4df07f08] kthread at ffffffff9a0b8005
 #14 [ffffb87c4df07f50] ret_from_fork at ffffffff9aa00344

Cc: stable@vger.kernel.org
Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
---
 drivers/md/md-bitmap.c |  2 +-
 drivers/md/md.c        | 39 ++++++++++++++++++++++++++-------------
 drivers/md/md.h        |  7 ++++++-
 drivers/md/raid10.c    |  2 +-
 drivers/md/raid5.c     |  6 +++---
 5 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 95a5f3757fa3..d61b524ae440 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1631,7 +1631,7 @@ void md_bitmap_cond_end_sync(struct bitmap *bitmap, sector_t sector, bool force)
 		s += blocks;
 	}
 	bitmap->last_end_sync = jiffies;
-	sysfs_notify(&bitmap->mddev->kobj, NULL, "sync_completed");
+	sysfs_notify_dirent_safe(bitmap->mddev->sysfs_completed);
 }
 EXPORT_SYMBOL(md_bitmap_cond_end_sync);
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index f567f536b529..42a0b5ceaaec 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2444,6 +2444,10 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
 	if (sysfs_create_link(&rdev->kobj, ko, "block"))
 		/* failure here is OK */;
 	rdev->sysfs_state = sysfs_get_dirent_safe(rdev->kobj.sd, "state");
+	rdev->sysfs_unack_badblocks =
+		sysfs_get_dirent_safe(rdev->kobj.sd, "unacknowledged_bad_blocks");
+	rdev->sysfs_badblocks =
+		sysfs_get_dirent_safe(rdev->kobj.sd, "bad_blocks");
 
 	list_add_rcu(&rdev->same_set, &mddev->disks);
 	bd_link_disk_holder(rdev->bdev, mddev->gendisk);
@@ -2477,7 +2481,11 @@ static void unbind_rdev_from_array(struct md_rdev *rdev)
 	rdev->mddev = NULL;
 	sysfs_remove_link(&rdev->kobj, "block");
 	sysfs_put(rdev->sysfs_state);
+	sysfs_put(rdev->sysfs_unack_badblocks);
+	sysfs_put(rdev->sysfs_badblocks);
 	rdev->sysfs_state = NULL;
+	rdev->sysfs_unack_badblocks = NULL;
+	rdev->sysfs_badblocks = NULL;
 	rdev->badblocks.count = 0;
 	/* We need to delay this, otherwise we can deadlock when
 	 * writing to 'remove' to "dev/state".  We also need
@@ -2822,7 +2830,7 @@ void md_update_sb(struct mddev *mddev, int force_change)
 		goto repeat;
 	wake_up(&mddev->sb_wait);
 	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
-		sysfs_notify(&mddev->kobj, NULL, "sync_completed");
+		sysfs_notify_dirent_safe(mddev->sysfs_completed);
 
 	rdev_for_each(rdev, mddev) {
 		if (test_and_clear_bit(FaultRecorded, &rdev->flags))
@@ -4828,7 +4836,7 @@ action_store(struct mddev *mddev, const char *page, size_t len)
 		}
 		if (err)
 			return err;
-		sysfs_notify(&mddev->kobj, NULL, "degraded");
+		sysfs_notify_dirent_safe(mddev->sysfs_degraded);
 	} else {
 		if (cmd_match(page, "check"))
 			set_bit(MD_RECOVERY_CHECK, &mddev->recovery);
@@ -5534,6 +5542,11 @@ static void md_free(struct kobject *ko)
 
 	if (mddev->sysfs_state)
 		sysfs_put(mddev->sysfs_state);
+	if (mddev->sysfs_completed)
+		sysfs_put(mddev->sysfs_completed);
+	if (mddev->sysfs_degraded)
+		sysfs_put(mddev->sysfs_degraded);
+
 
 	if (mddev->gendisk)
 		del_gendisk(mddev->gendisk);
@@ -5695,6 +5708,8 @@ static int md_alloc(dev_t dev, char *name)
 	if (!error && mddev->kobj.sd) {
 		kobject_uevent(&mddev->kobj, KOBJ_ADD);
 		mddev->sysfs_state = sysfs_get_dirent_safe(mddev->kobj.sd, "array_state");
+		mddev->sysfs_completed = sysfs_get_dirent_safe(mddev->kobj.sd, "sync_completed");
+		mddev->sysfs_degraded = sysfs_get_dirent_safe(mddev->kobj.sd, "degraded");
 	}
 	mddev_put(mddev);
 	return error;
@@ -6049,7 +6064,7 @@ static int do_md_run(struct mddev *mddev)
 	kobject_uevent(&disk_to_dev(mddev->gendisk)->kobj, KOBJ_CHANGE);
 	sysfs_notify_dirent_safe(mddev->sysfs_state);
 	sysfs_notify_dirent_safe(mddev->sysfs_action);
-	sysfs_notify(&mddev->kobj, NULL, "degraded");
+	sysfs_notify_dirent_safe(mddev->sysfs_degraded);
 out:
 	clear_bit(MD_NOT_READY, &mddev->flags);
 	return err;
@@ -8767,7 +8782,7 @@ void md_do_sync(struct md_thread *thread)
 	} else
 		mddev->curr_resync = 3; /* no longer delayed */
 	mddev->curr_resync_completed = j;
-	sysfs_notify(&mddev->kobj, NULL, "sync_completed");
+	sysfs_notify_dirent_safe(mddev->sysfs_completed);
 	md_new_event(mddev);
 	update_time = jiffies;
 
@@ -8795,7 +8810,7 @@ void md_do_sync(struct md_thread *thread)
 				mddev->recovery_cp = j;
 			update_time = jiffies;
 			set_bit(MD_SB_CHANGE_CLEAN, &mddev->sb_flags);
-			sysfs_notify(&mddev->kobj, NULL, "sync_completed");
+			sysfs_notify_dirent_safe(mddev->sysfs_completed);
 		}
 
 		while (j >= mddev->resync_max &&
@@ -8902,7 +8917,7 @@ void md_do_sync(struct md_thread *thread)
 	    !test_bit(MD_RECOVERY_INTR, &mddev->recovery) &&
 	    mddev->curr_resync > 3) {
 		mddev->curr_resync_completed = mddev->curr_resync;
-		sysfs_notify(&mddev->kobj, NULL, "sync_completed");
+		sysfs_notify_dirent_safe(mddev->sysfs_completed);
 	}
 	mddev->pers->sync_request(mddev, max_sectors, &skipped);
 
@@ -9032,7 +9047,7 @@ static int remove_and_add_spares(struct mddev *mddev,
 	}
 
 	if (removed && mddev->kobj.sd)
-		sysfs_notify(&mddev->kobj, NULL, "degraded");
+		sysfs_notify_dirent_safe(mddev->sysfs_degraded);
 
 	if (this && removed)
 		goto no_add;
@@ -9315,8 +9330,7 @@ void md_reap_sync_thread(struct mddev *mddev)
 		/* success...*/
 		/* activate any spares */
 		if (mddev->pers->spare_active(mddev)) {
-			sysfs_notify(&mddev->kobj, NULL,
-				     "degraded");
+			sysfs_notify_dirent_safe(mddev->sysfs_degraded);
 			set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
 		}
 	}
@@ -9406,8 +9420,7 @@ int rdev_set_badblocks(struct md_rdev *rdev, sector_t s, int sectors,
 	if (rv == 0) {
 		/* Make sure they get written out promptly */
 		if (test_bit(ExternalBbl, &rdev->flags))
-			sysfs_notify(&rdev->kobj, NULL,
-				     "unacknowledged_bad_blocks");
+			sysfs_notify_dirent_safe(rdev->sysfs_unack_badblocks);
 		sysfs_notify_dirent_safe(rdev->sysfs_state);
 		set_mask_bits(&mddev->sb_flags, 0,
 			      BIT(MD_SB_CHANGE_CLEAN) | BIT(MD_SB_CHANGE_PENDING));
@@ -9428,7 +9441,7 @@ int rdev_clear_badblocks(struct md_rdev *rdev, sector_t s, int sectors,
 		s += rdev->data_offset;
 	rv = badblocks_clear(&rdev->badblocks, s, sectors);
 	if ((rv == 0) && test_bit(ExternalBbl, &rdev->flags))
-		sysfs_notify(&rdev->kobj, NULL, "bad_blocks");
+		sysfs_notify_dirent_safe(rdev->sysfs_badblocks);
 	return rv;
 }
 EXPORT_SYMBOL_GPL(rdev_clear_badblocks);
@@ -9658,7 +9671,7 @@ static int read_rdev(struct mddev *mddev, struct md_rdev *rdev)
 	if (rdev->recovery_offset == MaxSector &&
 	    !test_bit(In_sync, &rdev->flags) &&
 	    mddev->pers->spare_active(mddev))
-		sysfs_notify(&mddev->kobj, NULL, "degraded");
+		sysfs_notify_dirent_safe(mddev->sysfs_degraded);
 
 	put_page(swapout);
 	return 0;
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 612814d07d35..7385fac39e15 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -126,7 +126,10 @@ struct md_rdev {
 
 	struct kernfs_node *sysfs_state; /* handle for 'state'
 					   * sysfs entry */
-
+	/* handle for 'unacknowledged_bad_blocks' sysfs dentry */
+	struct kernfs_node *sysfs_unack_badblocks;
+	/* handle for 'bad_blocks' sysfs dentry */
+	struct kernfs_node *sysfs_badblocks;
 	struct badblocks badblocks;
 
 	struct {
@@ -420,6 +423,8 @@ struct mddev {
 							 * file in sysfs.
 							 */
 	struct kernfs_node		*sysfs_action;  /* handle for 'sync_action' */
+	struct kernfs_node		*sysfs_completed;	/*handle for 'sync_completed' */
+	struct kernfs_node		*sysfs_degraded;	/*handle for 'degraded' */
 
 	struct work_struct del_work;	/* used for delayed sysfs removal */
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index ec136e44aef7..b2de47eac238 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4454,7 +4454,7 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
 			sector_nr = conf->reshape_progress;
 		if (sector_nr) {
 			mddev->curr_resync_completed = sector_nr;
-			sysfs_notify(&mddev->kobj, NULL, "sync_completed");
+			sysfs_notify_dirent_safe(mddev->sysfs_completed);
 			*skipped = 1;
 			return sector_nr;
 		}
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index ab8067f9ce8c..09f59611dd9b 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5799,7 +5799,7 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr, int *sk
 		sector_div(sector_nr, new_data_disks);
 		if (sector_nr) {
 			mddev->curr_resync_completed = sector_nr;
-			sysfs_notify(&mddev->kobj, NULL, "sync_completed");
+			sysfs_notify_dirent_safe(mddev->sysfs_completed);
 			*skipped = 1;
 			retn = sector_nr;
 			goto finish;
@@ -5913,7 +5913,7 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr, int *sk
 		conf->reshape_safe = mddev->reshape_position;
 		spin_unlock_irq(&conf->device_lock);
 		wake_up(&conf->wait_for_overlap);
-		sysfs_notify(&mddev->kobj, NULL, "sync_completed");
+		sysfs_notify_dirent_safe(mddev->sysfs_completed);
 	}
 
 	INIT_LIST_HEAD(&stripes);
@@ -6020,7 +6020,7 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr, int *sk
 		conf->reshape_safe = mddev->reshape_position;
 		spin_unlock_irq(&conf->device_lock);
 		wake_up(&conf->wait_for_overlap);
-		sysfs_notify(&mddev->kobj, NULL, "sync_completed");
+		sysfs_notify_dirent_safe(mddev->sysfs_completed);
 	}
 ret:
 	return retn;
-- 
2.20.1 (Apple Git-117)

