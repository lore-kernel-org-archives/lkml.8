Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185BAC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E248A20784
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifNypJ1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbgDHSYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:24:54 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39702 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729909AbgDHSYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 14:24:52 -0400
Received: by mail-pj1-f66.google.com with SMTP id z3so167450pjr.4;
        Wed, 08 Apr 2020 11:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+CbyZx4DsVajeH73SDij1aDz7h0XZqQanSKjpi7JEZo=;
        b=ifNypJ1b7dDTGPlgd0wuyCd0/MgV86FGP32CUV5mgq6rxfV6uiQ84wMLgUaT+ANg+N
         ti6jfHGH5bu8QTyCuq0wdXWjKKnfT8jm1C9+plceO+vFIl1jXSIrq7lgsGz94zkIi/Ai
         H2lhGMtiyftnqJ/IFx525rbmAS2hlzFYf3COIgrgSXZetTLINLIYc3sCbQjbZ6EysbLS
         P6liOdgB3aRdxMETouMuWz++bn4eskKE6hsHSmnprTwyMlpJxMLCHGh+PNuVXvKLXr/s
         NrRV3qT5Oevm6XQdaMcx2U9iVCZrSqwK4Cf0EaMEGQrnwfSHXEoUAflOWdqXXQP/Y319
         z9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+CbyZx4DsVajeH73SDij1aDz7h0XZqQanSKjpi7JEZo=;
        b=I0CXhHJgvNIvlC4YM/jqnVJ2y9KtWvp3M78qj4b1lFEJ5yClB7L4Z/Vw6ooKbUm4S4
         o3V4i+mkMdYrWYO7UWioKKFpRPd1a91LfyeNBLUrM3D5SprLAsvzjxFIYD51sC/12wZe
         76y4D4Tx9l0ssYhrgQ/c9+uniLzp0p2iIElmgFtR2weXSFAMCr3PnA+4YuyVNQ76h/SJ
         POxT3mq80CSOelGJzDXxjGwiA5eWPu8lyNwXOODJ+spCFYSXdoDUItHYG5NA+AaVQMia
         B2V2YAAXolEZpjAiSl3xjdHYGaUC7hd3808+3qE8oDZ8qDt/VpJlFohtD94Kp9py7fD4
         ZpNQ==
X-Gm-Message-State: AGi0PubjwgedA/LUtF8oFa8UCYxQfKxWq5SEMsMLMkNqtyXlEY+r84nV
        FWRkRSd3tPxzS3S20T+njeg=
X-Google-Smtp-Source: APiQypKLBpaEMClcnZVxlRUa0fDVguWyKkQPpS9+e2yWv+QXOmmSUtt4LAQcRRurfaI1rycO8lzzGQ==
X-Received: by 2002:a17:90a:4809:: with SMTP id a9mr6888244pjh.73.1586370291040;
        Wed, 08 Apr 2020 11:24:51 -0700 (PDT)
Received: from localhost (89.208.244.140.16clouds.com. [89.208.244.140])
        by smtp.gmail.com with ESMTPSA id u129sm17111100pfb.101.2020.04.08.11.24.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Apr 2020 11:24:50 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     thor.thayer@linux.intel.com, krzysztof.adamski@nokia.com,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, nsekhar@ti.com,
        bgolaszewski@baylibre.com, baruch@tkos.co.il,
        wsa+renesas@sang-engineering.com, kgene@kernel.org,
        krzk@kernel.org, paul@crapouillou.net, vz@mleia.com,
        khilman@baylibre.com, gregory.clement@bootlin.com,
        rrichter@marvell.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, heiko@sntech.de, baohua@kernel.org,
        linus.walleij@linaro.org, mripard@kernel.org, wens@csie.org,
        ardb@kernel.org, gcherian@marvell.com, jun.nie@linaro.org,
        shawnguo@kernel.org, tglx@linutronix.de, zhouyanjie@wanyeetech.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v2 22/24] i2c: xlr: convert to devm_platform_ioremap_resource
Date:   Thu,  9 Apr 2020 02:23:09 +0800
Message-Id: <20200408182311.26869-23-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200408182311.26869-1-zhengdejin5@gmail.com>
References: <20200408182311.26869-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use devm_platform_ioremap_resource() to simplify code, which
contains platform_get_resource and devm_ioremap_resource.

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
v1 -> v2:
	- no changed

 drivers/i2c/busses/i2c-xlr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xlr.c b/drivers/i2c/busses/i2c-xlr.c
index 34cd4b308540..544fd9459d60 100644
--- a/drivers/i2c/busses/i2c-xlr.c
+++ b/drivers/i2c/busses/i2c-xlr.c
@@ -362,7 +362,6 @@ static int xlr_i2c_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	struct xlr_i2c_private  *priv;
-	struct resource *res;
 	struct clk *clk;
 	unsigned long clk_rate;
 	unsigned long clk_div;
@@ -380,8 +379,7 @@ static int xlr_i2c_probe(struct platform_device *pdev)
 	else
 		priv->cfg = &xlr_i2c_config_default;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->iobase = devm_ioremap_resource(&pdev->dev, res);
+	priv->iobase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->iobase))
 		return PTR_ERR(priv->iobase);
 
-- 
2.25.0

