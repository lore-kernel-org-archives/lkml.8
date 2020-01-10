Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D88C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA112072A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="vCX/I+Z3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgAJKH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:07:57 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:34265 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727168AbgAJKH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 05:07:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578650876; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=uwwNlxbaPVAft3MSELUaVehozNoXoPWIw5uWz2i3i8Y=; b=vCX/I+Z3KuNCe+p21AK1SmLc2qJDb6Bs36SG/TpDPstywhug+F6u+FLqHALi9vXTDEsHqTF2
 6TD+U3gQxWsmkoAMApn+uiVXfKPTMSTmIuAm3KW/Dh75fokVWar/8OeDrKpVs5Wra5sFxNA1
 JNaB+zuWye19tQBtGGUSooH5C5g=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e184cfb.7f2adb4d4110-smtp-out-n03;
 Fri, 10 Jan 2020 10:07:55 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A8F97C4479F; Fri, 10 Jan 2020 10:07:55 +0000 (UTC)
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 27096C433CB;
        Fri, 10 Jan 2020 10:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 27096C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     bjorn.andersson@linaro.org, clew@codeaurora.org
Cc:     Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] soc: qcom: aoss: Reduce the AOP ACK wait time
Date:   Fri, 10 Jan 2020 15:37:40 +0530
Message-Id: <1578650861-2450-1-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AOP send ACK immediately before wait thread can start waiting.
In this case the probe call is blocked for default time 1sec and
causing bootup delay.

Reduce the default wait time to 20ms to avoid delay in IRQ miss case.

Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 drivers/soc/qcom/qcom_aoss.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index 006ac40..2cf2393 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -44,6 +44,8 @@
 
 #define QMP_NUM_COOLING_RESOURCES	2
 
+#define QMP_ACK_TIMEOUT			msecs_to_jiffies(10)
+
 static bool qmp_cdev_max_state = 1;
 
 struct qmp_cooling_device {
@@ -150,7 +152,8 @@ static int qmp_open(struct qmp *qmp)
 
 	qmp_kick(qmp);
 
-	ret = wait_event_timeout(qmp->event, qmp_link_acked(qmp), HZ);
+	ret = wait_event_timeout(qmp->event, qmp_link_acked(qmp),
+				 QMP_ACK_TIMEOUT);
 	if (!ret) {
 		dev_err(qmp->dev, "ucore didn't ack link\n");
 		goto timeout_close_link;
@@ -160,7 +163,8 @@ static int qmp_open(struct qmp *qmp)
 
 	qmp_kick(qmp);
 
-	ret = wait_event_timeout(qmp->event, qmp_ucore_channel_up(qmp), HZ);
+	ret = wait_event_timeout(qmp->event, qmp_ucore_channel_up(qmp),
+				 QMP_ACK_TIMEOUT);
 	if (!ret) {
 		dev_err(qmp->dev, "ucore didn't open channel\n");
 		goto timeout_close_channel;
@@ -171,7 +175,8 @@ static int qmp_open(struct qmp *qmp)
 
 	qmp_kick(qmp);
 
-	ret = wait_event_timeout(qmp->event, qmp_mcore_channel_acked(qmp), HZ);
+	ret = wait_event_timeout(qmp->event, qmp_mcore_channel_acked(qmp),
+				 QMP_ACK_TIMEOUT);
 	if (!ret) {
 		dev_err(qmp->dev, "ucore didn't ack channel\n");
 		goto timeout_close_channel;
-- 
1.9.1
