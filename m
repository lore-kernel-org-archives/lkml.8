Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082B5C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 07:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE706206D3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 07:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgBAHqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 02:46:35 -0500
Received: from foss.arm.com ([217.140.110.172]:41116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgBAHqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 02:46:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4070B11B3;
        Fri, 31 Jan 2020 23:46:34 -0800 (PST)
Received: from u200856.usa.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6B0F3F52E;
        Fri, 31 Jan 2020 23:50:12 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     netdev@vger.kernel.org
Cc:     opendmb@gmail.com, f.fainelli@gmail.com, davem@davemloft.net,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, wahrenst@gmx.net, andrew@lunn.ch,
        hkallweit1@gmail.com, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 1/6] mdio_bus: Add generic mdio_find_bus()
Date:   Sat,  1 Feb 2020 01:46:20 -0600
Message-Id: <20200201074625.8698-2-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200201074625.8698-1-jeremy.linton@arm.com>
References: <20200201074625.8698-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears most ethernet drivers follow one of two main strategies
for mdio bus/phy management. A monolithic model where the net driver
itself creates, probes and uses the phy, and one where an external
mdio/phy driver instantiates the mdio bus/phy and the net driver
only attaches to a known phy. Usually in this latter model the phys
are discovered via DT relationships or simply phy name/address
hardcoding.

This is a shame because modern well behaved mdio buses are self
describing and can be probed. The mdio layer itself is fully capable
of this, yet there isn't a clean way for a standalone net driver
to attach and enumerate the discovered devices. This is because
outside of of_mdio_find_bus() there isn't a straightforward way
to acquire the mii_bus pointer.

So, lets add a mdio_find_bus which can return the mii_bus based
only on its name.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/net/phy/mdio_bus.c | 17 +++++++++++++++++
 include/linux/phy.h        |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 229e480179ff..46dfb112fd04 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -260,6 +260,23 @@ static struct class mdio_bus_class = {
 	.dev_release	= mdiobus_release,
 };
 
+/**
+ * mdio_find_bus - Given the name of a mdiobus, find the mii_bus.
+ * @mdio_bus_np: Pointer to the mii_bus.
+ *
+ * Returns a reference to the mii_bus, or NULL if none found.  The
+ * embedded struct device will have its reference count incremented,
+ * and this must be put_deviced'ed once the bus is finished with.
+ */
+struct mii_bus *mdio_find_bus(const char *mdio_name)
+{
+	struct device *d;
+
+	d = class_find_device_by_name(&mdio_bus_class, mdio_name);
+	return d ? to_mii_bus(d) : NULL;
+}
+EXPORT_SYMBOL(mdio_find_bus);
+
 #if IS_ENABLED(CONFIG_OF_MDIO)
 /**
  * of_mdio_find_bus - Given an mii_bus node, find the mii_bus.
diff --git a/include/linux/phy.h b/include/linux/phy.h
index dd4a91f1feaa..5700dd4dbb6f 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -273,6 +273,7 @@ static inline struct mii_bus *devm_mdiobus_alloc(struct device *dev)
 	return devm_mdiobus_alloc_size(dev, 0);
 }
 
+struct mii_bus *mdio_find_bus(const char *mdio_name);
 void devm_mdiobus_free(struct device *dev, struct mii_bus *bus);
 struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr);
 
-- 
2.24.1

