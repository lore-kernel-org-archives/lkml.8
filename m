Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE322C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 04:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A158C20672
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 04:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Z2dPKoBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgF0Ezo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 00:55:44 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17412 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgF0Ezn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 00:55:43 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef6d1420000>; Fri, 26 Jun 2020 21:55:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 26 Jun 2020 21:55:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 26 Jun 2020 21:55:43 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 27 Jun
 2020 04:55:43 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 27 Jun 2020 04:55:43 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ef6d1490001>; Fri, 26 Jun 2020 21:55:42 -0700
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
Subject: [PATCH v4 16/23] ASoC: soc-pcm: Get all BEs along DAPM path
Date:   Sat, 27 Jun 2020 10:23:38 +0530
Message-ID: <1593233625-14961-17-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593233625-14961-1-git-send-email-spujar@nvidia.com>
References: <1593233625-14961-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593233730; bh=ATOw/4EzYXlMqEnwT1/6HimCfHDLLNbEe1aVkWPTa3o=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=Z2dPKoBvAEAVtJU7/ro9js14vMeSsOhzsRPMSRoylZg80cyNZESWK6YAKgHvrvgoU
         5gAQUekhv6dtHizbqWQ5kI83VCpWgXNv7q8rW9YL3FalXUcFFfJ8dCF1F/vp8zBPOK
         ld0V8W6zeOzc2cuG+grZU+uzKEHtXPlCMkUkdIVigQhYdAaY00HF2M+LNAfsGvFOrI
         stRs6/yzsPY+pQMEsW8Dlm1JPtngZIq5cg1YQPdUdGggd3tHhDGOJh+EtVVi6oiqvL
         cQj2VKCBT7nifBaJCoclIfDIOTa3mvxl8bEKG9x5pG0D5MOQoOljZeLdx16Fogs1go
         XlXagI9D41nrA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dpcm_end_walk_at_be() stops the graph walk when first BE is found for
the given FE component. In a component model we may want to connect
multiple DAIs from different components. A new flag is introduced in
'snd_soc_card', which when set allows DAI/component chaining. Later
PCM operations can be called for all these listed components for a
valid DAPM path.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 include/sound/soc.h | 1 +
 sound/soc/soc-pcm.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 1e0376f..95e02a7 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1069,6 +1069,7 @@ struct snd_soc_card {
 	int num_of_dapm_widgets;
 	const struct snd_soc_dapm_route *of_dapm_routes;
 	int num_of_dapm_routes;
+	bool component_chaining;
 
 	/* lists of probed devices belonging to this card */
 	struct list_head component_dev_list;
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 6dc21b6..7f612e3 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1322,7 +1322,8 @@ int dpcm_path_get(struct snd_soc_pcm_runtime *fe,
 
 	/* get number of valid DAI paths and their widgets */
 	paths = snd_soc_dapm_dai_get_connected_widgets(cpu_dai, stream, list,
-			dpcm_end_walk_at_be);
+			fe->card->component_chaining ?
+				NULL : dpcm_end_walk_at_be);
 
 	dev_dbg(fe->dev, "ASoC: found %d audio %s paths\n", paths,
 			stream ? "capture" : "playback");
-- 
2.7.4

