Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFE7C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 17:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA13D20768
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 17:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbgDHRKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 13:10:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:51446 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbgDHRKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 13:10:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A1977ABF5;
        Wed,  8 Apr 2020 17:10:14 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Daniel Wagner <dwagner@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] scsi: core: Rate limit "rejecting I/O" messages
Date:   Wed,  8 Apr 2020 19:10:12 +0200
Message-Id: <20200408171012.76890-1-dwagner@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent excessive logging by rate limiting the "rejecting I/O"
messages. For example in setups where remote syslog is used the link
is saturated by those messages when a storage controller/disk
misbehaves.

Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/scsi/scsi_lib.c    |  4 ++--
 include/scsi/scsi_device.h | 10 ++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 47835c4b4ee0..01c35c58c6f3 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1217,7 +1217,7 @@ scsi_prep_state_check(struct scsi_device *sdev, struct request *req)
 		 */
 		if (!sdev->offline_already) {
 			sdev->offline_already = true;
-			sdev_printk(KERN_ERR, sdev,
+			sdev_printk_ratelimited(KERN_ERR, sdev,
 				    "rejecting I/O to offline device\n");
 		}
 		return BLK_STS_IOERR;
@@ -1226,7 +1226,7 @@ scsi_prep_state_check(struct scsi_device *sdev, struct request *req)
 		 * If the device is fully deleted, we refuse to
 		 * process any commands as well.
 		 */
-		sdev_printk(KERN_ERR, sdev,
+		sdev_printk_ratelimited(KERN_ERR, sdev,
 			    "rejecting I/O to dead device\n");
 		return BLK_STS_IOERR;
 	case SDEV_BLOCK:
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index c3cba2aaf934..8be40b0e1b8f 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -257,6 +257,16 @@ sdev_prefix_printk(const char *, const struct scsi_device *, const char *,
 #define sdev_printk(l, sdev, fmt, a...)				\
 	sdev_prefix_printk(l, sdev, NULL, fmt, ##a)
 
+#define sdev_printk_ratelimited(l, sdev, fmt, a...)			\
+({									\
+	static DEFINE_RATELIMIT_STATE(_rs,				\
+				      DEFAULT_RATELIMIT_INTERVAL,	\
+				      DEFAULT_RATELIMIT_BURST);		\
+									\
+	if (__ratelimit(&_rs))						\
+		sdev_prefix_printk(l, sdev, NULL, fmt, ##a);		\
+})
+
 __printf(3, 4) void
 scmd_printk(const char *, const struct scsi_cmnd *, const char *, ...);
 
-- 
2.16.4

