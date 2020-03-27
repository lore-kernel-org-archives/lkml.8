Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347D8C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 14:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE86206F2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 14:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgC0Ofa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 10:35:30 -0400
Received: from foss.arm.com ([217.140.110.172]:45580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgC0Oev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 10:34:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 881531042;
        Fri, 27 Mar 2020 07:34:50 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C0193F71F;
        Fri, 27 Mar 2020 07:34:49 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        cristian.marussi@arm.com
Subject: [PATCH v6 03/13] firmware: arm_scmi: Add notifications support in transport layer
Date:   Fri, 27 Mar 2020 14:34:28 +0000
Message-Id: <20200327143438.5382-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200327143438.5382-1-cristian.marussi@arm.com>
References: <20200327143438.5382-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common transport-layer methods to:
 - fetch a notification instead of a response
 - clear a pending notification

Add also all the needed support in mailbox/shmem transports.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h  |  8 ++++++++
 drivers/firmware/arm_scmi/mailbox.c | 17 +++++++++++++++++
 drivers/firmware/arm_scmi/shmem.c   | 15 +++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 5ac06469b01c..3c2e5d0d7b68 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -178,6 +178,8 @@ struct scmi_chan_info {
  * @send_message: Callback to send a message
  * @mark_txdone: Callback to mark tx as done
  * @fetch_response: Callback to fetch response
+ * @fetch_notification: Callback to fetch notification
+ * @clear_notification: Callback to clear a pending notification
  * @poll_done: Callback to poll transfer status
  */
 struct scmi_transport_ops {
@@ -190,6 +192,9 @@ struct scmi_transport_ops {
 	void (*mark_txdone)(struct scmi_chan_info *cinfo, int ret);
 	void (*fetch_response)(struct scmi_chan_info *cinfo,
 			       struct scmi_xfer *xfer);
+	void (*fetch_notification)(struct scmi_chan_info *cinfo,
+				   size_t max_len, struct scmi_xfer *xfer);
+	void (*clear_notification)(struct scmi_chan_info *cinfo);
 	bool (*poll_done)(struct scmi_chan_info *cinfo, struct scmi_xfer *xfer);
 };
 
@@ -222,5 +227,8 @@ void shmem_tx_prepare(struct scmi_shared_mem __iomem *shmem,
 u32 shmem_read_header(struct scmi_shared_mem __iomem *shmem);
 void shmem_fetch_response(struct scmi_shared_mem __iomem *shmem,
 			  struct scmi_xfer *xfer);
+void shmem_fetch_notification(struct scmi_shared_mem __iomem *shmem,
+			      size_t max_len, struct scmi_xfer *xfer);
+void shmem_clear_notification(struct scmi_shared_mem __iomem *shmem);
 bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
 		     struct scmi_xfer *xfer);
diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index 73077bbc4ad9..19ee058f9f44 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -158,6 +158,21 @@ static void mailbox_fetch_response(struct scmi_chan_info *cinfo,
 	shmem_fetch_response(smbox->shmem, xfer);
 }
 
+static void mailbox_fetch_notification(struct scmi_chan_info *cinfo,
+				       size_t max_len, struct scmi_xfer *xfer)
+{
+	struct scmi_mailbox *smbox = cinfo->transport_info;
+
+	shmem_fetch_notification(smbox->shmem, max_len, xfer);
+}
+
+static void mailbox_clear_notification(struct scmi_chan_info *cinfo)
+{
+	struct scmi_mailbox *smbox = cinfo->transport_info;
+
+	shmem_clear_notification(smbox->shmem);
+}
+
 static bool
 mailbox_poll_done(struct scmi_chan_info *cinfo, struct scmi_xfer *xfer)
 {
@@ -173,6 +188,8 @@ static struct scmi_transport_ops scmi_mailbox_ops = {
 	.send_message = mailbox_send_message,
 	.mark_txdone = mailbox_mark_txdone,
 	.fetch_response = mailbox_fetch_response,
+	.fetch_notification = mailbox_fetch_notification,
+	.clear_notification = mailbox_clear_notification,
 	.poll_done = mailbox_poll_done,
 };
 
diff --git a/drivers/firmware/arm_scmi/shmem.c b/drivers/firmware/arm_scmi/shmem.c
index ca0ffd302ea2..e1ab05be90e3 100644
--- a/drivers/firmware/arm_scmi/shmem.c
+++ b/drivers/firmware/arm_scmi/shmem.c
@@ -67,6 +67,21 @@ void shmem_fetch_response(struct scmi_shared_mem __iomem *shmem,
 	memcpy_fromio(xfer->rx.buf, shmem->msg_payload + 4, xfer->rx.len);
 }
 
+void shmem_fetch_notification(struct scmi_shared_mem __iomem *shmem,
+			      size_t max_len, struct scmi_xfer *xfer)
+{
+	/* Skip only the length of header in shmem area i.e 4 bytes */
+	xfer->rx.len = min_t(size_t, max_len, ioread32(&shmem->length) - 4);
+
+	/* Take a copy to the rx buffer.. */
+	memcpy_fromio(xfer->rx.buf, shmem->msg_payload, xfer->rx.len);
+}
+
+void shmem_clear_notification(struct scmi_shared_mem __iomem *shmem)
+{
+	iowrite32(SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE, &shmem->channel_status);
+}
+
 bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
 		     struct scmi_xfer *xfer)
 {
-- 
2.17.1

