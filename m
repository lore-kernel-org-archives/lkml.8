Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC4AC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1773E24125
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xB0Z0aPP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgBRTeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:34:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41721 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgBRTdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:33:25 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so25420934wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VMhMCON8OuPufsG3ipSiCKDEgdVOYQVgnIzCUNgOnkY=;
        b=xB0Z0aPPPvTY5q59s/RiIVELERzjH2U8BFSMfOWfBxU2w29Zfc9KMc+U4jFuEPyX7a
         uJ/OxOvBnsGCSNGOJ9l5BqsfOc8Oj/HkX1E7JK95tLefzhDZYcFbWpgM+GTIYQaS0q+M
         6YAbCjlcGgapYWOvCKTdsoJaM0ekXgBQCiNgCLo9oFbtNOY4Dsj1VuZ0AHGF27Cn833s
         63gK3tlkEQbl61aBlFDS6LJAMCPYSQK+cU3iOdRmeuPsv5VXxNl9X/HL4nV1KMW4e2Kc
         wydsLep3EGtzxBHuZxoMEMPZ/DC7SefkXC4Mgh1lYfJgXyfXI2onhupUqgL/x2xFBL50
         NATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VMhMCON8OuPufsG3ipSiCKDEgdVOYQVgnIzCUNgOnkY=;
        b=BEyHc6ntwDC/jZSGxLQALFFC43AaHIW5r2WrA8vKkBe06TUBRfsd5rcM272Wj62rf6
         oVg1zBbIv52K68ZUHM6c0o4p5k3A9VxkQlZQoRGSfo5+Pg/h6iRltJzRyz3fZon5SQ8C
         t8gcKTXLRUmAQYFUPws56WxqJtoA5D0TEw/Okm7syQh8cMBW+B4XXfSdDznIqv/xISxF
         qtFgteRqdgTkgVdVuIT00MyDZIpnyAyOkrf1j3jCKFwClloFHIsZo/gehhOrHnWmFe92
         RtBCkdG3XD/fBhB608DCllz+hYRV7TJt3c60puDXSofeSLlfKW6th0F+5lj1jmEtTsdh
         BVeQ==
X-Gm-Message-State: APjAAAXO03PbcmQC2i19cnC145FLAJS7MR4uEhtYj+NzNS9Vxw0YjnGR
        NN+761B1N4NBDAo/pvd8A0ubhw==
X-Google-Smtp-Source: APXvYqzckUIyriHGnsYfrHwscI3IStYXXWUqfYiWyMM7Rh4jYCpfpR1iboxY9wA3gVwPxIiNgFDTCA==
X-Received: by 2002:adf:dfc8:: with SMTP id q8mr30710027wrn.135.1582054404454;
        Tue, 18 Feb 2020 11:33:24 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id k16sm7649266wru.0.2020.02.18.11.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2020 11:33:23 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     alexandre.belloni@bootlin.com, b-liu@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, ludovic.desroches@microchip.com,
        mathias.nyman@intel.com, nicolas.ferre@microchip.com,
        slemieux.tyco@gmail.com, stern@rowland.harvard.edu, vz@mleia.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 10/20] usb: gadget: m66592-udc: remove useless cast for driver.name
Date:   Tue, 18 Feb 2020 19:32:53 +0000
Message-Id: <1582054383-35760-11-git-send-email-clabbe@baylibre.com>
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
 drivers/usb/gadget/udc/m66592-udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/m66592-udc.c b/drivers/usb/gadget/udc/m66592-udc.c
index a8288df6aadf..75d16a8902e6 100644
--- a/drivers/usb/gadget/udc/m66592-udc.c
+++ b/drivers/usb/gadget/udc/m66592-udc.c
@@ -1691,7 +1691,7 @@ static int m66592_probe(struct platform_device *pdev)
 static struct platform_driver m66592_driver = {
 	.remove =	m66592_remove,
 	.driver		= {
-		.name =	(char *) udc_name,
+		.name =	udc_name,
 	},
 };
 
-- 
2.24.1

