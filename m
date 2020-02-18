Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A740C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64E124125
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uRA4WO9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgBRTd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:33:28 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33509 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBRTdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:33:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id u6so25467964wrt.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a7GEUna4G5RbXgq36EEYG2D0rjG6W8XH0Dtowe6As9s=;
        b=uRA4WO9lmxzJnN8WEkKi9RYhzj9YdW4cC5DYKICsVnNVacaQ9MyMZEa4pfRD5PaLh7
         t4uQnDrN90AItIWNienqvMAEsi0QfgYojLqhX8Cslw43H772RfSWRJ2e2IUOeKoSUiiM
         OtNwNmQ1yt9Qi3fO3AzxzoO083OuTRvtSFYnV89VAeUEPm2yiBEL90t0H5mp8tvDunq9
         czQIqOIzmzh6a/+kyiMFY5A35uqoNv37t0TJjaC68C90dxdGaUNw4yEfDRJKsMpvQZ2q
         L7qW/evqTpfiokn5ukUW+9GLzuBhFPFF4K42xCrxbVB04kMD1D3VguZdnT74SrPzX5Ie
         LULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a7GEUna4G5RbXgq36EEYG2D0rjG6W8XH0Dtowe6As9s=;
        b=EeBGofobGku2chHq3bKNkvmv80j1p8ScGV2+dq5VbLusJLSd+dSBIBlSz9BRxaJWlb
         hXb09qymMzEzyVSo1B7XWoTA5HoKAwXeCZ0So+Yhwz6Q0uy/kkUP7J9eLuWzqhfu+ejk
         9mTgnlu81yMxGzQFv9jWufxQGXP04sZtLm4yoP9LquuSB4r2n8nvv2UEZxCIYPDn5wIU
         asL22fsCwtsho/55e7Cm5f4pkVyvZkC1xicyU+qbmRNxC/aGn4VRyisPxD//4eOGWZ61
         1b0CMkeUWA1kq8hSJ6XvyDBXdDGcgKZ04MUcVg8Q7wRyegNqRkZT02ib72jrIVy2mVrp
         MDWQ==
X-Gm-Message-State: APjAAAVNHGy2tagfo6Y7BRbkhK923CzOFDSaB6vMcrqFnbnX3R/Tcgih
        y4Piy8cAzv94RDmP/lOGd25wKA==
X-Google-Smtp-Source: APXvYqxjXR4su4Hv72/U7GmAiRCFdmARwCRra/TybDUrWP+GSOq0Tnw/N56bhpE0fdQ/pQE08M6Y+Q==
X-Received: by 2002:adf:f986:: with SMTP id f6mr31872129wrr.182.1582054403557;
        Tue, 18 Feb 2020 11:33:23 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id k16sm7649266wru.0.2020.02.18.11.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2020 11:33:23 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     alexandre.belloni@bootlin.com, b-liu@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, ludovic.desroches@microchip.com,
        mathias.nyman@intel.com, nicolas.ferre@microchip.com,
        slemieux.tyco@gmail.com, stern@rowland.harvard.edu, vz@mleia.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 09/20] usb: gadget: lpc32xx_udc: remove useless cast for driver.name
Date:   Tue, 18 Feb 2020 19:32:52 +0000
Message-Id: <1582054383-35760-10-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
References: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_driver name is const char pointer, so it not useful to cast
driver_name (which is already const char).

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/usb/gadget/udc/lpc32xx_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index d14b2bb3f67c..cb997b82c008 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -3267,7 +3267,7 @@ static struct platform_driver lpc32xx_udc_driver = {
 	.suspend	= lpc32xx_udc_suspend,
 	.resume		= lpc32xx_udc_resume,
 	.driver		= {
-		.name	= (char *) driver_name,
+		.name	= driver_name,
 		.of_match_table = of_match_ptr(lpc32xx_udc_of_match),
 	},
 };
-- 
2.24.1

