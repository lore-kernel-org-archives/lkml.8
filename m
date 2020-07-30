Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0046EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 05:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF2FC2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 05:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="GvrbqY15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgG3FTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 01:19:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:63314 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgG3FTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 01:19:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596086340; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=Bs6Yz+e5gi3IatH5EaN6ufvWGEJcGzB2abXMp8UjszI=; b=GvrbqY15sFqQp9trlLKazvVVhS0beGeboUsFsZkhaSH1W3hszjlcqEoICTYE94OoNNY3v6Ax
 IM9q5omabrxGtVGUMVQAvUtgLF94JUoIhXW90+0W7dUdAwLse1R/1ZBNaMtm8rwCAnRHvOmM
 rXL8Hnb15p5Zc3FnjUx1bHVaCvQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n17.prod.us-east-1.postgun.com with SMTP id
 5f2258441db0b33fd8076208 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 30 Jul 2020 05:19:00
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 554BBC433AD; Thu, 30 Jul 2020 05:18:59 +0000 (UTC)
Received: from deesin-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: deesin)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 64295C433C6;
        Thu, 30 Jul 2020 05:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 64295C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=deesin@codeaurora.org
From:   Deepak Kumar Singh <deesin@codeaurora.org>
To:     bjorn.andersson@linaro.org, clew@codeaurora.org
Cc:     mathieu.poirier@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Deepak Kumar Singh <deesin@codeaurora.org>
Subject: [PATCH V1 6/6] rpmsg: glink: Send READ_NOTIFY command in FIFO full case
Date:   Thu, 30 Jul 2020 10:48:16 +0530
Message-Id: <1596086296-28529-7-git-send-email-deesin@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596086296-28529-1-git-send-email-deesin@codeaurora.org>
References: <1596086296-28529-1-git-send-email-deesin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arun Kumar Neelakantam <aneela@codeaurora.org>

The current design sleeps unconditionally in TX FIFO full case and
wakeup only after sleep timer expires which adds random delays in
clients TX path.

Avoid sleep and use READ_NOTIFY command so that writer can be woken up
when remote notifies about read completion by sending IRQ.

Signed-off-by: Deepak Kumar Singh <deesin@codeaurora.org>
Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 drivers/rpmsg/qcom_glink_native.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index efaf32d..098039d 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -92,6 +92,8 @@ struct glink_core_rx_intent {
  * @rcids:	idr of all channels with a known remote channel id
  * @features:	remote features
  * @intentless:	flag to indicate that there is no intent
+ * @tx_avail_notify: Waitqueue for pending tx tasks
+ * @sent_read_notify: flag to check cmd sent or not
  */
 struct qcom_glink {
 	struct device *dev;
@@ -118,6 +120,8 @@ struct qcom_glink {
 	unsigned long features;
 
 	bool intentless;
+	wait_queue_head_t tx_avail_notify;
+	bool sent_read_notify;
 };
 
 enum {
@@ -301,6 +305,20 @@ static void qcom_glink_tx_write(struct qcom_glink *glink,
 	glink->tx_pipe->write(glink->tx_pipe, hdr, hlen, data, dlen);
 }
 
+static void qcom_glink_send_read_notify(struct qcom_glink *glink)
+{
+	struct glink_msg msg;
+
+	msg.cmd = cpu_to_le16(RPM_CMD_READ_NOTIF);
+	msg.param1 = 0;
+	msg.param2 = 0;
+
+	qcom_glink_tx_write(glink, &msg, sizeof(msg), NULL, 0);
+
+	mbox_send_message(glink->mbox_chan, NULL);
+	mbox_client_txdone(glink->mbox_chan, 0);
+}
+
 static int qcom_glink_tx(struct qcom_glink *glink,
 			 const void *hdr, size_t hlen,
 			 const void *data, size_t dlen, bool wait)
@@ -321,12 +339,21 @@ static int qcom_glink_tx(struct qcom_glink *glink,
 			goto out;
 		}
 
+		if (!glink->sent_read_notify) {
+			glink->sent_read_notify = true;
+			qcom_glink_send_read_notify(glink);
+		}
+
 		/* Wait without holding the tx_lock */
 		spin_unlock_irqrestore(&glink->tx_lock, flags);
 
-		usleep_range(10000, 15000);
+		wait_event_timeout(glink->tx_avail_notify,
+				qcom_glink_tx_avail(glink) >= tlen, 10 * HZ);
 
 		spin_lock_irqsave(&glink->tx_lock, flags);
+
+		if (qcom_glink_tx_avail(glink) >= tlen)
+			glink->sent_read_notify = false;
 	}
 
 	qcom_glink_tx_write(glink, hdr, hlen, data, dlen);
@@ -1000,6 +1027,9 @@ static irqreturn_t qcom_glink_native_intr(int irq, void *data)
 	unsigned int cmd;
 	int ret = 0;
 
+	/* To wakeup any blocking writers */
+	wake_up_all(&glink->tx_avail_notify);
+
 	for (;;) {
 		avail = qcom_glink_rx_avail(glink);
 		if (avail < sizeof(msg))
@@ -1542,6 +1572,9 @@ static void qcom_glink_rx_close_ack(struct qcom_glink *glink, unsigned int lcid)
 	struct glink_channel *channel;
 	unsigned long flags;
 
+	/* To wakeup any blocking writers */
+	wake_up_all(&glink->tx_avail_notify);
+
 	spin_lock_irqsave(&glink->idr_lock, flags);
 	channel = idr_find(&glink->lcids, lcid);
 	if (WARN(!channel, "close ack on unknown channel\n")) {
@@ -1658,6 +1691,7 @@ struct qcom_glink *qcom_glink_native_probe(struct device *dev,
 	spin_lock_init(&glink->rx_lock);
 	INIT_LIST_HEAD(&glink->rx_queue);
 	INIT_WORK(&glink->rx_work, qcom_glink_work);
+	init_waitqueue_head(&glink->tx_avail_notify);
 
 	spin_lock_init(&glink->idr_lock);
 	idr_init(&glink->lcids);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

