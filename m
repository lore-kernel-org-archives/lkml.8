Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE2CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61477206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438061AbgE2AKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 20:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437871AbgE2AKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 20:10:25 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CFCC08C5C6;
        Thu, 28 May 2020 17:10:25 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSbP-00HEZV-Gt; Fri, 29 May 2020 00:10:23 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] scsi_ioctl.c: switch SCSI_IOCTL_GET_IDLUN to copy_to_user()
Date:   Fri, 29 May 2020 01:10:22 +0100
Message-Id: <20200529001023.4107547-2-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200529001023.4107547-1-viro@ZenIV.linux.org.uk>
References: <20200529000957.GW23230@ZenIV.linux.org.uk>
 <20200529001023.4107547-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/scsi/scsi_ioctl.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
index 8f3af87b6bb0..45d04b7b2643 100644
--- a/drivers/scsi/scsi_ioctl.c
+++ b/drivers/scsi/scsi_ioctl.c
@@ -211,18 +211,18 @@ static int scsi_ioctl_common(struct scsi_device *sdev, int cmd, void __user *arg
 	}
 
 	switch (cmd) {
-	case SCSI_IOCTL_GET_IDLUN:
-		if (!access_ok(arg, sizeof(struct scsi_idlun)))
+	case SCSI_IOCTL_GET_IDLUN: {
+		struct scsi_idlun v = {
+			.dev_id = (sdev->id & 0xff)
+				 + ((sdev->lun & 0xff) << 8)
+				 + ((sdev->channel & 0xff) << 16)
+				 + ((sdev->host->host_no & 0xff) << 24),
+			.host_unique_id = sdev->host->unique_id
+		};
+		if (copy_to_user(arg, &v, sizeof(struct scsi_idlun)))
 			return -EFAULT;
-
-		__put_user((sdev->id & 0xff)
-			 + ((sdev->lun & 0xff) << 8)
-			 + ((sdev->channel & 0xff) << 16)
-			 + ((sdev->host->host_no & 0xff) << 24),
-			 &((struct scsi_idlun __user *)arg)->dev_id);
-		__put_user(sdev->host->unique_id,
-			 &((struct scsi_idlun __user *)arg)->host_unique_id);
 		return 0;
+	}
 	case SCSI_IOCTL_GET_BUS_NUMBER:
 		return put_user(sdev->host->host_no, (int __user *)arg);
 	case SCSI_IOCTL_PROBE_HOST:
-- 
2.11.0

