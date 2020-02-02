Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAE4C35249
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 22:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6779F2051A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 22:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHP/sqRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgBBWot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 17:44:49 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33348 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgBBWos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 17:44:48 -0500
Received: by mail-lj1-f195.google.com with SMTP id y6so12653280lji.0;
        Sun, 02 Feb 2020 14:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uX9jcydOX89ZUGugoSW4MzS7C2+BSpc+mKQCrQ08uKo=;
        b=SHP/sqRPruZqaLCIk6EmJ9WPtKElGy8YeKueEbeU8O+o0AwzAEJoc5qhqHDDNfrdtn
         ZuBa2GhGaf7+QuOFX8+1m17bOs+lDZhOHx41Y8EYP6XRr68HC6XAk/HvwZ+/oXUW1q1S
         9pX17LccLxCfk+jEW5NQxCAMAxnGB7Vs7Hts6pfcVxxiiiiWkljeeuYL0RYh5MQea1u5
         IOjM7XVc/6xZwHIRyYhhSkqK3U2qPV+hBOX9AkDgP+NZf5nTbP98WoEus9hrYhcdGKpB
         UGTSLbs5b4P/s0BokeyzCN4BjnrN6GZAWpQiMAi82dzAKshK5P+cUeE07THjC3Joas3M
         PTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uX9jcydOX89ZUGugoSW4MzS7C2+BSpc+mKQCrQ08uKo=;
        b=H2vbFr4vfH2/8XRmxMXH9S57rLXlXmWIDOOFoiw8XbTABWKDOn+GeqBYsfbUKizQ4A
         SMh9Od3epiL1pvcK6OFwuVO0+blMSMGCjMOW7ihoY7e/P/RL3Jh2ZRAtyACP25lsOvPk
         5jYiz5o8wkYwP3EXOh46tRXXwLNr8FJ2ZeHHKSH5EJXjAQhUcaBT8w3wJjIGinJPrnPR
         8aqfVXxngCmzFgiQ3KqfHu7nXysNr1GAbE4XhXwZANS9HWmLhTIu5f2kbJczTeZGJHJH
         4nkuUSILCyvVwfG6odooGod6qqiHfdFbxlCPIRJLaiEdLm7tVGv0gAs/INCrnwYxzYXG
         nAcw==
X-Gm-Message-State: APjAAAWO/98b1FtuDT58TWUtxai/HyQUi7xiE7bHZHMPbJvlVzCtmcIB
        WPqytbfJv7J2USV0bpTxDeY=
X-Google-Smtp-Source: APXvYqw9SUOzao6RNXRMb9fAXP2eoOjQxkoW3I5EiJLMd8bMoKMvIOH8Bz8JsfRVc3QrpPwPO1mGIw==
X-Received: by 2002:a2e:a491:: with SMTP id h17mr12065508lji.101.1580683486101;
        Sun, 02 Feb 2020 14:44:46 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id p136sm8031014lfa.8.2020.02.02.14.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 14:44:45 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] usb: phy: tegra: Add clarifying comments about the shared registers
Date:   Mon,  3 Feb 2020 01:42:59 +0300
Message-Id: <20200202224259.29187-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tools like Coccinelle may erroneously recommend to use the
devm_platform_ioremap_resource() API for the registers mapping because
these tools are not aware about the implementation details of the driver.
Let's add a clarifying comments to the code, which should help to stop
future attempts to break the driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/phy/phy-tegra-usb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index 037e8eee737d..6153cc35aba0 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -969,6 +969,10 @@ static int utmi_phy_probe(struct tegra_usb_phy *tegra_phy,
 		return  -ENXIO;
 	}
 
+	/*
+	 * Note that UTMI pad registers are shared by all PHYs, therefore
+	 * devm_platform_ioremap_resource() can't be used here.
+	 */
 	tegra_phy->pad_regs = devm_ioremap(&pdev->dev, res->start,
 					   resource_size(res));
 	if (!tegra_phy->pad_regs) {
@@ -1087,6 +1091,10 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 		return  -ENXIO;
 	}
 
+	/*
+	 * Note that PHY and USB controller are using shared registers,
+	 * therefore devm_platform_ioremap_resource() can't be used here.
+	 */
 	tegra_phy->regs = devm_ioremap(&pdev->dev, res->start,
 				       resource_size(res));
 	if (!tegra_phy->regs) {
-- 
2.24.0

