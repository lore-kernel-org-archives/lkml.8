Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6DDC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 04:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1C2206E9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 04:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVnhA2NE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgCOEM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 00:12:58 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38677 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgCOEM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 00:12:57 -0400
Received: by mail-pj1-f68.google.com with SMTP id m15so5784809pje.3;
        Sat, 14 Mar 2020 21:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ZVo5FaZNwZELfh1VyA/NYtKv4jB3J6tMqy+qzZfMkg=;
        b=nVnhA2NEI2n3kE+hDccvDAe54lL5OEEmJoYbzmpBtmSclCdLkwXqcVTaT914W+9f/i
         cLIU6A1TePY6AVQrImGjwqZrui3qew0G5HywaBCcriKxA9XreaRrWPybDoG2X0Enyzqt
         YJFybTAVrdXzZ2KLE7fD6lwg0zlT4OKIRNBD/T8Z82WQUvTqgOaj3gmFkpvCWoRPO2mE
         x8YeGYiVPTzTxJvSzeg8BJmQPpfCyjGDWAoMkONyeaHtrG7k0y/CMvmX+dCsGVAEOeMq
         WsZ4GMOFssiv1tCRX3UAavgF/+Co3V8o0yAgtDCjsXpQ6vM0VsQ5iEENipBnrsYxwgt0
         o+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ZVo5FaZNwZELfh1VyA/NYtKv4jB3J6tMqy+qzZfMkg=;
        b=Pm68E2ZzP5Ug7rqu2/WRzx+Bymrvvzm1jrh/FfBfHdD3dUbGPIhiD3F8zRqQEGSO/+
         Ik1aWa2stX3BU/cMahnnbbFHHeNu3Hp/TtfIsqLrseXkdgJMDpqlo+qE9ZPSRyyViKyI
         CcAIIb0b/XtgGEO3pdECk++Q4hZmp5ZrVo8wJOlvl+hYz+9CFCBkGEP+xiUy4f4Mils0
         Bbr601eCZcDsOXoBYZp2peh45MbjAtU7aDGfGrP5eimOdC0CZVS9wBTv8ErDM/N7tSpv
         1km53+W3nSPkE/RZUj2ufhOUSXDJH6gVr3sz6R8/p6l6BhO8puxb2ZKQojlYzKv0UYi/
         mhpg==
X-Gm-Message-State: ANhLgQ2Uecd+0HtnfZ0C896vG2rQMi/jSlr1UimXlAJp+Y5IxauQTy9V
        lMRB2gSc+KG54KVh6NJIp5adlzUO
X-Google-Smtp-Source: ADFU+vt+7EZpRr3OvR5XsOBvmt7UW8WcXEsqh2M7neVxm3k/Vj9VBulsoXLvHSBinQtdJv+jQgklSw==
X-Received: by 2002:a62:7696:: with SMTP id r144mr18006093pfc.177.1584163620366;
        Fri, 13 Mar 2020 22:27:00 -0700 (PDT)
Received: from localhost ([216.24.188.11])
        by smtp.gmail.com with ESMTPSA id j38sm54350554pgi.51.2020.03.13.22.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 22:26:59 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, hminas@synopsys.com,
        mathias.nyman@intel.com, bgolaszewski@baylibre.com, arnd@arndb.de,
        geert@linux-m68k.org, mchehab+samsung@kernel.org,
        treding@nvidia.com, tglx@linutronix.de, suzuki.poulose@arm.com,
        hdegoede@redhat.com, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v2 2/4] usb: host: xhci-plat: convert to devm_platform_ioremap_and_get_resource
Date:   Sat, 14 Mar 2020 13:26:36 +0800
Message-Id: <20200314052638.6008-3-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200314052638.6008-1-zhengdejin5@gmail.com>
References: <20200314052638.6008-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_and_get_resource() to simplify code, which
contains platform_get_resource() and devm_ioremap_resource(), it also
get the resource for use by the following code.

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 drivers/usb/host/xhci-plat.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index d90cd5ec09cf..2852afa69ee9 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -219,8 +219,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
 		goto disable_runtime;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
+	hcd->regs = devm_platform_ioremap_and_get_resource(pdev, 0, &res);
 	if (IS_ERR(hcd->regs)) {
 		ret = PTR_ERR(hcd->regs);
 		goto put_hcd;
-- 
2.25.0

