Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEF0C38A2C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F04F122202
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgDQQzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:55:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:42424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727840AbgDQQy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:54:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 06275AE21;
        Fri, 17 Apr 2020 16:54:55 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     saravanak@google.com, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 2/2] of: property: Do not link to disabled devices
Date:   Fri, 17 Apr 2020 18:54:42 +0200
Message-Id: <20200417165442.1856-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200417165442.1856-1-nsaenzjulienne@suse.de>
References: <20200417165442.1856-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating a consumer/supplier relationship between two devices,
make sure the supplier node is actually active. Otherwise this will
create a link relationship that will never be fulfilled. This, in the
worst case scenario, will hang the system during boot.

Note that, in practice, the fact that a device-tree represented
consumer/supplier relationship isn't fulfilled will not prevent devices
from successfully probing.

Fixes: a3e1d1a7f5fc ("of: property: Add functional dependency link from DT bindings")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

---

Changes since v1:
 - Move availability check into the compatible search routine and bail
   if device node disabled

 drivers/of/property.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index dc034eb45defd..14b6266dd054b 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1045,8 +1045,25 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
 	 * Find the device node that contains the supplier phandle.  It may be
 	 * @sup_np or it may be an ancestor of @sup_np.
 	 */
-	while (sup_np && !of_find_property(sup_np, "compatible", NULL))
+	while (sup_np) {
+
+		/*
+		 * Don't allow linking a device node as consumer of a disabled
+		 * node.
+		 */
+		if (!of_device_is_available(sup_np)) {
+			dev_dbg(dev, "Not linking to %pOFP - Not available\n",
+				sup_np);
+			of_node_put(sup_np);
+			return -ENODEV;
+		}
+
+		if (of_find_property(sup_np, "compatible", NULL))
+			break;
+
 		sup_np = of_get_next_parent(sup_np);
+	}
+
 	if (!sup_np) {
 		dev_dbg(dev, "Not linking to %pOFP - No device\n", tmp_np);
 		return -ENODEV;
-- 
2.26.0

