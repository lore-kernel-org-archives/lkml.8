Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B75C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A8B24654
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RRR7WIr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgBRTeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:34:25 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50616 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgBRTdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:33:23 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so3985030wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n2/6Go98pHaxpLCc5lRLRHeU4KxfdOQs2LuzJH/tK0k=;
        b=RRR7WIr1e0sQU9K3EdoR/DhnYIc4/rh3LiZbPMP3o7KsDxgcrnlOejN0fh/4Y8Rh3Q
         PlF1am3pvjHFriwsTGetrBUQ+vxK91j/cwtv861hpab+b7fFGhLBT/1KZMhBapKahvxp
         +cMVOJ9slgZWA9SfAfKhFxyCeQizK0oe1imzaUNU5ICbKQepRp+X3gthGa65xy6AG37M
         ymq1Q8iA1cfeopQSGsQ7Lq/TYulpxOdga90qXJW77ShQyoU3ip//MS9KhaqE7b4YUfaU
         qEBv7669Xyp3pbtXR46v9X4zfy/GYbkyjOTmFk4dvqifb81mNHbp5lBHfYnb+JVH61UU
         GZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n2/6Go98pHaxpLCc5lRLRHeU4KxfdOQs2LuzJH/tK0k=;
        b=RQn6tykoPPA0MOhrvQ0Apbr1Ok6lZARa1bTdI9G82otiOoija2xThEwqWmvkgtVGgu
         5y0aefjTELtAdOPd/9+6jhcA1uL1YVVf4MtBtHP9ki7pogwQ1Tx79av9u8rSRUGp6MM/
         yxXN1MBTRVdAEVaXX6qr/p6PsMupN2xn7Bg87F/d1TpK3H4hw8fF7mIINLdt+/VdAlrn
         fWb5G5kx9pP6+JGs4jf5KYz0woCknuk5wlh7RXmon5C5s8da97zc/h2TaETv9w9RmbGj
         0YaSZS2cXxkISr1cXmZI7OiVgaq6lc7fLR9oX4HEnkluKN3tMbzcnuVEhP/Mlo1HcdBp
         ASuA==
X-Gm-Message-State: APjAAAXXoyZcm7O65GSor9yYEtrmYiT3Q0Eh82y7otVEYa2ODEToDuQR
        BpjCjyiXXpoFa0Uq1bmnE98NvA==
X-Google-Smtp-Source: APXvYqyC6GjfeEE6nKgfSsSWz1/SSC2ZJpbMalzrWcB1oLvQHLfxW6Z17TFDIAS/YBVFDc1UIIhZ2w==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr4978411wmc.185.1582054401703;
        Tue, 18 Feb 2020 11:33:21 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id k16sm7649266wru.0.2020.02.18.11.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2020 11:33:21 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     alexandre.belloni@bootlin.com, b-liu@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, ludovic.desroches@microchip.com,
        mathias.nyman@intel.com, nicolas.ferre@microchip.com,
        slemieux.tyco@gmail.com, stern@rowland.harvard.edu, vz@mleia.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 07/20] usb: gadget: fusb300_udc: remove useless cast for driver.name
Date:   Tue, 18 Feb 2020 19:32:50 +0000
Message-Id: <1582054383-35760-8-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
References: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_driver name is const char pointer, so it not useful to cast
udc_name (which is already const char).

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/usb/gadget/udc/fusb300_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/fusb300_udc.c b/drivers/usb/gadget/udc/fusb300_udc.c
index 00e3f66836a9..9af8b415f303 100644
--- a/drivers/usb/gadget/udc/fusb300_udc.c
+++ b/drivers/usb/gadget/udc/fusb300_udc.c
@@ -1507,7 +1507,7 @@ static int fusb300_probe(struct platform_device *pdev)
 static struct platform_driver fusb300_driver = {
 	.remove =	fusb300_remove,
 	.driver		= {
-		.name =	(char *) udc_name,
+		.name =	udc_name,
 	},
 };
 
-- 
2.24.1

