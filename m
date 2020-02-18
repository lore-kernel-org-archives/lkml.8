Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD543C3404B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CAD24125
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uU2854W9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgBRTd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:33:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39147 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgBRTdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:33:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so25379967wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AOWCbHndeZPS5+byfbryCBkvxECGgsEdFqsZA/3IxRs=;
        b=uU2854W9t9Wy+R1PcnzelLtDSm00kguTfVv2dKnIl6fYk87418YBQyB44AvSD0Tv43
         7OJUIUpcXGYeEe6TRdeliUT0QK7jxD5wCt9BdXKfdHXqHtoKSO1T4C1Bi3r0BiGiwfSs
         BiPe35HKcbG5BK0ytQY4yWO/u7N7uU7AvsF9bmUFFooaBGFBrXRgQcUylWVA+G+Lkdp6
         fL3E05K9ryRVMePNm3y7zIaC/mtl99vU92cthki3SsP7I0GOcwUAV73zIT3pxQmuVZkM
         91rP90GL8c20fRjpWCesgQjtUzZS1Z0EFkphxUuKw7mrrAjeiI/JrkjRQyHLPOX17RSS
         2fEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AOWCbHndeZPS5+byfbryCBkvxECGgsEdFqsZA/3IxRs=;
        b=DltvuR0ssT2jIHIA9A25U5zUL7owIZMO/K5bfVSu1dgilCgHPMZd1Nf/UfpL1Oxky3
         LQRGLWXzpu8k6Wo3vWJg12mXsUwsZt5EriCESby+u72HF+HVAPhRLSKO59IKxeXsiJYU
         uJFZ/9y90iCgOKcpaDjH+GBwMAVBHIkF6aTfQdXlT0daXEb6FVCRHd3xwORuRpjznvhd
         6uXvqd7M7ipA0CUVCufe9itlH6c8n4KnvzHyyr/4XCB+InEyL2VD9kKKIwfos8s49RhF
         7DrguWDxgDunLfrnIq2yn+/KnfzO+HOA21msnO0Jyv8zNwHT4z4J4edcBmThVpQRasrm
         AX0A==
X-Gm-Message-State: APjAAAUZAMMEOyBMooKxZHZ6t6nqJPUX6JAXEP2qUtqGYeqqdsfOK+HQ
        UvSNGaRrWlhyoX3vPPieY66Gzg==
X-Google-Smtp-Source: APXvYqxWwSnTlhW6CSi27BoAt02KsGM3sb4bgJm52rNZkiHzGKPso/pT/s28vLFiQQJ+HdZLVSIYhA==
X-Received: by 2002:adf:d0c1:: with SMTP id z1mr32598309wrh.371.1582054400814;
        Tue, 18 Feb 2020 11:33:20 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id k16sm7649266wru.0.2020.02.18.11.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2020 11:33:20 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     alexandre.belloni@bootlin.com, b-liu@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, ludovic.desroches@microchip.com,
        mathias.nyman@intel.com, nicolas.ferre@microchip.com,
        slemieux.tyco@gmail.com, stern@rowland.harvard.edu, vz@mleia.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 06/20] usb: gadget: fotg210-udc: remove useless cast for driver.name
Date:   Tue, 18 Feb 2020 19:32:49 +0000
Message-Id: <1582054383-35760-7-git-send-email-clabbe@baylibre.com>
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
 drivers/usb/gadget/udc/fotg210-udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/fotg210-udc.c b/drivers/usb/gadget/udc/fotg210-udc.c
index 21f3e6c4e4d6..d6ca50f01985 100644
--- a/drivers/usb/gadget/udc/fotg210-udc.c
+++ b/drivers/usb/gadget/udc/fotg210-udc.c
@@ -1199,7 +1199,7 @@ static int fotg210_udc_probe(struct platform_device *pdev)
 
 static struct platform_driver fotg210_driver = {
 	.driver		= {
-		.name =	(char *)udc_name,
+		.name =	udc_name,
 	},
 	.probe		= fotg210_udc_probe,
 	.remove		= fotg210_udc_remove,
-- 
2.24.1

