Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5180CC433E5
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 05:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29106208B3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 05:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CASNUZBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgGSFLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 01:11:05 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4652 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgGSFLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 01:11:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f13d5ab0000>; Sat, 18 Jul 2020 22:10:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 18 Jul 2020 22:11:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 18 Jul 2020 22:11:04 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 19 Jul
 2020 05:11:03 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 19 Jul 2020 05:11:04 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f13d5e30000>; Sat, 18 Jul 2020 22:11:03 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <kuninori.morimoto.gx@renesas.com>, <robh+dt@kernel.org>,
        <lgirdwood@gmail.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <mkumard@nvidia.com>, <viswanathl@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <atalambedu@nvidia.com>, <nwartikar@nvidia.com>,
        <swarren@nvidia.com>, <nicoleotsuka@gmail.com>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 05/10] ASoC: audio-graph: Identify 'no_pcm' DAI links for DPCM
Date:   Sun, 19 Jul 2020 10:40:12 +0530
Message-ID: <1595135417-16589-6-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595135417-16589-1-git-send-email-spujar@nvidia.com>
References: <1595135417-16589-1-git-send-email-spujar@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595135403; bh=CN3aeoKnSLU0Sh/hr4/p656z+IRsSzvsM2rh1hzS2m0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=CASNUZBkkajwmtcTi5r6rIBrBJlsmejiJJtjS4UjAcroI4DoeuTiyl7RBkQJkyK4T
         SrQ2pPRg96T5gTwr5Q+aPz6j5m36AQVcYOtoxRgZyUrcKcSdeiwq4ydYA52Ek0xCxg
         QoA10N/nHHJAeZtUQM9CLxHg31Prj6rnHSqVAjZZPFm/TAyim4ZskXvTWm1fQxAPL7
         ielueNMBjODQARx/we97e6z8QkjY1zxE2gVwh39wpgyjcF/nDQRc4KrZtaz5thPLj6
         yB1jgyuSJt1DO90v/6ENrLjtobt8r3FJdNLXk14fAWzimwr4Z3399RHU+jbvJzg5k4
         xDIna5rgCXvZw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCM devices are created for FE dai links with 'no-pcm' flag as '0'.
Such DAI links have CPU component which implement either pcm_construct()
or pcm_new() at component or dai level respectively. Based on this,
current patch exposes a helper function to identify such components
and populate 'no_pcm' flag for DPCM DAI link.

This helps to have BE<->BE component links where PCM devices need
not be created for CPU component involved in such links.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/soc/generic/audio-graph-card.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index caa8a77..82d8c740 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -111,6 +111,17 @@ static int graph_get_dai_id(struct device_node *ep)
 	return id;
 }
 
+static bool soc_component_is_pcm(struct snd_soc_dai_link_component *dlc)
+{
+	struct snd_soc_dai *dai = snd_soc_find_dai(dlc);
+
+	if (dai && (dai->component->driver->pcm_construct ||
+		    dai->driver->pcm_new))
+		return true;
+
+	return false;
+}
+
 static int asoc_simple_parse_dai(struct device_node *ep,
 				 struct snd_soc_dai_link_component *dlc,
 				 int *is_single_link)
@@ -262,6 +273,16 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 		if (ret < 0)
 			goto out_put_node;
 
+		/*
+		 * In BE<->BE connections it is not required to create
+		 * PCM devices at CPU end of the dai link and thus 'no_pcm'
+		 * flag needs to be set. It is useful when there are many
+		 * BE components and some of these have to be connected to
+		 * form a valid audio path.
+		 */
+		if (!soc_component_is_pcm(cpus))
+			dai_link->no_pcm = 1;
+
 		/* card->num_links includes Codec */
 		asoc_simple_canonicalize_cpu(dai_link, is_single_links);
 	} else {
-- 
2.7.4

