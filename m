Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03677C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C777D2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hQ4SQQcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbgBNVsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 16:48:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35993 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730464AbgBNVsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 16:48:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so12322598wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 13:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tuhpf2H8a4ZzCABJWxUowWp6EKCvGrriOjGBgmmrUqk=;
        b=hQ4SQQcTZJYMJuGZ+sQF+Ern+ux0UaPM5+ddU9VsawxMBSNRoBQ5HHGbv2iNajhR2x
         oLZ6oWB9QvA3XrP3wpvBD8d4G8nrCqZZ8RlFLQfkp0Xe4UypOaGTNap69OXifGgIfN4d
         806OAX5oL1Eht/84kwnb/N8C5O5eo3AvMGVcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tuhpf2H8a4ZzCABJWxUowWp6EKCvGrriOjGBgmmrUqk=;
        b=KVGW6yZwXr22V/a9WHh/05LUlYvWXR9Px94KkbGPGqOlGQwrAwJ+P6rV4EJy/bWgVz
         nOz0XVeILRNs8Ytn8AwInT/ZidUftyG/JlaYNyMtxgv2dkFXyPnirH6S64ciOwQXUycd
         HWGzpYNlS+fn5Hd4rPh9BO36r227n3MkXrU7DO+66MRQhIzJMZKlP/8VMkWGi7iqMxZR
         paxvCD3Fh8cJCpq9NFTjUfjJOYpblZgLGf8xeuAaajG8deL+fGUPPX/BlVWhfuBPJEv+
         ZkbMOLmuSbHO+DVw7GSBpSLqFb3UPLVqeb06nGjson17Z1yYMAZdlyG8W1mI52eJnlH2
         F1OA==
X-Gm-Message-State: APjAAAWnnyXQ4/ZXFdjjIMj11WN13BVnOVIvJ6FhB20dEKzL+WC2+NQW
        c6yhjqO+eBLvnzkCtI0brf1lXw==
X-Google-Smtp-Source: APXvYqzPAS+OXaRY2OgIGYMo+NU6m1xw9xivVTbrwWXjQRsZAf0oh5rZLW12uHI+OCzLkzVtHm0Oag==
X-Received: by 2002:a1c:9ed7:: with SMTP id h206mr6546114wme.67.1581716885231;
        Fri, 14 Feb 2020 13:48:05 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id y12sm8842421wrw.88.2020.02.14.13.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 13:48:04 -0800 (PST)
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
Subject: [PATCH v2] net: phy: restore mdio regs in the iproc mdio driver
Date:   Fri, 14 Feb 2020 13:47:46 -0800
Message-Id: <20200214214746.10153-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arun Parameswaran <arun.parameswaran@broadcom.com>

The mii management register in iproc mdio block
does not have a retention register so it is lost on suspend.
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

