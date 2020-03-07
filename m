Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D6CC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 15:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C35220675
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 15:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgCGPRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 10:17:10 -0500
Received: from 7.mo4.mail-out.ovh.net ([178.33.253.54]:53115 "EHLO
        7.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgCGPRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 10:17:10 -0500
Received: from player729.ha.ovh.net (unknown [10.108.42.145])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id 8EB3A226612
        for <linux-kernel@vger.kernel.org>; Sat,  7 Mar 2020 15:57:26 +0100 (CET)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player729.ha.ovh.net (Postfix) with ESMTPSA id A9C13104ED0CF;
        Sat,  7 Mar 2020 14:57:17 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2] Document genhd capability flags
Date:   Sat,  7 Mar 2020 15:56:59 +0100
Message-Id: <20200307145659.22657-1-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13138688963716533573
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddugedgjeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjedvledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
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
perhaps more user-oriented than might be expected. Since the values
are shown to users in hexadecimal, the documentation lists them in
hexadecimal, and the constant declarations are adjusted to match.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/block/capability.rst | 16 ++-----
 include/linux/genhd.h              | 69 +++++++++++++++++++++++++-----
 2 files changed, 62 insertions(+), 23 deletions(-)

diff --git a/Documentation/block/capability.rst b/Documentation/block/capability.rst
index 2cf258d64bbe..160a5148b915 100644
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
+``capability`` is a bitfield, printed in hexadecimal, indicating which
+capabilities a specific block device supports:
 
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
index 6fbe58538ad6..e7244fb6b6ad 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -133,17 +133,64 @@ struct hd_struct {
 	struct rcu_work rcu_work;
 };
 
-#define GENHD_FL_REMOVABLE			1
-/* 2 is unused */
-#define GENHD_FL_MEDIA_CHANGE_NOTIFY		4
-#define GENHD_FL_CD				8
-#define GENHD_FL_UP				16
-#define GENHD_FL_SUPPRESS_PARTITION_INFO	32
-#define GENHD_FL_EXT_DEVT			64 /* allow extended devt */
-#define GENHD_FL_NATIVE_CAPACITY		128
-#define GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE	256
-#define GENHD_FL_NO_PART_SCAN			512
-#define GENHD_FL_HIDDEN				1024
+/**
+ * DOC: genhd capability flags
+ *
+ * ``GENHD_FL_REMOVABLE`` (0x0001): indicates that the block device
+ * gives access to removable media.
+ * When set, the device remains present even when media is not
+ * inserted.
+ * Must not be set for devices which are removed entirely when the
+ * media is removed.
+ *
+ * ``GENHD_FL_CD`` (0x0008): the block device is a CD-ROM-style
+ * device.
+ * Affects responses to the ``CDROM_GET_CAPABILITY`` ioctl.
+ *
+ * ``GENHD_FL_UP`` (0x0010): indicates that the block device is "up",
+ * with a similar meaning to network interfaces.
+ *
+ * ``GENHD_FL_SUPPRESS_PARTITION_INFO`` (0x0020): don't include
+ * partition information in ``/proc/partitions`` or in the output of
+ * printk_all_partitions().
+ * Used for the null block device and some MMC devices.
+ *
+ * ``GENHD_FL_EXT_DEVT`` (0x0040): the driver supports extended
+ * dynamic ``dev_t``, i.e. it wants extended device numbers
+ * (``BLOCK_EXT_MAJOR``).
+ * This affects the maximum number of partitions.
+ *
+ * ``GENHD_FL_NATIVE_CAPACITY`` (0x0080): based on information in the
+ * partition table, the device's capacity has been extended to its
+ * native capacity; i.e. the device has hidden capacity used by one
+ * of the partitions (this is a flag used so that native capacity is
+ * only ever unlocked once).
+ *
+ * ``GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE`` (0x0100): event polling is
+ * blocked whenever a writer holds an exclusive lock.
+ *
+ * ``GENHD_FL_NO_PART_SCAN`` (0x0200): partition scanning is disabled.
+ * Used for loop devices in their default settings and some MMC
+ * devices.
+ *
+ * ``GENHD_FL_HIDDEN`` (0x0400): the block device is hidden; it
+ * doesn't produce events, doesn't appear in sysfs, and doesn't have
+ * an associated ``bdev``.
+ * Implies ``GENHD_FL_SUPPRESS_PARTITION_INFO`` and
+ * ``GENHD_FL_NO_PART_SCAN``.
+ * Used for multipath devices.
+ */
+#define GENHD_FL_REMOVABLE			0x0001
+/* 2 is unused (used to be GENHD_FL_DRIVERFS) */
+/* 4 is unused (used to be GENHD_FL_MEDIA_CHANGE_NOTIFY) */
+#define GENHD_FL_CD				0x0008
+#define GENHD_FL_UP				0x0010
+#define GENHD_FL_SUPPRESS_PARTITION_INFO	0x0020
+#define GENHD_FL_EXT_DEVT			0x0040
+#define GENHD_FL_NATIVE_CAPACITY		0x0080
+#define GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE	0x0100
+#define GENHD_FL_NO_PART_SCAN			0x0200
+#define GENHD_FL_HIDDEN				0x0400
 
 enum {
 	DISK_EVENT_MEDIA_CHANGE			= 1 << 0, /* media changed */

base-commit: aeb542a1b5c507ea117d21c3e3e012ba16f065ac
-- 
2.20.1

