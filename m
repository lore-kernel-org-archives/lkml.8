Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706E5C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 02:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44BD72072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 02:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgICCwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 22:52:03 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:34054 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726523AbgICCwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 22:52:00 -0400
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Sep 2020 19:51:58 -0700
Received: from th-lint-039.qualcomm.com ([10.63.179.124])
  by ironmsg05-sd.qualcomm.com with ESMTP; 02 Sep 2020 19:51:58 -0700
Received: by th-lint-039.qualcomm.com (Postfix, from userid 2383757)
        id 6023F1B65; Wed,  2 Sep 2020 19:51:58 -0700 (PDT)
From:   Gurbir Arora <gurbaror@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, rishabhb@codeaurora.org,
        Gurbir Arora <gurbaror@codeaurora.org>
Subject: [PATCH v2 3/3] remoteproc: qcom: Add minidump id for sm8150 modem remoteproc
Date:   Wed,  2 Sep 2020 19:51:56 -0700
Message-Id: <1599101516-243760-4-git-send-email-gurbaror@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599101516-243760-1-git-send-email-gurbaror@codeaurora.org>
References: <1599101516-243760-1-git-send-email-gurbaror@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add minidump id for modem in sm8150 chipset.

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
Signed-off-by: Gurbir Arora <gurbaror@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 19873d1..d35a502 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -639,6 +639,7 @@ static const struct adsp_data mpss_resource_init = {
 	.crash_reason_smem = 421,
 	.firmware_name = "modem.mdt",
 	.pas_id = 4,
+	.minidump_id = 3,
 	.has_aggre2_clk = false,
 	.auto_boot = false,
 	.active_pd_names = (char*[]){
-- 
2.7.4

