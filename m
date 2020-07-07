Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4B4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DB71206E9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgGGTHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:07:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:46557 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728849AbgGGTGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:06:45 -0400
IronPort-SDR: cBnD9EjEJth5b7E4sbuHtmAe4zwHEI3g+vprlJ9qqGq3n8Xza6OgOtnxBBnwzX9JwClKrVU8ww
 qdp+XOOo0EXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="127764317"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="127764317"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:06:45 -0700
IronPort-SDR: 2y+pYrxM/e/H+2o4edmVGd/hhRXYdc5rf0sVQQ/GsKmTOKHMydmjidsdUFarjne3MQGFaFQrU7
 1ZrP5pX5Va3w==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="268278611"
Received: from mrtorger-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.77.62])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:06:43 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        ter Huurne <maarten@treewalker.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 08/13] ASoC: codecs: jz4770: Remove defined but never used variable 'mic_boost_tlv'
Date:   Tue,  7 Jul 2020 14:06:07 -0500
Message-Id: <20200707190612.97799-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707190612.97799-1-pierre-louis.bossart@linux.intel.com>
References: <20200707190612.97799-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lee Jones <lee.jones@linaro.org>

Fixes the following W=1 kernel build warning(s):

 In file included from include/sound/tlv.h:10,
 from sound/soc/codecs/jz4770.c:19:
 sound/soc/codecs/jz4770.c:306:35: warning: ‘mic_boost_tlv’ defined but not used [-Wunused-const-variable=]
 306 | static const DECLARE_TLV_DB_SCALE(mic_boost_tlv, 0, 400, 0);
 | ^~~~~~~~~~~~~
 include/uapi/sound/tlv.h:64:15: note: in definition of macro ‘SNDRV_CTL_TLVD_DECLARE_DB_SCALE’
 64 | unsigned int name[] = { | ^~~~
 sound/soc/codecs/jz4770.c:306:14: note: in expansion of macro ‘DECLARE_TLV_DB_SCALE’
 306 | static const DECLARE_TLV_DB_SCALE(mic_boost_tlv, 0, 400, 0);
 | ^~~~~~~~~~~~~~~~~~~~

Cc: ter Huurne <maarten@treewalker.org>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/jz4770.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/jz4770.c b/sound/soc/codecs/jz4770.c
index 34775aa62402..4dee585761c2 100644
--- a/sound/soc/codecs/jz4770.c
+++ b/sound/soc/codecs/jz4770.c
@@ -303,7 +303,6 @@ static int jz4770_codec_digital_mute(struct snd_soc_dai *dai, int mute)
 static const DECLARE_TLV_DB_MINMAX_MUTE(dac_tlv, -3100, 0);
 static const DECLARE_TLV_DB_SCALE(adc_tlv, 0, 100, 0);
 static const DECLARE_TLV_DB_MINMAX(out_tlv, -2500, 600);
-static const DECLARE_TLV_DB_SCALE(mic_boost_tlv, 0, 400, 0);
 static const DECLARE_TLV_DB_SCALE(linein_tlv, -2500, 100, 0);
 
 /* Unconditional controls. */
-- 
2.25.1

