Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3690EC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD1221D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OvB7Kyfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgBRTdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:33:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44047 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRTdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:33:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id m16so25357919wrx.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9nGneN4FF9FG4UqBBakQfwNSGfoHUIS33OCajZHkIHc=;
        b=OvB7KyfyEVZHQJfu/Zd/LprOMDUmwxj14FNKr6Qv5XAFcb22USOTj1kGcVyzSm2RXH
         GOHieY/yIwsFCWpLr7XeqeJFhQ2DHcc5hfwydTprXHOaUcga3Qr6pHSjYIrf/Q6XSqNs
         StC1ITm1/WWYjQjMd/IQgYHp8BYmvOMfPS8J4ma59IkWd4rpCEd0Uqlh8eApv6pRHK6L
         Am+CSNySXgEsH1c6DqlpNBEoavoJxGyRh4mZ2ettOdwynUmBA/cwJRYpCMtcG7mCrbWt
         I+x9br1lCHlQvuXWsY3Jxq1xXA6B97Pj2unGQN7+kNssu99Qej/NoUcH2bdCd8hY0V8+
         tEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9nGneN4FF9FG4UqBBakQfwNSGfoHUIS33OCajZHkIHc=;
        b=FwHgwCA/OJJ1KaaF3dvySe0w7pxhg3ITi8TNw7tF+uqbzFSz13kYKf59boKBfqQus1
         1Fg8vtcLoytHeoy9y9oQZ8yKLh3t9iKlKNUrb28gKhtNEwhrNMIGruiooxbQtC6Fqmlo
         rEesyt50b9NQU2BZnR9l9n4IFxIKJ6nuxfWPiPZInd/Yk8Wzmk4sUEbtZK2KYAu+CEue
         KbOjZvz0AC1ad4KTfXoT6eJq+MJCns0ZYY5sNOlPGAzGUyaTCpWFZJH0a09z6iLkytxi
         BQ4rTqmJXC/K66t2KUgcCFd+ewigegDP6ePzww5nvQgN89D/6OyB4IPWDQjcPEyWdo9j
         /G/w==
X-Gm-Message-State: APjAAAV9M9fMX7TqYg04QD5ZLjJZ2wj6zo4gUERSP0ObBUDvn1CxXI75
        PgqE9uPNnAA0iCTakeuk0X/ssA==
X-Google-Smtp-Source: APXvYqw3rW1kRcZH/PRtRWgPRBFpvvRAhqVbY4TEosssX4QTBJn9TlTcWsGkj8OA5iYx8iCEg6BUZg==
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr32891365wrx.153.1582054395840;
        Tue, 18 Feb 2020 11:33:15 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id k16sm7649266wru.0.2020.02.18.11.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2020 11:33:15 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     alexandre.belloni@bootlin.com, b-liu@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, ludovic.desroches@microchip.com,
        mathias.nyman@intel.com, nicolas.ferre@microchip.com,
        slemieux.tyco@gmail.com, stern@rowland.harvard.edu, vz@mleia.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 01/20] usb: gadget: legacy: gmidi: remove useless cast for driver.name
Date:   Tue, 18 Feb 2020 19:32:44 +0000
Message-Id: <1582054383-35760-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
References: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_composite_driver name is const char pointer, so it not useful to cast
longname (which is already const char).

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/usb/gadget/legacy/gmidi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/gmidi.c b/drivers/usb/gadget/legacy/gmidi.c
index 9eea2d18f2bf..265c392810d7 100644
--- a/drivers/usb/gadget/legacy/gmidi.c
+++ b/drivers/usb/gadget/legacy/gmidi.c
@@ -174,7 +174,7 @@ static int midi_bind(struct usb_composite_dev *cdev)
 }
 
 static struct usb_composite_driver midi_driver = {
-	.name		= (char *) longname,
+	.name		= longname,
 	.dev		= &device_desc,
 	.strings	= dev_strings,
 	.max_speed	= USB_SPEED_HIGH,
-- 
2.24.1

