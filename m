Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67633C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4241F208B3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="TpsnR5Wc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgIBPrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:47:41 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:55958 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbgIBNbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:31:34 -0400
IronPort-SDR: d0lp3rNJvvGbqLTQHTgs5N75l5D8szcOauSqLAcK2eHMB6yeOrT3QZKzwGvRtyhhgPZKQ4bLHq
 ULNlUd5siJwveh/9eNJIo9GNvSWpPU2RfBr90oP+QEeVrrvgwx5VZdrPVRQaccxIuL9NslTW4Y
 HwSmRvNZRZQRzvU0Ta4/fztT63g+ZdNjdO1cxAMdNzFo6/q1GvbC6Qonoy9jSIYr//q/tJHOX4
 zbMfgebHJ8rwPUcsSKer9TdeTZ/LQtBj4ULSlNNvBci0c6F/tNElWentlIRC9NrjOFVgvsjOPE
 JsU=
X-IronPort-AV: E=Sophos;i="5.76,383,1592863200"; 
   d="scan'208";a="13702688"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 02 Sep 2020 15:30:59 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 02 Sep 2020 15:30:59 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 02 Sep 2020 15:30:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1599053459; x=1630589459;
  h=from:to:cc:subject:date:message-id;
  bh=ORYe7avErwu4WFEAorhEscGnFHXvdNg4+jfB80re9o0=;
  b=TpsnR5WcfjtNwbxceig1HrB0dl9w2sYCHFdhYJrxiQ9nwuzPBIyGjqcs
   k4Ybi6Ev6qBFy33aYuuw6pms4dkW3RyDl/vP27zI7uw9TKRZyyQjX7rgV
   vngYfYVu93WZwNj1n0lQ6jeZk6OlZwGcaTs4pNd3qUKJ9HdGwWIAA4FHH
   ep6M33Yuyt2xnCm/o7bBIlr6YvotY2o1ED7blYUJsrwTZ5hn0lQOaKjFH
   DIEwcfosdjE89hhjqz4wd0XttpIArP/GqBTl0SwnWRpj8qXJPIcSQ5VMl
   reZ08T0l/uAj6HGaRIA3+RS2F7VogJPxHTA1ounRfXVGaLX8wLDjFyeNO
   g==;
IronPort-SDR: VLEY4cbyc3i8spDisESikz/mri5KDL/ihYpJyEaiioQkDYSXhUSroCWlQ+fz+Bbi2dy2jnz+sx
 MP3srgBnXC6JlbwPyGd6mqBOx0EOcUyFF4uN449l8zyTrFNWjgfxViiXRx8IsCvdWmvK7lJmZx
 IO9YYH0RcbuaEBR7gjWd4OsL9qtBP4Dd0pGFsWZzJAhWsURcFIABCZyXYNbIRSwwW4/SAMR3Yv
 69vuKjbmO/w4ZRYrOMFEFX5PT542Hz3nhUrlxXBcTgDBVLvmhxbKPzmPWhJbTsGQ0aYwNA1P/0
 AEM=
X-IronPort-AV: E=Sophos;i="5.76,383,1592863200"; 
   d="scan'208";a="13702687"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 02 Sep 2020 15:30:59 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id F14ED280065;
        Wed,  2 Sep 2020 15:30:58 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 1/2] ASoC: codec: tlv320aic32x4: fix missing aic32x4_disable_regulators() in error path
Date:   Wed,  2 Sep 2020 15:30:42 +0200
Message-Id: <20200902133043.19504-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regulators need to be disabled in the aic32x4_register_clocks()
failure case as well.

Fixes: 9d4befff5a95 ("ASoC: codec: tlv3204: Moving GPIO reset and add ADC
reset")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 sound/soc/codecs/tlv320aic32x4.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 8dcea566b375..a45fb496082c 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -1230,8 +1230,7 @@ int aic32x4_probe(struct device *dev, struct regmap *regmap)
 			&soc_component_dev_aic32x4, &aic32x4_dai, 1);
 	if (ret) {
 		dev_err(dev, "Failed to register component\n");
-		aic32x4_disable_regulators(aic32x4);
-		return ret;
+		goto err_disable_regulators;
 	}
 
 	if (gpio_is_valid(aic32x4->rstn_gpio)) {
@@ -1242,9 +1241,14 @@ int aic32x4_probe(struct device *dev, struct regmap *regmap)
 
 	ret = aic32x4_register_clocks(dev, aic32x4->mclk_name);
 	if (ret)
-		return ret;
+		goto err_disable_regulators;
 
 	return 0;
+
+err_disable_regulators:
+	aic32x4_disable_regulators(aic32x4);
+
+	return ret;
 }
 EXPORT_SYMBOL(aic32x4_probe);
 
-- 
2.17.1

