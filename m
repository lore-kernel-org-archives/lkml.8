Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C746EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A741D221EE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgGBTWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:22:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:9166 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgGBTV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 15:21:59 -0400
IronPort-SDR: V3z3FpZqtFLZBgX89kqAovrvUkUIdbGchLCGk4w54tQH6Ap+EAbNFoRW8Dp/G0x1sw63Vq6jj6
 QgAQMtSVwmjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="146092695"
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; 
   d="scan'208";a="146092695"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 12:21:58 -0700
IronPort-SDR: i3oRHcmPBT82bLG9COiew6nDKoIzPpGO6/4tCOuGasscx8IKZ/JXKgGKLXaTK4feUDR8CZNolH
 ejHREWfSnrKA==
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; 
   d="scan'208";a="304345288"
Received: from dhprice-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.75.219])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 12:21:56 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC SOUND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/6] ASoC: fsl: fsl-asoc-card: fix kernel-doc
Date:   Thu,  2 Jul 2020 14:21:38 -0500
Message-Id: <20200702192141.168018-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702192141.168018-1-pierre-louis.bossart@linux.intel.com>
References: <20200702192141.168018-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 warnings. Kernel-doc syntax was not properly used.

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 57ea1b072326..faac6ce9a82c 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -33,8 +33,7 @@
 #define DAI_FMT_BASE (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF)
 
 /**
- * CODEC private data
- *
+ * struct codec_priv - CODEC private data
  * @mclk_freq: Clock rate of MCLK
  * @mclk_id: MCLK (or main clock) id for set_sysclk()
  * @fll_id: FLL (or secordary clock) id for set_sysclk()
@@ -48,11 +47,10 @@ struct codec_priv {
 };
 
 /**
- * CPU private data
- *
- * @sysclk_freq[2]: SYSCLK rates for set_sysclk()
- * @sysclk_dir[2]: SYSCLK directions for set_sysclk()
- * @sysclk_id[2]: SYSCLK ids for set_sysclk()
+ * struct cpu_priv - CPU private data
+ * @sysclk_freq: SYSCLK rates for set_sysclk()
+ * @sysclk_dir: SYSCLK directions for set_sysclk()
+ * @sysclk_id: SYSCLK ids for set_sysclk()
  * @slot_width: Slot width of each frame
  *
  * Note: [1] for tx and [0] for rx
@@ -65,9 +63,8 @@ struct cpu_priv {
 };
 
 /**
- * Freescale Generic ASOC card private data
- *
- * @dai_link[3]: DAI link structure including normal one and DPCM link
+ * struct fsl_asoc_card_priv - Freescale Generic ASOC card private data
+ * @dai_link: DAI link structure including normal one and DPCM link
  * @pdev: platform device pointer
  * @codec_priv: CODEC private data
  * @cpu_priv: CPU private data
@@ -94,8 +91,8 @@ struct fsl_asoc_card_priv {
 	char name[32];
 };
 
-/**
- * This dapm route map exsits for DPCM link only.
+/*
+ * This dapm route map exits for DPCM link only.
  * The other routes shall go through Device Tree.
  *
  * Note: keep all ASRC routes in the second half
-- 
2.25.1

