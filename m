Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0569FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF662206E9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgGGTQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:16:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:5637 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728663AbgGGTQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:16:41 -0400
IronPort-SDR: 1adwI9Bmok6mFXu/eLuVYGpi6sYLMyNfra6wYTc28y9tsk0EH2mnE/FjzkRx74XLcG+9Pr3vjw
 EDr7V7CI8wUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="165753006"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="165753006"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:16:41 -0700
IronPort-SDR: SwqtXOkuo5ynNOdi12dDxKh7z+v7x8FCxMJpHZAly0pP9RSMD+0Vqd5hzqDxQfvGH3pEQpBMW6
 EC0jXWJcKSjQ==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="388601645"
Received: from mrtorger-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.77.62])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:16:40 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 07/10] ASoC: codecs: rt5631: fix kernel-doc
Date:   Tue,  7 Jul 2020 14:16:12 -0500
Message-Id: <20200707191615.98296-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707191615.98296-1-pierre-louis.bossart@linux.intel.com>
References: <20200707191615.98296-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 warning, spurious kernel-doc start and missing arguments

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5631.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index b5184f0e10e3..653da3eaf355 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -64,7 +64,7 @@ static const struct reg_default rt5631_reg[] = {
 	{ RT5631_PSEUDO_SPATL_CTRL, 0x0553 },
 };
 
-/**
+/*
  * rt5631_write_index - write index register of 2nd layer
  */
 static void rt5631_write_index(struct snd_soc_component *component,
@@ -74,7 +74,7 @@ static void rt5631_write_index(struct snd_soc_component *component,
 	snd_soc_component_write(component, RT5631_INDEX_DATA, value);
 }
 
-/**
+/*
  * rt5631_read_index - read index register of 2nd layer
  */
 static unsigned int rt5631_read_index(struct snd_soc_component *component,
@@ -359,6 +359,7 @@ static int check_adcr_select(struct snd_soc_dapm_widget *source,
 
 /**
  * onebit_depop_power_stage - auto depop in power stage.
+ * @component: ASoC component
  * @enable: power on/off
  *
  * When power on/off headphone, the depop sequence is done by hardware.
@@ -397,6 +398,7 @@ static void onebit_depop_power_stage(struct snd_soc_component *component, int en
 
 /**
  * onebit_depop_mute_stage - auto depop in mute stage.
+ * @component: ASoC component
  * @enable: mute/unmute
  *
  * When mute/unmute headphone, the depop sequence is done by hardware.
@@ -435,6 +437,7 @@ static void onebit_depop_mute_stage(struct snd_soc_component *component, int ena
 
 /**
  * onebit_depop_power_stage - step by step depop sequence in power stage.
+ * @component: ASoC component
  * @enable: power on/off
  *
  * When power on/off headphone, the depop sequence is done in step by step.
@@ -507,6 +510,7 @@ static void depop_seq_power_stage(struct snd_soc_component *component, int enabl
 
 /**
  * depop_seq_mute_stage - step by step depop sequence in mute stage.
+ * @component: ASoC component
  * @enable: mute/unmute
  *
  * When mute/unmute headphone, the depop sequence is done in step by step.
-- 
2.25.1

