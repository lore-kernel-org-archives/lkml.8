Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB789C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DAF20768
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARmv8+B6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbgDHSYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:24:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34730 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729706AbgDHSYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 14:24:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id a23so2828548plm.1;
        Wed, 08 Apr 2020 11:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ds5CldkNdViqYbBNI8smRrL4+Qy7chHgOin2wK6+Evs=;
        b=ARmv8+B6UWSgEWip2KlWhsLcV80V1EzULpRjVsKeawndCggf65SLACm0KiFuwumiwp
         JDiyb/ANV9GY23Uvf1RzIbiR7aylgaMgS7ncTESbmfOWhzK6aw6NNocfFcG8esqVoIWZ
         CzVsVV9ZGKNq/48NLGfkDMgRtEr8rXxYNDhiLFIRjWs+FVbrrwkmuHSORRkfPwSb4uQP
         g7Eo3kccD3UyeKpeEiogL8LbNwvSBl9tXP4gQXnAb4pb9E6SgjgshsNnWeYpQgwpfJnO
         HjXdyN/ct1TxY3LQx/y+niot4QNpaJVMO9sJOi+hn2Dtcn04vgJrRXtuLpRRnQ/Lp620
         +DLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ds5CldkNdViqYbBNI8smRrL4+Qy7chHgOin2wK6+Evs=;
        b=I4qesDaRbmVpdCTVzs4N321zNf1bzJcLnxybhfCbz0TRz8JKSOvAzX6I/0kVUUk6UN
         nxPdHH/Ylkjjie2QdAjrP5hF1oNAw8L6SGfWOysy7irv97YQfy0pwQJ4zdDuiTYrVc5i
         S7D1+pXioSs1+JuQWYzMWUKx8n/d1NiSOUXIJwsIs/ATZbfhT9YsrXM02ab/LTIlKe9q
         7FSjsQIcWOtfLqt4SWXQcOrlmPfe9obtn4H20P2LSSRcx38RQ9ssIo/t8CFW63siMu+v
         Oh+v44V8uH5AxX+mDWuBfk6mY2AosMtWQB7+2i4PE3WapErilOCbe4+7RP/RJV+vQgcT
         C12w==
X-Gm-Message-State: AGi0PuYWMhba+kqR0OFORKHyQt8svuv8sZHOg9RdmXArUcbdqHTByBJE
        hIflWslCEM3pdt1KeX5a7G4=
X-Google-Smtp-Source: APiQypKBqupI8crfx532xLT0pMeGN43dtwl3Qmk5fEr0y5pzoyb8BcqWt3a8g28r9cOjoDqF9TKv7w==
X-Received: by 2002:a17:90a:cb14:: with SMTP id z20mr6667204pjt.170.1586370256178;
        Wed, 08 Apr 2020 11:24:16 -0700 (PDT)
Received: from localhost (89.208.244.140.16clouds.com. [89.208.244.140])
        by smtp.gmail.com with ESMTPSA id z8sm199307pju.33.2020.04.08.11.24.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Apr 2020 11:24:15 -0700 (PDT)
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
Subject: [PATCH v2 13/24] i2c: jz4780: convert to devm_platform_ioremap_resource
Date:   Thu,  9 Apr 2020 02:23:00 +0800
Message-Id: <20200408182311.26869-14-zhengdejin5@gmail.com>
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

 drivers/i2c/busses/i2c-jz4780.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-jz4780.c b/drivers/i2c/busses/i2c-jz4780.c
index b426fc956938..ba831df6661e 100644
--- a/drivers/i2c/busses/i2c-jz4780.c
+++ b/drivers/i2c/busses/i2c-jz4780.c
@@ -763,7 +763,6 @@ static int jz4780_i2c_probe(struct platform_device *pdev)
 	int ret = 0;
 	unsigned int clk_freq = 0;
 	unsigned short tmp;
-	struct resource *r;
 	struct jz4780_i2c *i2c;
 
 	i2c = devm_kzalloc(&pdev->dev, sizeof(struct jz4780_i2c), GFP_KERNEL);
@@ -787,8 +786,7 @@ static int jz4780_i2c_probe(struct platform_device *pdev)
 	init_completion(&i2c->trans_waitq);
 	spin_lock_init(&i2c->lock);
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	i2c->iomem = devm_ioremap_resource(&pdev->dev, r);
+	i2c->iomem = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(i2c->iomem))
 		return PTR_ERR(i2c->iomem);
 
-- 
2.25.0

