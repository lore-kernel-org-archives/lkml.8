Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F27C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 04:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BB3A20E65
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 04:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Qtcj4hNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgF0EzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 00:55:17 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14216 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgF0EzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 00:55:16 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef6d1040000>; Fri, 26 Jun 2020 21:54:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Jun 2020 21:55:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 26 Jun 2020 21:55:16 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 27 Jun
 2020 04:55:15 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 27 Jun 2020 04:55:15 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ef6d12e0000>; Fri, 26 Jun 2020 21:55:15 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <kuninori.morimoto.gx@renesas.com>, <robh+dt@kernel.org>,
        <lgirdwood@gmail.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <digetx@gmail.com>, <alsa-devel@alsa-project.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <mkumard@nvidia.com>,
        <viswanathl@nvidia.com>, <rlokhande@nvidia.com>,
        <dramesh@nvidia.com>, <atalambedu@nvidia.com>,
        <nwartikar@nvidia.com>, <swarren@nvidia.com>,
        <nicoleotsuka@gmail.com>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v4 11/23] ASoC: simple-card: Loop over all children for 'mclk-fs'
Date:   Sat, 27 Jun 2020 10:23:33 +0530
Message-ID: <1593233625-14961-12-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593233625-14961-1-git-send-email-spujar@nvidia.com>
References: <1593233625-14961-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593233668; bh=4ND8txYRt9aF/VJmFfVsaNJ3R7xChBowo2iz1AmLmcg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=Qtcj4hNTqC3Q7adov9wd1dtZ1ybLvIRAxpiPz5zmKfMBKe9JFUucr24CcJ3MW71B5
         ZUPK6huyOiUlgZdWTe7nRsvuiK0weCywanL3+12KixoEiOrLELYclfwwhWAISruYXQ
         QFLv7+fQdHFpCPQbXtdCzeM86zEiOTNn9Dj0rvb9Bp0xCo9WTW1Ivq17DSkcZNwVRU
         kk9Pha2QQnZzfb8BtgTCRyuoGoA8Pk9pO4bQNlOIjeDc24QhRlNNXKwGbnuL1K5v9E
         cRcJbi3Fog/ipRvBqPptrNYYOdXudP8GttIKV8pfjSS/hygTNCRFaCSmM7cCnZAytn
         Fg2CDmADLHGrw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU/Codec in DPCM DAI links are connected as CPU<->Dummy and Dummy<->Codec.
Though mostly CPU won't use/require 'mclk-fs' property, looping over
'np' (current child node in a DAI link) can help in cases where multiple
Codecs are defined. This further helps to get rid of 'codec' argument
from simple_dai_link_of_dpcm() function, which gets called for DPCM links.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/soc/generic/simple-card.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 39cdc71..02d6295 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -107,7 +107,9 @@ static void simple_parse_mclk_fs(struct device_node *top,
 	snprintf(prop, sizeof(prop), "%smclk-fs", prefix);
 	of_property_read_u32(node,	prop, &props->mclk_fs);
 	of_property_read_u32(cpu,	prop, &props->mclk_fs);
-	of_property_read_u32(codec,	prop, &props->mclk_fs);
+
+	if (cpu != codec)
+		of_property_read_u32(codec, prop, &props->mclk_fs);
 
 	of_node_put(node);
 }
@@ -220,7 +222,7 @@ static int simple_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 	}
 
 	simple_parse_convert(dev, np, &dai_props->adata);
-	simple_parse_mclk_fs(top, np, codec, dai_props, prefix);
+	simple_parse_mclk_fs(top, np, np, dai_props, prefix);
 
 	asoc_simple_canonicalize_platform(dai_link);
 
-- 
2.7.4

