Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9FCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B48032078D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgHSQBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:01:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35511 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgHSQBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 12:01:14 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k8QWN-0003Um-Kj; Wed, 19 Aug 2020 16:01:03 +0000
From:   Colin King <colin.king@canonical.com>
To:     Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Pandey <ajitp@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: qcom: add missing out of memory check on drvdata->clks allocation
Date:   Wed, 19 Aug 2020 17:01:03 +0100
Message-Id: <20200819160103.164893-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently drvdata->clks is not being checked for an allocation failure,
leading to potential null pointer dereferencing. Fix this by adding a
check and returning -ENOMEM if an error occurred.

Addresses-Coverity: ("Dereference null return value")
Fixes: 1220f6a76e77 ("ASoC: qcom: Add common array to initialize soc based core clocks")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/qcom/lpass-apq8016.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/qcom/lpass-apq8016.c b/sound/soc/qcom/lpass-apq8016.c
index dd9e3dd014f6..5c8ae225cd5d 100644
--- a/sound/soc/qcom/lpass-apq8016.c
+++ b/sound/soc/qcom/lpass-apq8016.c
@@ -168,6 +168,8 @@ static int apq8016_lpass_init(struct platform_device *pdev)
 
 	drvdata->clks = devm_kcalloc(dev, variant->num_clks,
 				     sizeof(*drvdata->clks), GFP_KERNEL);
+	if (!drvdata->clks)
+		return -ENOMEM;
 	drvdata->num_clks = variant->num_clks;
 
 	for (i = 0; i < drvdata->num_clks; i++)
-- 
2.27.0

