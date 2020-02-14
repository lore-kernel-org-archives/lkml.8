Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD88DC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867DD20873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701869;
	bh=UKBxKNky4iQEGRDznoyYCbojGAdlLVJO7yBfi2zO1hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q6LcbAgnJVrtAZNwPjcRwo+Vu8Q07NuGy4zP65MTUs0ltMdT3bapZrIAqML7xzbJN
	 HgdnLXiC5OYzh6swWHwRebMcvG5pdTwNn8rSQTK9gGviJQVmH+zsWvKGr+7Hjq5CfR
	 WsVZgs6iql6hBgU8XtMa6WIWLAJ7kAtr/ZrBMRfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391861AbgBNRhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:37:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:54398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390077AbgBNQFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:05:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A2BD2469B;
        Fri, 14 Feb 2020 16:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696308;
        bh=UKBxKNky4iQEGRDznoyYCbojGAdlLVJO7yBfi2zO1hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LkUNLPdF2SnCk6bwX+1kp9YDSO1ER3ZDi4plyleaboNVOXu3DtWywhvvC3u/CKswR
         9TbQ8dsf/upV9UlWBIkMQ+8OZrQDpvO2doX3bxq1kVWBUsqph4/+i/QQovUkUrbx/4
         oUzqd4m1FpS9XkcIpypzVC6z+qE+fYe8NjAjns8c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Jairaj Arava <jairaj.arava@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 151/459] ASoC: intel: sof_rt5682: Add quirk for number of HDMI DAI's
Date:   Fri, 14 Feb 2020 10:56:41 -0500
Message-Id: <20200214160149.11681-151-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>

[ Upstream commit c68e07970eca79106b0c35b88a12298569590081 ]

TGL supports one more HDMI DAI than previous models.
So add quirk support for number of HDMI DAI's.

Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Signed-off-by: Jairaj Arava <jairaj.arava@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191126143205.21987-2-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_rt5682.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 4f6e58c3954a2..377ff17dedb98 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -34,6 +34,10 @@
 #define SOF_RT5682_SSP_AMP(quirk)	\
 	(((quirk) << SOF_RT5682_SSP_AMP_SHIFT) & SOF_RT5682_SSP_AMP_MASK)
 #define SOF_RT5682_MCLK_BYTCHT_EN		BIT(9)
+#define SOF_RT5682_NUM_HDMIDEV_SHIFT		10
+#define SOF_RT5682_NUM_HDMIDEV_MASK		(GENMASK(12, 10))
+#define SOF_RT5682_NUM_HDMIDEV(quirk)	\
+	((quirk << SOF_RT5682_NUM_HDMIDEV_SHIFT) & SOF_RT5682_NUM_HDMIDEV_MASK)
 
 /* Default: MCLK on, MCLK 19.2M, SSP0  */
 static unsigned long sof_rt5682_quirk = SOF_RT5682_MCLK_EN |
@@ -585,6 +589,8 @@ static int sof_audio_probe(struct platform_device *pdev)
 	if (!ctx)
 		return -ENOMEM;
 
+	dmi_check_system(sof_rt5682_quirk_table);
+
 	if (soc_intel_is_byt() || soc_intel_is_cht()) {
 		is_legacy_cpu = 1;
 		dmic_be_num = 0;
@@ -595,11 +601,13 @@ static int sof_audio_probe(struct platform_device *pdev)
 						SOF_RT5682_SSP_CODEC(2);
 	} else {
 		dmic_be_num = 2;
-		hdmi_num = 3;
+		hdmi_num = (sof_rt5682_quirk & SOF_RT5682_NUM_HDMIDEV_MASK) >>
+			 SOF_RT5682_NUM_HDMIDEV_SHIFT;
+		/* default number of HDMI DAI's */
+		if (!hdmi_num)
+			hdmi_num = 3;
 	}
 
-	dmi_check_system(sof_rt5682_quirk_table);
-
 	/* need to get main clock from pmc */
 	if (sof_rt5682_quirk & SOF_RT5682_MCLK_BYTCHT_EN) {
 		ctx->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
-- 
2.20.1

