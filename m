Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A446C38A29
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 07:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B725221F7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 07:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDSHpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 03:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725903AbgDSHpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 03:45:30 -0400
Received: from master.debian.org (master.debian.org [IPv6:2001:41b8:202:deb:216:36ff:fe40:4001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866FEC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 00:45:30 -0700 (PDT)
Received: from pabs by master.debian.org with local (Exim 4.92)
        (envelope-from <pabs@master.debian.org>)
        id 1jQ4Q5-00040V-QM; Sun, 19 Apr 2020 07:31:13 +0000
From:   Paul Wise <pabs3@bonedaddy.net>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Paul Wise <pabs3@bonedaddy.net>
Subject: [PATCH 1/3] dm: add support for targets that allow discard when one device does
Date:   Sun, 19 Apr 2020 15:30:24 +0800
Message-Id: <20200419073026.197967-2-pabs3@bonedaddy.net>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200419073026.197967-1-pabs3@bonedaddy.net>
References: <20200419073026.197967-1-pabs3@bonedaddy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the discards_supported variable to discard_support since
the discard support isn't just turned on or off and there
are now three types of discard support for dm targets.

Switch discard_support to using an enum so that the other types of
discard support (all devices or ignore devices) can be accommodated.

This is needed so that dm raid and dm raid1 can support discard for
arrays of devices of varying discard support where this is safe.

Signed-off-by: Paul Wise <pabs3@bonedaddy.net>
---
 drivers/md/dm-cache-target.c  |  2 +-
 drivers/md/dm-clone-target.c  |  2 +-
 drivers/md/dm-log-writes.c    |  2 +-
 drivers/md/dm-table.c         | 32 +++++++++++++++++++++-----------
 drivers/md/dm-thin.c          |  8 ++++----
 drivers/md/dm-zoned-target.c  |  2 +-
 include/linux/device-mapper.h | 13 ++++++++-----
 include/uapi/linux/dm-ioctl.h |  4 ++--
 8 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index d3bb355819a4..9aba81324579 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -2459,7 +2459,7 @@ static int cache_create(struct cache_args *ca, struct cache **result)
 	ti->flush_supported = true;
 
 	ti->num_discard_bios = 1;
-	ti->discards_supported = true;
+	ti->discard_support = DM_DISCARD_IGN_DEVS;
 
 	ti->per_io_data_size = sizeof(struct per_bio_data);
 
diff --git a/drivers/md/dm-clone-target.c b/drivers/md/dm-clone-target.c
index 5ce96ddf1ce1..f5b2c1998628 100644
--- a/drivers/md/dm-clone-target.c
+++ b/drivers/md/dm-clone-target.c
@@ -1938,7 +1938,7 @@ static int clone_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->flush_supported = true;
 
 	/* Enable discards */
-	ti->discards_supported = true;
+	ti->discard_support = DM_DISCARD_IGN_DEVS;
 	ti->num_discard_bios = 1;
 
 	ti->private = clone;
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index 8ea20b56b4d6..9414214c250d 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -593,7 +593,7 @@ static int log_writes_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->num_flush_bios = 1;
 	ti->flush_supported = true;
 	ti->num_discard_bios = 1;
-	ti->discards_supported = true;
+	ti->discard_support = DM_DISCARD_IGN_DEVS;
 	ti->per_io_data_size = sizeof(struct per_bio_data);
 	ti->private = lc;
 	return 0;
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 0a2cc197f62b..0e5a38da0ca8 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -789,8 +789,8 @@ int dm_table_add_target(struct dm_table *t, const char *type,
 
 	t->highs[t->num_targets++] = tgt->begin + tgt->len - 1;
 
-	if (!tgt->num_discard_bios && tgt->discards_supported)
-		DMWARN("%s: %s: ignoring discards_supported because num_discard_bios is zero.",
+	if (!tgt->num_discard_bios && (tgt->discard_support != DM_DISCARD_ALL_DEVS))
+		DMWARN("%s: %s: ignoring discard support because num_discard_bios is zero.",
 		       dm_device_name(t->md), type);
 
 	return 0;
@@ -1786,6 +1786,14 @@ static bool dm_table_supports_write_zeroes(struct dm_table *t)
 	return true;
 }
 
+static int device_discard_capable(struct dm_target *ti, struct dm_dev *dev,
+				      sector_t start, sector_t len, void *data)
+{
+	struct request_queue *q = bdev_get_queue(dev->bdev);
+
+	return q && blk_queue_discard(q);
+}
+
 static int device_not_discard_capable(struct dm_target *ti, struct dm_dev *dev,
 				      sector_t start, sector_t len, void *data)
 {
@@ -1805,15 +1813,17 @@ static bool dm_table_supports_discards(struct dm_table *t)
 		if (!ti->num_discard_bios)
 			return false;
 
-		/*
-		 * Either the target provides discard support (as implied by setting
-		 * 'discards_supported') or it relies on _all_ data devices having
-		 * discard support.
-		 */
-		if (!ti->discards_supported &&
-		    (!ti->type->iterate_devices ||
-		     ti->type->iterate_devices(ti, device_not_discard_capable, NULL)))
-			return false;
+		if (ti->discard_support == DM_DISCARD_IGN_DEVS) {
+			continue;
+		} else if (ti->discard_support == DM_DISCARD_ANY_DEVS) {
+			if (!ti->type->iterate_devices ||
+			     !ti->type->iterate_devices(ti, device_discard_capable, NULL))
+				return false;
+		} else {
+			if (!ti->type->iterate_devices ||
+			     ti->type->iterate_devices(ti, device_not_discard_capable, NULL))
+				return false;
+		}
 	}
 
 	return true;
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index fa8d5464c1fb..f9384e1a44ce 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -3402,11 +3402,11 @@ static int pool_ctr(struct dm_target *ti, unsigned argc, char **argv)
 		ti->num_discard_bios = 1;
 
 		/*
-		 * Setting 'discards_supported' circumvents the normal
-		 * stacking of discard limits (this keeps the pool and
+		 * Setting this circumvents the normal stacking
+		 * of discard limits (this keeps the pool and
 		 * thin devices' discard limits consistent).
 		 */
-		ti->discards_supported = true;
+		ti->discard_support = DM_DISCARD_IGN_DEVS;
 	}
 	ti->private = pt;
 
@@ -4266,7 +4266,7 @@ static int thin_ctr(struct dm_target *ti, unsigned argc, char **argv)
 
 	/* In case the pool supports discards, pass them on. */
 	if (tc->pool->pf.discard_enabled) {
-		ti->discards_supported = true;
+		ti->discard_support = DM_DISCARD_IGN_DEVS;
 		ti->num_discard_bios = 1;
 	}
 
diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
index f4f83d39b3dc..76e7886cba9e 100644
--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -796,7 +796,7 @@ static int dmz_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->num_write_zeroes_bios = 1;
 	ti->per_io_data_size = sizeof(struct dmz_bioctx);
 	ti->flush_supported = true;
-	ti->discards_supported = true;
+	ti->discard_support = DM_DISCARD_IGN_DEVS;
 
 	/* The exposed capacity is the number of chunks that can be mapped */
 	ti->len = (sector_t)dmz_nr_chunks(dmz->metadata) << dev->zone_nr_sectors_shift;
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index af48d9da3916..67cb0f7427e4 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -252,6 +252,12 @@ struct target_type {
 #define DM_TARGET_ZONED_HM		0x00000040
 #define dm_target_supports_zoned_hm(type) ((type)->features & DM_TARGET_ZONED_HM)
 
+enum dm_discard_mode {
+	DM_DISCARD_ALL_DEVS = 0,
+	DM_DISCARD_ANY_DEVS = 1,
+	DM_DISCARD_IGN_DEVS = 2,
+};
+
 struct dm_target {
 	struct dm_table *table;
 	struct target_type *type;
@@ -315,11 +321,8 @@ struct dm_target {
 	 */
 	bool flush_supported:1;
 
-	/*
-	 * Set if this target needs to receive discards regardless of
-	 * whether or not its underlying devices have support.
-	 */
-	bool discards_supported:1;
+	/* Use to specify the discard support of this target */
+	enum dm_discard_mode discard_support;
 };
 
 /* Each target can link one of these into the table */
diff --git a/include/uapi/linux/dm-ioctl.h b/include/uapi/linux/dm-ioctl.h
index 6622912c2342..360bd55c1681 100644
--- a/include/uapi/linux/dm-ioctl.h
+++ b/include/uapi/linux/dm-ioctl.h
@@ -272,9 +272,9 @@ enum {
 #define DM_DEV_SET_GEOMETRY	_IOWR(DM_IOCTL, DM_DEV_SET_GEOMETRY_CMD, struct dm_ioctl)
 
 #define DM_VERSION_MAJOR	4
-#define DM_VERSION_MINOR	42
+#define DM_VERSION_MINOR	43
 #define DM_VERSION_PATCHLEVEL	0
-#define DM_VERSION_EXTRA	"-ioctl (2020-02-27)"
+#define DM_VERSION_EXTRA	"-ioctl (2020-04-14)"
 
 /* Status bits */
 #define DM_READONLY_FLAG	(1 << 0) /* In/Out */
-- 
2.26.1

