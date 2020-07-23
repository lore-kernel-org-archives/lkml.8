Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC8AC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3EEB2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="p2tBy+Ag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgGWIOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:14:03 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12757 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgGWIOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:14:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1946be0000>; Thu, 23 Jul 2020 01:13:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 23 Jul 2020 01:14:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 23 Jul 2020 01:14:02 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 Jul
 2020 08:14:02 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 23 Jul 2020 08:14:02 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f1946c70001>; Thu, 23 Jul 2020 01:14:02 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <geert@linux-m68k.org>, <rdunlap@infradead.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH] ASoC: tegra: Fix build error due to 64-by-32 division
Date:   Thu, 23 Jul 2020 13:43:31 +0530
Message-ID: <1595492011-2411-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595492030; bh=KlXp5Z8io6593lkYe651OoFDsSM02BKTkfmssD6nCRU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=p2tBy+Agm5pBGRTnZ4+mwBepgTYGpgVQI/lY4R9q4nAqrtu6Qi0EjLiqz36PTtSJ/
         PUubrApLsVOW99+H8Ob38pgwND9ARSnKD1olmkV+9Gztw8IVyb6a3kFvW+nzof3YVm
         rsiFJNWFp9HryUA3OTSlWE4fu09PHJ2Ri5x1geGgxC2YtXbiBFFnMx7OVYE/xxNhvK
         GBW6MVJ44edD5AzIeIspC/65P4BsJ+gx4is49DIdpgS9SFcglwv5Vka/vAd+oUP1XW
         pByXnEIyJfzRGuqLErt1YWaIMvx0j+agmrDMmpY2b4MHP1pC02+fqNFpebImCL1nSo
         Oxc2Y8CXTQypA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build errors are seen on 32-bit platforms because of a plain 64-by-32
division. For example, following build erros were reported.

"ERROR: modpost: "__udivdi3" [sound/soc/tegra/snd-soc-tegra210-dmic.ko]
 undefined!"
"ERROR: modpost: "__divdi3" [sound/soc/tegra/snd-soc-tegra210-dmic.ko]
 undefined!"

This can be fixed by using div_u64() helper from 'math64.h' header.

Fixes: 8c8ff982e9e2 ("ASoC: tegra: Add Tegra210 based DMIC driver")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/soc/tegra/tegra210_dmic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/tegra/tegra210_dmic.c b/sound/soc/tegra/tegra210_dmic.c
index ff6fd65..d682414 100644
--- a/sound/soc/tegra/tegra210_dmic.c
+++ b/sound/soc/tegra/tegra210_dmic.c
@@ -6,6 +6,7 @@
 
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -129,7 +130,7 @@ static int tegra210_dmic_hw_params(struct snd_pcm_substream *substream,
 	 * Boost Gain Volume control has 100x factor.
 	 */
 	if (dmic->boost_gain)
-		gain_q23 = (gain_q23 * dmic->boost_gain) / 100;
+		gain_q23 = div_u64(gain_q23 * dmic->boost_gain, 100);
 
 	regmap_write(dmic->regmap, TEGRA210_DMIC_LP_FILTER_GAIN,
 		     (unsigned int)gain_q23);
-- 
2.7.4

