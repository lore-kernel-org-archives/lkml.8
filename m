Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704BDC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F792464E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xPlX00Mb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgBRTef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:34:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34461 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgBRTdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:33:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id n10so23454185wrm.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MHonpuv7CKuPglJHIaWmpMCNHqnlw8BincncIn85484=;
        b=xPlX00MbtZPFdDI8x/pR7q0l1TZpqo2MP/MlI6syrVxWnNMq3POocxJWNitt2FlfxK
         ca40BfKAOFXHzRriPeTtPNg+bNr5ei/h3F2xMcHQwCEDcOb5WPV5mCq8naeI6ImybtU/
         bnVwuMQjNelohtlU4ihbZGDKOX6knBA76tIlFkcrBCXLkHOlGCLftfdvMEAZQ/Ba4aSD
         EqRICW1GkyQoFz0XWgtwU0MVv/use0zPoxumU8KbBonqUWBy7wfeVjZcjs+RqGiKuUVt
         p5gck6BIpA9G/WG4ZGueIPji09RD6jn5tBIZWSMjJsWk311ldnufMQtfArBWaKdpSykE
         pwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MHonpuv7CKuPglJHIaWmpMCNHqnlw8BincncIn85484=;
        b=tCFSJ3RcESxV3TEZ7FfUE86jd3nZotLCDm/Qg0Tc41AdwjLJs5HZqPQGKk53gIapFP
         3w5MA5y3pQ2mSPwaxrwfSOBHorm/nUcg+fnMEkDOiiouWhlFDYGpaUfsxxMhllMC/L1O
         LBI/k7G4rVQwxAhkY8x4C1lhBBiOJW28iaD1/1Cr5NcxIaJXvDX47nx7IHBQbj3LLiTe
         IgQEhqk4Ulop8812I5gTemKqyAle3f87+h9VIEhwRl/FB8L42IDIkOIibVBe1GQlCEFS
         OEN5GYkViOdfNOwSCgs0n/iwsoE1qW9v3wDh2LaCIyUDoBOKh4lz0Ld0sOyaKOo2X/wp
         SJEg==
X-Gm-Message-State: APjAAAUgf0d9QUp9LDdYz67ODTUjaS36HBNdwqiL9dJjgfOCb2bre/jH
        IZbeY4STq5lCECQ8KUfq1oQIfA==
X-Google-Smtp-Source: APXvYqwDYnjVJED0t0uAAknTEyT+FlngUXNJYoICixbTq4qdRKzsb0cy22FB6lKxXU3H3aF+0ybUNw==
X-Received: by 2002:adf:fa87:: with SMTP id h7mr32215756wrr.172.1582054399956;
        Tue, 18 Feb 2020 11:33:19 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id k16sm7649266wru.0.2020.02.18.11.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2020 11:33:19 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     alexandre.belloni@bootlin.com, b-liu@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, ludovic.desroches@microchip.com,
        mathias.nyman@intel.com, nicolas.ferre@microchip.com,
        slemieux.tyco@gmail.com, stern@rowland.harvard.edu, vz@mleia.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 05/20] usb: gadget: dummy_hcd: remove useless cast for driver.name
Date:   Tue, 18 Feb 2020 19:32:48 +0000
Message-Id: <1582054383-35760-6-git-send-email-clabbe@baylibre.com>
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
 drivers/usb/gadget/udc/dummy_hcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 4c9d1e49d5ed..6e3e3ebf715f 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -1134,7 +1134,7 @@ static struct platform_driver dummy_udc_driver = {
 	.suspend	= dummy_udc_suspend,
 	.resume		= dummy_udc_resume,
 	.driver		= {
-		.name	= (char *) gadget_name,
+		.name	= gadget_name,
 	},
 };
 
@@ -2720,7 +2720,7 @@ static struct platform_driver dummy_hcd_driver = {
 	.suspend	= dummy_hcd_suspend,
 	.resume		= dummy_hcd_resume,
 	.driver		= {
-		.name	= (char *) driver_name,
+		.name	= driver_name,
 	},
 };
 
-- 
2.24.1

