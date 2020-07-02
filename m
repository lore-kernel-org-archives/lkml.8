Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F346DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C63F920781
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593653788;
	bh=K+8DiW78hpyxOFxK1fhgrYHAc5PufAYISdcBtUkSMz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CBYNK/vOD8eiq1GoiN7lDgOVLazCi82sRNDvnf5ep2oRSYW6ts2LyGRBLEUFjN5Bh
	 2VkXdtBP1FJ8hu4ZdisGUlihnRIN2GFoBA5FiisdoWKOxXGpD8CDwRpVUapEG5RLHc
	 OYDyPyVzwdTBIynVVrBX13Cp7JGvvHZeWBN7NANk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgGBBg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:36:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728244AbgGBBXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 21:23:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C4CF2083E;
        Thu,  2 Jul 2020 01:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593652993;
        bh=K+8DiW78hpyxOFxK1fhgrYHAc5PufAYISdcBtUkSMz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eXGtN+Y/1XL9y2YWtxkFE1kgTvZizbzWIrmhtUhjVsFWz5sPcTAnagZUOly31VS8b
         636G61Jbu0KVWqonYma6mdQGtno1n+wNOYjMYeDNyWnh9q3/MitLENFVRMjPIa7Rr5
         SiA73IsqC2dVbJIOcO3dywJJUYde/5sGJ7uRWQro=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.7 15/53] ASoC: SOF: Intel: add PCI IDs for ICL-H and TGL-H
Date:   Wed,  1 Jul 2020 21:21:24 -0400
Message-Id: <20200702012202.2700645-15-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702012202.2700645-1-sashal@kernel.org>
References: <20200702012202.2700645-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit c8d2e2bfaeffa0f914330e8b4e45b986c8d30b58 ]

Usually the DSP is not traditionally enabled on H skews but this might
be used moving forward.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://lore.kernel.org/r/20200617164755.18104-4-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/sof-pci-dev.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index 7b1846aeadd59..3a71f813fb563 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -411,8 +411,11 @@ static const struct pci_device_id sof_pci_ids[] = {
 		.driver_data = (unsigned long)&cfl_desc},
 #endif
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_ICELAKE)
-	{ PCI_DEVICE(0x8086, 0x34C8),
+	{ PCI_DEVICE(0x8086, 0x34C8), /* ICL-LP */
 		.driver_data = (unsigned long)&icl_desc},
+	{ PCI_DEVICE(0x8086, 0x3dc8), /* ICL-H */
+		.driver_data = (unsigned long)&icl_desc},
+
 #endif
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_JASPERLAKE)
 	{ PCI_DEVICE(0x8086, 0x38c8),
@@ -431,8 +434,11 @@ static const struct pci_device_id sof_pci_ids[] = {
 		.driver_data = (unsigned long)&cml_desc},
 #endif
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_TIGERLAKE)
-	{ PCI_DEVICE(0x8086, 0xa0c8),
+	{ PCI_DEVICE(0x8086, 0xa0c8), /* TGL-LP */
 		.driver_data = (unsigned long)&tgl_desc},
+	{ PCI_DEVICE(0x8086, 0x43c8), /* TGL-H */
+		.driver_data = (unsigned long)&tgl_desc},
+
 #endif
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_ELKHARTLAKE)
 	{ PCI_DEVICE(0x8086, 0x4b55),
-- 
2.25.1

