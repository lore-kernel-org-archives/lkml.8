Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D514FC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD25D208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgFSEbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 00:31:36 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:64916 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725826AbgFSEbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 00:31:36 -0400
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 18 Jun 2020 21:31:35 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg04-sd.qualcomm.com with ESMTP; 18 Jun 2020 21:31:32 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id 1C2C621894; Fri, 19 Jun 2020 10:01:31 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        linus.walleij@linaro.org, arajkuma@codeaurora.org,
        sricharan@codeaurora.org, speriaka@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Subject: [PATCH V2] pinctrl: qcom: ipq6018 Add missing pins in qpic pin group
Date:   Fri, 19 Jun 2020 10:01:29 +0530
Message-Id: <1592541089-17700-1-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds missing qpic data pins to qpic pingroup. These pins are
necessary for the qpic nand to work.

Fixes: ef1ea54eab0e ("pinctrl: qcom: Add ipq6018 pinctrl driver")
Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
---
[V2]
 * Corrected Fixes tag
 drivers/pinctrl/qcom/pinctrl-ipq6018.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-ipq6018.c b/drivers/pinctrl/qcom/pinctrl-ipq6018.c
index 38c33a778cb8..ec50a3b4bd16 100644
--- a/drivers/pinctrl/qcom/pinctrl-ipq6018.c
+++ b/drivers/pinctrl/qcom/pinctrl-ipq6018.c
@@ -367,7 +367,8 @@ static const char * const wci20_groups[] = {
 
 static const char * const qpic_pad_groups[] = {
 	"gpio0", "gpio1", "gpio2", "gpio3", "gpio4", "gpio9", "gpio10",
-	"gpio11", "gpio17",
+	"gpio11", "gpio17", "gpio15", "gpio12", "gpio13", "gpio14", "gpio5",
+	"gpio6", "gpio7", "gpio8",
 };
 
 static const char * const burn0_groups[] = {
-- 
2.7.4

