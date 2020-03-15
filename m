Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC57C2BB1D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 14:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24DCA2072A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 14:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uAiNLQk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgCOOFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 10:05:46 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53238 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbgCOOFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 10:05:45 -0400
Received: by mail-pj1-f67.google.com with SMTP id f15so6649276pjq.2;
        Sun, 15 Mar 2020 07:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L7C3dEEW8EbelrBoqrqx1YkqURfNqpCDdR2obkOBI9o=;
        b=uAiNLQk7xxCNt++G1LyX+ZQEY7EzqZy2gQ5BS5w//5tvRc/9Ic9x6N84ZKnBvGEM64
         DapNRoIdtNMHukSvfDK+U0Yos+JKkmlrO4/l5yd4oz6NWBcN4QKHr8CMLqAX1xLfnkXc
         HvAe3S2cVYAKsuyTlnsst676NbepBczXGQeTJcanMWRbdPHe6YcNK/9LLXWSqyhr4XTl
         MlVkUKswsAaKE5rA2OT+FmOhZXz78RpjT3uj0nRVUOu8WOTHi2z++7NIrC+Mfhlkq6CW
         SjuerrIKL3E6GHTMqj4IHZQ4lIEFy454QZd2TlDFen37CUsopzpz9QeikZUzCTvWUYUo
         Z1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L7C3dEEW8EbelrBoqrqx1YkqURfNqpCDdR2obkOBI9o=;
        b=Qe917JqAkwa12TN6qLxsVNrM+d7xgmNiadrFdcK8M7yo8i4+N8rD924cZM34BrUwYP
         CwiXuGUwOq+QlBKAemZxYyQc4q9TBSNeu7e33bq8bYJq3OdD5Oy4WkVBx3jAhH3749ge
         /5yAMJarSpW27rbcht+b/jjp5skD1kYf++y30KXkWPUcUqQAha6uJimzRHn6GxKoECeF
         tcywdVy6CMPC6AMo3hdBYL9fqvwDzskfS5oqmKe13TEOgNtybcG30dP/pl3omFmy2nMU
         0ej7NzTABaKFztzNmfZlb9vIAPWXvDlzc+S5GsTnxYxX4xIRpejHDcmNiZUaqS8pW71y
         LwKQ==
X-Gm-Message-State: ANhLgQ1iSwJ0DLGyEyMd+RlgYuBYx88Z7pFBQRgOMsxbTSwDQw+dVI9Z
        XFC+jPADYZdF5YvhFIVQtH0=
X-Google-Smtp-Source: ADFU+vsK2OGq9zv93mItbd3oMFbsKPee66NT6Q/S+5hbX9v6TgRlq/swR606BCKyI6H0ZsvEwSHYgA==
X-Received: by 2002:a17:902:6b86:: with SMTP id p6mr22348016plk.150.1584281143618;
        Sun, 15 Mar 2020 07:05:43 -0700 (PDT)
Received: from localhost (216.24.188.11.16clouds.com. [216.24.188.11])
        by smtp.gmail.com with ESMTPSA id b4sm66092535pfd.18.2020.03.15.07.05.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Mar 2020 07:05:43 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, hminas@synopsys.com,
        mathias.nyman@intel.com, bgolaszewski@baylibre.com, arnd@arndb.de,
        jeffrey.t.kirsher@intel.com, hdegoede@redhat.com,
        treding@nvidia.com, tglx@linutronix.de, tomas.winkler@intel.com,
        suzuki.poulose@arm.com, sergei.shtylyov@cogentembedded.com,
        geert@linux-m68k.org, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v3 2/5] usb: host: xhci-plat: convert to devm_platform_get_and_ioremap_resource
Date:   Sun, 15 Mar 2020 22:05:22 +0800
Message-Id: <20200315140525.21780-3-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200315140525.21780-1-zhengdejin5@gmail.com>
References: <20200315140525.21780-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_get_and_ioremap_resource() to simplify code, which
contains platform_get_resource() and devm_ioremap_resource(), it also
get the resource for use by the following code.

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
v2 -> v3:
	- call the rename function devm_platform_get_and_ioremap_resource()

v1 -> v2:
	- add this patch for add some real users of this function. 
 
 drivers/usb/host/xhci-plat.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index d90cd5ec09cf..dcc0bfe04c43 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -219,8 +219,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
 		goto disable_runtime;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
+	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(hcd->regs)) {
 		ret = PTR_ERR(hcd->regs);
 		goto put_hcd;
-- 
2.25.0

