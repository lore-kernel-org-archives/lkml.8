Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F825C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8444B2075A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgEGDjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 23:39:24 -0400
Received: from smtprelay0117.hostedemail.com ([216.40.44.117]:52426 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725893AbgEGDjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 23:39:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id D78E01802DF6F;
        Thu,  7 May 2020 03:39:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: grip73_6e9eae6cba716
X-Filterd-Recvd-Size: 5159
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 May 2020 03:39:20 +0000 (UTC)
Message-ID: <427ca3c1e2d9f9d74ce2f60659da04e267009d2d.camel@perches.com>
Subject: Re: [PATCH -next] ASoC: SOF: Intel: Mark cht_debugfs as
 __maybe_unused
From:   Joe Perches <joe@perches.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 06 May 2020 20:39:18 -0700
In-Reply-To: <20200507031911.38644-1-yuehaibing@huawei.com>
References: <20200507031911.38644-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-07 at 11:19 +0800, YueHaibing wrote:
> When CONFIG_SND_SOC_SOF_BAYTRAIL is not set, gcc warns:
> 
> sound/soc/sof/intel/byt.c:85:41: warning: ‘cht_debugfs’ defined but not used [-Wunused-const-variable=]
>  static const struct snd_sof_debugfs_map cht_debugfs[] = {
>                                          ^~~~~~~~~~~
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  sound/soc/sof/intel/byt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
> index f872bb1f2682..1c75e4220e9d 100644
> --- a/sound/soc/sof/intel/byt.c
> +++ b/sound/soc/sof/intel/byt.c
> @@ -82,7 +82,7 @@ static const struct snd_sof_debugfs_map byt_debugfs[] = {
>  	 SOF_DEBUGFS_ACCESS_ALWAYS},
>  };
>  
> -static const struct snd_sof_debugfs_map cht_debugfs[] = {
> +static const struct snd_sof_debugfs_map __maybe_unused cht_debugfs[] = {
>  	{"dmac0", BYT_DSP_BAR, DMAC0_OFFSET, DMAC_SIZE,
>  	 SOF_DEBUGFS_ACCESS_ALWAYS},
>  	{"dmac1", BYT_DSP_BAR,  DMAC1_OFFSET, DMAC_SIZE,

Likely better moving the struct instead inside the
#ifdef block
---
 sound/soc/sof/intel/byt.c | 54 +++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
index f872bb1f2682..3747f2c2c28b 100644
--- a/sound/soc/sof/intel/byt.c
+++ b/sound/soc/sof/intel/byt.c
@@ -82,33 +82,6 @@ static const struct snd_sof_debugfs_map byt_debugfs[] = {
 	 SOF_DEBUGFS_ACCESS_ALWAYS},
 };
 
-static const struct snd_sof_debugfs_map cht_debugfs[] = {
-	{"dmac0", BYT_DSP_BAR, DMAC0_OFFSET, DMAC_SIZE,
-	 SOF_DEBUGFS_ACCESS_ALWAYS},
-	{"dmac1", BYT_DSP_BAR,  DMAC1_OFFSET, DMAC_SIZE,
-	 SOF_DEBUGFS_ACCESS_ALWAYS},
-	{"dmac2", BYT_DSP_BAR,  DMAC2_OFFSET, DMAC_SIZE,
-	 SOF_DEBUGFS_ACCESS_ALWAYS},
-	{"ssp0",  BYT_DSP_BAR, SSP0_OFFSET, SSP_SIZE,
-	 SOF_DEBUGFS_ACCESS_ALWAYS},
-	{"ssp1", BYT_DSP_BAR, SSP1_OFFSET, SSP_SIZE,
-	 SOF_DEBUGFS_ACCESS_ALWAYS},
-	{"ssp2", BYT_DSP_BAR, SSP2_OFFSET, SSP_SIZE,
-	 SOF_DEBUGFS_ACCESS_ALWAYS},
-	{"ssp3", BYT_DSP_BAR, SSP3_OFFSET, SSP_SIZE,
-	 SOF_DEBUGFS_ACCESS_ALWAYS},
-	{"ssp4", BYT_DSP_BAR, SSP4_OFFSET, SSP_SIZE,
-	 SOF_DEBUGFS_ACCESS_ALWAYS},
-	{"ssp5", BYT_DSP_BAR, SSP5_OFFSET, SSP_SIZE,
-	 SOF_DEBUGFS_ACCESS_ALWAYS},
-	{"iram", BYT_DSP_BAR, IRAM_OFFSET, IRAM_SIZE,
-	 SOF_DEBUGFS_ACCESS_D0_ONLY},
-	{"dram", BYT_DSP_BAR, DRAM_OFFSET, DRAM_SIZE,
-	 SOF_DEBUGFS_ACCESS_D0_ONLY},
-	{"shim", BYT_DSP_BAR, SHIM_OFFSET, SHIM_SIZE_CHT,
-	 SOF_DEBUGFS_ACCESS_ALWAYS},
-};
-
 static void byt_host_done(struct snd_sof_dev *sdev);
 static void byt_dsp_done(struct snd_sof_dev *sdev);
 static void byt_get_reply(struct snd_sof_dev *sdev);
@@ -681,6 +654,33 @@ EXPORT_SYMBOL_NS(tng_chip_info, SND_SOC_SOF_MERRIFIELD);
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
 
+static const struct snd_sof_debugfs_map cht_debugfs[] = {
+	{"dmac0", BYT_DSP_BAR, DMAC0_OFFSET, DMAC_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"dmac1", BYT_DSP_BAR,  DMAC1_OFFSET, DMAC_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"dmac2", BYT_DSP_BAR,  DMAC2_OFFSET, DMAC_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"ssp0",  BYT_DSP_BAR, SSP0_OFFSET, SSP_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"ssp1", BYT_DSP_BAR, SSP1_OFFSET, SSP_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"ssp2", BYT_DSP_BAR, SSP2_OFFSET, SSP_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"ssp3", BYT_DSP_BAR, SSP3_OFFSET, SSP_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"ssp4", BYT_DSP_BAR, SSP4_OFFSET, SSP_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"ssp5", BYT_DSP_BAR, SSP5_OFFSET, SSP_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"iram", BYT_DSP_BAR, IRAM_OFFSET, IRAM_SIZE,
+	 SOF_DEBUGFS_ACCESS_D0_ONLY},
+	{"dram", BYT_DSP_BAR, DRAM_OFFSET, DRAM_SIZE,
+	 SOF_DEBUGFS_ACCESS_D0_ONLY},
+	{"shim", BYT_DSP_BAR, SHIM_OFFSET, SHIM_SIZE_CHT,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+};
+
 static int byt_acpi_probe(struct snd_sof_dev *sdev)
 {
 	struct snd_sof_pdata *pdata = sdev->pdata;


