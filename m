Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DD7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6371320720
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="cq42QKYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389983AbgF2U74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731234AbgF2TNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:00 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25139C00E3DB
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:04:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h5so16261119wrc.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xq/04cXluHxdn4oi+41YOzLKGhFgJERYE/hh7Fzob8w=;
        b=cq42QKYmOY4CtgFfqpxPZGj+yH2jOhEq38bEjhAHoYTOXYGCicGLSutWfhQ6z5Vh2B
         U0lZ5r8yZIQt2X4ZPwujuxJRz9HH6HNYoSaHyPglfp3ukXWSIqwb+E+J3YLDTwrHMrCV
         ZIjniX4ZwfBATGFb0Wf3xeffsu5ooRohKhDhMtE0pEWJOCaADxTynAwlB1ez86wcN5nV
         BtfBAZI0+Xi58iZ+ptSSkUaYiYSzbz5OpsYKp5upjJ/YXYQNPaX+Oc0bLJIwJfT6s9jw
         8jSxiCzyozRWdLOocNL5TtWN+mY0/AzdFPQY/sS+4mL9/9eOSmuL6t34Xy96O7G6kg0f
         WfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xq/04cXluHxdn4oi+41YOzLKGhFgJERYE/hh7Fzob8w=;
        b=I+6MRItZRORfnY61mlaGeC1cmJYTn00itWQz0JpkM3PFXzo9NYqiZgV9yt12PxHJZb
         yVEfPgpS+ezBeg+Hfyc9cIn0cM4JWUcKATi4SK2EOeZqPHv4ne6j2oe+v6W5a2Ko6v9C
         02FsI5bDaEVJZQHjjDoxUq/nmcZQMpMUbHdwTYd8KZJg07ud8xkDMFLwDV+N4HDZvCWo
         WS4qEFYwhO7gKFKtPgo+SC654NYayhxBu4owlGNOFw9dreKrB+rnEzQPxBwG4nJcFJZn
         NUkgTab80ocwh2BJRvyv4H7qlnmSlAOtq4S/WYCZI4bT7dUP7pYtSBDEb8elFNd6k0ae
         ISCg==
X-Gm-Message-State: AOAM5302iKnIrP/IYxMUjO5oidmj5NwwP92NCi0J/IGq8JF54vv/NpaH
        VyN7eRqw2odzk6slQoCIDvJn1w==
X-Google-Smtp-Source: ABdhPJyrWCbmLd6m6LZkBqztyMtmYuEkSUadLFAGKZEzpCnv3LiUC60yUSxB/ZOUMh6W4+tCPoXEpA==
X-Received: by 2002:a5d:65cd:: with SMTP id e13mr18265629wrw.213.1593432261778;
        Mon, 29 Jun 2020 05:04:21 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id d81sm25274347wmc.0.2020.06.29.05.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 05:04:21 -0700 (PDT)
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
Subject: [PATCH v2 07/10] net: phy: don't abuse devres in devm_mdiobus_register()
Date:   Mon, 29 Jun 2020 14:03:43 +0200
Message-Id: <20200629120346.4382-8-brgl@bgdev.pl>
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

We currently have two managed helpers for mdiobus - devm_mdiobus_alloc()
and devm_mdiobus_register(). The idea behind devres is that the release
callback releases whatever resource the devm function allocates. In the
mdiobus case however there's no devres associated with the device by
devm_mdiobus_register(). Instead the release callback for
devm_mdiobus_alloc(): _devm_mdiobus_free() unregisters the device if
it is marked as managed.

This all seems wrong. The managed structure shouldn't need to know or
care about whether it's managed or not - and this is the case now for
struct mii_bus. The devres wrapper should be opaque to the managed
resource.

This changeset makes devm_mdiobus_alloc() and devm_mdiobus_register()
conform to common devres standards: devm_mdiobus_alloc() allocates a
devres structure and registers a callback that will call mdiobus_free().
__devm_mdiobus_register() allocated another devres and registers a
callback that will unregister the bus.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/net/ethernet/realtek/r8169_main.c     |  2 +-
 drivers/net/phy/mdio_bus.c                    | 73 ----------------
 drivers/net/phy/mdio_devres.c                 | 83 +++++++++++++++++--
 include/linux/phy.h                           | 10 +--
 5 files changed, 82 insertions(+), 87 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 5463fc8a60c1..e0333d66a7f4 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -342,7 +342,6 @@ LED
 MDIO
   devm_mdiobus_alloc()
   devm_mdiobus_alloc_size()
-  devm_mdiobus_free()
   devm_mdiobus_register()
 
 MEM
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index b660ddbe4025..bfb68a1b1958 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5103,7 +5103,7 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 	new_bus->read = r8169_mdio_read_reg;
 	new_bus->write = r8169_mdio_write_reg;
 
-	ret = devm_mdiobus_register(new_bus);
+	ret = devm_mdiobus_register(&pdev->dev, new_bus);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 6ceee82b2839..42192991f55d 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -165,79 +165,6 @@ struct mii_bus *mdiobus_alloc_size(size_t size)
 }
 EXPORT_SYMBOL(mdiobus_alloc_size);
 
-static void _devm_mdiobus_free(struct device *dev, void *res)
-{
-	struct mii_bus *bus = *(struct mii_bus **)res;
-
-	if (bus->is_managed_registered && bus->state == MDIOBUS_REGISTERED)
-		mdiobus_unregister(bus);
-
-	mdiobus_free(bus);
-}
-
-static int devm_mdiobus_match(struct device *dev, void *res, void *data)
-{
-	struct mii_bus **r = res;
-
-	if (WARN_ON(!r || !*r))
-		return 0;
-
-	return *r == data;
-}
-
-/**
- * devm_mdiobus_alloc_size - Resource-managed mdiobus_alloc_size()
- * @dev:		Device to allocate mii_bus for
- * @sizeof_priv:	Space to allocate for private structure.
- *
- * Managed mdiobus_alloc_size. mii_bus allocated with this function is
- * automatically freed on driver detach.
- *
- * If an mii_bus allocated with this function needs to be freed separately,
- * devm_mdiobus_free() must be used.
- *
- * RETURNS:
- * Pointer to allocated mii_bus on success, NULL on failure.
- */
-struct mii_bus *devm_mdiobus_alloc_size(struct device *dev, int sizeof_priv)
-{
-	struct mii_bus **ptr, *bus;
-
-	ptr = devres_alloc(_devm_mdiobus_free, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return NULL;
-
-	/* use raw alloc_dr for kmalloc caller tracing */
-	bus = mdiobus_alloc_size(sizeof_priv);
-	if (bus) {
-		*ptr = bus;
-		devres_add(dev, ptr);
-		bus->is_managed = 1;
-	} else {
-		devres_free(ptr);
-	}
-
-	return bus;
-}
-EXPORT_SYMBOL_GPL(devm_mdiobus_alloc_size);
-
-/**
- * devm_mdiobus_free - Resource-managed mdiobus_free()
- * @dev:		Device this mii_bus belongs to
- * @bus:		the mii_bus associated with the device
- *
- * Free mii_bus allocated with devm_mdiobus_alloc_size().
- */
-void devm_mdiobus_free(struct device *dev, struct mii_bus *bus)
-{
-	int rc;
-
-	rc = devres_release(dev, _devm_mdiobus_free,
-			    devm_mdiobus_match, bus);
-	WARN_ON(rc);
-}
-EXPORT_SYMBOL_GPL(devm_mdiobus_free);
-
 /**
  * mdiobus_release - mii_bus device release callback
  * @d: the target struct device that contains the mii_bus
diff --git a/drivers/net/phy/mdio_devres.c b/drivers/net/phy/mdio_devres.c
index 3ee887733d4a..0b9bd9a61378 100644
--- a/drivers/net/phy/mdio_devres.c
+++ b/drivers/net/phy/mdio_devres.c
@@ -1,25 +1,96 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#include <linux/device.h>
 #include <linux/phy.h>
+#include <linux/stddef.h>
+
+struct mdiobus_devres {
+	struct mii_bus *mii;
+};
+
+static void devm_mdiobus_free(struct device *dev, void *this)
+{
+	struct mdiobus_devres *dr = this;
+
+	mdiobus_free(dr->mii);
+}
+
+/**
+ * devm_mdiobus_alloc_size - Resource-managed mdiobus_alloc_size()
+ * @dev:		Device to allocate mii_bus for
+ * @sizeof_priv:	Space to allocate for private structure
+ *
+ * Managed mdiobus_alloc_size. mii_bus allocated with this function is
+ * automatically freed on driver detach.
+ *
+ * RETURNS:
+ * Pointer to allocated mii_bus on success, NULL on out-of-memory error.
+ */
+struct mii_bus *devm_mdiobus_alloc_size(struct device *dev, int sizeof_priv)
+{
+	struct mdiobus_devres *dr;
+
+	dr = devres_alloc(devm_mdiobus_free, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return NULL;
+
+	dr->mii = mdiobus_alloc_size(sizeof_priv);
+	if (!dr->mii) {
+		devres_free(dr);
+		return NULL;
+	}
+
+	devres_add(dev, dr);
+	return dr->mii;
+}
+EXPORT_SYMBOL(devm_mdiobus_alloc_size);
+
+static void devm_mdiobus_unregister(struct device *dev, void *this)
+{
+	struct mdiobus_devres *dr = this;
+
+	mdiobus_unregister(dr->mii);
+}
+
+static int mdiobus_devres_match(struct device *dev,
+				void *this, void *match_data)
+{
+	struct mdiobus_devres *res = this;
+	struct mii_bus *mii = match_data;
+
+	return mii == res->mii;
+}
 
 /**
  * __devm_mdiobus_register - Resource-managed variant of mdiobus_register()
+ * @dev:	Device to register mii_bus for
  * @bus:	MII bus structure to register
  * @owner:	Owning module
  *
  * Returns 0 on success, negative error number on failure.
  */
-int __devm_mdiobus_register(struct mii_bus *bus, struct module *owner)
+int __devm_mdiobus_register(struct device *dev, struct mii_bus *bus,
+			    struct module *owner)
 {
+	struct mdiobus_devres *dr;
 	int ret;
 
-	if (!bus->is_managed)
-		return -EPERM;
+	if (WARN_ON(!devres_find(dev, devm_mdiobus_free,
+				 mdiobus_devres_match, bus)))
+		return -EINVAL;
+
+	dr = devres_alloc(devm_mdiobus_unregister, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
 
 	ret = __mdiobus_register(bus, owner);
-	if (!ret)
-		bus->is_managed_registered = 1;
+	if (ret) {
+		devres_free(dr);
+		return ret;
+	}
 
-	return ret;
+	dr->mii = bus;
+	devres_add(dev, dr);
+	return 0;
 }
 EXPORT_SYMBOL(__devm_mdiobus_register);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 4935867f024b..3695e9d6b3f6 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -260,9 +260,6 @@ struct mii_bus {
 	int (*reset)(struct mii_bus *bus);
 	struct mdio_bus_stats stats[PHY_MAX_ADDR];
 
-	unsigned int is_managed:1;	/* is device-managed */
-	unsigned int is_managed_registered:1;
-
 	/*
 	 * A lock to ensure that only one thing can read/write
 	 * the MDIO bus at a time
@@ -313,9 +310,11 @@ static inline struct mii_bus *mdiobus_alloc(void)
 }
 
 int __mdiobus_register(struct mii_bus *bus, struct module *owner);
-int __devm_mdiobus_register(struct mii_bus *bus, struct module *owner);
+int __devm_mdiobus_register(struct device *dev, struct mii_bus *bus,
+			    struct module *owner);
 #define mdiobus_register(bus) __mdiobus_register(bus, THIS_MODULE)
-#define devm_mdiobus_register(bus) __devm_mdiobus_register(bus, THIS_MODULE)
+#define devm_mdiobus_register(dev, bus) \
+		__devm_mdiobus_register(dev, bus, THIS_MODULE)
 
 void mdiobus_unregister(struct mii_bus *bus);
 void mdiobus_free(struct mii_bus *bus);
@@ -326,7 +325,6 @@ static inline struct mii_bus *devm_mdiobus_alloc(struct device *dev)
 }
 
 struct mii_bus *mdio_find_bus(const char *mdio_name);
-void devm_mdiobus_free(struct device *dev, struct mii_bus *bus);
 struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr);
 
 #define PHY_INTERRUPT_DISABLED	false
-- 
2.26.1

