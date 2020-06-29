Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F60C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 005A120724
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="wrrcCV/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387982AbgF2UuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731473AbgF2TNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:37 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C59C00E3D5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:04:20 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l2so14371902wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hztYQwCZoivzm5mGWlL7y58+THNI2tIqMQL/obqgBh8=;
        b=wrrcCV/eHtEzwZIw9VBAP2zQ1gydhl0t9E8l473TWC1k05eOBumji4Os1tiblAIJzO
         4wOzef0hZPVEX5d6XcKMyCLmyT1b7YyADt6ahskiop6YYNc4kCYECitUEPTZ2F+fGW7i
         6y8Uvfl5xMLYsCcJdugcnS3YtHoCINKs3ujOoex6Br78sdsqIuKWAPmqQBMdtMgzZc4Z
         IgDmjSTOStUefzpm8hIuT/c2k0/+8rBOE6qocp0QN+rhvRzXyv46oLIUH3XFLdMSc0fo
         EpUTI/q2/srGjYzlHBIkYZyaLKmmyxTE0lK2PPy6VX9gggVCK384yzLHsG9blwPMptuJ
         bl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hztYQwCZoivzm5mGWlL7y58+THNI2tIqMQL/obqgBh8=;
        b=oeaFZ5+gE0u2CuonWxqk+45S809c/JKbSdVbvgEo4IsDW21dNPadAZV4lIonxIKOmS
         KT2bRjsM8XcHen706ptdYn+LPEFhFVUZGA6RXTB3b0d53cn7+o17d7E1v1qq/0KmjkcM
         bt5mWOGEzK+Wz9pFKr5ZnHh4jGvpVoDdMVs7qTtbQyHvk/2JEZGK2/NJR6ujV9glpj1R
         m+RDUMlR3/Zfvo+nCT5YGYCHTk8bvXMDnxjubG9QU2WZtuRjiD5NPIqRD0+vnj44Qkh+
         XXNMFAldNKs5B7mPs+Z1I8RORp4kUDvesQceZh7uFkY6iJ6S2mqFD7mZOxc1T02s8WKm
         Oo3Q==
X-Gm-Message-State: AOAM530WfjliuWse22atnKfDMMWBMxStbm7uUEcRBwYJaSDLmXsghB1X
        fbobx9aYvSjmeqB4vpyWOGVAgA==
X-Google-Smtp-Source: ABdhPJwFYLtezxZPsklmDvGqxvDLuEveoshSgJPr77DKJtvQVHg9COcCXF74kUionqbzZntdIBqycg==
X-Received: by 2002:a7b:cc8b:: with SMTP id p11mr17633011wma.180.1593432258934;
        Mon, 29 Jun 2020 05:04:18 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id d81sm25274347wmc.0.2020.06.29.05.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 05:04:18 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 05/10] phy: un-inline devm_mdiobus_register()
Date:   Mon, 29 Jun 2020 14:03:41 +0200
Message-Id: <20200629120346.4382-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200629120346.4382-1-brgl@bgdev.pl>
References: <20200629120346.4382-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Functions should only be static inline if they're very short. This
devres helper is already over 10 lines and it will grow soon as we'll
be improving upon its approach. Pull it into mdio_devres.c.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/phy/Makefile      |  2 +-
 drivers/net/phy/mdio_devres.c | 18 ++++++++++++++++++
 include/linux/phy.h           | 15 ++-------------
 3 files changed, 21 insertions(+), 14 deletions(-)
 create mode 100644 drivers/net/phy/mdio_devres.c

diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index dc9e53b511d6..896afdcac437 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -3,7 +3,7 @@
 
 libphy-y			:= phy.o phy-c45.o phy-core.o phy_device.o \
 				   linkmode.o
-mdio-bus-y			+= mdio_bus.o mdio_device.o
+mdio-bus-y			+= mdio_bus.o mdio_device.o mdio_devres.o
 
 ifdef CONFIG_MDIO_DEVICE
 obj-y				+= mdio-boardinfo.o
diff --git a/drivers/net/phy/mdio_devres.c b/drivers/net/phy/mdio_devres.c
new file mode 100644
index 000000000000..f0b4b6cfe5e3
--- /dev/null
+++ b/drivers/net/phy/mdio_devres.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/phy.h>
+
+int __devm_mdiobus_register(struct mii_bus *bus, struct module *owner)
+{
+	int ret;
+
+	if (!bus->is_managed)
+		return -EPERM;
+
+	ret = __mdiobus_register(bus, owner);
+	if (!ret)
+		bus->is_managed_registered = 1;
+
+	return ret;
+}
+EXPORT_SYMBOL(__devm_mdiobus_register);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index b693b609b2f5..4935867f024b 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -313,20 +313,9 @@ static inline struct mii_bus *mdiobus_alloc(void)
 }
 
 int __mdiobus_register(struct mii_bus *bus, struct module *owner);
+int __devm_mdiobus_register(struct mii_bus *bus, struct module *owner);
 #define mdiobus_register(bus) __mdiobus_register(bus, THIS_MODULE)
-static inline int devm_mdiobus_register(struct mii_bus *bus)
-{
-	int ret;
-
-	if (!bus->is_managed)
-		return -EPERM;
-
-	ret = mdiobus_register(bus);
-	if (!ret)
-		bus->is_managed_registered = 1;
-
-	return ret;
-}
+#define devm_mdiobus_register(bus) __devm_mdiobus_register(bus, THIS_MODULE)
 
 void mdiobus_unregister(struct mii_bus *bus);
 void mdiobus_free(struct mii_bus *bus);
-- 
2.26.1

