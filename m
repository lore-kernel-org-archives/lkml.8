Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71530C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D69204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c2AHu8++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgHLNb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbgHLNbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 09:31:23 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184CEC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 06:31:21 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d22so1035885pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 06:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vlf2gQ258Yo0xeKkYNMeBOCIHVe3hvJX2SMEJPRuUbY=;
        b=c2AHu8++qdSURlnEYQVRqISoN1mnzzPboyfje7CpVG4P/AdpneMgNGfx+vclZ3SmJZ
         mrOFXwgOO3vK6Am/uNIgDP/uUcboRU3d7JhhPETV+s21RG7g1SXIG4mFstfweGJ23OE4
         T0M8LDUAq/EplxYiiQNFOrdpjZd8vxugMAX9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vlf2gQ258Yo0xeKkYNMeBOCIHVe3hvJX2SMEJPRuUbY=;
        b=sCRfqws5+lOehAifLEbYXZM3iXFNWGKng5axQmh5+pCVty9AotOFVSLuPpvqMcaEOg
         jfopMTTRu6LAVi4GxgpiG/Wh+5gIJFQq3+l7hUwcr3Z6OXM9FLu5RYCqUhFWjbjP5Gd5
         pBZzIIqCJBSnl/U42pXpMQens/VbbEN2M6qnB6XN/GBqaSBWkSuZS+Hk/iHb2YcHczr/
         EjNRLaE5NnohOIcTB6fVXZ7cRTLXi+JE7x3ABLLm0eDXRHvxuUX5kGQwD8febGCi6NJ5
         huofaSbI0sxaFbxdzsqS4cPpAkbo5gV8ERYdZy+ePB9eL9oK6QoYNuvsl62fABzoC43Y
         fGXA==
X-Gm-Message-State: AOAM530cKyqSII37ExcPN8Gl67C7BxgWKce/6vbdhxomCWja+4rpawCg
        GnyPhIZ3g8C9U4uuftJsHsRCxA==
X-Google-Smtp-Source: ABdhPJzpMXs76cDKrcxnEiUeiPgvpYo8pxBDIU68bf9PUiSC35Y94TDM35dGj/w0hCqzbdmyYT2Acw==
X-Received: by 2002:aa7:9703:: with SMTP id a3mr11043496pfg.268.1597239079820;
        Wed, 12 Aug 2020 06:31:19 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id b63sm2488143pfg.43.2020.08.12.06.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 06:31:19 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Tomasz Figa <tfiga@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH] regulator: da9211: add cache_type
Date:   Wed, 12 Aug 2020 21:31:02 +0800
Message-Id: <20200812133101.2513317-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regmap_cache to reduce wakeups events of interrupt if regulator is
accessed frequently. This results in saving more power.

Suggested-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/regulator/da9211-regulator.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index 297b3aa7c753..cffcefd0538d 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -51,10 +51,24 @@ static const struct regmap_range_cfg da9211_regmap_range[] = {
 	},
 };
 
+static bool da9211_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case DA9211_REG_STATUS_A:
+	case DA9211_REG_STATUS_B:
+	case DA9211_REG_EVENT_A:
+	case DA9211_REG_EVENT_B:
+		return true;
+	}
+	return false;
+}
+
 static const struct regmap_config da9211_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = 5 * 128,
+	.volatile_reg = da9211_volatile_reg,
+	.cache_type = REGCACHE_RBTREE,
 	.ranges = da9211_regmap_range,
 	.num_ranges = ARRAY_SIZE(da9211_regmap_range),
 };
-- 
2.28.0.236.gb10cc79966-goog

