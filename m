Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C8CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5B6920DD4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsiM4ZEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgFSFH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 01:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFSFH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 01:07:28 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EF3C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 22:07:27 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id j68so4526110qkb.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 22:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vn1bV10W3tvJRgYqdiRF0lmWnCMP76unsCJTzVGifFg=;
        b=QsiM4ZEJtUhQBs9Gx6kygyiM3m/xn7LX5/xJOnd0aIo40xbOLxTp3kkz7sZLVlTRxs
         Ijtlknaxc3Ni0Zx29CJV3owe/eHwEtYBAZtZ5+ytAeodTJ7djTA0YxZj0GYFM+TAuX+W
         oy2uKeyRuTu7BwkVok5NX/e9CpWQhciz8/7+YPxEz7yMw17y+wLYHtTX39jYgzpNvSs5
         5YrusWV2KudcVsaEk72kDZP0wPoDWMNINCOI3+Rl0ucKCY40WrUM0QMztvj+n0Vt/PH4
         n1DsLnHfzxTg+hH0f0DL4nRNmOqLgiqcI92EgqTFWKrXCRQIFZ0PEH6YHVA1kj4IlR5T
         lCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vn1bV10W3tvJRgYqdiRF0lmWnCMP76unsCJTzVGifFg=;
        b=aV4R91XuGlBVsPitxCi3QvBXaJo7t/ohoSOBvPlj68vh/CsJQMNtJFcIfwGNbNPAxP
         M5SV1k/TPwK1y1YLLQcuG+bZyeH4ZWrA+4mz0dtRknXXof04WFCHqrk7YhlHBCs31Z/Q
         jILNe6oC4JkmMOeeCW4QATj4dW7kKZ6y2S7K0/OvxI2RqPjLXuZkpiuFvdcyQiyiYLcG
         pLbj8+i+Fj+bzHF28BdTK/gJuVLduQQzrypg1axKbdu0nCqUM4v5jjeIVXW54bmxqslH
         qixAOSHkSudmljkWkDKtyaGgeocesRzcx8ZKKw5vim38CQmiIbEv48BRjuj6ewIK1LVw
         W80g==
X-Gm-Message-State: AOAM532mu0lcptC3ERbGxMVzRYviHI/NZShfn0Gx6UDDM6V/cFxR8YSn
        jeuZRRqomyZbueCUeAl/lu8=
X-Google-Smtp-Source: ABdhPJwGrG2+nHFRvXxjANzAX712LgL7SmRcp5gvmZCjf8F4P0+WmiVBJ7ItfaAO+UlXJWD3mVSyIA==
X-Received: by 2002:a37:49d1:: with SMTP id w200mr1766639qka.153.1592543247147;
        Thu, 18 Jun 2020 22:07:27 -0700 (PDT)
Received: from LeoBras.ibmuc.com (177-131-65-187.dynamic.desktop.com.br. [177.131.65.187])
        by smtp.gmail.com with ESMTPSA id o6sm5235503qtd.59.2020.06.18.22.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 22:07:26 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Leonardo Bras <leobras.c@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] powerpc/pseries/iommu: Update call to ibm,query-pe-dma-windows
Date:   Fri, 19 Jun 2020 02:06:17 -0300
Message-Id: <20200619050619.266888-2-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200619050619.266888-1-leobras.c@gmail.com>
References: <20200619050619.266888-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From LoPAR level 2.8, "ibm,ddw-extensions" index 3 can make the number of
outputs from "ibm,query-pe-dma-windows" go from 5 to 6.

This change of output size is meant to expand the address size of
largest_available_block PE TCE from 32-bit to 64-bit, which ends up
shifting page_size and migration_capable.

This ends up requiring the update of
ddw_query_response->largest_available_block from u32 to u64, and manually
assigning the values from the buffer into this struct, according to
output size.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 57 +++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 6d47b4a3ce39..e5a617738c8b 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -334,7 +334,7 @@ struct direct_window {
 /* Dynamic DMA Window support */
 struct ddw_query_response {
 	u32 windows_available;
-	u32 largest_available_block;
+	u64 largest_available_block;
 	u32 page_size;
 	u32 migration_capable;
 };
@@ -869,14 +869,32 @@ static int find_existing_ddw_windows(void)
 }
 machine_arch_initcall(pseries, find_existing_ddw_windows);
 
+/*
+ * From LoPAR level 2.8, "ibm,ddw-extensions" index 3 can rule how many output
+ * parameters ibm,query-pe-dma-windows will have, ranging from 5 to 6.
+ */
+
+static int query_ddw_out_sz(struct device_node *par_dn)
+{
+	int ret;
+	u32 ddw_ext[3];
+
+	ret = of_property_read_u32_array(par_dn, "ibm,ddw-extensions",
+					 &ddw_ext[0], 3);
+	if (ret || ddw_ext[0] < 2 || ddw_ext[2] != 1)
+		return 5;
+	return 6;
+}
+
 static int query_ddw(struct pci_dev *dev, const u32 *ddw_avail,
-			struct ddw_query_response *query)
+		     struct ddw_query_response *query,
+		     struct device_node *par_dn)
 {
 	struct device_node *dn;
 	struct pci_dn *pdn;
-	u32 cfg_addr;
+	u32 cfg_addr, query_out[5];
 	u64 buid;
-	int ret;
+	int ret, out_sz;
 
 	/*
 	 * Get the config address and phb buid of the PE window.
@@ -888,12 +906,29 @@ static int query_ddw(struct pci_dev *dev, const u32 *ddw_avail,
 	pdn = PCI_DN(dn);
 	buid = pdn->phb->buid;
 	cfg_addr = ((pdn->busno << 16) | (pdn->devfn << 8));
+	out_sz = query_ddw_out_sz(par_dn);
+
+	ret = rtas_call(ddw_avail[0], 3, out_sz, query_out,
+			cfg_addr, BUID_HI(buid), BUID_LO(buid));
+	dev_info(&dev->dev, "ibm,query-pe-dma-windows(%x) %x %x %x returned %d\n",
+		 ddw_avail[0], cfg_addr, BUID_HI(buid), BUID_LO(buid), ret);
+
+	switch (out_sz) {
+	case 5:
+		query->windows_available = query_out[0];
+		query->largest_available_block = query_out[1];
+		query->page_size = query_out[2];
+		query->migration_capable = query_out[3];
+		break;
+	case 6:
+		query->windows_available = query_out[0];
+		query->largest_available_block = ((u64)query_out[1] << 32) |
+						 query_out[2];
+		query->page_size = query_out[3];
+		query->migration_capable = query_out[4];
+		break;
+	}
 
-	ret = rtas_call(ddw_avail[0], 3, 5, (u32 *)query,
-		  cfg_addr, BUID_HI(buid), BUID_LO(buid));
-	dev_info(&dev->dev, "ibm,query-pe-dma-windows(%x) %x %x %x"
-		" returned %d\n", ddw_avail[0], cfg_addr, BUID_HI(buid),
-		BUID_LO(buid), ret);
 	return ret;
 }
 
@@ -1040,7 +1075,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	 * of page sizes: supported and supported for migrate-dma.
 	 */
 	dn = pci_device_to_OF_node(dev);
-	ret = query_ddw(dev, ddw_avail, &query);
+	ret = query_ddw(dev, ddw_avail, &query, pdn);
 	if (ret != 0)
 		goto out_failed;
 
@@ -1068,7 +1103,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	/* check largest block * page size > max memory hotplug addr */
 	max_addr = ddw_memory_hotplug_max();
 	if (query.largest_available_block < (max_addr >> page_shift)) {
-		dev_dbg(&dev->dev, "can't map partition max 0x%llx with %u "
+		dev_dbg(&dev->dev, "can't map partition max 0x%llx with %llu "
 			  "%llu-sized pages\n", max_addr,  query.largest_available_block,
 			  1ULL << page_shift);
 		goto out_failed;
-- 
2.25.4

