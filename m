Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C50C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC002051A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgCFRQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:16:51 -0500
Received: from 2.mo173.mail-out.ovh.net ([178.33.251.49]:42992 "EHLO
        2.mo173.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFRQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:16:51 -0500
Received: from player168.ha.ovh.net (unknown [10.108.57.18])
        by mo173.mail-out.ovh.net (Postfix) with ESMTP id 51AFC134567
        for <linux-kernel@vger.kernel.org>; Fri,  6 Mar 2020 18:16:48 +0100 (CET)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player168.ha.ovh.net (Postfix) with ESMTPSA id 107B7101F59BD;
        Fri,  6 Mar 2020 17:16:42 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH] Document genhd capability flags
Date:   Fri,  6 Mar 2020 18:16:21 +0100
Message-Id: <20200306171621.24134-1-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 9619688804342385933
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudduvddguddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhduieekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel documentation includes a brief section about genhd
capabilities, but it turns out that the only documented
capability (GENHD_FL_MEDIA_CHANGE_NOTIFY) isn't used any more.

This patch removes that flag, and documents the rest, based on my
understanding of the current uses of these flags in the kernel. The
documentation is kept in the header file, alongside the declarations,
in the hope that it will be kept up-to-date in future; the kernel
documentation is changed to include the documentation generated from
the header file.

Because the ultimate goal is to provide some end-user
documentation (or end-administrator documentation), the comments are
perhaps more user-oriented than might be expected.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/block/capability.rst | 16 +++------
 include/linux/genhd.h              | 52 ++++++++++++++++++++++++++++--
 2 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/Documentation/block/capability.rst b/Documentation/block/capability.rst
index 2cf258d64bbe..26b9eccc48eb 100644
--- a/Documentation/block/capability.rst
+++ b/Documentation/block/capability.rst
@@ -2,17 +2,9 @@
 Generic Block Device Capability
 ===============================
 
-This file documents the sysfs file block/<disk>/capability
+This file documents the sysfs file ``block/<disk>/capability``.
 
-capability is a hex word indicating which capabilities a specific disk
-supports.  For more information on bits not listed here, see
-include/linux/genhd.h
+``capability`` is a hex word indicating which capabilities a specific
+disk supports:
 
-GENHD_FL_MEDIA_CHANGE_NOTIFY
-----------------------------
-
-Value: 4
-
-When this bit is set, the disk supports Asynchronous Notification
-of media change events.  These events will be broadcast to user
-space via kernel uevent.
+.. kernel-doc:: include/linux/genhd.h
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 6fbe58538ad6..d56aa4ccd34f 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -133,13 +133,59 @@ struct hd_struct {
 	struct rcu_work rcu_work;
 };
 
+/**
+ * DOC: genhd capability flags
+ *
+ * ``GENHD_FL_REMOVABLE`` (1): indicates that the block device gives
+ * access to removable media.
+ * When set, the device remains present even when media is not
+ * inserted.
+ * Must not be set for devices which are removed entirely when the
+ * media is removed.
+ *
+ * ``GENHD_FL_CD`` (8): the block device is a CD-ROM-style device.
+ * Affects responses to the ``CDROM_GET_CAPABILITY`` ioctl.
+ *
+ * ``GENHD_FL_UP`` (16): indicates that the block device is "up", with
+ * a similar meaning to network interfaces.
+ *
+ * ``GENHD_FL_SUPPRESS_PARTITION_INFO`` (32): don't include partition
+ * information in ``/proc/partitions`` or in the output of
+ * printk_all_partitions().
+ * Used for the null block device and some MMC devices.
+ *
+ * ``GENHD_FL_EXT_DEVT`` (64): the driver supports extended dynamic
+ * ``dev_t``, i.e. it wants extended device numbers
+ * (``BLOCK_EXT_MAJOR``).
+ * This affects the maximum number of partitions.
+ *
+ * ``GENHD_FL_NATIVE_CAPACITY`` (128): based on information in the
+ * partition table, the device's capacity has been extended to its
+ * native capacity; i.e. the device has hidden capacity used by one
+ * of the partitions (this is a flag used so that native capacity is
+ * only ever unlocked once).
+ *
+ * ``GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE`` (256): event polling is
+ * blocked whenever a writer holds an exclusive lock.
+ *
+ * ``GENHD_FL_NO_PART_SCAN`` (512): partition scanning is disabled.
+ * Used for loop devices in their default settings and some MMC
+ * devices.
+ *
+ * ``GENHD_FL_HIDDEN`` (1024): the block device is hidden; it doesn't
+ * produce events, doesn't appear in sysfs, and doesn't have an
+ * associated ``bdev``.
+ * Implies ``GENHD_FL_SUPPRESS_PARTITION_INFO`` and
+ * ``GENHD_FL_NO_PART_SCAN``.
+ * Used for multipath devices.
+ */
 #define GENHD_FL_REMOVABLE			1
-/* 2 is unused */
-#define GENHD_FL_MEDIA_CHANGE_NOTIFY		4
+/* 2 is unused (used to be GENHD_FL_DRIVERFS) */
+/* 4 is unused (used to be GENHD_FL_MEDIA_CHANGE_NOTIFY) */
 #define GENHD_FL_CD				8
 #define GENHD_FL_UP				16
 #define GENHD_FL_SUPPRESS_PARTITION_INFO	32
-#define GENHD_FL_EXT_DEVT			64 /* allow extended devt */
+#define GENHD_FL_EXT_DEVT			64
 #define GENHD_FL_NATIVE_CAPACITY		128
 #define GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE	256
 #define GENHD_FL_NO_PART_SCAN			512

base-commit: aeb542a1b5c507ea117d21c3e3e012ba16f065ac
-- 
2.20.1

