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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308CDC2BA1B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5CB20678
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiWsxXk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbgDHSYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:24:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35715 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729706AbgDHSYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 14:24:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id k5so3704794pga.2;
        Wed, 08 Apr 2020 11:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CG7WSXBqexh3DissoKcJ4k0HfJzButfmb/h6318ckoQ=;
        b=WiWsxXk3bcXVfoDWZ6ApJq8zXCNW9LqR6aXC7TTWKjYHHgXuI7a13oEPw/UTtjbXIr
         IVxbRf5zbjBaXiS4VsM0XEfaSUixMZIBfa/dD4K0LrCKcdkTkORLBZyRPNJxraEWC81/
         Ol+CQI05d9PD0aU9d/gLt9m5imEKnV7a2KYfmL/KbOZAEFmMhs+xcbd988hQvPWw4Rl6
         RMKSs94WSAfa2G0GYcSSuQTQIX2/Yy1MIdIeERAt5CIFU2oqxAEyR7vDvH7lypv3PXm2
         i5MXQt/XYD7rFx6sA0Nul3lQ+P+YSsF3yMueUuTk0woZfwllgEOvIDMQK4MAbKZBD/BK
         C+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CG7WSXBqexh3DissoKcJ4k0HfJzButfmb/h6318ckoQ=;
        b=VpPlLwa36ERGDlu5kR8jYmKCsjHIMJvHMn7vqjTnb1asiccDP5/pjkRRLqh2ud5tZY
         wOHOtywGKPh3UJJWHxbyBVz0bNPpiJqE+wat2Gew2JgzfMYHbUZRnJ9GsTKqYJLorKuX
         OtwYjzG3BHGWAoNGRh7hWi0q/asni8eXManzui883f8qCVqq/oxgoZOMgFNKmPWGtNmw
         dxWmkNdTcNOMSAfctx3NyT2hDefg+KL6PTUxRNkJcuDqVSjbD4/J6YKvOvfXqyBSYYCl
         a12L4j1x1eyogOktRDJ3PD8sBeLq2LkYJKTgS8MVvzgeqD4SqrRqz9j+4738vgzmiCw+
         bwIw==
X-Gm-Message-State: AGi0PuaFYBdW+q9os7MmtglW97nrFSP722cRGnjToEnCoSBdbltMJRDR
        M1gKQU40Ut18+QWAoQ2k2hM=
X-Google-Smtp-Source: APiQypL8JqVjJsx6qsfjINDEQsLxU2HhtDqY8e7pNVXKyjCUWbmjTYpdcjqwYnXMwFQsMPtdh3SC+w==
X-Received: by 2002:a63:ee0b:: with SMTP id e11mr8428682pgi.80.1586370252346;
        Wed, 08 Apr 2020 11:24:12 -0700 (PDT)
Received: from localhost (89.208.244.140.16clouds.com. [89.208.244.140])
        by smtp.gmail.com with ESMTPSA id my15sm210276pjb.28.2020.04.08.11.24.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Apr 2020 11:24:11 -0700 (PDT)
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
Subject: [PATCH v2 12/24] i2c: emev2: convert to devm_platform_ioremap_resource
Date:   Thu,  9 Apr 2020 02:22:59 +0800
Message-Id: <20200408182311.26869-13-zhengdejin5@gmail.com>
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

 drivers/i2c/busses/i2c-emev2.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-emev2.c b/drivers/i2c/busses/i2c-emev2.c
index 959d4912ec0d..1a319352e51b 100644
--- a/drivers/i2c/busses/i2c-emev2.c
+++ b/drivers/i2c/busses/i2c-emev2.c
@@ -361,15 +361,13 @@ static const struct i2c_algorithm em_i2c_algo = {
 static int em_i2c_probe(struct platform_device *pdev)
 {
 	struct em_i2c_device *priv;
-	struct resource *r;
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(&pdev->dev, r);
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-- 
2.25.0

