Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B563CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 04:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F28020656
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 04:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nrVG6SeK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgF0Ezz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 00:55:55 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17425 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgF0Ezy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 00:55:54 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef6d14d0001>; Fri, 26 Jun 2020 21:55:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Jun 2020 21:55:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 26 Jun 2020 21:55:54 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 27 Jun
 2020 04:55:54 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 27 Jun 2020 04:55:53 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ef6d1540004>; Fri, 26 Jun 2020 21:55:53 -0700
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
Subject: [PATCH v4 18/23] ASoC: simple-card: Add support for component chaining
Date:   Sat, 27 Jun 2020 10:23:40 +0530
Message-ID: <1593233625-14961-19-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593233625-14961-1-git-send-email-spujar@nvidia.com>
References: <1593233625-14961-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593233741; bh=RKcJuNtPINklkPDE/ES2HA3ahPNsVmFfqN/5tIE4PC4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=nrVG6SeKNthY/EYfWcUGkmd94IP/iq9r8TKiJ8Tj6WDnvMz2KLys70zWIn32VJoIu
         qyYkkhDTbTJ4RE5sQ6PClSubN5Zd2ULeJAmKY+iGDr34EgO52leG1uh5/SNOcVC1eX
         xrUT+shEz/jMWCob75frF+fRqBKWZuYNY/Suu2QQhWuIpfhCCGQk5CpqvPDUphM56m
         qUkPMMUIysi+pjeMMZjKlcLUADygkFFp5wRJjCXNCDVT7AUifn32MxaPWv06lsD40w
         /O1hDvSbo43MZEpHwdmEogzbMDKtAs3WJngFt6EszIzHt6Ew+8u7eRz+HfcKbUZg3z
         XRVZ2k3ecK5wg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simple-card driver supports both normal and DPCM DAI links. The
sound cards requiring DPCM DAI link support use DPCM_SELECTABLE flag
and DAI links are treated as DPCM links depending on the number of
child nodes in a given DAI link.

There is another requirement where multiple ASoC components need to
be connected together in a chained fashion in a component model. This
patch sets 'component_chaining' flag for such sound cards where FE<->BE
and multiple BE<->BE component connections is required. Hence support
for such sound cards is added under 'simple-cc-audio-card' compatible.
All DAI links under this are treated as DPCM links and links can have
empty Codec list since components are chainied via router controls.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 include/sound/simple_card.h     |  5 +++++
 sound/soc/generic/simple-card.c | 35 ++++++++++++++++++++++++++++-------
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/include/sound/simple_card.h b/include/sound/simple_card.h
index d264e54..79019d0 100644
--- a/include/sound/simple_card.h
+++ b/include/sound/simple_card.h
@@ -23,4 +23,9 @@ struct asoc_simple_card_info {
 	struct asoc_simple_dai codec_dai;
 };
 
+struct asoc_simple_soc_data {
+	bool dpcm_selectable;
+	bool component_chaining;
+};
+
 #endif /* __SIMPLE_CARD_H */
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index f19030b..758c612 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -16,8 +16,6 @@
 #include <sound/soc-dai.h>
 #include <sound/soc.h>
 
-#define DPCM_SELECTABLE 1
-
 #define DAI	"sound-dai"
 #define CELL	"#sound-dai-cells"
 #define PREFIX	"simple-audio-card,"
@@ -386,10 +384,11 @@ static int simple_for_each_link(struct asoc_simple_priv *priv,
 					 struct device_node *np,
 					 struct link_info *li, bool is_top))
 {
+	struct snd_soc_card *card = simple_priv_to_card(priv);
 	struct device *dev = simple_priv_to_dev(priv);
 	struct device_node *top = dev->of_node;
 	struct device_node *node;
-	uintptr_t dpcm_selectable = (uintptr_t)of_device_get_match_data(dev);
+	const struct asoc_simple_soc_data *data = of_device_get_match_data(dev);
 	bool is_top = 0;
 	int ret = 0;
 
@@ -411,10 +410,13 @@ static int simple_for_each_link(struct asoc_simple_priv *priv,
 		/* get codec */
 		codec = of_get_child_by_name(node, is_top ?
 					     PREFIX "codec" : "codec");
-		if (!codec) {
+
+		/* Codec list can be empty for component<->component chain */
+		if (!codec && !card->component_chaining) {
 			ret = -ENODEV;
 			goto error;
 		}
+
 		/* get platform */
 		plat = of_get_child_by_name(node, is_top ?
 					    PREFIX "plat" : "plat");
@@ -432,9 +434,10 @@ static int simple_for_each_link(struct asoc_simple_priv *priv,
 			 * It is DPCM
 			 * if it has many CPUs,
 			 * or has convert-xxx property
+			 * or if component_chaining is used
 			 */
-			if (dpcm_selectable &&
-			    (num > 2 ||
+			if (data && data->dpcm_selectable &&
+			    (num > 2 || data->component_chaining ||
 			     adata.convert_rate || adata.convert_channels))
 				ret = func_dpcm(priv, np, li, is_top);
 			/* else normal sound */
@@ -654,6 +657,7 @@ static int asoc_simple_probe(struct platform_device *pdev)
 	struct asoc_simple_priv *priv;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
+	const struct asoc_simple_soc_data *data;
 	struct snd_soc_card *card;
 	struct link_info li;
 	int ret;
@@ -668,6 +672,11 @@ static int asoc_simple_probe(struct platform_device *pdev)
 	card->dev		= dev;
 	card->probe		= simple_soc_probe;
 
+	data = of_device_get_match_data(dev);
+
+	if (data)
+		card->component_chaining = data->component_chaining;
+
 	memset(&li, 0, sizeof(li));
 	simple_get_dais_count(priv, &li);
 	if (!li.link || !li.dais)
@@ -757,10 +766,22 @@ static int asoc_simple_remove(struct platform_device *pdev)
 	return asoc_simple_clean_reference(card);
 }
 
+static const struct asoc_simple_soc_data scu_card_data = {
+	.dpcm_selectable = true,
+};
+
+/* Component chaining with DPCM */
+static const struct asoc_simple_soc_data cc_card_data = {
+	.dpcm_selectable = true,
+	.component_chaining = true,
+};
+
 static const struct of_device_id simple_of_match[] = {
 	{ .compatible = "simple-audio-card", },
 	{ .compatible = "simple-scu-audio-card",
-	  .data = (void *)DPCM_SELECTABLE },
+	  .data = &scu_card_data },
+	{ .compatible = "simple-cc-audio-card",
+	  .data = &cc_card_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, simple_of_match);
-- 
2.7.4

