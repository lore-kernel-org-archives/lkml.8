Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B11FC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0713020857
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371202AbgDOPG2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:06:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:60700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394091AbgDOPGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:06:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E4142AFBE;
        Wed, 15 Apr 2020 15:06:17 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     saravanak@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] of: property: Do not link to disabled devices
Date:   Wed, 15 Apr 2020 17:05:47 +0200
Message-Id: <20200415150550.28156-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200415150550.28156-1-nsaenzjulienne@suse.de>
References: <20200415150550.28156-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating a consumer/supplier relationship between two devices, make
sure the supplier node is actually active. Otherwise this will create a
device link that will never be fulfilled. This, in the worst case
scenario, will hang the system during boot.

Note that, in practice, the fact that a device-tree represented
consumer/supplier relationship isn't fulfilled will not prevent devices
from successfully probing.

Fixes: a3e1d1a7f5fc ("of: property: Add functional dependency link from DT bindings")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/of/property.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index a8c2b13521b27..487685ff8bb19 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1052,6 +1052,13 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
 		return -ENODEV;
 	}
 
+	/* Don't allow linking a device node as consumer of a disabled node */
+	if (!of_device_is_available(sup_np)) {
+		dev_dbg(dev, "Not linking to %pOFP - Not available\n", sup_np);
+		of_node_put(sup_np);
+		return -ENODEV;
+	}
+
 	/*
 	 * Don't allow linking a device node as a consumer of one of its
 	 * descendant nodes. By definition, a child node can't be a functional
-- 
2.26.0

