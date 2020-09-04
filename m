Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E911C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DD722074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="o3fTEMEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgIDNNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:13:32 -0400
Received: from crapouillou.net ([89.234.176.41]:53504 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730423AbgIDNM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599225119; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rkqt09OX0z4L1cVwLlbeLSj8qO995KDBSzSLUeT8TiI=;
        b=o3fTEMEzKq9M0HL60IdNSSiTMby+xXMbq2D3VQA2Cyy7SzgmglhL7G56QZ4JxloNIdALyL
        9jahg4e6w5It4ESgRy2T68Z9c4scwD/kHg2x9yhTTx9Osnv98dZFgxWDzEhl6laslNH/v0
        hQgfbTfxcfNSvKkeag2NNlsZn0awrHY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     od@zcrc.me, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/3] i2c: jz4780: Add compatible string for JZ4770 SoC
Date:   Fri,  4 Sep 2020 15:11:51 +0200
Message-Id: <20200904131152.17390-2-paul@crapouillou.net>
In-Reply-To: <20200904131152.17390-1-paul@crapouillou.net>
References: <20200904131152.17390-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2C controller in the JZ4770 SoC seems to work the exact same as in
the JZ4780 SoC.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/i2c/busses/i2c-jz4780.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-jz4780.c b/drivers/i2c/busses/i2c-jz4780.c
index ba831df6661e..ed2ec86f6f1a 100644
--- a/drivers/i2c/busses/i2c-jz4780.c
+++ b/drivers/i2c/busses/i2c-jz4780.c
@@ -752,6 +752,7 @@ static const struct ingenic_i2c_config x1000_i2c_config = {
 };
 
 static const struct of_device_id jz4780_i2c_of_matches[] = {
+	{ .compatible = "ingenic,jz4770-i2c", .data = &jz4780_i2c_config },
 	{ .compatible = "ingenic,jz4780-i2c", .data = &jz4780_i2c_config },
 	{ .compatible = "ingenic,x1000-i2c", .data = &x1000_i2c_config },
 	{ /* sentinel */ }
-- 
2.28.0

