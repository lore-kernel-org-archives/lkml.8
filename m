Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484FFC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F58024125
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QWteRJ8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgBRTdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:33:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39165 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgBRTda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:33:30 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so25380377wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CICLGgehzIV39n0G5fNiUeOx0sShsCKvoh9C5iQTUS4=;
        b=QWteRJ8APs9AACJxJ9Isru24pG8gclsXlxMe6kSQOClBCpMl9ynpbto9oH6gayxX6Y
         LN8mY8/VqcBoPo+fXhK6Aqa5x7fmd5OU4M/ORWMM3qRj3G2vDIbIfrG5EdtHR1W5QQDN
         /1whNGpeWcaOTd0MTWYvaHXbvyeh/Eo3LW6tCgWil9L1mgTI/HYVtZEpoXzTm7o5w+GP
         QSrGXuQncB7Ov6s8JyeFsw0POrCwUA3tKyacioNHh9aHZlDSngcTLzejZr0fwEZKoPOT
         eCDkzPLTMnWddU0Utce26hh7WZ9jSv2IETBN8OcT8yCENZKT05/QWXLBaGVrge8suKLi
         xDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CICLGgehzIV39n0G5fNiUeOx0sShsCKvoh9C5iQTUS4=;
        b=V0UvTZFkYLqaeNYEU5UnikMY0MzgLbZ3Fw5HGMw4V3qrxpp3EXMPtFSa1+EPLXRLoL
         NsDcAfG6L1u6OjmfrZYMP12y/hIir0KrQgkX6fYJkutvy1qBKKcOg9hiQNjsEklmoerS
         dnK6lYkKYhPAylYL8Y7Ckz+X4nGSKv+zFpBGiU+m/PXTnane1W43T/b9s5jel0f8WtSI
         C+baSs63yAWIVGKQGG7z+R6IZ1WqytygytnwrOR6tt4MWungdN3FCybPYUqdSdmXRRWK
         EFutx0XpJwDkr5wVchcjjNFTvuu38kq9kWaKva0Leh5mA6qlkAunDTUr2Kyz6icD+ZBp
         1YUg==
X-Gm-Message-State: APjAAAVBgfPQPB2y6o75quga1xmF5bsuTbVUQ6k5+0NDTFwrHmMyW/kz
        UsuPwCEFk2TjOX34L1w22z+V2A==
X-Google-Smtp-Source: APXvYqxEf0O101KsjGID0PiOn4lRSqAvS4WrZb4wtaWI12XLgPEfj4VBO+GEZ/T462WCcJF+1Y7oiA==
X-Received: by 2002:adf:fa87:: with SMTP id h7mr32216339wrr.172.1582054408009;
        Tue, 18 Feb 2020 11:33:28 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id k16sm7649266wru.0.2020.02.18.11.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2020 11:33:27 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     alexandre.belloni@bootlin.com, b-liu@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, ludovic.desroches@microchip.com,
        mathias.nyman@intel.com, nicolas.ferre@microchip.com,
        slemieux.tyco@gmail.com, stern@rowland.harvard.edu, vz@mleia.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 14/20] usb: gadget: renesas_usb3: remove useless cast for driver.name
Date:   Tue, 18 Feb 2020 19:32:57 +0000
Message-Id: <1582054383-35760-15-git-send-email-clabbe@baylibre.com>
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
 drivers/usb/gadget/udc/renesas_usb3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index c5c3c14df67a..42ae99ad9b25 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2906,7 +2906,7 @@ static struct platform_driver renesas_usb3_driver = {
 	.probe		= renesas_usb3_probe,
 	.remove		= renesas_usb3_remove,
 	.driver		= {
-		.name =	(char *)udc_name,
+		.name =	udc_name,
 		.pm		= &renesas_usb3_pm_ops,
 		.of_match_table = of_match_ptr(usb3_of_match),
 	},
-- 
2.24.1

