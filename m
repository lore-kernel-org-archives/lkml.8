Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC45C2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A7B2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwe55r88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgDGQh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:37:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36315 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgDGQh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:37:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id n10so1052832pff.3;
        Tue, 07 Apr 2020 09:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i7NXUncttHKn24gmiTbFFll7Tmqd1p9Knemu5Uatb0Q=;
        b=iwe55r885GatNZT/3ayY95HLjmr9mDeuCoNfY/f1yoWQygO/ZJt+BgrNywiiiew22i
         +wL8BiREp1P1ENUterdhLuTYiFdguIMDZBbgn78DChRYQFxZ/JyeBS1v1nrdEARLJ2aH
         f2cVIQ1LSe30JSIxXWDvYplWTkpIjDyDeyLsrhGdbVcodGbmu6SYmT4czYNeUpQpgFbc
         1ZKzJsQEAOZqCBzQDYHFyk/rOvdpN+g9eZdaeVFdmShHObqyPfABlczCFSvkwlaKU5Fi
         zgc8Ox0W8h4mCKByKL3q7cqzpQCtLCoCibGWq5ky3NuCad3NTsS0ZzpkM8MrUdH/lFSm
         aU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i7NXUncttHKn24gmiTbFFll7Tmqd1p9Knemu5Uatb0Q=;
        b=NXDncofDcQ8xobOKAUHuQ9xzLctJ/+l9t1IyhiOx25uWCL13XNZ03cLgCom7qoWwBE
         IOlHmDezMdTeteFAwtfIuYrqIVh6CXNso0nxPwMLk90jyWq8ByEc0qkR6w96FlamNfJT
         SPLjaGbfa+XDbyNH9Z8srf+IlDp/iSt1HSvzv4PT0bZcqLuFNfHRYAwBE0JDox5qvTju
         fqNhDd6+RR6cRXKGnoO+oSUNC/DspQEiqj5b0kxiNromOcXorlRFXCTpiQd6jjVklVlY
         BCR6xV19T/K3RzkBgz5qc0lqV3xQI36kFcpG8XUto0wyZv6UB/qyGBt31sppmrNZhaN3
         DwKA==
X-Gm-Message-State: AGi0PuYnrPxVgWyJkXcZ2fivs+tLJfku9i+1CEayBffIjedLsYXTSPAg
        e8UY5Dkzn9hJIqI5FuYtvJk=
X-Google-Smtp-Source: APiQypIuEQro2fvQdRcmyYhdnJrBbSGHACksbqKRSxW8eqGjZyqJb3/KxcpUDtn15jSEGpWMJ341QQ==
X-Received: by 2002:a63:8b42:: with SMTP id j63mr2724840pge.27.1586277474958;
        Tue, 07 Apr 2020 09:37:54 -0700 (PDT)
Received: from localhost (89.208.244.140.16clouds.com. [89.208.244.140])
        by smtp.gmail.com with ESMTPSA id n100sm2008856pjc.38.2020.04.07.09.37.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Apr 2020 09:37:54 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     thor.thayer@linux.intel.com, krzysztof.adamski@nokia.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        nsekhar@ti.com, bgolaszewski@baylibre.com,
        jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com,
        mika.westerberg@linux.intel.com, baruch@tkos.co.il,
        wsa+renesas@sang-engineering.com, kgene@kernel.org,
        krzk@kernel.org, paul@crapouillou.net, vz@mleia.com,
        khilman@baylibre.com, matthias.bgg@gmail.com,
        gregory.clement@bootlin.com, rrichter@marvell.com,
        afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org, heiko@sntech.de,
        baohua@kernel.org, linus.walleij@linaro.org, mripard@kernel.org,
        wens@csie.org, ardb@kernel.org, michal.simek@xilinx.com,
        gcherian@marvell.com, jun.nie@linaro.org, shawnguo@kernel.org,
        rayagonda.kokatanur@broadcom.com, lori.hikichi@broadcom.com,
        nishkadg.linux@gmail.com, kstewart@linuxfoundation.org,
        allison@lohutok.net, gregkh@linuxfoundation.org,
        tglx@linutronix.de, bigeasy@linutronix.de, info@metux.net,
        hslester96@gmail.com, narmstrong@baylibre.com,
        martin.blumenstingl@googlemail.com, qii.wang@mediatek.com,
        drinkcat@chromium.org, hsinyi@chromium.org, fparent@baylibre.com,
        opensource@jilayne.com, swinslow@gmail.com,
        linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v1 01/28] i2c: img-scb: convert to devm_platform_ioremap_resource
Date:   Wed,  8 Apr 2020 00:37:14 +0800
Message-Id: <20200407163741.17615-2-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200407163741.17615-1-zhengdejin5@gmail.com>
References: <20200407163741.17615-1-zhengdejin5@gmail.com>
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
 drivers/i2c/busses/i2c-img-scb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 20a4fbc53007..5e0022e55315 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -1330,7 +1330,6 @@ static int img_i2c_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct img_i2c *i2c;
-	struct resource *res;
 	int irq, ret;
 	u32 val;
 
@@ -1338,8 +1337,7 @@ static int img_i2c_probe(struct platform_device *pdev)
 	if (!i2c)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	i2c->base = devm_ioremap_resource(&pdev->dev, res);
+	i2c->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(i2c->base))
 		return PTR_ERR(i2c->base);
 
-- 
2.25.0

