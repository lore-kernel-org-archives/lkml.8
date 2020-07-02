Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A3EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5166020771
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgGBRXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 13:23:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:2609 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbgGBRWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 13:22:51 -0400
IronPort-SDR: G2LanqxLEXTxnE+T5g57dkvvthqybWb/fBUQv0Ur2857dB3kBViJ8VZKWY86h/C71t+pN8CMjE
 UpOE92rUNgKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="135255672"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="135255672"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 10:22:51 -0700
IronPort-SDR: 8V5QjC/cvmL6jPyiq6KUG7JjQGBBGeaq5u2Q5ONxesSQQtZAmxSRHxTKBwXNmgCPjFgAfadFIT
 e2W3Q4Y/1rEQ==
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="356521260"
Received: from nzbastur-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.231.182])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 10:22:50 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC SOUND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/6] ASoC: fsl: fsl_asrc: fix kernel-doc
Date:   Thu,  2 Jul 2020 12:22:26 -0500
Message-Id: <20200702172227.164474-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702172227.164474-1-pierre-louis.bossart@linux.intel.com>
References: <20200702172227.164474-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 warnings. fix kernel doc and describe arguments.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/fsl/fsl_asrc.c | 57 +++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 18 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 462ce9f9ab48..02c81d2e34ad 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -37,7 +37,7 @@ static struct snd_pcm_hw_constraint_list fsl_asrc_rate_constraints = {
 	.list = supported_asrc_rate,
 };
 
-/**
+/*
  * The following tables map the relationship between asrc_inclk/asrc_outclk in
  * fsl_asrc.h and the registers of ASRCSR
  */
@@ -68,7 +68,7 @@ static unsigned char output_clk_map_imx53[ASRC_CLK_MAP_LEN] = {
 	0x7, 0x7, 0x7, 0x7, 0x7, 0x7, 0x7, 0x7, 0x7, 0x7, 0x7, 0x7, 0x7, 0x7, 0x7, 0x7,
 };
 
-/**
+/*
  * i.MX8QM/i.MX8QXP uses the same map for input and output.
  * clk_map_imx8qm[0] is for i.MX8QM asrc0
  * clk_map_imx8qm[1] is for i.MX8QM asrc1
@@ -102,16 +102,17 @@ static unsigned char clk_map_imx8qxp[2][ASRC_CLK_MAP_LEN] = {
 };
 
 /**
- * Select the pre-processing and post-processing options
+ * fsl_asrc_sel_proc - Select the pre-processing and post-processing options
+ * @inrate: input sample rate
+ * @outrate: output sample rate
+ * @pre_proc: return value for pre-processing option
+ * @post_proc: return value for post-processing option
+ *
  * Make sure to exclude following unsupported cases before
  * calling this function:
  * 1) inrate > 8.125 * outrate
  * 2) inrate > 16.125 * outrate
  *
- * inrate: input sample rate
- * outrate: output sample rate
- * pre_proc: return value for pre-processing option
- * post_proc: return value for post-processing option
  */
 static void fsl_asrc_sel_proc(int inrate, int outrate,
 			     int *pre_proc, int *post_proc)
@@ -148,7 +149,9 @@ static void fsl_asrc_sel_proc(int inrate, int outrate,
 }
 
 /**
- * Request ASRC pair
+ * fsl_asrc_request_pair - Request ASRC pair
+ * @channels: number of channels
+ * @pair: pointer to pair
  *
  * It assigns pair by the order of A->C->B because allocation of pair B,
  * within range [ANCA, ANCA+ANCB-1], depends on the channels of pair A
@@ -193,7 +196,8 @@ static int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair)
 }
 
 /**
- * Release ASRC pair
+ * fsl_asrc_release_pair - Release ASRC pair
+ * @pair: pair to release
  *
  * It clears the resource from asrc and releases the occupied channels.
  */
@@ -217,7 +221,10 @@ static void fsl_asrc_release_pair(struct fsl_asrc_pair *pair)
 }
 
 /**
- * Configure input and output thresholds
+ * fsl_asrc_set_watermarks- configure input and output thresholds
+ * @pair: pointer to pair
+ * @in: input threshold
+ * @out: output threshold
  */
 static void fsl_asrc_set_watermarks(struct fsl_asrc_pair *pair, u32 in, u32 out)
 {
@@ -234,7 +241,9 @@ static void fsl_asrc_set_watermarks(struct fsl_asrc_pair *pair, u32 in, u32 out)
 }
 
 /**
- * Calculate the total divisor between asrck clock rate and sample rate
+ * fsl_asrc_cal_asrck_divisor - Calculate the total divisor between asrck clock rate and sample rate
+ * @pair: pointer to pair
+ * @div: divider
  *
  * It follows the formula clk_rate = samplerate * (2 ^ prescaler) * divider
  */
@@ -250,7 +259,10 @@ static u32 fsl_asrc_cal_asrck_divisor(struct fsl_asrc_pair *pair, u32 div)
 }
 
 /**
- * Calculate and set the ratio for Ideal Ratio mode only
+ * fsl_asrc_set_ideal_ratio - Calculate and set the ratio for Ideal Ratio mode only
+ * @pair: pointer to pair
+ * @inrate: input rate
+ * @outrate: output rate
  *
  * The ratio is a 32-bit fixed point value with 26 fractional bits.
  */
@@ -293,7 +305,9 @@ static int fsl_asrc_set_ideal_ratio(struct fsl_asrc_pair *pair,
 }
 
 /**
- * Configure the assigned ASRC pair
+ * fsl_asrc_config_pair - Configure the assigned ASRC pair
+ * @pair: pointer to pair
+ * @use_ideal_rate: boolean configuration
  *
  * It configures those ASRC registers according to a configuration instance
  * of struct asrc_config which includes in/output sample rate, width, channel
@@ -508,7 +522,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair, bool use_ideal_rate)
 }
 
 /**
- * Start the assigned ASRC pair
+ * fsl_asrc_start_pair - Start the assigned ASRC pair
+ * @pair: pointer to pair
  *
  * It enables the assigned pair and makes it stopped at the stall level.
  */
@@ -539,7 +554,8 @@ static void fsl_asrc_start_pair(struct fsl_asrc_pair *pair)
 }
 
 /**
- * Stop the assigned ASRC pair
+ * fsl_asrc_stop_pair - Stop the assigned ASRC pair
+ * @pair: pointer to pair
  */
 static void fsl_asrc_stop_pair(struct fsl_asrc_pair *pair)
 {
@@ -552,7 +568,9 @@ static void fsl_asrc_stop_pair(struct fsl_asrc_pair *pair)
 }
 
 /**
- * Get DMA channel according to the pair and direction.
+ * fsl_asrc_get_dma_channel- Get DMA channel according to the pair and direction.
+ * @pair: pointer to pair
+ * @dir: DMA direction
  */
 static struct dma_chan *fsl_asrc_get_dma_channel(struct fsl_asrc_pair *pair,
 						 bool dir)
@@ -896,7 +914,8 @@ static const struct regmap_config fsl_asrc_regmap_config = {
 };
 
 /**
- * Initialize ASRC registers with a default configurations
+ * fsl_asrc_init - Initialize ASRC registers with a default configuration
+ * @asrc: ASRC context
  */
 static int fsl_asrc_init(struct fsl_asrc *asrc)
 {
@@ -930,7 +949,9 @@ static int fsl_asrc_init(struct fsl_asrc *asrc)
 }
 
 /**
- * Interrupt handler for ASRC
+ * fsl_asrc_isr- Interrupt handler for ASRC
+ * @irq: irq number
+ * @dev_id: ASRC context
  */
 static irqreturn_t fsl_asrc_isr(int irq, void *dev_id)
 {
-- 
2.25.1

