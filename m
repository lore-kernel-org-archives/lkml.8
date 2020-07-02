Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96DEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A1720870
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgGBQpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:45:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:18398 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbgGBQpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:45:02 -0400
IronPort-SDR: /27DttMOUTtVxtsEx7EmfT/TA2t26RR1OTtuz7o2mMysnQIVTRA6BwRc0w2y2GuhDPRt99K8ZJ
 UI/dxPoZpkFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="231818046"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="231818046"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 09:45:01 -0700
IronPort-SDR: 1BYtnU1QvnJ0SaGRufgPIkJdUX/d4RO1VRyBiwHCqYwA+1N/ku7nEm/U18cdKSsp7/Fj26s4eB
 FTDKRkOCvNMw==
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="426011084"
Received: from nzbastur-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.231.182])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 09:45:00 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/6] ASoC: amd: raven: acp3x-i2s: fix 'set but not used' warning
Date:   Thu,  2 Jul 2020 11:44:31 -0500
Message-Id: <20200702164433.162815-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702164433.162815-1-pierre-louis.bossart@linux.intel.com>
References: <20200702164433.162815-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 warning. the card variable is useless here

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/amd/raven/acp3x-i2s.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
index 14607563abd2..a0e14cc91d95 100644
--- a/sound/soc/amd/raven/acp3x-i2s.c
+++ b/sound/soc/amd/raven/acp3x-i2s.c
@@ -150,13 +150,11 @@ static int acp3x_i2s_trigger(struct snd_pcm_substream *substream,
 {
 	struct i2s_stream_instance *rtd;
 	struct snd_soc_pcm_runtime *prtd;
-	struct snd_soc_card *card;
 	u32 ret, val, period_bytes, reg_val, ier_val, water_val;
 	u32 buf_size, buf_reg;
 
 	prtd = substream->private_data;
 	rtd = substream->runtime->private_data;
-	card = prtd->card;
 	period_bytes = frames_to_bytes(substream->runtime,
 			substream->runtime->period_size);
 	buf_size = frames_to_bytes(substream->runtime,
-- 
2.25.1

