Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C2EC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4FA6206B9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JK15Tz10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgEDIRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 04:17:03 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10321 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgEDIRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 04:17:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eafcf720000>; Mon, 04 May 2020 01:16:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 04 May 2020 01:17:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 04 May 2020 01:17:02 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May
 2020 08:17:02 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 4 May 2020 08:17:02 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5eafcf7a0003>; Mon, 04 May 2020 01:17:01 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <perex@perex.cz>, <tiwai@suse.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <mkumard@nvidia.com>, <viswanathl@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <atalambedu@nvidia.com>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 2/3] ALSA: hda: add member to store ratio for stripe control
Date:   Mon, 4 May 2020 13:46:15 +0530
Message-ID: <1588580176-2801-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588580176-2801-1-git-send-email-spujar@nvidia.com>
References: <1588580176-2801-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588580210; bh=qbzsxdHGBq2fDlJ3axAuLqANZI4+ZxwyGsOG2a287NQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=JK15Tz10z9ecQrye2vrnOS5GhNq0ik6JxOfXnzZm2YPy8IyvmBHGMaWqwZXD0h82W
         I7nDZQU81EJt43jo9y285vj4UNQ9pjaCl1po4KGIYThHPaR+nvTLtwFZtn6qPMKujm
         XFy9tZoJe3v96yv0T1RMzQtEDgDZc8suECBf5PzlzQQPPUc4D9C9+fs7UfCHg4sJ32
         ysLREkR6jk3fLFrOmChLeU+3Sdyn3467PSjkov6VwL8JzIWP6vkDqMdIJqL7en+37C
         2Ea3FOt76U74CNKAh4rVukBux7Smzd7oQzIKPlBTjOBloAzsMSmCSJHSh3ctOvH7Uj
         LxXFu81MStXjg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stripe control programming is governed by following formula, which is
referenced from the HD Audio specification(Revision 1.0a).
  { ((num_channels * bits_per_sample) / number of SDOs) >= 8 }

Currently above is implemented in snd_hdac_get_stream_stripe_ctl().
This patch introduces a structure member to store the default factor
of '8'. If any HW wants to use a different value, this member can be
easily updated.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 include/sound/hdaudio.h     |  3 +++
 sound/hda/hdac_controller.c | 12 ++++++++++++
 sound/hda/hdac_stream.c     |  2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index affedc2..d365297 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -364,6 +364,9 @@ struct hdac_bus {
 	/* link management */
 	struct list_head hlink_list;
 	bool cmd_dma_state;
+
+	/* factor used to derive STRIPE control value */
+	unsigned int sdo_limit;
 };
 
 int snd_hdac_bus_init(struct hdac_bus *bus, struct device *dev,
diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index bc4a8b6..ac15aa3 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -527,6 +527,18 @@ bool snd_hdac_bus_init_chip(struct hdac_bus *bus, bool full_reset)
 	}
 
 	bus->chip_init = true;
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
 	return true;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_bus_init_chip);
diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index a314b03..a38a2af 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -38,7 +38,7 @@ int snd_hdac_get_stream_stripe_ctl(struct hdac_bus *bus,
 		else
 			value = (channels * bits_per_sample) / sdo_line;
 
-		if (value >= 8)
+		if (value >= bus->sdo_limit)
 			break;
 	}
 
-- 
2.7.4

