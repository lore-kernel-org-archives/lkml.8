Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC74C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C8D24125
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rXidaeWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgBRTdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:33:42 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39757 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgBRTde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:33:34 -0500
Received: by mail-wm1-f68.google.com with SMTP id c84so4203273wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N/BxOSBMeZaNye1MoygZyS5wTUoMQ90aTMHecPnsJPU=;
        b=rXidaeWUp55RRA4kDzm4Zjydnfv3HOiUvFDIADeJPNx920JX7ff7VJvMbBJ8TLcZAS
         P70P6YhgdR182/a/jxnxOJ7b+PN7+Ca34GK1v080CSCqVvNFeD0AUXcReChn+VRY/7gt
         Kvp3BbyB3mBpywJLrhwHcajvmvC2J1okk8E6i4NpjP/e2gK/kjrobHkPlnDyVf/w+Ndv
         +QfqJVGt8S8dA1nMPd4jgBjxCudtplIKiWxXtoYvZU5MFJ0KNm6A23Wmc83NxvTCvKKx
         1KB1Elinhg9txI2vUhlprBn65djxajzW63KKnnOFNUR0q6QDayPTKEGLl4MOzjhCqmfb
         8gMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N/BxOSBMeZaNye1MoygZyS5wTUoMQ90aTMHecPnsJPU=;
        b=ntOO48VrPtjwAD0B7XIad1WlQvf3HXpwCMlRZQzlVT+Ad42/Ow1EkO/hUuCefQt464
         xh2e2AU9Nj8WCl4H3phhXpNp53qF7EucO+7aSg59C6f0K5u5TB/XHiesaqYUcD/s8FVs
         atI6YpfIDmC1uCC/dFiFAxwsTzoW90Q6ymjywEP4ftl4NzZ+V0G2Aruf4Z5/xPsAvYa6
         SKWq+pyhiKdXzHTMYshDYtKiVBb1JAWqY8E2i/Px+RebIZa3Aqh7cnGRZ2DzQrLeEtuE
         uLPh3rs50Mr8zIOazyLU03xKVf46C6oqCYxVdZcL4KCasBWDRKtS2laSqJ41u4fb6Wow
         FI6A==
X-Gm-Message-State: APjAAAV6zMltNgQO2Bt5iDNckPY2VSslda7p4F+QDr3vMPbqWiMzL2vK
        CWW1IfOkKZt7R7iuzFvGQMow/A==
X-Google-Smtp-Source: APXvYqx2OzakvxU5+FL/ru47MRsIqww5QrDu9aHWIw0Oi3Ym29k9T249gOsfNdREzGBgqi5TKxRGww==
X-Received: by 2002:a1c:541b:: with SMTP id i27mr5046830wmb.137.1582054412748;
        Tue, 18 Feb 2020 11:33:32 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id k16sm7649266wru.0.2020.02.18.11.33.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2020 11:33:32 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     alexandre.belloni@bootlin.com, b-liu@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, ludovic.desroches@microchip.com,
        mathias.nyman@intel.com, nicolas.ferre@microchip.com,
        slemieux.tyco@gmail.com, stern@rowland.harvard.edu, vz@mleia.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 19/20] usb: host: xhci-pci: remove useless cast for driver.name
Date:   Tue, 18 Feb 2020 19:33:02 +0000
Message-Id: <1582054383-35760-20-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
References: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_driver name is const char pointer, so it not useful to cast
hcd_name (which is already const char).

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/usb/host/xhci-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 5e9b537df631..0715a2e75413 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -549,7 +549,7 @@ MODULE_DEVICE_TABLE(pci, pci_ids);
 
 /* pci driver glue; this is a "new style" PCI driver module */
 static struct pci_driver xhci_pci_driver = {
-	.name =		(char *) hcd_name,
+	.name =		hcd_name,
 	.id_table =	pci_ids,
 
 	.probe =	xhci_pci_probe,
-- 
2.24.1

