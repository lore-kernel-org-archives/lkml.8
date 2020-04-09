Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998FFC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F52F2082D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="vEciI4kl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgDITgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:36:09 -0400
Received: from mail.efficios.com ([167.114.26.124]:47238 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgDITgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:36:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0D266280AFF;
        Thu,  9 Apr 2020 15:36:01 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1xUB_dCUfYTA; Thu,  9 Apr 2020 15:36:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CF22528100F;
        Thu,  9 Apr 2020 15:35:59 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CF22528100F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1586460959;
        bh=sd06b6HYqBdAiANYGacvpOXGpwn0UOdA7tBIF8l17eQ=;
        h=From:To:Date:Message-Id;
        b=vEciI4kli64Cjh1lmpecaIyIwZ27XgDyKJ/Qm+QHCtp2/kUjG0+prYFJCZwjDN1yv
         o7mJcKtpBfKG67BFDEk5TZLNs56g9QHn4F55+tuZcSoqjvSnWo52z9/GrqjGQU8d+N
         KTItjTx5ECVETKx0xE/VOBHuZRlYlzY5x811ggQHSHXzYoT8jXcPV+Qc27fLK5mTG7
         T9SjZ+lJqCHa2ZzvieXNgc9w219a6EkjGbVKRC8I9UUqHOV7vrgYR2Fzj9SrwpD7dL
         jz64nJPoSSTcTxQoSJP5vyNrCUTFSQ5D8VQ6qnGzggNFHoag4DcAb3oeKyc635pkX0
         5awEqNiKHiFNQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HT3TfwOA5RZl; Thu,  9 Apr 2020 15:35:59 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 4B69E280D6C;
        Thu,  9 Apr 2020 15:35:59 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, akpm@linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, rostedt@goodmis.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tejun Heo <tj@kernel.org>
Subject: [RFC PATCH 7/9] block: genhd: export-GPL gendisk_name
Date:   Thu,  9 Apr 2020 15:35:41 -0400
Message-Id: <20200409193543.18115-8-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409193543.18115-1-mathieu.desnoyers@efficios.com>
References: <20200409193543.18115-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Iteration on class devices is exported for use by GPL modules, but the
helper for formatting generic disk name is not.

The symbol "disk_name" used for this helper could benefit from
a more specific namespacing. Rename it to "gendisk_name" and adapt all
users across the kernel tree.

Export the generic disk name formatting helper for use by GPL modules.
This is useful for tracing a meaningful list of block devices from
tracers implemented as GPL modules.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 block/bio.c             |  2 +-
 block/blk-settings.c    |  2 +-
 block/blk.h             |  2 +-
 block/genhd.c           | 13 +++++++------
 block/partitions/core.c |  2 +-
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 21cbaa6a1c20..d6665bab1fef 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -725,7 +725,7 @@ EXPORT_SYMBOL(bio_clone_fast);
 
 const char *bio_devname(struct bio *bio, char *buf)
 {
-	return disk_name(bio->bi_disk, bio->bi_partno, buf);
+	return gendisk_name(bio->bi_disk, bio->bi_partno, buf);
 }
 EXPORT_SYMBOL(bio_devname);
 
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 14397b4c4b53..0b2eed0ed556 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -622,7 +622,7 @@ void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
 	if (bdev_stack_limits(&t->limits, bdev, offset >> 9) < 0) {
 		char top[BDEVNAME_SIZE], bottom[BDEVNAME_SIZE];
 
-		disk_name(disk, 0, top);
+		gendisk_name(disk, 0, top);
 		bdevname(bdev, bottom);
 
 		printk(KERN_NOTICE "%s: Warning: Device %s is misaligned\n",
diff --git a/block/blk.h b/block/blk.h
index 0a94ec68af32..21978defa4b5 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -385,7 +385,7 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector);
 int blk_alloc_devt(struct hd_struct *part, dev_t *devt);
 void blk_free_devt(dev_t devt);
 void blk_invalidate_devt(dev_t devt);
-char *disk_name(struct gendisk *hd, int partno, char *buf);
+char *gendisk_name(struct gendisk *hd, int partno, char *buf);
 #define ADDPART_FLAG_NONE	0
 #define ADDPART_FLAG_RAID	1
 #define ADDPART_FLAG_WHOLEDISK	2
diff --git a/block/genhd.c b/block/genhd.c
index 06b642b23a07..409c5a92b0b9 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -74,7 +74,7 @@ EXPORT_SYMBOL_GPL(set_capacity_revalidate_and_notify);
  * Format the device name of the indicated disk into the supplied buffer and
  * return a pointer to that same buffer for convenience.
  */
-char *disk_name(struct gendisk *hd, int partno, char *buf)
+char *gendisk_name(struct gendisk *hd, int partno, char *buf)
 {
 	if (!partno)
 		snprintf(buf, BDEVNAME_SIZE, "%s", hd->disk_name);
@@ -85,10 +85,11 @@ char *disk_name(struct gendisk *hd, int partno, char *buf)
 
 	return buf;
 }
+EXPORT_SYMBOL_GPL(gendisk_name);
 
 const char *bdevname(struct block_device *bdev, char *buf)
 {
-	return disk_name(bdev->bd_disk, bdev->bd_part->partno, buf);
+	return gendisk_name(bdev->bd_disk, bdev->bd_part->partno, buf);
 }
 EXPORT_SYMBOL(bdevname);
 
@@ -1081,8 +1082,8 @@ void __init printk_all_partitions(void)
 
 			printk("%s%s %10llu %s %s", is_part0 ? "" : "  ",
 			       bdevt_str(part_devt(part), devt_buf),
-			       (unsigned long long)part_nr_sects_read(part) >> 1
-			       , disk_name(disk, part->partno, name_buf),
+			       (unsigned long long)part_nr_sects_read(part) >> 1,
+			       gendisk_name(disk, part->partno, name_buf),
 			       part->info ? part->info->uuid : "");
 			if (is_part0) {
 				if (dev->parent && dev->parent->driver)
@@ -1175,7 +1176,7 @@ static int show_partition(struct seq_file *seqf, void *v)
 		seq_printf(seqf, "%4d  %7d %10llu %s\n",
 			   MAJOR(part_devt(part)), MINOR(part_devt(part)),
 			   (unsigned long long)part_nr_sects_read(part) >> 1,
-			   disk_name(sgp, part->partno, buf));
+			   gendisk_name(sgp, part->partno, buf));
 	disk_part_iter_exit(&piter);
 
 	return 0;
@@ -1583,7 +1584,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 			   "%lu %u"
 			   "\n",
 			   MAJOR(part_devt(hd)), MINOR(part_devt(hd)),
-			   disk_name(gp, hd->partno, buf),
+			   gendisk_name(gp, hd->partno, buf),
 			   stat.ios[STAT_READ],
 			   stat.merges[STAT_READ],
 			   stat.sectors[STAT_READ],
diff --git a/block/partitions/core.c b/block/partitions/core.c
index b79c4513629b..56f0b730a2a0 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -129,7 +129,7 @@ static struct parsed_partitions *check_partition(struct gendisk *hd,
 	state->pp_buf[0] = '\0';
 
 	state->bdev = bdev;
-	disk_name(hd, 0, state->name);
+	gendisk_name(hd, 0, state->name);
 	snprintf(state->pp_buf, PAGE_SIZE, " %s:", state->name);
 	if (isdigit(state->name[strlen(state->name)-1]))
 		sprintf(state->name, "p");
-- 
2.17.1

