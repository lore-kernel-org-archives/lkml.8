Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F577C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3980206E9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgGGTGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:06:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:54600 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbgGGTGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:06:45 -0400
IronPort-SDR: CTRc5LGl+fz2QTyEPFVOD/36o9AW0WxA8ciO6Vln/e/imYmOoOatdhH5MDWm52y14fNiRizEcn
 ry8hlmWXvIMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="135924076"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="135924076"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:06:44 -0700
IronPort-SDR: 4zJ6Irp7x3uElHFi5lQeT+sF12n55oX7ckDDOnDHshWPzMEP9F2zKlamncBnec09LroFwX66Os
 83gTM3acm4Jw==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="268278576"
Received: from mrtorger-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.77.62])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:06:39 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 06/13] ASoC: codecs: da7210: fix kernel-doc
Date:   Tue,  7 Jul 2020 14:06:05 -0500
Message-Id: <20200707190612.97799-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707190612.97799-1-pierre-louis.bossart@linux.intel.com>
References: <20200707190612.97799-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 warning, the kernel-doc syntax was probably from Doxygen?

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/da7210.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 0c99dcf242e4..2bb727dd3a20 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -971,14 +971,16 @@ static int da7210_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 
 /**
  * da7210_set_dai_pll	:Configure the codec PLL
- * @param codec_dai	: pointer to codec DAI
- * @param pll_id	: da7210 has only one pll, so pll_id is always zero
- * @param fref		: MCLK frequency, should be < 20MHz
- * @param fout		: FsDM value, Refer page 44 & 45 of datasheet
- * @return int		: Zero for success, negative error code for error
+ * @codec_dai: pointer to codec DAI
+ * @pll_id: da7210 has only one pll, so pll_id is always zero
+ * @source: clock source
+ * @fref: MCLK frequency, should be < 20MHz
+ * @fout: FsDM value, Refer page 44 & 45 of datasheet
  *
  * Note: Supported PLL input frequencies are 12MHz, 13MHz, 13.5MHz, 14.4MHz,
  *       19.2MHz, 19.6MHz and 19.8MHz
+ *
+ * Return: Zero for success, negative error code for error
  */
 static int da7210_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 			      int source, unsigned int fref, unsigned int fout)
-- 
2.25.1

