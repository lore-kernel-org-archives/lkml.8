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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6C6C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0360B20768
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIhU32Lh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbgDHSYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:24:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40860 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729706AbgDHSYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 14:24:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id h11so2807204plk.7;
        Wed, 08 Apr 2020 11:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TgetHGEu6f5kVofaVtLnz/fdy6VDTCTDpSm4U8yZQ8k=;
        b=tIhU32Lhm8RUdHbi6UWgehMOyYMgQrC1yacNiPcI4jIjJiREkGplL8aEpZ7wcm8abm
         06iBaJPEf16h4ZjjQkJZ0qv7zjK3v5c4653vizJb5oqAdQFAJMNBwVtvx0WOl/FRHDxu
         hHJBmcZSpLZK51hEoimYQgyStr4LDzaY473Wv0ko2uEyv4LR7i7W3JCjx56SDtzO/1hz
         4ItwWqK5hPbUBd5XuqBU9wtWBRdSVxHyVuO8xfS2Z8nSIfzuDD1GpGL7Rn8Svzc8rhEW
         MCwGpHmAcbG5N4JSxn0B/MpSZ9MsePZwn0rQvhtWhrQOF9GlmWqaiUroOIB9zFJHU3YL
         cKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TgetHGEu6f5kVofaVtLnz/fdy6VDTCTDpSm4U8yZQ8k=;
        b=hzIHS/oia/4JlZKjPgjTCvCSOw6MIiaYMJjxSkfmLU0shUvBmwnrRLuXUonpi9T1Ch
         h7VXr2PjddJ8U9O7zs3ioCxPfkJOGKQ84qQV/mQGFoFo9yDbVFPxkE8DFn9VIPQBDrY9
         99uSJA/tai9oFVAvscuPsHy53fwwph3hH8BQRjQQ+flfueDSn8/JNY6qqOtbLgxtrBU6
         joz9h9qYXWAwr51ipHNb098EqASk9ESXJd0UGTgy4HLn2z98wYgaQssVvuPDvRaYJq0n
         emcOmfCqiA4cgLRkdhzBiaNhp5vTo8Ld/gjqPMkZuvWsQdHP3wNCtrYXTDMdaSd+5tJt
         E2+g==
X-Gm-Message-State: AGi0PubsFSw03Cqcxa3OBoRzdgySE8AAPSk8hc5p8u3Mep+IGVzoagax
        awO9BLagmRYf9hdJxGfdIx0=
X-Google-Smtp-Source: APiQypIiMxkyZeUUZIzaqniGHQEXkdD0jQz9ceaYuZcyAXjJcvIJKtnlOfyHUoS8yby2LelKbN1z4g==
X-Received: by 2002:a17:90a:33d1:: with SMTP id n75mr6715955pjb.167.1586370248499;
        Wed, 08 Apr 2020 11:24:08 -0700 (PDT)
Received: from localhost (89.208.244.140.16clouds.com. [89.208.244.140])
        by smtp.gmail.com with ESMTPSA id e129sm1059107pfh.187.2020.04.08.11.24.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Apr 2020 11:24:08 -0700 (PDT)
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
Subject: [PATCH v2 11/24] i2c: hix5hd2: convert to devm_platform_ioremap_resource
Date:   Thu,  9 Apr 2020 02:22:58 +0800
Message-Id: <20200408182311.26869-12-zhengdejin5@gmail.com>
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

 drivers/i2c/busses/i2c-hix5hd2.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-hix5hd2.c b/drivers/i2c/busses/i2c-hix5hd2.c
index 224f830f77f9..4b72cb3b4231 100644
--- a/drivers/i2c/busses/i2c-hix5hd2.c
+++ b/drivers/i2c/busses/i2c-hix5hd2.c
@@ -390,7 +390,6 @@ static int hix5hd2_i2c_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct hix5hd2_i2c_priv *priv;
-	struct resource *mem;
 	unsigned int freq;
 	int irq, ret;
 
@@ -411,8 +410,7 @@ static int hix5hd2_i2c_probe(struct platform_device *pdev)
 		}
 	}
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->regs = devm_ioremap_resource(&pdev->dev, mem);
+	priv->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->regs))
 		return PTR_ERR(priv->regs);
 
-- 
2.25.0

