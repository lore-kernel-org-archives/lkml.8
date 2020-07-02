Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2D2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15D1C208C7
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgGBQ72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:59:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:59112 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbgGBQ7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:59:25 -0400
IronPort-SDR: Rf00+y5BkKyhP8lpjlPUZOMI4ioSmLwWHNChYUcIehXPg1G2WfP42HiddYTylw3/jsDj+49ScP
 tFrLDHN9/+Bw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="146051873"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="146051873"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 09:59:24 -0700
IronPort-SDR: uUNoPoufGcDhF3lI9DepTyS3pbZwmKLRfRKKDU8qbLmkcyhDNzk0RXqZgOc1hoxkiIKrwOAEYA
 KvSWPxPGwstg==
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="426014906"
Received: from nzbastur-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.231.182])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 09:59:23 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        YueHaibing <yuehaibing@huawei.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 7/8] ASoC: tegra: tegra20_das: remove always-true comparison
Date:   Thu,  2 Jul 2020 11:59:00 -0500
Message-Id: <20200702165901.164100-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702165901.164100-1-pierre-louis.bossart@linux.intel.com>
References: <20200702165901.164100-1-pierre-louis.bossart@linux.intel.com>
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

