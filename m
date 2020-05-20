Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AD0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 09:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E22D8207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 09:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="UQ99uAW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgETJkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 05:40:12 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:53180 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726748AbgETJkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 05:40:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589967611; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=K4ExBGCsYxziXQ/tZmwH21vvC09oS+9OCCe2vM9zxcc=; b=UQ99uAW9NNuTuYX/lEeNKaeVYzr234SaLuE5QoNdVYhJ60Q8KyHxpY+pSqeyPl7Q8FdNRlAe
 UsuPRrcbkuLmFiuiiQDaDbOR/u9bWbfXqxgQkvWVgys4sel3QL2jLzazjI3xptpgHwdKiBE/
 QSJMk8X1ah7dZ3MQ1oYO5P8mL8g=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec4fafb.7f97c5cc4f10-smtp-out-n02;
 Wed, 20 May 2020 09:40:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1D3FBC433C9; Wed, 20 May 2020 09:40:10 +0000 (UTC)
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CD072C43391;
        Wed, 20 May 2020 09:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD072C43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        sricharan@codeaurora.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
Subject: [PATCH V6 4/5] rpmsg: glink: Expose rpmsg name attr for glink
Date:   Wed, 20 May 2020 15:09:38 +0530
Message-Id: <1589967579-15559-5-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589967579-15559-1-git-send-email-aneela@codeaurora.org>
References: <1589967579-15559-1-git-send-email-aneela@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Lew <clew@codeaurora.org>

Expose the name field as an attr so clients listening to uevents for
rpmsg can identify the edge the events correspond to.

Signed-off-by: Chris Lew <clew@codeaurora.org>
Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 drivers/rpmsg/qcom_glink_native.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index b85433c..2b5368b 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1574,6 +1574,26 @@ static void qcom_glink_cancel_rx_work(struct qcom_glink *glink)
 		kfree(dcmd);
 }
 
+static ssize_t rpmsg_name_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	int ret = 0;
+	const char *name;
+
+	ret = of_property_read_string(dev->of_node, "label", &name);
+	if (ret < 0)
+		name = dev->of_node->name;
+
+	return snprintf(buf, RPMSG_NAME_SIZE, "%s\n", name);
+}
+static DEVICE_ATTR_RO(rpmsg_name);
+
+static struct attribute *qcom_glink_attrs[] = {
+	&dev_attr_rpmsg_name.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(qcom_glink);
+
 static void qcom_glink_device_release(struct device *dev)
 {
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
@@ -1638,6 +1658,12 @@ struct qcom_glink *qcom_glink_native_probe(struct device *dev,
 	idr_init(&glink->lcids);
 	idr_init(&glink->rcids);
 
+	glink->dev->groups = qcom_glink_groups;
+
+	ret = device_add_groups(dev, qcom_glink_groups);
+	if (ret)
+		dev_err(dev, "failed to add groups\n");
+
 	ret = of_property_read_string(dev->of_node, "label", &glink->name);
 	if (ret < 0)
 		glink->name = dev->of_node->name;
-- 
2.7.4
