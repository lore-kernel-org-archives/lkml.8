Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF77C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A9E2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="t+km1e2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405193AbgFXQqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:46:34 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:12619 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405135AbgFXQqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:46:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593017192; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=IUA+BBdK1Ye7yJYb9KcCnxtHYBVDopo/iZ52SrD+KfQ=; b=t+km1e2fG6QBfiRj3O1FjuMNn4QJUVt63TLea0rdmDZH65Lj0o6WjJIVkIj28jK2A0mfcXNR
 bQ7dZN9HkGoyd5q8kOwW7Nf7aIlk71ScsPzRI4kIaxFXtxtBXB9b7nskerS3EVRT1DJXaGJm
 9jcqKIrjA/BN5SKiVyzpICZDeQg=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-east-1.postgun.com with SMTP id
 5ef3835a8fe116ddd945d27a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Jun 2020 16:46:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E7930C433C6; Wed, 24 Jun 2020 16:46:17 +0000 (UTC)
Received: from deesin-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: deesin)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ABF99C433C8;
        Wed, 24 Jun 2020 16:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ABF99C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=deesin@codeaurora.org
From:   Deepak Kumar Singh <deesin@codeaurora.org>
To:     bjorn.andersson@linaro.org, clew@codeaurora.org,
        mathieu.poirier@linaro.org
Cc:     Deepak Kumar Singh <deesin@codeaurora.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-remoteproc@vger.kernel.org (open list:REMOTE PROCESSOR MESSAGING
        (RPMSG) SUBSYSTEM), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V7 4/4] rpmsg: glink: Expose rpmsg name attr for glink
Date:   Wed, 24 Jun 2020 22:15:21 +0530
Message-Id: <1593017121-7953-5-git-send-email-deesin@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593017121-7953-1-git-send-email-deesin@codeaurora.org>
References: <1593017121-7953-1-git-send-email-deesin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Lew <clew@codeaurora.org>

Expose the name field as an attr so clients listening to uevents for
rpmsg can identify the edge the events correspond to.

Signed-off-by: Chris Lew <clew@codeaurora.org>
Signed-off-by: Deepak Kumar Singh <deesin@codeaurora.org>
Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 drivers/rpmsg/qcom_glink_native.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 3a7f87c..0e8a28c0 100644
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

