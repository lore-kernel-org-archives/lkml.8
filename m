Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F00C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D42B20823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404099AbgFXOFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:05:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36851 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403979AbgFXOFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:05:19 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jo61c-0002uM-Mr; Wed, 24 Jun 2020 14:05:16 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] soc: qcom: fix off-by-one array index bounds check
Date:   Wed, 24 Jun 2020 15:05:16 +0100
Message-Id: <20200624140516.5929-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The bounds check on model is off-by-one, leading to an array out
of bounds read when model is 26. Fix this.

Addresses-Coverity: ("Out-of-bounds read")
Fixes: e9247e2ce577 ("soc: qcom: socinfo: fix printing of pmic_model")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/soc/qcom/socinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index e19102f46302..4d29ea244e71 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -275,7 +275,7 @@ static int qcom_show_pmic_model(struct seq_file *seq, void *p)
 	if (model < 0)
 		return -EINVAL;
 
-	if (model <= ARRAY_SIZE(pmic_models) && pmic_models[model])
+	if (model < ARRAY_SIZE(pmic_models) && pmic_models[model])
 		seq_printf(seq, "%s\n", pmic_models[model]);
 	else
 		seq_printf(seq, "unknown (%d)\n", model);
-- 
2.27.0

