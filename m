Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C15C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2052073A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ONX9OTdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388726AbgBNTtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:49:08 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38201 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387508AbgBNTtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:49:07 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so5362572pfc.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 11:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZWng66Hoj7xQzhbUhm9kO2M9MQGzsOmKGEij3AJEDXU=;
        b=ONX9OTdBNa/5a5mLeDhmt5afoWTqsbefXAjxdh/WIid2nembeEayJx0HLEs8vp++ya
         qNSBA5/39f/Uiub0eo9h4mFy2IyRKrvLNU62KsbY2C+JbPxgLzOLkU2rAk4X2B4CzKQG
         7vZQJzLhiUc00YnSzHTqzKKTWkjPZ/hxr9A0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZWng66Hoj7xQzhbUhm9kO2M9MQGzsOmKGEij3AJEDXU=;
        b=NJQHtOBKS+GjTHxAUMj/JNo0DrCmzDJjJVVzZuRHhp356+XJTppbDPfeZ9Ynn299N8
         gwCMeaIfgtJ7RpspQXkC8VXBtFOMUqGhuOhvhsF9BJA64hfQMwYcMHgRp2eOiA5q73ZS
         3w/B10AGB54L1V6LfCO5jzj0mVVPObOIFQXL8pSh8dcWd0ot/pgd/wVDaxseBnhzpqtM
         Xuw8r+FQ/ZtszlZuNLPcQTzZ+aFrNbL/7aSE27t/cFBRLB4DdbQDW7lcIk1N5TZfOqMn
         vkg5NpHHMufb7uPdO4n54uJK0w7tLqnmlSyA+EgDA6G2MjJZhmsNyaDMp5CsBIVWeyVM
         xPEQ==
X-Gm-Message-State: APjAAAUfnCks5YpGe2IxyzO/9gV2E3m0dxK62t8rprVDq8wCp31KO5q3
        6ZwW+9zdqEz54+gXeZkKRXAg0w==
X-Google-Smtp-Source: APXvYqwODEoeN+gxHepqNLozmja+mZtjocOV32D//1Zb1ppvJzZVslchQzuA62bl70OctqgEcPFbtg==
X-Received: by 2002:aa7:9808:: with SMTP id e8mr5202704pfl.32.1581709745136;
        Fri, 14 Feb 2020 11:49:05 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id u3sm7349815pjv.32.2020.02.14.11.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 11:49:04 -0800 (PST)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Ray Jui <rjui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arun Parameswaran <arun.parameswaran@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] net: phy: restore mdio regs in the iproc mdio driver
Date:   Fri, 14 Feb 2020 11:48:58 -0800
Message-Id: <20200214194858.8528-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arun Parameswaran <arun.parameswaran@broadcom.com>

The mii management register in iproc mdio block
does not have a reention register so it is lost on suspend.
Save and restore value of register while resuming from suspend.

Fixes: bb1a619735b4 ("net: phy: Initialize mdio clock at probe function")

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/net/phy/mdio-bcm-iproc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/phy/mdio-bcm-iproc.c b/drivers/net/phy/mdio-bcm-iproc.c
index 7e9975d25066..f1ded03f0229 100644
--- a/drivers/net/phy/mdio-bcm-iproc.c
+++ b/drivers/net/phy/mdio-bcm-iproc.c
@@ -178,6 +178,23 @@ static int iproc_mdio_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+int iproc_mdio_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct iproc_mdio_priv *priv = platform_get_drvdata(pdev);
+
+	/* restore the mii clock configuration */
+	iproc_mdio_config_clk(priv->base);
+
+	return 0;
+}
+
+static const struct dev_pm_ops iproc_mdio_pm_ops = {
+	.resume = iproc_mdio_resume
+};
+#endif /* CONFIG_PM_SLEEP */
+
 static const struct of_device_id iproc_mdio_of_match[] = {
 	{ .compatible = "brcm,iproc-mdio", },
 	{ /* sentinel */ },
@@ -188,6 +205,9 @@ static struct platform_driver iproc_mdio_driver = {
 	.driver = {
 		.name = "iproc-mdio",
 		.of_match_table = iproc_mdio_of_match,
+#ifdef CONFIG_PM_SLEEP
+		.pm = &iproc_mdio_pm_ops,
+#endif
 	},
 	.probe = iproc_mdio_probe,
 	.remove = iproc_mdio_remove,
-- 
2.17.1

