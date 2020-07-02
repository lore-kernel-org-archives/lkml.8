Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70246C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4896F20780
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgGBLss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:48:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41447 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgGBLsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:48:47 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jqxhj-00067a-OM; Thu, 02 Jul 2020 11:48:35 +0000
From:   Colin King <colin.king@canonical.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: Intel: bxt-da7219-max98357a: return -EINVAL on unrecognized speaker amplifier
Date:   Thu,  2 Jul 2020 12:48:35 +0100
Message-Id: <20200702114835.37889-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently if the ctx->spkamp is not recognized an error message is
reported but the code continues to set up the device with uninitialized
variables such as the number of widgets.  Fix this by returning -EINVAL
for unrecognized speaker amplifier types.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: e1435a1feb18 ("ASoC: Intel: bxt-da7219-max98357a: support MAX98390 speaker amp")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 4d39253e796b..0c0a717823c4 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -677,7 +677,7 @@ static int bxt_card_late_probe(struct snd_soc_card *card)
 		break;
 	default:
 		dev_err(card->dev, "Invalid speaker amplifier %d\n", ctx->spkamp);
-		break;
+		return -EINVAL;
 	}
 
 	err = snd_soc_dapm_new_controls(&card->dapm, widgets, num_widgets);
-- 
2.27.0

