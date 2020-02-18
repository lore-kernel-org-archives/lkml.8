Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04815C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF63F24125
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WXbdgkRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgBRTd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:33:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39170 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgBRTdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:33:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so25380496wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kXwAGZwN4heqrm+yisZqSC1971kXzW7z7pJvBg5a/VA=;
        b=WXbdgkRzz5bJUy/h9WLUJEoNOZR/kJIuqcw8w2abFn6go/1ZB6+eLoDZIhb7ewUiWM
         437/g3AnYe/8BatYTAt1Npl6AlTSuHbHeV5fIky9gyMf45x3EKU/eO3ujlo3rIFRBjt3
         8RiafI6Khpn7vQWe39P71bMeZj0ZndEtYNEWgQnCswKehQpa7cBrhiA/sMm/VyLJAOh5
         aUzf36wvBk2vWJ6SQO6vQSqFu5d1P2k2GhCLLKhvQnbn7JPwOm5cyWWAU7PZca4plUzy
         7hnc8gmWXooxeFHIo5vduWgn2tHBbfg39iCWhn/F6BH1Ky9P4VFTVcnoAqZkT4v1SaEj
         hsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kXwAGZwN4heqrm+yisZqSC1971kXzW7z7pJvBg5a/VA=;
        b=fAHcKokK/NMiuvA/ARZ59scYm09mHQ47fltLMb0+KbsyuGcANsChdSnWgG3jI3QiFn
         iyTUnpqqdQLIgPYvSuJgSwwMnOelzK9MCzpiq2xw5u3OCmttRYTFMVnK+535vjUVV16t
         IEIhLpcXmHerzLuohu9Ytw3rtGNAW624d11DW7VBH1B6B1u0l8SQSs/WKtHEX7AUlUE6
         cEpizgHV3XMpTBX3L6uaUv/j4es26tq3HlkUyUsTXjLJfSmOPCm7WrRjR9UX3kxUBuOd
         PiIo++eiWHPE+gnvIq1rGylPZZORyhinZTlq/+4PNli5S3+eZmEu1/mzgcPAZ844iwtY
         xyfw==
X-Gm-Message-State: APjAAAVB9rdquWypCDqfq1gP8rLNjqs3p/wzP9KUJyNYrYbqBairEOTB
        y3wHont0DWSDIFtst9tzr8hC8w==
X-Google-Smtp-Source: APXvYqz9QEapK+rHVfxz1jZEt08EcWoid6BWixbA5raOfT1UtuZhp2XypMaSFN4hipm9DH7zI+zXkA==
X-Received: by 2002:a5d:4d04:: with SMTP id z4mr33060983wrt.157.1582054410617;
        Tue, 18 Feb 2020 11:33:30 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id k16sm7649266wru.0.2020.02.18.11.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2020 11:33:30 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     alexandre.belloni@bootlin.com, b-liu@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, ludovic.desroches@microchip.com,
        mathias.nyman@intel.com, nicolas.ferre@microchip.com,
        slemieux.tyco@gmail.com, stern@rowland.harvard.edu, vz@mleia.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 17/20] usb: host: sl811-hcd: remove useless cast for driver.name
Date:   Tue, 18 Feb 2020 19:33:00 +0000
Message-Id: <1582054383-35760-18-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
References: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_driver name is const char pointer, so it not useful to cast
hcd_name (which is already const char).

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/usb/host/sl811-hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index 72a34a1eb618..adaf4063690a 100644
--- a/drivers/usb/host/sl811-hcd.c
+++ b/drivers/usb/host/sl811-hcd.c
@@ -1792,7 +1792,7 @@ struct platform_driver sl811h_driver = {
 	.suspend =	sl811h_suspend,
 	.resume =	sl811h_resume,
 	.driver = {
-		.name =	(char *) hcd_name,
+		.name =	hcd_name,
 	},
 };
 EXPORT_SYMBOL(sl811h_driver);
-- 
2.24.1

