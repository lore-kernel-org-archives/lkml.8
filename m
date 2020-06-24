Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AD5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9691620738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="O3q1iUNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405682AbgFXRpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:45:54 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:23241 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405662AbgFXRpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:45:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593020751; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=J3C3DH38HNTXhiMFboVNl1/mnSBUaUI3h0PuvrpneKg=; b=O3q1iUNnNIeH45/0rFFsgolOHRIc8fAfP/oknxZojVdP7TUN4p8WaE0t0iKO2atl7olBrPmQ
 OyWnYcAtLv6zdZiEacEAIF55c524e6DeMVjIITLYp7kDjtxJdOPI0zmeRaIkbvdhjl8PYr/x
 lUUaR6SACeIF0Z4s8HbVUofYKLk=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5ef3914186de6ccd44d7d842 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Jun 2020 17:45:37
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 01945C43391; Wed, 24 Jun 2020 17:45:36 +0000 (UTC)
Received: from deesin-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: deesin)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D1C59C43395;
        Wed, 24 Jun 2020 17:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1C59C43395
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=deesin@codeaurora.org
From:   Deepak Kumar Singh <deesin@codeaurora.org>
To:     bjorn.andersson@linaro.org, clew@codeaurora.org,
        mathieu.poirier@linaro.org
Cc:     rampraka@codeaurora.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Deepak Kumar Singh <deesin@codeaurora.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org (open list:REMOTE PROCESSOR MESSAGING
        (RPMSG) SUBSYSTEM), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V5 4/4] rpmsg: char: Add signal callback and POLLPRI support
Date:   Wed, 24 Jun 2020 23:15:01 +0530
Message-Id: <1593020701-23778-5-git-send-email-deesin@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593020701-23778-1-git-send-email-deesin@codeaurora.org>
References: <1593020701-23778-1-git-send-email-deesin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arun Kumar Neelakantam <aneela@codeaurora.org>

Register a callback to get the signal notifications from rpmsg and
send POLLPRI mask to indicate the signal change in POLL system call.

Signed-off-by: Deepak Kumar Singh <deesin@codeaurora.org>
Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 drivers/rpmsg/rpmsg_char.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 43ceac0..50a02fb 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -64,6 +64,7 @@ struct rpmsg_ctrldev {
  * @queue_lock:	synchronization of @queue operations
  * @queue:	incoming message queue
  * @readq:	wait object for incoming queue
+ * @sig_pending:state of signal notification
  */
 struct rpmsg_eptdev {
 	struct device dev;
@@ -78,6 +79,8 @@ struct rpmsg_eptdev {
 	spinlock_t queue_lock;
 	struct sk_buff_head queue;
 	wait_queue_head_t readq;
+
+	bool sig_pending;
 };
 
 static int rpmsg_eptdev_destroy(struct device *dev, void *data)
@@ -122,6 +125,19 @@ static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
 	return 0;
 }
 
+static int rpmsg_sigs_cb(struct rpmsg_device *rpdev, void *priv,
+			 u32 old, u32 new)
+{
+	struct rpmsg_eptdev *eptdev = priv;
+
+	eptdev->sig_pending = true;
+
+	/* wake up any blocking processes, waiting for signal notification */
+	wake_up_interruptible(&eptdev->readq);
+	return 0;
+}
+
+
 static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
 {
 	struct rpmsg_eptdev *eptdev = cdev_to_eptdev(inode->i_cdev);
@@ -138,6 +154,7 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
 		return -EINVAL;
 	}
 
+	ept->sig_cb = rpmsg_sigs_cb;
 	eptdev->ept = ept;
 	filp->private_data = eptdev;
 
@@ -156,6 +173,7 @@ static int rpmsg_eptdev_release(struct inode *inode, struct file *filp)
 		eptdev->ept = NULL;
 	}
 	mutex_unlock(&eptdev->ept_lock);
+	eptdev->sig_pending = false;
 
 	/* Discard all SKBs */
 	skb_queue_purge(&eptdev->queue);
@@ -266,6 +284,9 @@ static __poll_t rpmsg_eptdev_poll(struct file *filp, poll_table *wait)
 	if (!skb_queue_empty(&eptdev->queue))
 		mask |= EPOLLIN | EPOLLRDNORM;
 
+	if (eptdev->sig_pending)
+		mask |= POLLPRI;
+
 	mask |= rpmsg_poll(eptdev->ept, filp, wait);
 
 	return mask;
@@ -309,6 +330,7 @@ static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
 
 	switch (cmd) {
 	case TIOCMGET:
+		eptdev->sig_pending = false;
 		ret = rpmsg_get_signals(eptdev->ept);
 		if (ret >= 0)
 			ret = put_user(ret, (int __user *)arg);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

