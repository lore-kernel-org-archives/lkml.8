Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD16C2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A15D2077D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="QieJ57Hv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgCYRnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:43:37 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:10396 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728020AbgCYRnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:43:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585158215; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=f+CR1kcG4Nmj1zbB3rR2lH3I1Cysjzz9Pe1f5KmSe4o=; b=QieJ57Hvy3NrB95aoL+HtFdqS4N4TSTur9p7TsGkCuhR5wbKIRakezmXLxmmlocVPqvkeJeQ
 OSbtL6garKqIW+KeedruU3DsBK1rxN9lUD6xHT3hj/vlV+aKkdsmjXDSN7p3DdOSM/peeZmU
 J2n4i7bvyIAhBhP62sfBVcDOBXM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7b9834.7fdb12c5e420-smtp-out-n04;
 Wed, 25 Mar 2020 17:43:16 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1E4E6C447A1; Wed, 25 Mar 2020 17:43:15 +0000 (UTC)
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 570BDC433D2;
        Wed, 25 Mar 2020 17:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 570BDC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, p.zabel@pengutronix.de
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH v3 4/4] phy: qcom-qmp: Use proper PWRDOWN offset for sm8150 USB
Date:   Wed, 25 Mar 2020 10:43:04 -0700
Message-Id: <1585158184-5907-5-git-send-email-wcheng@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1585158184-5907-1-git-send-email-wcheng@codeaurora.org>
References: <1585158184-5907-1-git-send-email-wcheng@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register map for SM8150 QMP USB SSPHY has moved
QPHY_POWER_DOWN_CONTROL to a different offset.  Allow for
an offset in the register table to override default value
if it is a DP capable PHY.

Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index cc04471..71a230a 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -164,6 +164,7 @@ enum qphy_reg_layout {
 	[QPHY_SW_RESET]			= 0x00,
 	[QPHY_START_CTRL]		= 0x44,
 	[QPHY_PCS_STATUS]		= 0x14,
+	[QPHY_COM_POWER_DOWN_CONTROL]	= 0x40,
 };
 
 static const unsigned int sdm845_ufsphy_regs_layout[] = {
@@ -1627,6 +1628,9 @@ static int qcom_qmp_phy_com_init(struct qmp_phy *qphy)
 	if (cfg->has_phy_com_ctrl)
 		qphy_setbits(serdes, cfg->regs[QPHY_COM_POWER_DOWN_CONTROL],
 			     SW_PWRDN);
+	else if (!cfg->has_phy_com_ctrl && cfg->regs[QPHY_COM_POWER_DOWN_CONTROL])
+		qphy_setbits(pcs, cfg->regs[QPHY_COM_POWER_DOWN_CONTROL],
+			     cfg->pwrdn_ctrl);
 	else
 		qphy_setbits(pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
