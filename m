Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99270C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA272076A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371237AbgDOPG5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:06:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:60720 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394095AbgDOPGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:06:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C82B1AFBB;
        Wed, 15 Apr 2020 15:06:18 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     saravanak@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] of: property: Move of_link_to_phandle()
Date:   Wed, 15 Apr 2020 17:05:48 +0200
Message-Id: <20200415150550.28156-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200415150550.28156-1-nsaenzjulienne@suse.de>
References: <20200415150550.28156-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is done in order to simplify further changes.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/of/property.c | 145 +++++++++++++++++++++---------------------
 1 file changed, 73 insertions(+), 72 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 487685ff8bb19..2c7978ef22be1 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1014,78 +1014,6 @@ static bool of_is_ancestor_of(struct device_node *test_ancestor,
 	return false;
 }
 
-/**
- * of_link_to_phandle - Add device link to supplier from supplier phandle
- * @dev: consumer device
- * @sup_np: phandle to supplier device tree node
- *
- * Given a phandle to a supplier device tree node (@sup_np), this function
- * finds the device that owns the supplier device tree node and creates a
- * device link from @dev consumer device to the supplier device. This function
- * doesn't create device links for invalid scenarios such as trying to create a
- * link with a parent device as the consumer of its child device. In such
- * cases, it returns an error.
- *
- * Returns:
- * - 0 if link successfully created to supplier
- * - -EAGAIN if linking to the supplier should be reattempted
- * - -EINVAL if the supplier link is invalid and should not be created
- * - -ENODEV if there is no device that corresponds to the supplier phandle
- */
-static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
-			      u32 dl_flags)
-{
-	struct device *sup_dev;
-	int ret = 0;
-	struct device_node *tmp_np = sup_np;
-	int is_populated;
-
-	of_node_get(sup_np);
-	/*
-	 * Find the device node that contains the supplier phandle.  It may be
-	 * @sup_np or it may be an ancestor of @sup_np.
-	 */
-	while (sup_np && !of_find_property(sup_np, "compatible", NULL))
-		sup_np = of_get_next_parent(sup_np);
-	if (!sup_np) {
-		dev_dbg(dev, "Not linking to %pOFP - No device\n", tmp_np);
-		return -ENODEV;
-	}
-
-	/* Don't allow linking a device node as consumer of a disabled node */
-	if (!of_device_is_available(sup_np)) {
-		dev_dbg(dev, "Not linking to %pOFP - Not available\n", sup_np);
-		of_node_put(sup_np);
-		return -ENODEV;
-	}
-
-	/*
-	 * Don't allow linking a device node as a consumer of one of its
-	 * descendant nodes. By definition, a child node can't be a functional
-	 * dependency for the parent node.
-	 */
-	if (of_is_ancestor_of(dev->of_node, sup_np)) {
-		dev_dbg(dev, "Not linking to %pOFP - is descendant\n", sup_np);
-		of_node_put(sup_np);
-		return -EINVAL;
-	}
-	sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
-	is_populated = of_node_check_flag(sup_np, OF_POPULATED);
-	of_node_put(sup_np);
-	if (!sup_dev && is_populated) {
-		/* Early device without struct device. */
-		dev_dbg(dev, "Not linking to %pOFP - No struct device\n",
-			sup_np);
-		return -ENODEV;
-	} else if (!sup_dev) {
-		return -EAGAIN;
-	}
-	if (!device_link_add(dev, sup_dev, dl_flags))
-		ret = -EAGAIN;
-	put_device(sup_dev);
-	return ret;
-}
-
 /**
  * parse_prop_cells - Property parsing function for suppliers
  *
@@ -1243,6 +1171,79 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{}
 };
 
+/**
+ * of_link_to_phandle - Add device link to supplier from supplier phandle
+ * @dev: consumer device
+ * @sup_np: phandle to supplier device tree node
+ *
+ * Given a phandle to a supplier device tree node (@sup_np), this function
+ * finds the device that owns the supplier device tree node and creates a
+ * device link from @dev consumer device to the supplier device. This function
+ * doesn't create device links for invalid scenarios such as trying to create a
+ * link with a parent device as the consumer of its child device. In such
+ * cases, it returns an error.
+ *
+ * Returns:
+ * - 0 if link successfully created to supplier
+ * - -EAGAIN if linking to the supplier should be reattempted
+ * - -EINVAL if the supplier link is invalid and should not be created
+ * - -ENODEV if there is no device that corresponds to the supplier phandle
+ */
+static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
+			      u32 dl_flags)
+{
+	struct device *sup_dev;
+	int ret = 0;
+	struct device_node *tmp_np = sup_np;
+	int is_populated;
+
+	of_node_get(sup_np);
+	/*
+	 * Find the device node that contains the supplier phandle.  It may be
+	 * @sup_np or it may be an ancestor of @sup_np.
+	 */
+	while (sup_np && !of_find_property(sup_np, "compatible", NULL))
+		sup_np = of_get_next_parent(sup_np);
+	if (!sup_np) {
+		dev_dbg(dev, "Not linking to %pOFP - No device\n", tmp_np);
+		return -ENODEV;
+	}
+
+	/* Don't allow linking a device node as consumer of a disabled node */
+	if (!of_device_is_available(sup_np)) {
+		dev_dbg(dev, "Not linking to %pOFP - Not available\n", sup_np);
+		of_node_put(sup_np);
+		return -ENODEV;
+	}
+
+	/*
+	 * Don't allow linking a device node as a consumer of one of its
+	 * descendant nodes. By definition, a child node can't be a functional
+	 * dependency for the parent node.
+	 */
+	if (of_is_ancestor_of(dev->of_node, sup_np)) {
+		dev_dbg(dev, "Not linking to %pOFP - is descendant\n", sup_np);
+		of_node_put(sup_np);
+		return -EINVAL;
+	}
+	sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
+	is_populated = of_node_check_flag(sup_np, OF_POPULATED);
+	of_node_put(sup_np);
+	if (!sup_dev && is_populated) {
+		/* Early device without struct device. */
+		dev_dbg(dev, "Not linking to %pOFP - No struct device\n",
+			sup_np);
+		return -ENODEV;
+	} else if (!sup_dev) {
+		return -EAGAIN;
+	}
+
+	if (!device_link_add(dev, sup_dev, dl_flags))
+		ret = -EAGAIN;
+	put_device(sup_dev);
+	return ret;
+}
+
 /**
  * of_link_property - Create device links to suppliers listed in a property
  * @dev: Consumer device
-- 
2.26.0

