Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB32C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DC87206B9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgDTPXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:23:31 -0400
Received: from foss.arm.com ([217.140.110.172]:50888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgDTPXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:23:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9A30C14;
        Mon, 20 Apr 2020 08:23:29 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F19AE3F73D;
        Mon, 20 Apr 2020 08:23:28 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com
Subject: [PATCH 1/4] firmware: arm_scmi: Rename .clear_notification() transport_ops
Date:   Mon, 20 Apr 2020 16:23:12 +0100
Message-Id: <20200420152315.21008-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420152315.21008-1-cristian.marussi@arm.com>
References: <20200420152315.21008-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCMI transport operation .clear_notification() is indeed a generic method
to clear the channel in a transport dependent way: as such it could be a
useful helper also in other contexts.

Rename such method as .clear_channel(), renaming accordingly also its
already existent call-sites.

No functional change.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h  | 6 +++---
 drivers/firmware/arm_scmi/driver.c  | 4 ++--
 drivers/firmware/arm_scmi/mailbox.c | 6 +++---
 drivers/firmware/arm_scmi/shmem.c   | 2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 07eb33c1576b..31fe5a22a011 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -179,7 +179,7 @@ struct scmi_chan_info {
  * @mark_txdone: Callback to mark tx as done
  * @fetch_response: Callback to fetch response
  * @fetch_notification: Callback to fetch notification
- * @clear_notification: Callback to clear a pending notification
+ * @clear_channel: Callback to clear a channel
  * @poll_done: Callback to poll transfer status
  */
 struct scmi_transport_ops {
@@ -194,7 +194,7 @@ struct scmi_transport_ops {
 			       struct scmi_xfer *xfer);
 	void (*fetch_notification)(struct scmi_chan_info *cinfo,
 				   size_t max_len, struct scmi_xfer *xfer);
-	void (*clear_notification)(struct scmi_chan_info *cinfo);
+	void (*clear_channel)(struct scmi_chan_info *cinfo);
 	bool (*poll_done)(struct scmi_chan_info *cinfo, struct scmi_xfer *xfer);
 };
 
@@ -232,6 +232,6 @@ void shmem_fetch_response(struct scmi_shared_mem __iomem *shmem,
 			  struct scmi_xfer *xfer);
 void shmem_fetch_notification(struct scmi_shared_mem __iomem *shmem,
 			      size_t max_len, struct scmi_xfer *xfer);
-void shmem_clear_notification(struct scmi_shared_mem __iomem *shmem);
+void shmem_clear_channel(struct scmi_shared_mem __iomem *shmem);
 bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
 		     struct scmi_xfer *xfer);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 332edf1b09fc..90c7a0bb62ef 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -213,7 +213,7 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 	if (IS_ERR(xfer)) {
 		dev_err(dev, "failed to get free message slot (%ld)\n",
 			PTR_ERR(xfer));
-		info->desc->ops->clear_notification(cinfo);
+		info->desc->ops->clear_channel(cinfo);
 		return;
 	}
 
@@ -228,7 +228,7 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 
 	__scmi_xfer_put(minfo, xfer);
 
-	info->desc->ops->clear_notification(cinfo);
+	info->desc->ops->clear_channel(cinfo);
 }
 
 static void scmi_handle_response(struct scmi_chan_info *cinfo,
diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index 19ee058f9f44..6998dc86b5ce 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -166,11 +166,11 @@ static void mailbox_fetch_notification(struct scmi_chan_info *cinfo,
 	shmem_fetch_notification(smbox->shmem, max_len, xfer);
 }
 
-static void mailbox_clear_notification(struct scmi_chan_info *cinfo)
+static void mailbox_clear_channel(struct scmi_chan_info *cinfo)
 {
 	struct scmi_mailbox *smbox = cinfo->transport_info;
 
-	shmem_clear_notification(smbox->shmem);
+	shmem_clear_channel(smbox->shmem);
 }
 
 static bool
@@ -189,7 +189,7 @@ static struct scmi_transport_ops scmi_mailbox_ops = {
 	.mark_txdone = mailbox_mark_txdone,
 	.fetch_response = mailbox_fetch_response,
 	.fetch_notification = mailbox_fetch_notification,
-	.clear_notification = mailbox_clear_notification,
+	.clear_channel = mailbox_clear_channel,
 	.poll_done = mailbox_poll_done,
 };
 
diff --git a/drivers/firmware/arm_scmi/shmem.c b/drivers/firmware/arm_scmi/shmem.c
index a5a5d0f6bf86..0e3eaea5d852 100644
--- a/drivers/firmware/arm_scmi/shmem.c
+++ b/drivers/firmware/arm_scmi/shmem.c
@@ -77,7 +77,7 @@ void shmem_fetch_notification(struct scmi_shared_mem __iomem *shmem,
 	memcpy_fromio(xfer->rx.buf, shmem->msg_payload, xfer->rx.len);
 }
 
-void shmem_clear_notification(struct scmi_shared_mem __iomem *shmem)
+void shmem_clear_channel(struct scmi_shared_mem __iomem *shmem)
 {
 	iowrite32(SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE, &shmem->channel_status);
 }
-- 
2.17.1

