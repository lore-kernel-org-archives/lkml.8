Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903FBC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B8520637
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxD82NUs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgCWQGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:06:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42518 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbgCWQGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:06:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id 22so4094784pfa.9;
        Mon, 23 Mar 2020 09:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8tYqGa6805J8Z9/SpCi+A0e31BtAsAhuAIgSlltUwew=;
        b=cxD82NUsmUlVkHHLZICBsIGlSbSsRH+t+nItS6ajOAR293BWCmcMWyvEkA4ahQFws0
         H5tyMnz6yqu/P6Iq32+r7XW/DCzXtheZ2+2j9RG6Pbkp6VzYJ/dfc/E0EuxjwRZHFLEn
         i9cT+EWJCKhMtZ7t2VcWSRPDoy8eyzY9B8kLvFed9Ufxp2P8ALLLS7xYGS7HjavTrz0s
         iz0K1pCIJs4QcAuoepsuTYEoTDVy2+Vl+GwGFQOIWVGexdqqvTQXXnI7rviZzxyMdQVT
         60qmlswkuOsJWy7kwQpLpipUY5i6IX6kXrfbWI0Vz0BHv9JFEIigNzdSQjUa0EVbZdh4
         ncIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8tYqGa6805J8Z9/SpCi+A0e31BtAsAhuAIgSlltUwew=;
        b=Dv9XHS3TZl95dbot3xj9xfmTNJUBF6aGLSd2/wMOCHh56o/kqyOqRYZ/4WtfwyONdZ
         K5XkYoCDydWhy/FSicWVzGNFAxcky1cN/qgxTEnIuqBQe+ajJBQxPbE6xG4oqyVEF6/F
         7adbrIvUQ8+FiHbtU9+Z8SADoItB9fUZdEVtiry9ANEHvEZxHP1BNr/5923MmZInXqLh
         L1Eoe8yX6Y+i/M9DsSpIUUl3VAtNj2ySmUy9AoC66uuoWlP1bMojLjGIh5YM4WOI/8Ej
         AiRe80I0rLDYIM7SkREQikdasbzRzMj9yWB5SzxvHCJUHNDAUqyoLqlRIfpMzB3UlH7J
         bG7A==
X-Gm-Message-State: ANhLgQ1+Ts2fRZH39R6q9UXu2aiA62uqj1lV1ciisJ9zkW9RiZvf+/Sa
        hjVDhNW84o8+yK3USTndNAE=
X-Google-Smtp-Source: ADFU+vvqlch323EK4Tj7T5keEKOSg3p3q3fzROnY4mNjI1TuUQ6o6vzCiM/RtvyV1AFlb2g7Bu9Xtg==
X-Received: by 2002:aa7:99d1:: with SMTP id v17mr26147892pfi.165.1584979600922;
        Mon, 23 Mar 2020 09:06:40 -0700 (PDT)
Received: from localhost (176.122.158.203.16clouds.com. [176.122.158.203])
        by smtp.gmail.com with ESMTPSA id q103sm294485pjc.1.2020.03.23.09.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 09:06:40 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, hminas@synopsys.com,
        mathias.nyman@intel.com, bgolaszewski@baylibre.com, arnd@arndb.de,
        geert+renesas@glider.be, tomas.winkler@intel.com,
        tglx@linutronix.de, hdegoede@redhat.com, treding@nvidia.com,
        suzuki.poulose@arm.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH v4 3/5] usb: host: hisilicon: convert to devm_platform_get_and_ioremap_resource
Date:   Tue, 24 Mar 2020 00:06:10 +0800
Message-Id: <20200323160612.17277-4-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200323160612.17277-1-zhengdejin5@gmail.com>
References: <20200323160612.17277-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_get_and_ioremap_resource() to simplify code, which
contains platform_get_resource() and devm_ioremap_resource(), it also
get the resource for use by the following code.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
v3 -> v4:
	- no changed.
v2 -> v3:
	- call the rename function devm_platform_get_and_ioremap_resource()
v1 -> v2:
	- add this patch for add some real users of this function. 
 
 drivers/usb/host/xhci-histb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-histb.c b/drivers/usb/host/xhci-histb.c
index 3c4abb5a1c3f..5546e7e013a8 100644
--- a/drivers/usb/host/xhci-histb.c
+++ b/drivers/usb/host/xhci-histb.c
@@ -219,8 +219,7 @@ static int xhci_histb_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	histb->ctrl = devm_ioremap_resource(&pdev->dev, res);
+	histb->ctrl = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(histb->ctrl))
 		return PTR_ERR(histb->ctrl);
 
-- 
2.25.0

