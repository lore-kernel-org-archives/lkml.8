Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7F8C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6707020753
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZFGiZD87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbgDHTnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:43:20 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33606 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730124AbgDHTnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 15:43:20 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 038Jh8Tt033391;
        Wed, 8 Apr 2020 14:43:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1586374988;
        bh=zJkKVgkfbIzZTkO2jdOTLZAkH40G1j3CYC29M02fcrw=;
        h=From:To:CC:Subject:Date;
        b=ZFGiZD87Mm9LOs7iWkStk0bH7xXbSdo8KnoXVvcK80dNlaTV2oIXjwsTCxMOTx1Ag
         qawEsqWTpiD7vH4EZ/Zb49knK7CsnirLpU/gSshA3EETD0RrjDWLATAAP7Dj6L+DTD
         9qRfLYxs72mqP/iZ9xziKHeuk6tilEWVAgXWMGwk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 038Jh87M003986
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Apr 2020 14:43:08 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Apr
 2020 14:43:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Apr 2020 14:43:07 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 038Jh64Y027091;
        Wed, 8 Apr 2020 14:43:07 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        <iommu@lists.linux-foundation.org>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v2] dma-debug: fix displaying of dma allocation type
Date:   Wed, 8 Apr 2020 22:43:00 +0300
Message-ID: <20200408194300.21426-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 2e05ea5cdc1a ("dma-mapping: implement dma_map_single_attrs using
dma_map_page_attrs") removed "dma_debug_page" enum, but missed to update
type2name string table. This causes incorrect displaying of dma allocation
type.
Fix it by removing "page" string from type2name string table and switch to
use named initializers.

Before (dma_alloc_coherent()):
k3-ringacc 4b800000.ringacc: scather-gather idx 2208 P=d1140000 N=d114 D=d1140000 L=40 DMA_BIDIRECTIONAL dma map error check not applicable
k3-ringacc 4b800000.ringacc: scather-gather idx 2216 P=d1150000 N=d115 D=d1150000 L=40 DMA_BIDIRECTIONAL dma map error check not applicable

After:
k3-ringacc 4b800000.ringacc: coherent idx 2208 P=d1140000 N=d114 D=d1140000 L=40 DMA_BIDIRECTIONAL dma map error check not applicable
k3-ringacc 4b800000.ringacc: coherent idx 2216 P=d1150000 N=d115 D=d1150000 L=40 DMA_BIDIRECTIONAL dma map error check not applicable

Fixes: 2e05ea5cdc1a ("dma-mapping: implement dma_map_single_attrs using dma_map_page_attrs")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
v2:
 - witch to use named initializers.

 kernel/dma/debug.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 2031ed1ad7fa..21dc002eff13 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -137,9 +137,12 @@ static const char *const maperr2str[] = {
 	[MAP_ERR_CHECKED] = "dma map error checked",
 };
 
-static const char *type2name[5] = { "single", "page",
-				    "scather-gather", "coherent",
-				    "resource" };
+static const char *type2name[5] = {
+	[dma_debug_single] = "single",
+	[dma_debug_sg] = "scather-gather",
+	[dma_debug_coherent] = "coherent",
+	[dma_debug_resource] = "resource",
+};
 
 static const char *dir2name[4] = { "DMA_BIDIRECTIONAL", "DMA_TO_DEVICE",
 				   "DMA_FROM_DEVICE", "DMA_NONE" };
-- 
2.17.1

