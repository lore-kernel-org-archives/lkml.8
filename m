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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A04C0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57E720637
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VN6pTaax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgCOCQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:16:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39696 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgCOCQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:16:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id b22so1439292pgb.6;
        Sat, 14 Mar 2020 19:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gYq5XOfqQjLgXmjjatxoqh+sT7kdm5qTJhz0juqtyOs=;
        b=VN6pTaaxim91WzS/m9eDEsE6VQC2UU0D9iLbneT/JDpuoQGnJF9nuFHR9upM/nwZ1k
         CDjjpbjoDm/OuqqpylCCU0aM74hHrjVnm2OV3yUtN6umKIhi+yr/W5gUeSTB7v3GIEL+
         FOpOi9ctfep9BVZLr221j94do5MRGWqGMgRsXj0ovEsyCJGM61IPJK71fv1AiAc5fi8r
         C68euv+YIAoSASc6MasPC37MJPlWin2iKlIXh60Cb1LerjpDoTt6Z28SA6mw3+KnMoaO
         Csf1lry1N+Nj/6OIh+Sfj0U+v0oMZGh6+gEhoMysnWSx1zgw3PKXsK0F5igosAE8TUat
         0jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gYq5XOfqQjLgXmjjatxoqh+sT7kdm5qTJhz0juqtyOs=;
        b=ZW6wMFvRJ/Mu/E2a+KsirFtIN3QKHd9rRuMsZGGyJ1cfCM/Dg3WITboxUEW1aS9vQT
         GMBaNtYGA3gR0On0HmOnBpgaPovuBhOKHpeKrXZ1G8e/i6EoOQoC/Qz93qp6BNUtrpdT
         xaQd3XZTonxlIh1Rsn8B29HovRCZywLdEWOpK0FcvaL1fd6mt4ycwF29gfc8WfZ+huRl
         2kX2lZkR0QsmYd7H+dbPRXDWMykr8vTXlJadJO2JuacpbF/8803TEy8cr0gQhzhsgCrh
         ur5R3MMKmCmahJw1SFG7ehn55ebzLnaDgGm0fDZ4Q7he1W0OcgNyzao1ww+rsV8SpAuG
         Qy6A==
X-Gm-Message-State: ANhLgQ3C6drXDua0t5phfR0cjyMlLaC4Paun76Ce9LCFCLc0YgtlV6cs
        zYG4c65z/hTQcWJgXL1lLA2xbU9Q
X-Google-Smtp-Source: ADFU+vtZwujMqGMWtPI+Td3zqf/d5OQwWoJbIi4pdRHew+9QThjOgENoIl6Mck41/v+RcXWXhEjagw==
X-Received: by 2002:a63:9143:: with SMTP id l64mr15889990pge.75.1584163624286;
        Fri, 13 Mar 2020 22:27:04 -0700 (PDT)
Received: from localhost ([216.24.188.11])
        by smtp.gmail.com with ESMTPSA id k3sm2500525pgr.40.2020.03.13.22.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 22:27:03 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, hminas@synopsys.com,
        mathias.nyman@intel.com, bgolaszewski@baylibre.com, arnd@arndb.de,
        geert@linux-m68k.org, mchehab+samsung@kernel.org,
        treding@nvidia.com, tglx@linutronix.de, suzuki.poulose@arm.com,
        hdegoede@redhat.com, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v2 3/4] usb: host: hisilicon: convert to devm_platform_ioremap_and_get_resource
Date:   Sat, 14 Mar 2020 13:26:37 +0800
Message-Id: <20200314052638.6008-4-zhengdejin5@gmail.com>
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
 drivers/usb/host/xhci-histb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-histb.c b/drivers/usb/host/xhci-histb.c
index 3c4abb5a1c3f..a314139e5343 100644
--- a/drivers/usb/host/xhci-histb.c
+++ b/drivers/usb/host/xhci-histb.c
@@ -219,8 +219,7 @@ static int xhci_histb_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	histb->ctrl = devm_ioremap_resource(&pdev->dev, res);
+	histb->ctrl = devm_platform_ioremap_and_get_resource(pdev, 0, &res);
 	if (IS_ERR(histb->ctrl))
 		return PTR_ERR(histb->ctrl);
 
-- 
2.25.0

