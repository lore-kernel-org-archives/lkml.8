Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157D2C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DED76206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgDUMKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:10:45 -0400
Received: from inva021.nxp.com ([92.121.34.21]:55996 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728702AbgDUMKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:10:44 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 246E4200C8F;
        Tue, 21 Apr 2020 14:10:43 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8FD72200C7B;
        Tue, 21 Apr 2020 14:10:38 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C567A4029E;
        Tue, 21 Apr 2020 20:10:32 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, shengjiu.wang@nxp.com, tglx@linutronix.de,
        allison@lohutok.net, info@metux.net, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: wm8962: restore the CLOCKING2 register in resume
Date:   Tue, 21 Apr 2020 20:02:15 +0800
Message-Id: <1587470535-20469-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CLOCKING2 is a volatile register, but some bits should
be restored when resume, for example SYSCLK_SRC. otherwise
the output clock is wrong

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/wm8962.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index d9d59f45833f..6e96c0c5ad2a 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -82,6 +82,7 @@ struct wm8962_priv {
 #endif
 
 	int irq;
+	u32 regcache_clocking2;
 };
 
 /* We can't use the same notifier block for more than one supply and
@@ -3813,6 +3814,10 @@ static int wm8962_runtime_resume(struct device *dev)
 
 	regcache_sync(wm8962->regmap);
 
+	regmap_update_bits(wm8962->regmap, WM8962_CLOCKING2,
+			   WM8962_SYSCLK_SRC_MASK,
+			   wm8962->regcache_clocking2);
+
 	regmap_update_bits(wm8962->regmap, WM8962_ANTI_POP,
 			   WM8962_STARTUP_BIAS_ENA | WM8962_VMID_BUF_ENA,
 			   WM8962_STARTUP_BIAS_ENA | WM8962_VMID_BUF_ENA);
@@ -3842,6 +3847,9 @@ static int wm8962_runtime_suspend(struct device *dev)
 			   WM8962_STARTUP_BIAS_ENA |
 			   WM8962_VMID_BUF_ENA, 0);
 
+	regmap_read(wm8962->regmap, WM8962_CLOCKING2,
+		    &wm8962->regcache_clocking2);
+
 	regcache_cache_only(wm8962->regmap, true);
 
 	regulator_bulk_disable(ARRAY_SIZE(wm8962->supplies),
-- 
2.21.0

