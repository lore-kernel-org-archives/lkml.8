Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAEAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 455772082F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732978AbgGASZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:25:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:61638 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732931AbgGASYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:24:50 -0400
IronPort-SDR: dKgOhCaLWHtzYEkC2RXAOngkCzgm6HSLwVkMsBkcgPMAaFS5YmAFU5c/M2woHpatGjGduQdJ/+
 vwIVpcdpnp5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="148218894"
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="148218894"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 11:24:50 -0700
IronPort-SDR: yES3Ov1rH9C2nALpPXeWrwm05f4VgRAfiswKJUXKNG9r7/exOn8aDQBSimLab/15nHm+LkRnRP
 7Tl9OPea4Gsg==
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="425679619"
Received: from srnatla-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.76.199])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 11:24:49 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 09/11] ASoC: codecs: rt5631: fix kernel-doc
Date:   Wed,  1 Jul 2020 13:24:20 -0500
Message-Id: <20200701182422.81496-10-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701182422.81496-1-pierre-louis.bossart@linux.intel.com>
References: <20200701182422.81496-1-pierre-louis.bossart@linux.intel.com>
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

