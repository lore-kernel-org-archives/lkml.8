Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AAEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A9E82072C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gx5B4KRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgESUfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:35:01 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:34988 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727772AbgESUe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:34:57 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 6E7C630D5D4;
        Tue, 19 May 2020 13:33:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 6E7C630D5D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1589920413;
        bh=JQAkxMVnGUF8iY20Hh625Yq05MLbzTewkMnThHqGS34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gx5B4KRiS564vm/miPhArKQOv0Rd0/mhNNPsfzjOjKCoh3IzffZnF8HPsghOoW88J
         FjgMVMhZ9Q4PEZauldHLNZ3kIsPE9zFR1lYpC9eGYBS0sJ7x6BbBiyYNTYuzpQwGpU
         NwsiTdWttiMNgwyn7bM95rwGtNr6mn5Ob4jkHqQA=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id F3894140069;
        Tue, 19 May 2020 13:34:54 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     james.quinlan@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 08/15] of: Include a dev param in of_dma_get_range()
Date:   Tue, 19 May 2020 16:34:06 -0400
Message-Id: <20200519203419.12369-9-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519203419.12369-1-james.quinlan@broadcom.com>
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is only one caller of of_dma_get_range().
A struct device *dev param is needed For implementing
multiple dma offsets.  This function will still work
if dev == NULL.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/of/address.c    | 4 +++-
 drivers/of/device.c     | 2 +-
 drivers/of/of_private.h | 8 ++++----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 8eea3f6e29a4..96d8cfb14a60 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -920,6 +920,7 @@ EXPORT_SYMBOL(of_io_request_and_map);
 
 /**
  * of_dma_get_range - Get DMA range info
+ * @dev:	device pointer; only needed for a corner case.
  * @np:		device node to get DMA range info
  * @dma_addr:	pointer to store initial DMA address of DMA range
  * @paddr:	pointer to store initial CPU address of DMA range
@@ -935,7 +936,8 @@ EXPORT_SYMBOL(of_io_request_and_map);
  * It returns -ENODEV if "dma-ranges" property was not found
  * for this device in DT.
  */
-int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *size)
+int of_dma_get_range(struct device *dev, struct device_node *np, u64 *dma_addr,
+		     u64 *paddr, u64 *size)
 {
 	struct device_node *node = of_node_get(np);
 	const __be32 *ranges = NULL;
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 27203bfd0b22..ef6a741f9f0b 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -95,7 +95,7 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
 	const struct iommu_ops *iommu;
 	u64 mask, end;
 
-	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
+	ret = of_dma_get_range(dev, np, &dma_addr, &paddr, &size);
 	if (ret < 0) {
 		/*
 		 * For legacy reasons, we have to assume some devices need
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index edc682249c00..7a83d3a81ab6 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -158,11 +158,11 @@ extern int of_bus_n_addr_cells(struct device_node *np);
 extern int of_bus_n_size_cells(struct device_node *np);
 
 #ifdef CONFIG_OF_ADDRESS
-extern int of_dma_get_range(struct device_node *np, u64 *dma_addr,
-			    u64 *paddr, u64 *size);
+extern int of_dma_get_range(struct device *dev, struct device_node *np,
+			    u64 *dma_addr, u64 *paddr, u64 *size);
 #else
-static inline int of_dma_get_range(struct device_node *np, u64 *dma_addr,
-				   u64 *paddr, u64 *size)
+static inline int of_dma_get_range(struct device *dev, struct device_node *np,
+				   u64 *dma_addr, u64 *paddr, u64 *size)
 {
 	return -ENODEV;
 }
-- 
2.17.1

