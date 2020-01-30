Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B309C35246
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 10:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E99F2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 10:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PEMLRh1j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgA3KeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:34:17 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4454 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgA3KeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 05:34:16 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e32b0f30000>; Thu, 30 Jan 2020 02:33:23 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 30 Jan 2020 02:34:15 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 30 Jan 2020 02:34:15 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 30 Jan
 2020 10:34:14 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 30 Jan 2020 10:34:14 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e32b1210004>; Thu, 30 Jan 2020 02:34:14 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <robh+dt@kernel.org>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <digetx@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <mkumard@nvidia.com>, <viswanathl@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <atalambedu@nvidia.com>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 2/9] ASoC: tegra: add support for CIF programming
Date:   Thu, 30 Jan 2020 16:03:35 +0530
Message-ID: <1580380422-3431-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580380403; bh=KBNVhGw8w/plbegpaXG3oGndaiAOTvHopvV4JtTt+Pg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=PEMLRh1j1xCBILaLgRR1MNtCoqqwRyXo+hwPYxqSQ9dqsKiNUw2jX0KAIXchd/x3u
         w11tfYYoeRGU0hiyMnyUT0GrFClSjzP7vOybAtLz8WfotC3XNYLTWjvdQaMe/l59QO
         sReF3nmfAan1LxXEEpy0W3NyE+eQscVEB7gRsclaK3X8d3K8fIdnSdwGCUO/dIhHMt
         daAl/jjl4kCJJZuVsDPsutceIGFAqH1gFIMmSPudljtGDGmi2ds4TPCiuw/RugjdO9
         AuRdC0uWfENxd7Wj3k7kzf9XwmdBYCZz20T9+a2w45Bf11gBQNFDthXyLKp9RLzirG
         7UYTc7IqJrVNQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audio Client Interface (CIF) is a proprietary interface employed to route
audio samples through Audio Hub (AHUB) components by inter connecting the
various modules.

This patch exports a helper function tegra_set_cif() which can be used,
for now, to program CIF on Tegra210 and later Tegra generations. Later it
can be extended to include helpers for legacy chips as well.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/soc/tegra/Makefile    |  2 ++
 sound/soc/tegra/tegra_cif.c | 34 ++++++++++++++++++++++++++++++++
 sound/soc/tegra/tegra_cif.h | 47 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)
 create mode 100644 sound/soc/tegra/tegra_cif.c
 create mode 100644 sound/soc/tegra/tegra_cif.h

diff --git a/sound/soc/tegra/Makefile b/sound/soc/tegra/Makefile
index c84f183..261aa21 100644
--- a/sound/soc/tegra/Makefile
+++ b/sound/soc/tegra/Makefile
@@ -8,9 +8,11 @@ snd-soc-tegra20-i2s-objs := tegra20_i2s.o
 snd-soc-tegra20-spdif-objs := tegra20_spdif.o
 snd-soc-tegra30-ahub-objs := tegra30_ahub.o
 snd-soc-tegra30-i2s-objs := tegra30_i2s.o
+snd-soc-tegra-cif-objs := tegra_cif.o
 
 obj-$(CONFIG_SND_SOC_TEGRA) += snd-soc-tegra-pcm.o
 obj-$(CONFIG_SND_SOC_TEGRA) += snd-soc-tegra-utils.o
+obj-$(CONFIG_SND_SOC_TEGRA) += snd-soc-tegra-cif.o
 obj-$(CONFIG_SND_SOC_TEGRA20_AC97) += snd-soc-tegra20-ac97.o
 obj-$(CONFIG_SND_SOC_TEGRA20_DAS) += snd-soc-tegra20-das.o
 obj-$(CONFIG_SND_SOC_TEGRA20_I2S) += snd-soc-tegra20-i2s.o
diff --git a/sound/soc/tegra/tegra_cif.c b/sound/soc/tegra/tegra_cif.c
new file mode 100644
index 0000000..242ae34
--- /dev/null
+++ b/sound/soc/tegra/tegra_cif.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * tegra_cif.c - Tegra Audio CIF Programming for AHUB modules
+ *
+ * Copyright (c) 2020 NVIDIA CORPORATION.  All rights reserved.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include "tegra_cif.h"
+
+void tegra_set_cif(struct regmap *regmap, unsigned int reg,
+		   struct tegra_cif_conf *conf)
+{
+	unsigned int value;
+
+	value = (conf->threshold << TEGRA_ACIF_CTRL_FIFO_TH_SHIFT) |
+		((conf->audio_ch - 1) << TEGRA_ACIF_CTRL_AUDIO_CH_SHIFT) |
+		((conf->client_ch - 1) << TEGRA_ACIF_CTRL_CLIENT_CH_SHIFT) |
+		(conf->audio_bits << TEGRA_ACIF_CTRL_AUDIO_BITS_SHIFT) |
+		(conf->client_bits << TEGRA_ACIF_CTRL_CLIENT_BITS_SHIFT) |
+		(conf->expand << TEGRA_ACIF_CTRL_EXPAND_SHIFT) |
+		(conf->stereo_conv << TEGRA_ACIF_CTRL_STEREO_CONV_SHIFT) |
+		(conf->replicate << TEGRA_ACIF_CTRL_REPLICATE_SHIFT) |
+		(conf->truncate << TEGRA_ACIF_CTRL_TRUNCATE_SHIFT) |
+		(conf->mono_conv << TEGRA_ACIF_CTRL_MONO_CONV_SHIFT);
+
+	regmap_update_bits(regmap, reg, TEGRA_ACIF_UPDATE_MASK, value);
+}
+EXPORT_SYMBOL_GPL(tegra_set_cif);
+
+MODULE_DESCRIPTION("Tegra Audio Client Interface (ACIF) driver");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/tegra/tegra_cif.h b/sound/soc/tegra/tegra_cif.h
new file mode 100644
index 0000000..fb55812
--- /dev/null
+++ b/sound/soc/tegra/tegra_cif.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * tegra_cif.h - TEGRA Audio CIF Programming
+ *
+ * Copyright (c) 2020 NVIDIA CORPORATION.  All rights reserved.
+ *
+ */
+
+#ifndef __TEGRA_CIF_H__
+#define __TEGRA_CIF_H__
+
+#define TEGRA_ACIF_CTRL_FIFO_TH_SHIFT		24
+#define TEGRA_ACIF_CTRL_AUDIO_CH_SHIFT		20
+#define TEGRA_ACIF_CTRL_CLIENT_CH_SHIFT		16
+#define TEGRA_ACIF_CTRL_AUDIO_BITS_SHIFT	12
+#define TEGRA_ACIF_CTRL_CLIENT_BITS_SHIFT	8
+#define TEGRA_ACIF_CTRL_EXPAND_SHIFT		6
+#define TEGRA_ACIF_CTRL_STEREO_CONV_SHIFT	4
+#define TEGRA_ACIF_CTRL_REPLICATE_SHIFT		3
+#define TEGRA_ACIF_CTRL_TRUNCATE_SHIFT		1
+#define TEGRA_ACIF_CTRL_MONO_CONV_SHIFT		0
+
+/* AUDIO/CLIENT_BITS values */
+#define TEGRA_ACIF_BITS_8			1
+#define TEGRA_ACIF_BITS_16			3
+#define TEGRA_ACIF_BITS_24			5
+#define TEGRA_ACIF_BITS_32			7
+
+#define TEGRA_ACIF_UPDATE_MASK			0x3ffffffb
+
+struct tegra_cif_conf {
+	unsigned int threshold;
+	unsigned int audio_ch;
+	unsigned int client_ch;
+	unsigned int audio_bits;
+	unsigned int client_bits;
+	unsigned int expand;
+	unsigned int stereo_conv;
+	unsigned int replicate;
+	unsigned int truncate;
+	unsigned int mono_conv;
+};
+
+void tegra_set_cif(struct regmap *regmap, unsigned int reg,
+		   struct tegra_cif_conf *conf);
+
+#endif
-- 
2.7.4

