Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E14CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FF53207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HyCuX0TH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgHSPc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:32:26 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18249 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgHSPc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 11:32:26 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3d45cd0004>; Wed, 19 Aug 2020 08:31:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 19 Aug 2020 08:32:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 19 Aug 2020 08:32:23 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Aug
 2020 15:32:20 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 19 Aug 2020 15:32:20 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f3d46020000>; Wed, 19 Aug 2020 08:32:20 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <tiwai@suse.com>, <perex@perex.cz>
CC:     <kai.vehmanen@linux.intel.com>, <yang.jie@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH v2] ALSA: hda: avoid reset of sdo_limit
Date:   Wed, 19 Aug 2020 21:02:10 +0530
Message-ID: <1597851130-6765-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597851085; bh=UKdLDoLgUYOX5aCYnviJBBJIVVE0zJ5ynw8P/hu+ZBQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=HyCuX0THfj4UQS9DN3XxPXIbBaZp/goOgVzHVQIX7XgP+NaV0gecB6kon3K9FoDy9
         nMFzALtdtrs05WgPu2YMSTg4/Xk34oXDNd1UvAiVJzdqCEDQFVGhccrc7v39bY1eRV
         zRjsrl/s8uUcPwhsKnvbe4KHe1sBb9Es3v/L0HD3aTRp7zzqtNpNfiTYrfipJW/SAE
         wjlMWleyHT31avgA3IheHbaObWz2npoyzXCiSjnnVQDjbcep0SN5IIU8H8H1fm8CaJ
         egh+FKC7XK1xJHc6xbT4XtGsdhRsIbAq3oTbLvKBQv4gv6d9GnzAlxDSQAAair9wVO
         vyC+U1cCT5B0A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default 'sdo_limit' is initialized with a default value of '8'
as per spec. This is overridden in cases where a different value is
required. However this is getting reset when snd_hdac_bus_init_chip()
is called again, which happens during runtime PM cycle.

Avoid this reset by moving 'sdo_limit' setup to 'snd_hdac_bus_init()'
function which would be called only once.

Fixes: 67ae482a59e9 ("ALSA: hda: add member to store ratio for stripe control")
Cc: <stable@vger.kernel.org>
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/hda/hdac_bus.c        | 12 ++++++++++++
 sound/hda/hdac_controller.c | 11 -----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/sound/hda/hdac_bus.c b/sound/hda/hdac_bus.c
index 09ddab5..9766f6a 100644
--- a/sound/hda/hdac_bus.c
+++ b/sound/hda/hdac_bus.c
@@ -46,6 +46,18 @@ int snd_hdac_bus_init(struct hdac_bus *bus, struct device *dev,
 	INIT_LIST_HEAD(&bus->hlink_list);
 	init_waitqueue_head(&bus->rirb_wq);
 	bus->irq = -1;
+
+	/*
+	 * Default value of '8' is as per the HD audio specification (Rev 1.0a).
+	 * Following relation is used to derive STRIPE control value.
+	 *  For sample rate <= 48K:
+	 *   { ((num_channels * bits_per_sample) / number of SDOs) >= 8 }
+	 *  For sample rate > 48K:
+	 *   { ((num_channels * bits_per_sample * rate/48000) /
+	 *	number of SDOs) >= 8 }
+	 */
+	bus->sdo_limit = 8;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_bus_init);
diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index 011b17c..b98449f 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -529,17 +529,6 @@ bool snd_hdac_bus_init_chip(struct hdac_bus *bus, bool full_reset)
 
 	bus->chip_init = true;
 
-	/*
-	 * Default value of '8' is as per the HD audio specification (Rev 1.0a).
-	 * Following relation is used to derive STRIPE control value.
-	 *  For sample rate <= 48K:
-	 *   { ((num_channels * bits_per_sample) / number of SDOs) >= 8 }
-	 *  For sample rate > 48K:
-	 *   { ((num_channels * bits_per_sample * rate/48000) /
-	 *	number of SDOs) >= 8 }
-	 */
-	bus->sdo_limit = 8;
-
 	return true;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_bus_init_chip);
-- 
2.7.4

