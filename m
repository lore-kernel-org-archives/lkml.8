Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C599C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A18206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="tSA+//yq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730844AbgG1P0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:26:37 -0400
Received: from crapouillou.net ([89.234.176.41]:46220 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730637AbgG1P0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595949994; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=WZATYdvQioBf66nwEBhd77lthqSIvneIIUEGQ+zn1jg=;
        b=tSA+//yqbM3nRlSMlqjN+6pw8Hy4iRvX3tN44Z0akzuzR52Zlmr6y0IyF09lpAXsUd/bG1
        N7I3e34q+REGUQrLy+oFaoGPpOGJVUo8lufGilkY84l923xhrfkZmJLXQoYoQXZml2AJoS
        IDn7dMM/M7EnQMVvfLdVa2yAUtmkASw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        "H . Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2] memory: jz4780_nemc: Only request IO memory the driver will use
Date:   Tue, 28 Jul 2020 17:26:29 +0200
Message-Id: <20200728152629.28878-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver only uses the registers up to offset 0x54. Since the EFUSE
registers are in the middle of the NEMC registers, we only request
the registers we will use for now - that way the EFUSE driver can
probe too.

Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Only ioremap() the registers we will use

 drivers/memory/jz4780-nemc.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/jz4780-nemc.c b/drivers/memory/jz4780-nemc.c
index b232ed279fc3..3ec5cb0fce1e 100644
--- a/drivers/memory/jz4780-nemc.c
+++ b/drivers/memory/jz4780-nemc.c
@@ -8,6 +8,7 @@
 
 #include <linux/clk.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/math64.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -22,6 +23,8 @@
 #define NEMC_SMCRn(n)		(0x14 + (((n) - 1) * 4))
 #define NEMC_NFCSR		0x50
 
+#define NEMC_REG_LEN		0x54
+
 #define NEMC_SMCR_SMT		BIT(0)
 #define NEMC_SMCR_BW_SHIFT	6
 #define NEMC_SMCR_BW_MASK	(0x3 << NEMC_SMCR_BW_SHIFT)
@@ -288,7 +291,19 @@ static int jz4780_nemc_probe(struct platform_device *pdev)
 	nemc->dev = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	nemc->base = devm_ioremap_resource(dev, res);
+
+	/*
+	 * The driver currently only uses the registers up to offset
+	 * NEMC_REG_LEN. Since the EFUSE registers are in the middle of the
+	 * NEMC registers, we only request the registers we will use for now;
+	 * that way the EFUSE driver can probe too.
+	 */
+	if (!devm_request_mem_region(dev, res->start, NEMC_REG_LEN, dev_name(dev))) {
+		dev_err(dev, "unable to request I/O memory region\n");
+		return -EBUSY;
+	}
+
+	nemc->base = devm_ioremap(dev, res->start, NEMC_REG_LEN);
 	if (IS_ERR(nemc->base)) {
 		dev_err(dev, "failed to get I/O memory\n");
 		return PTR_ERR(nemc->base);
-- 
2.27.0

