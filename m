Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6890AC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4551020873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701865;
	bh=j6vTk5xwIZQxMl0N+87vCz7J+K5hKkkEZIizq5rdXXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yMwH7gVxp+qApShTZx1iyzJvnT/UhaMoB8NA3cjEZ9VNt9343g+eCcF/1FB6Ww896
	 ZbHuZd7JnldiYUVq7PxU+8PbB1wT5V9ZBxngfM5l4WMDqrIIaywTnP5L0nVNFOuONA
	 MvQ6p2ylmrApzQ5pkbzqM5kPzOw197kyPJue63qs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391194AbgBNRho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:37:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:54460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390087AbgBNQFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:05:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B35224699;
        Fri, 14 Feb 2020 16:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696309;
        bh=j6vTk5xwIZQxMl0N+87vCz7J+K5hKkkEZIizq5rdXXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DR+bvb4Jk0V7c2dGLYp0lB27UFPeeZ7WNoBKiUQLVMKGrk848hqqdymwJETFzMKkC
         c1ax3pTIaZGGhinvpwvjovPgT69iVDa/CIPT1tMKMqQCpivAPJccuZCzDsDM77da5u
         WWDC8LZLNKrposQiyc8+51IBJKbYkfMWJ1sbqDg4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Jairaj Arava <jairaj.arava@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 152/459] ASoC: intel: sof_rt5682: Add support for tgl-max98357a-rt5682
Date:   Fri, 14 Feb 2020 10:56:42 -0500
Message-Id: <20200214160149.11681-152-sashal@kernel.org>
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

[ Upstream commit 6605f0ca3af3b964635287ec7c9dadc812b78eb0 ]

This patch adds the driver data and updates quirk info
for tgl with max98357a speaker amp and ALC5682 headset codec.

Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Signed-off-by: Jairaj Arava <jairaj.arava@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191126143205.21987-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_rt5682.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 377ff17dedb98..9441ddfeea5e6 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -589,6 +589,9 @@ static int sof_audio_probe(struct platform_device *pdev)
 	if (!ctx)
 		return -ENOMEM;
 
+	if (pdev->id_entry && pdev->id_entry->driver_data)
+		sof_rt5682_quirk = (unsigned long)pdev->id_entry->driver_data;
+
 	dmi_check_system(sof_rt5682_quirk_table);
 
 	if (soc_intel_is_byt() || soc_intel_is_cht()) {
@@ -680,6 +683,21 @@ static int sof_rt5682_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct platform_device_id board_ids[] = {
+	{
+		.name = "sof_rt5682",
+	},
+	{
+		.name = "tgl_max98357a_rt5682",
+		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
+					SOF_RT5682_SSP_CODEC(0) |
+					SOF_SPEAKER_AMP_PRESENT |
+					SOF_RT5682_SSP_AMP(1) |
+					SOF_RT5682_NUM_HDMIDEV(4)),
+	},
+	{ }
+};
+
 static struct platform_driver sof_audio = {
 	.probe = sof_audio_probe,
 	.remove = sof_rt5682_remove,
@@ -687,6 +705,7 @@ static struct platform_driver sof_audio = {
 		.name = "sof_rt5682",
 		.pm = &snd_soc_pm_ops,
 	},
+	.id_table = board_ids,
 };
 module_platform_driver(sof_audio)
 
@@ -696,3 +715,4 @@ MODULE_AUTHOR("Bard Liao <bard.liao@intel.com>");
 MODULE_AUTHOR("Sathya Prakash M R <sathya.prakash.m.r@intel.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:sof_rt5682");
+MODULE_ALIAS("platform:tgl_max98357a_rt5682");
-- 
2.20.1

