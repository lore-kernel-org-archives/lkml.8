Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849BEC433E3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7008E206E9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgGGTGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:06:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:54574 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728029AbgGGTGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:06:37 -0400
IronPort-SDR: Zki+WEM5KZoNosB6Wq4MORQsVvTlEJZSJxWwfKhZ4XhOeyNNPP4s7CvQecYFX4t8JN3sz5x5KK
 VoqVPDxHg1Cg==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="135924063"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="135924063"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:06:36 -0700
IronPort-SDR: c+QrqvRHvqybbsdzESVBZe6ihASfuLsit4oMA8N5Lkv3gCadq23nUsiXYUmgU7+FeMSfTXq6+G
 zW4BMEc2C0VQ==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="268278550"
Received: from mrtorger-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.77.62])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:06:35 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 04/13] ASoC: tegra: tegra20_das: remove always-true comparison
Date:   Tue,  7 Jul 2020 14:06:03 -0500
Message-Id: <20200707190612.97799-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707190612.97799-1-pierre-louis.bossart@linux.intel.com>
References: <20200707190612.97799-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 warning:

sound/soc//tegra/tegra20_das.c:101:11: warning:
comparison of unsigned expression >= 0 is always true [-Wtype-limits]
  101 |  if ((reg >= TEGRA20_DAS_DAP_CTRL_SEL) &&
      |           ^~

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/tegra/tegra20_das.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra20_das.c b/sound/soc/tegra/tegra20_das.c
index 1070b2710d5e..79dba878d854 100644
--- a/sound/soc/tegra/tegra20_das.c
+++ b/sound/soc/tegra/tegra20_das.c
@@ -98,8 +98,7 @@ EXPORT_SYMBOL_GPL(tegra20_das_connect_dac_to_dap);
 
 static bool tegra20_das_wr_rd_reg(struct device *dev, unsigned int reg)
 {
-	if ((reg >= TEGRA20_DAS_DAP_CTRL_SEL) &&
-	    (reg <= LAST_REG(DAP_CTRL_SEL)))
+	if (reg <= LAST_REG(DAP_CTRL_SEL))
 		return true;
 	if ((reg >= TEGRA20_DAS_DAC_INPUT_DATA_CLK_SEL) &&
 	    (reg <= LAST_REG(DAC_INPUT_DATA_CLK_SEL)))
-- 
2.25.1

