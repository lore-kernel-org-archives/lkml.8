Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB7EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEB9C221E8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgGBTWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:22:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:9166 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbgGBTWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 15:22:01 -0400
IronPort-SDR: D71IRy7cOGi+JH7syY6DvD0Z+mqFYoyZozHl0QbIMN1WWXMbRnq4BVYeW1eMlNdpkEN6RF+VMh
 y9pKaPgz9nJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="146092706"
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; 
   d="scan'208";a="146092706"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 12:22:01 -0700
IronPort-SDR: 0MSZc4j1NtUdgXXi5+xmqcpzvZwHrMwZQnSlT16ycjSqUBDlJ8mmTkpngi2o7urnIiGnDR63yM
 etVW3YfwFSwQ==
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; 
   d="scan'208";a="304345301"
Received: from dhprice-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.75.219])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 12:21:59 -0700
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
Subject: [PATCH v2 4/6] ASoC: fsl: fsl_spdif: fix kernel-doc
Date:   Thu,  2 Jul 2020 14:21:39 -0500
Message-Id: <20200702192141.168018-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702192141.168018-1-pierre-louis.bossart@linux.intel.com>
References: <20200702192141.168018-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 warnings. kernel-doc syntax was not followed and missing parameter

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/fsl/fsl_spdif.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 5b2689ae63d4..9fb95c6ee7ba 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -81,8 +81,8 @@ struct spdif_mixer_control {
 };
 
 /**
- * fsl_spdif_priv: Freescale SPDIF private data
- *
+ * struct fsl_spdif_priv - Freescale SPDIF private data
+ * @soc: SPDIF soc data
  * @fsl_spdif_control: SPDIF control data
  * @cpu_dai_drv: cpu dai driver
  * @pdev: platform device pointer
@@ -100,6 +100,7 @@ struct spdif_mixer_control {
  * @spbaclk: SPBA clock (optional, depending on SoC design)
  * @dma_params_tx: DMA parameters for transmit channel
  * @dma_params_rx: DMA parameters for receive channel
+ * @regcache_srpc: regcache for SRPC
  */
 struct fsl_spdif_priv {
 	const struct fsl_spdif_soc_data *soc;
-- 
2.25.1

