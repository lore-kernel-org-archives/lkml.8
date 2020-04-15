Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA738C2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B56F82076A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371216AbgDOPGd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:06:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:60738 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394096AbgDOPGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:06:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BD32EAFBF;
        Wed, 15 Apr 2020 15:06:19 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     saravanak@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] of: property: Avoid linking devices with circular dependencies
Date:   Wed, 15 Apr 2020 17:05:49 +0200
Message-Id: <20200415150550.28156-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200415150550.28156-1-nsaenzjulienne@suse.de>
References: <20200415150550.28156-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating a consumer/supplier relationship between devices it's
essential to make sure they aren't supplying each other creating a
circular dependency.

Introduce a new function to check if such circular dependency exists
between two device nodes and use it in of_link_to_phandle().

Fixes: a3e1d1a7f5fc ("of: property: Add functional dependency link from DT bindings")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

NOTE:
 I feel of_link_is_circular() is a little dense, and could benefit from
 some abstraction/refactoring. That said, I'd rather get some feedback,
 before spending time on it.

 drivers/of/property.c | 50 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 2c7978ef22be1..74a5190408c3b 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1171,6 +1171,44 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{}
 };
 
+/**
+ * of_link_is_circular - Make sure potential link isn't circular
+ *
+ * @sup_np: Supplier device
+ * @con_np: Consumer device
+ *
+ * This function checks if @sup_np's properties contain a reference to @con_np.
+ *
+ * Will return true if there's a circular dependency and false otherwise.
+ */
+static bool of_link_is_circular(struct device_node *sup_np,
+				struct device_node *con_np)
+{
+	const struct supplier_bindings *s = of_supplier_bindings;
+	struct device_node *tmp;
+	bool matched = false;
+	struct property *p;
+	int i = 0;
+
+	for_each_property_of_node(sup_np, p) {
+		while (!matched && s->parse_prop) {
+			while ((tmp = s->parse_prop(sup_np, p->name, i))) {
+				matched = true;
+				i++;
+
+				if (tmp == con_np)
+					return true;
+			}
+			i = 0;
+			s++;
+		}
+		s = of_supplier_bindings;
+		matched = false;
+	}
+
+	return false;
+}
+
 /**
  * of_link_to_phandle - Add device link to supplier from supplier phandle
  * @dev: consumer device
@@ -1216,6 +1254,18 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
 		return -ENODEV;
 	}
 
+	/*
+	 * It is possible for consumer device nodes to also supply the device
+	 * node they are consuming from. Creating an unwarranted circular
+	 * dependency.
+	 */
+	if (of_link_is_circular(sup_np, dev->of_node)) {
+		dev_dbg(dev, "Not linking to %pOFP - Circular dependency\n",
+			sup_np);
+		of_node_put(sup_np);
+		return -ENODEV;
+	}
+
 	/*
 	 * Don't allow linking a device node as a consumer of one of its
 	 * descendant nodes. By definition, a child node can't be a functional
-- 
2.26.0

