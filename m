Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A20CC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2049524654
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FByhnh4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgBRTeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:34:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40311 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgBRTdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:33:23 -0500
Received: by mail-wm1-f68.google.com with SMTP id t14so4203495wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pjF+muLIhia2iJlkAiVEwAXGwvsTo93e9rZBfV8mBcQ=;
        b=FByhnh4aHbUwNUbrLIvCa7S87+yL9GFB5EFtUZDmg6Yh7/YSremqljAk7DlVVNbB0j
         eDHgyZHU38hH1nj2jmooaixF0wMPPMgmkycHURgyd39qmHHKGjmoJAti7onWk2ytn9yC
         j5dpQvtW24HH3oxtLgnIYTgtbSMoAV1CEhfbC6L+1tPFy13Rq/ZYJIyyZwRAgBcEp/8m
         7oEjGi9PRYVjY3hbz+Fc3JBC/GkA0STUH5NPL/BUbp71f3YJZrd5HuH3XHcDJzZJDmXg
         gqYFqmNij+sNWdWaHXPPLM2Ma6Md6xvqmQITG62MPIwEXmZd5KPSsNMOvV49b2b0unOF
         FNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pjF+muLIhia2iJlkAiVEwAXGwvsTo93e9rZBfV8mBcQ=;
        b=bWZb5oBfXbhpTPok3rbX0CoogfjJ0ApD6T1xYWSKGzb3DgA6vZtyzEy67AATaLUUc4
         xNTO6nFeM2Wz9vM0GYpMRE2HJAEfjd/S4Xire8k1C9NH+lDBnJoV2Yy/AzEFEH08JaQF
         6Y8P6xzjsyYzjKX6b+MWj6a7bzEJXQSW3pPI0ZInoRK/AMQRCHq4PwfJuoCSMCKwxxHT
         +prWIHz3qAIdKAAiIDakVeMao6STZM4HuFquh8dxZT32iycsfmnVPEAkpofGQy6WoHyv
         l8Mqvo8I0Y4V1tcAh6v53wghWfqoMI8+0Nw4NoEhcncY8fmJRpj1B/KkkLKQxZQ5Ztvv
         quyg==
X-Gm-Message-State: APjAAAXMnt1/30JSCBKBBpazvKzgNIwDDo72PQ6o8T+hRk/nmG6XCj65
        oMQVsA++uwu3WioUXO6uZrCXQQ==
X-Google-Smtp-Source: APXvYqxoVM6rVVdhsfUOYDPvd6s6raX8l1EuWNKZpuyCFsDx7HpiuPGc56k+1Q/N8uLfxpoiCj/6/Q==
X-Received: by 2002:a7b:c778:: with SMTP id x24mr4959002wmk.59.1582054402666;
        Tue, 18 Feb 2020 11:33:22 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id k16sm7649266wru.0.2020.02.18.11.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2020 11:33:22 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     alexandre.belloni@bootlin.com, b-liu@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, ludovic.desroches@microchip.com,
        mathias.nyman@intel.com, nicolas.ferre@microchip.com,
        slemieux.tyco@gmail.com, stern@rowland.harvard.edu, vz@mleia.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 08/20] usb: gadget: goku_udc: remove useless cast for driver.name
Date:   Tue, 18 Feb 2020 19:32:51 +0000
Message-Id: <1582054383-35760-9-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
References: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_driver name is const char pointer, so it not useful to cast
driver_name (which is already const char).

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/usb/gadget/udc/goku_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/goku_udc.c b/drivers/usb/gadget/udc/goku_udc.c
index 4a46f661d0e4..91dcb1995c27 100644
--- a/drivers/usb/gadget/udc/goku_udc.c
+++ b/drivers/usb/gadget/udc/goku_udc.c
@@ -1844,7 +1844,7 @@ static const struct pci_device_id pci_ids[] = { {
 MODULE_DEVICE_TABLE (pci, pci_ids);
 
 static struct pci_driver goku_pci_driver = {
-	.name =		(char *) driver_name,
+	.name =		driver_name,
 	.id_table =	pci_ids,
 
 	.probe =	goku_probe,
-- 
2.24.1

