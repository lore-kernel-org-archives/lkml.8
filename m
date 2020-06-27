Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B35C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 04:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55E852080C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 04:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="a3+uDdXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgF0EzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 00:55:02 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8632 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgF0EzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 00:55:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef6d0c40000>; Fri, 26 Jun 2020 21:53:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Jun 2020 21:54:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 26 Jun 2020 21:54:59 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 27 Jun
 2020 04:54:59 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 27 Jun 2020 04:54:59 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ef6d11e0001>; Fri, 26 Jun 2020 21:54:59 -0700
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
Subject: [PATCH v4 08/23] ASoC: soc-core: Fix component name_prefix parsing
Date:   Sat, 27 Jun 2020 10:23:30 +0530
Message-ID: <1593233625-14961-9-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593233625-14961-1-git-send-email-spujar@nvidia.com>
References: <1593233625-14961-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593233604; bh=Aqc23rPM+/+YfF7gUxbU0Uby6S6q/iF4yfPy4mrpIFw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=a3+uDdXSkUAcYGSblwdUXLAN5Hd2UtRL7Phb918qYgwQ9KAgw/TP9+mWPGZoPjLKp
         YFWpXj+idLkWhDUCZ7tGTWA6cmXAg5LO6jFRAsEywNyAQBy/JTLZy3YhACncFpI2Jy
         ag4/jg4ZiwSOQIDkOqSjzoJD8nmeuR30sJm7CanbH6Q7Kh3Ve0D5tyn8Su5eAQ4TND
         kR4Pegxrqq2/8k8MP9g4XrhFkK7BgoWQxykTQZ6zllaNiJLQKQBTX2rxU6uKdDhJLw
         bEeA2ZUL75AmIKJFmxbQY/hTa87rsh1HksRHp9kYiC8bHkrd86/yhbMZbtBegw2aj2
         aClKYJefLyA1g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "prefix" can be defined in DAI link node or it can be specified as
part of the component node itself. Currently "sound-name-prefix" defined
in a component is not taking effect. Actually the property is not getting
parsed. It can be fixed by parsing "sound-name-prefix" property whenever
"prefix" is missing in DAI link Codec node.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/soc/soc-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index adedadc..8faca60 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1111,8 +1111,10 @@ static void soc_set_name_prefix(struct snd_soc_card *card,
 		struct snd_soc_codec_conf *map = &card->codec_conf[i];
 
 		if (snd_soc_is_matching_component(&map->dlc, component)) {
-			component->name_prefix = map->name_prefix;
-			return;
+			if (map->name_prefix) {
+				component->name_prefix = map->name_prefix;
+				return;
+			}
 		}
 	}
 
-- 
2.7.4

