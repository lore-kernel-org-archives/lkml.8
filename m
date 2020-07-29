Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E60C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F51120809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596008663;
	bh=EAAEADU7DSjaLvXALOCEsiBzv+cV9IYKsedOqf641lM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=i4raFoeLYKHhvYfpv1PtT8XRyyqp9EZsoYZ98SBbPDfLhlA43nY3pnfoCt6dYrk7s
	 UUDe3Bz2MdjfqLeIc3rXJ1Pu8bTk32TQ22IoFF589l5nCrlK85YmW2AjtPoyPileHR
	 Es3g7+wEXw6gQ5Qr8KbDjCjnf9k8clWrSIZw8I6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgG2HoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 03:44:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgG2HoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 03:44:21 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B964D20809;
        Wed, 29 Jul 2020 07:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596008661;
        bh=EAAEADU7DSjaLvXALOCEsiBzv+cV9IYKsedOqf641lM=;
        h=From:To:Cc:Subject:Date:From;
        b=yike37CLVQmHz0JUqQNOKjuZ3Am1/pbaBIWrX2PWKJHTCJ5QY9PKb6B1SIA/HVxhu
         Tot/6jU8FXITkwE/DI3HTqeqIdmxRg7Bi+QsHhamZDK7kn+9st8Cp+AWJ3i8624dZ1
         gjFvMo05FB5c3t4plz2TvdczGhJgbDX8bI3q3D8E=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] soc: mediatek: mtk-infracfg: Fix kerneldoc
Date:   Wed, 29 Jul 2020 09:44:14 +0200
Message-Id: <20200729074415.28393-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 compile warnings (invalid kerneldoc):

    drivers/soc/mediatek/mtk-infracfg.c:34: warning: Function parameter or member 'infracfg' not described in 'mtk_infracfg_set_bus_protection'
    drivers/soc/mediatek/mtk-infracfg.c:34: warning: Excess function parameter 'regmap' description in 'mtk_infracfg_set_bus_protection'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/soc/mediatek/mtk-infracfg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-infracfg.c b/drivers/soc/mediatek/mtk-infracfg.c
index 341c7ac250e3..4a123796aad3 100644
--- a/drivers/soc/mediatek/mtk-infracfg.c
+++ b/drivers/soc/mediatek/mtk-infracfg.c
@@ -19,7 +19,7 @@
 
 /**
  * mtk_infracfg_set_bus_protection - enable bus protection
- * @regmap: The infracfg regmap
+ * @infracfg: The infracfg regmap
  * @mask: The mask containing the protection bits to be enabled.
  * @reg_update: The boolean flag determines to set the protection bits
  *              by regmap_update_bits with enable register(PROTECTEN) or
@@ -50,7 +50,7 @@ int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
 
 /**
  * mtk_infracfg_clear_bus_protection - disable bus protection
- * @regmap: The infracfg regmap
+ * @infracfg: The infracfg regmap
  * @mask: The mask containing the protection bits to be disabled.
  * @reg_update: The boolean flag determines to clear the protection bits
  *              by regmap_update_bits with enable register(PROTECTEN) or
-- 
2.17.1

