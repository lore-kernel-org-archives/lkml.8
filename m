Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB6AC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C5D021741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598453403;
	bh=4KSU23WtTjItpkpM4PdbL4vEH8O0UC56ECWXv2J/6J0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=PCKpQUh5DvznqGIjB+cHvnJhkEgsYOw+No3HOSPZvQv9lpFb6Jp8VUIi4eX7OjoG4
	 OB9JKj4TpdrXvPy+s02Mt/Eob0hcol93eoJ1eUvMK1budHr2pyxgs0xHAZ70QTvFQd
	 KxoF35faik8s+A+VqJtWd9KV82cWpwgkOx9/uu08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgHZOuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:50:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbgHZOtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:49:41 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFABF2177B;
        Wed, 26 Aug 2020 14:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453381;
        bh=4KSU23WtTjItpkpM4PdbL4vEH8O0UC56ECWXv2J/6J0=;
        h=From:To:Cc:Subject:Date:From;
        b=ScUGKkM+UeSzgY8CMhwi8/yLLMbvJ0FnhzjziU28im+JhxuxMHaDVTMN80ixGtMTt
         Am/zzb5mVpN9sx7OSMnAH1h57ECyeO2+QJbuALgfs9vdz5A8/gdyvvQFmJQih4fqtb
         DSRsulWA1dpGg5pD7Fvr08H8nTo55Pl9X4WXKrFY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/3] mfd: madera: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:49:33 +0200
Message-Id: <20200826144935.10067-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/madera-core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index 8a8d733fdce5..4ed6ad8ce002 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -369,19 +369,14 @@ EXPORT_SYMBOL_GPL(madera_of_match);
 static int madera_get_reset_gpio(struct madera *madera)
 {
 	struct gpio_desc *reset;
-	int ret;
 
 	if (madera->pdata.reset)
 		return 0;
 
 	reset = devm_gpiod_get_optional(madera->dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(reset)) {
-		ret = PTR_ERR(reset);
-		if (ret != -EPROBE_DEFER)
-			dev_err(madera->dev, "Failed to request /RESET: %d\n",
-				ret);
-		return ret;
-	}
+	if (IS_ERR(reset))
+		return dev_err_probe(madera->dev, PTR_ERR(reset),
+				"Failed to request /RESET");
 
 	/*
 	 * A hard reset is needed for full reset of the chip. We allow running
-- 
2.17.1

