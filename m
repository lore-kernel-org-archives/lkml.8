Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2636C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97C4720836
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgGIQYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:24:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:37078 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbgGIQYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:24:02 -0400
IronPort-SDR: 6upNIkT02t1HNUvA+4oV0O4HpgjHvhERxGE7c9CvaR7GG+sSWjY0cY+LnAA88aj6j7V0yF8zdz
 tEnV532czmBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="128100634"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="128100634"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 09:24:00 -0700
IronPort-SDR: 5JAzNT2lO/ogbhTrmzaK5lxtIVpAI3zjIQspC5bYWj+dhG/S0QKmBMEfIJjsbgesKdHB5cNnh+
 I8UQrS4A2Cew==
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="280353107"
Received: from mdcoakle-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.231.43])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 09:24:00 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>,
        Mihai Serban <mihai.serban@nxp.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 10/10] ASoC: codecs: ak4458: Remove set but never checked variable 'ret'
Date:   Thu,  9 Jul 2020 11:23:27 -0500
Message-Id: <20200709162328.259586-11-pierre-louis.bossart@linux.intel.com>
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

Looks as though the result of snd_soc_update_bits() has never been checked.

Fixes the following W=1 kernel build warning(s):

sound/soc/codecs/ak4458.c: In function ‘ak4458_set_dai_mute’:
sound/soc/codecs/ak4458.c:408:16: warning: variable ‘ret’ set but not
used [-Wunused-but-set-variable]

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>
Cc: Mihai Serban <mihai.serban@nxp.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/ak4458.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index f180cb5dfe4f..39ae089dcd1d 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -405,7 +405,7 @@ static int ak4458_set_dai_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_component *component = dai->component;
 	struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
-	int nfs, ndt, ret, reg;
+	int nfs, ndt, reg;
 	int ats;
 
 	nfs = ak4458->fs;
@@ -416,14 +416,14 @@ static int ak4458_set_dai_mute(struct snd_soc_dai *dai, int mute)
 	ndt = att_speed[ats] / (nfs / 1000);
 
 	if (mute) {
-		ret = snd_soc_component_update_bits(component, AK4458_01_CONTROL2,  0x01, 1);
+		snd_soc_component_update_bits(component, AK4458_01_CONTROL2,  0x01, 1);
 		mdelay(ndt);
 		if (ak4458->mute_gpiod)
 			gpiod_set_value_cansleep(ak4458->mute_gpiod, 1);
 	} else {
 		if (ak4458->mute_gpiod)
 			gpiod_set_value_cansleep(ak4458->mute_gpiod, 0);
-		ret = snd_soc_component_update_bits(component, AK4458_01_CONTROL2, 0x01, 0);
+		snd_soc_component_update_bits(component, AK4458_01_CONTROL2, 0x01, 0);
 		mdelay(ndt);
 	}
 
-- 
2.25.1

