Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E2EC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7BE20637
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYsC2aFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbgCWQGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:06:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39814 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgCWQGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:06:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id m1so6095054pll.6;
        Mon, 23 Mar 2020 09:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=esK0ijTXuENjjUv500sYKFrmgfX9eJSiFoVlzHTv9Q0=;
        b=AYsC2aFu+2q5eUIx9X3jD7ZTe9IGGy69BQ0h1kg1HrGQ60SpHEM12MuP11JLfIgNUW
         jIiIf2Ms6DnJ8/fEj5mmjVWQE/l9tl1RyOPJjPjLiSztc4pCRAXl1G9zy9wjWghNsPpO
         oHf6CFY4Y3FI7hNdnh6MjT94W0Y6eN2BRUOAKh5W4N4wd0JNfJNzDQsFGNr18qtgmjuD
         kp0EmBMJLRzTVbZkVxXi+KuYq6Sps98cZ8CDBNWnMIGllWCTTaVe+Zs4QY+NnH/yJsXH
         R7FL0Sz58Gw1uXXa4mTtw7ZrS/43jTRYZoE+GMY7fGqZYkd1WVkNaU0+tt6L564YNNPY
         RCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=esK0ijTXuENjjUv500sYKFrmgfX9eJSiFoVlzHTv9Q0=;
        b=J8/OfU3XHuBk2MjJzLt8w11TK1BXP3Dq2gwYS1qIl8bFb3k1k01ggAs+4FMpzrOUgO
         GozFxOAEYl6N7jqiBYb/O7QzOZZfsmbGeFYchbq7L+Nuq9eqln1tMAUEFDeruULtPSfH
         agmjG+EfiU6N2OCeC0AnkhW7degpD/Asnw/fNijO8C4us7JqlFXEA5Yl4x/K+QYHfWMP
         tfY5z/r2Z93zZW78Oj0G3FoZHYC8wi2yp1igPtWQvgwJAtwIOL1DHE8h93RbKRQUKKtc
         BK1TifKp8DBQ+R1LPqPGWJ7LmzVkIdQN/0GnYSVZwMbAz4M6ODpy6+C89hI+Fejk+iMH
         AkRA==
X-Gm-Message-State: ANhLgQ1TELKTFzIM6ScFcbtA3OxUr+Cisbqv5QaC9kBEVd1cT+UO6wPe
        Dvb1ZOvkz4dVPwPrSrbTU4M=
X-Google-Smtp-Source: ADFU+vvs/lX+dw4xA3N+Piv9saWf8XcN/uDvwNsco+RqVP7o60D8z9MZgnsgcKOIVowPaiUyUbSuFQ==
X-Received: by 2002:a17:90a:e64e:: with SMTP id ep14mr13945930pjb.149.1584979607770;
        Mon, 23 Mar 2020 09:06:47 -0700 (PDT)
Received: from localhost (176.122.158.203.16clouds.com. [176.122.158.203])
        by smtp.gmail.com with ESMTPSA id y9sm14873pjj.17.2020.03.23.09.06.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 09:06:47 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, hminas@synopsys.com,
        mathias.nyman@intel.com, bgolaszewski@baylibre.com, arnd@arndb.de,
        geert+renesas@glider.be, tomas.winkler@intel.com,
        tglx@linutronix.de, hdegoede@redhat.com, treding@nvidia.com,
        suzuki.poulose@arm.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v4 4/5] usb: dwc2: convert to devm_platform_get_and_ioremap_resource
Date:   Tue, 24 Mar 2020 00:06:11 +0800
Message-Id: <20200323160612.17277-5-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200323160612.17277-1-zhengdejin5@gmail.com>
References: <20200323160612.17277-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_get_and_ioremap_resource() to simplify code, which
contains platform_get_resource() and devm_ioremap_resource(), it also
get the resource for use by the following code.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
v2 -> v3:
	- no changed.
v2 -> v3:
	- call the rename function devm_platform_get_and_ioremap_resource()
v1 -> v2:
	- add this patch for add some real users of this function. 
 
 drivers/usb/dwc2/platform.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 3c6ce09a6db5..8a68e89749d2 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -392,8 +392,7 @@ static int dwc2_driver_probe(struct platform_device *dev)
 		return retval;
 	}
 
-	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	hsotg->regs = devm_ioremap_resource(&dev->dev, res);
+	hsotg->regs = devm_platform_get_and_ioremap_resource(dev, 0, &res);
 	if (IS_ERR(hsotg->regs))
 		return PTR_ERR(hsotg->regs);
 
-- 
2.25.0

