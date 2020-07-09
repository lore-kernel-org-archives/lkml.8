Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BD5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CD4A207F9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgGIQX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:23:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:37037 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728329AbgGIQXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:23:54 -0400
IronPort-SDR: wGRdzQ8O/hwFTd1tX/qdvMmcHtThJDeXlmlEOBYBpd3bkhJoNeYj2OtTgb/h0nnsUC+HsOSBWZ
 W2JdbpLtQE8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="128100585"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="128100585"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 09:23:53 -0700
IronPort-SDR: AFPU3/pslc3kyCCROQND6pvI376z8oj4lK+LEGNEsCaj+Gbv6jeU17N1negviMKydRse3Vvjbv
 jO3rlSgP7KAA==
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="280353028"
Received: from mdcoakle-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.231.43])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 09:23:53 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        zhong jiang <zhongjiang@huawei.com>,
        Ola Lilja <ola.o.lilja@stericsson.com>,
        Roger Nilsson <roger.xr.nilsson@stericsson.com>,
        Sandeep Kaushik <sandeep.kaushik@st.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 06/10] ASoC: ux500: ux500_msp_i2s: Remove unused variables 'reg_val_DR' and 'reg_val_TSTDR'
Date:   Thu,  9 Jul 2020 11:23:23 -0500
Message-Id: <20200709162328.259586-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709162328.259586-1-pierre-louis.bossart@linux.intel.com>
References: <20200709162328.259586-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lee Jones <lee.jones@linaro.org>

Looks like these have been unchecked since the driver's inception in 2012.

Fixes the following W=1 kernel build warning(s):

sound/soc/ux500/ux500_msp_i2s.c: In function ‘flush_fifo_rx’:
sound/soc/ux500/ux500_msp_i2s.c:398:6: warning: variable ‘reg_val_DR’
set but not used [-Wunused-but-set-variable]
sound/soc/ux500/ux500_msp_i2s.c: In function ‘flush_fifo_tx’:
sound/soc/ux500/ux500_msp_i2s.c:415:6: warning: variable
‘reg_val_TSTDR’ set but not used [-Wunused-but-set-variable]

Cc: zhong jiang <zhongjiang@huawei.com>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: Roger Nilsson <roger.xr.nilsson@stericsson.com>
Cc: Sandeep Kaushik <sandeep.kaushik@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/ux500/ux500_msp_i2s.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
index 394d8b2a4a16..fd0b88bb7921 100644
--- a/sound/soc/ux500/ux500_msp_i2s.c
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -395,7 +395,7 @@ static int enable_msp(struct ux500_msp *msp, struct ux500_msp_config *config)
 
 static void flush_fifo_rx(struct ux500_msp *msp)
 {
-	u32 reg_val_DR, reg_val_GCR, reg_val_FLR;
+	u32 reg_val_GCR, reg_val_FLR;
 	u32 limit = 32;
 
 	reg_val_GCR = readl(msp->registers + MSP_GCR);
@@ -403,7 +403,7 @@ static void flush_fifo_rx(struct ux500_msp *msp)
 
 	reg_val_FLR = readl(msp->registers + MSP_FLR);
 	while (!(reg_val_FLR & RX_FIFO_EMPTY) && limit--) {
-		reg_val_DR = readl(msp->registers + MSP_DR);
+		readl(msp->registers + MSP_DR);
 		reg_val_FLR = readl(msp->registers + MSP_FLR);
 	}
 
@@ -412,7 +412,7 @@ static void flush_fifo_rx(struct ux500_msp *msp)
 
 static void flush_fifo_tx(struct ux500_msp *msp)
 {
-	u32 reg_val_TSTDR, reg_val_GCR, reg_val_FLR;
+	u32 reg_val_GCR, reg_val_FLR;
 	u32 limit = 32;
 
 	reg_val_GCR = readl(msp->registers + MSP_GCR);
@@ -421,7 +421,7 @@ static void flush_fifo_tx(struct ux500_msp *msp)
 
 	reg_val_FLR = readl(msp->registers + MSP_FLR);
 	while (!(reg_val_FLR & TX_FIFO_EMPTY) && limit--) {
-		reg_val_TSTDR = readl(msp->registers + MSP_TSTDR);
+		readl(msp->registers + MSP_TSTDR);
 		reg_val_FLR = readl(msp->registers + MSP_FLR);
 	}
 	writel(0x0, msp->registers + MSP_ITCR);
-- 
2.25.1

