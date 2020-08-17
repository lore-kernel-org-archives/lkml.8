Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF09DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 902882065D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/5jxyOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgHQXln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 19:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbgHQXlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 19:41:32 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2C7C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:41:32 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 62so16672143qkj.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FRXoC7AzVK9au+/rOAXZuIsbP17c0bW4y0Ze4bdvrTQ=;
        b=j/5jxyOhrKdi1+ojW2Pl968RbS+3S1kU8wDvSqBg3BgbOG90oc+ltXHveENr6tFRAe
         CR6zP76/DMKGAYc81sAvVm7q17sg1RfqD0xBmTyB11IruaRYK0u91YGuoCvu9JonEZeQ
         pdTGvGHIGr/Nuygdf2MbRiaFywDTpX8tpAW5M87T7NYEiiM/q5g/00InlgGrgNfmVQ0S
         9HjzrcR9QZ9aE9oHNhYkws0A9epYw7mLyh7hnO29bxvAE3bdUrKiUxT/1Dak62paN+Rw
         WHavJePnufMNUXcmPsKOn+VW/6YNRmpxCR1Gw6hewpEE+azRA0fiCB6oirZ2Bp3v1DaE
         v8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FRXoC7AzVK9au+/rOAXZuIsbP17c0bW4y0Ze4bdvrTQ=;
        b=eVC1QFDiyiaosFr9umWu7I7pP9xlf/9WNShNQWD15+XFH3qVd9f7eMoyBJapg7Zusl
         IRd3JDRkDdYZT2/U6CJATk6TmZGx6yhRr0IV1fdNxLornFT4F0otXmfIBzPeqTaIrtMS
         iTcz1/tqu6z4a5B3kKwK/T0R8s4dobfuYGEQ+sJ1km5KKKhModm4IfFbhPesg/St/KxZ
         b2zH11hitZAdNdMFgFJdB44+FtKLRpXAUb/NjpjCCcSGYhgCZUmasVzzo6WtZi5jr67p
         rJbvjvbnnEs2n8R/00CMA83cjcKAG/r+kS53kQkbhfi5bhC8rzzRs0k+lPNEFIt4ZWPK
         qzhQ==
X-Gm-Message-State: AOAM531+cCEQZuRKkTazqlIN7OgKbyzh/ZXJZpGtsYxQR3Wjr1pq9XYI
        4sDsrm/oSvcMBGeMLyuNcOA=
X-Google-Smtp-Source: ABdhPJyqpbRFrrGu/KH2EiEoPl02Kx6QwRK8byQPJhNcazxCqKpTdu6sJHgMBQ7DkV7H+GgVM9Tr1Q==
X-Received: by 2002:a37:b145:: with SMTP id a66mr14588867qkf.338.1597707691695;
        Mon, 17 Aug 2020 16:41:31 -0700 (PDT)
Received: from LeoBras.ibmuc.com ([177.35.193.93])
        by smtp.gmail.com with ESMTPSA id w58sm22342868qth.95.2020.08.17.16.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 16:41:31 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Leonardo Bras <leobras.c@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        Murilo Fossa Vicentini <muvic@linux.ibm.com>,
        David Dai <zdai@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 09/10] powerpc/pseries/iommu: Make use of DDW even if it does not map the partition
Date:   Mon, 17 Aug 2020 20:40:32 -0300
Message-Id: <20200817234033.442511-10-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200817234033.442511-1-leobras.c@gmail.com>
References: <20200817234033.442511-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of today, if the biggest DDW that can be created can't map the whole
partition, it's creation is skipped and the default DMA window
"ibm,dma-window" is used instead.

DDW is 16x bigger than the default DMA window, having the same amount of
pages, but increasing the page size to 64k.
Besides larger DMA window, it performs better for allocations over 4k,
so it would be nice to use it instead.

The DDW created will be used for direct mapping by default.
If it's not available, indirect mapping will be used instead.

For indirect mapping, it's necessary to update the iommu_table so
iommu_alloc() can use the DDW created. For this,
iommu_table_update_window() is called when everything else succeeds
at enable_ddw().

Removing the default DMA window for using DDW with indirect mapping
is only allowed if there is no current IOMMU memory allocated in
the iommu_table. enable_ddw() is aborted otherwise.

As there will never have both direct and indirect mappings at the same
time, the same property name can be used for the created DDW.

So renaming
define DIRECT64_PROPNAME "linux,direct64-ddr-window-info"
to
define DMA64_PROPNAME "linux,dma64-ddr-window-info"
looks the right thing to do.

To make sure the property differentiates both cases, a new u32 for flags
was added at the end of the property, where BIT(0) set means direct
mapping.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 108 +++++++++++++++++++------
 1 file changed, 84 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 3a1ef02ad9d5..9544e3c91ced 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -350,8 +350,11 @@ struct dynamic_dma_window_prop {
 	__be64	dma_base;	/* address hi,lo */
 	__be32	tce_shift;	/* ilog2(tce_page_size) */
 	__be32	window_shift;	/* ilog2(tce_window_size) */
+	__be32	flags;		/* DDW properties, see bellow */
 };
 
+#define DDW_FLAGS_DIRECT	0x01
+
 struct direct_window {
 	struct device_node *device;
 	const struct dynamic_dma_window_prop *prop;
@@ -377,7 +380,7 @@ static LIST_HEAD(direct_window_list);
 static DEFINE_SPINLOCK(direct_window_list_lock);
 /* protects initializing window twice for same device */
 static DEFINE_MUTEX(direct_window_init_mutex);
-#define DIRECT64_PROPNAME "linux,direct64-ddr-window-info"
+#define DMA64_PROPNAME "linux,dma64-ddr-window-info"
 
 static int tce_clearrange_multi_pSeriesLP(unsigned long start_pfn,
 					unsigned long num_pfn, const void *arg)
@@ -836,7 +839,7 @@ static void remove_ddw(struct device_node *np, bool remove_prop)
 	if (ret)
 		return;
 
-	win = of_find_property(np, DIRECT64_PROPNAME, NULL);
+	win = of_find_property(np, DMA64_PROPNAME, NULL);
 	if (!win)
 		return;
 
@@ -852,7 +855,7 @@ static void remove_ddw(struct device_node *np, bool remove_prop)
 			np, ret);
 }
 
-static bool find_existing_ddw(struct device_node *pdn, u64 *dma_addr)
+static bool find_existing_ddw(struct device_node *pdn, u64 *dma_addr, bool *direct_mapping)
 {
 	struct direct_window *window;
 	const struct dynamic_dma_window_prop *direct64;
@@ -864,6 +867,7 @@ static bool find_existing_ddw(struct device_node *pdn, u64 *dma_addr)
 		if (window->device == pdn) {
 			direct64 = window->prop;
 			*dma_addr = be64_to_cpu(direct64->dma_base);
+			*direct_mapping = be32_to_cpu(direct64->flags) & DDW_FLAGS_DIRECT;
 			found = true;
 			break;
 		}
@@ -901,8 +905,8 @@ static int find_existing_ddw_windows(void)
 	if (!firmware_has_feature(FW_FEATURE_LPAR))
 		return 0;
 
-	for_each_node_with_property(pdn, DIRECT64_PROPNAME) {
-		direct64 = of_get_property(pdn, DIRECT64_PROPNAME, &len);
+	for_each_node_with_property(pdn, DMA64_PROPNAME) {
+		direct64 = of_get_property(pdn, DMA64_PROPNAME, &len);
 		if (!direct64)
 			continue;
 
@@ -1124,7 +1128,8 @@ static void reset_dma_window(struct pci_dev *dev, struct device_node *par_dn)
 }
 
 static int ddw_property_create(struct property **ddw_win, const char *propname,
-			       u32 liobn, u64 dma_addr, u32 page_shift, u32 window_shift)
+			       u32 liobn, u64 dma_addr, u32 page_shift,
+			       u32 window_shift, bool direct_mapping)
 {
 	struct dynamic_dma_window_prop *ddwprop;
 	struct property *win64;
@@ -1144,6 +1149,36 @@ static int ddw_property_create(struct property **ddw_win, const char *propname,
 	ddwprop->dma_base = cpu_to_be64(dma_addr);
 	ddwprop->tce_shift = cpu_to_be32(page_shift);
 	ddwprop->window_shift = cpu_to_be32(window_shift);
+	if (direct_mapping)
+		ddwprop->flags = cpu_to_be32(DDW_FLAGS_DIRECT);
+
+	return 0;
+}
+
+static int iommu_table_update_window(struct iommu_table **tbl, int nid, unsigned long liobn,
+				     unsigned long win_addr, unsigned long page_shift,
+				     unsigned long window_size)
+{
+	struct iommu_table *new_tbl, *old_tbl;
+
+	new_tbl = iommu_pseries_alloc_table(nid);
+	if (!new_tbl)
+		return -ENOMEM;
+
+	old_tbl = *tbl;
+	new_tbl->it_index = liobn;
+	new_tbl->it_offset = win_addr >> page_shift;
+	new_tbl->it_page_shift = page_shift;
+	new_tbl->it_size = window_size >> page_shift;
+	new_tbl->it_base = old_tbl->it_base;
+	new_tbl->it_busno = old_tbl->it_busno;
+	new_tbl->it_blocksize = old_tbl->it_blocksize;
+	new_tbl->it_type = old_tbl->it_type;
+	new_tbl->it_ops = old_tbl->it_ops;
+
+	iommu_init_table(new_tbl, nid, old_tbl->it_reserved_start, old_tbl->it_reserved_end);
+	iommu_tce_table_put(old_tbl);
+	*tbl = new_tbl;
 
 	return 0;
 }
@@ -1171,12 +1206,16 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	struct direct_window *window;
 	struct property *win64 = NULL;
 	struct failed_ddw_pdn *fpdn;
-	bool default_win_removed = false;
+	bool default_win_removed = false, maps_whole_partition = false;
+	struct pci_dn *pci = PCI_DN(pdn);
+	struct iommu_table *tbl = pci->table_group->tables[0];
 
 	mutex_lock(&direct_window_init_mutex);
 
-	if (find_existing_ddw(pdn, &dev->dev.archdata.dma_offset))
-		goto out_unlock;
+	if (find_existing_ddw(pdn, &dev->dev.archdata.dma_offset, &maps_whole_partition)) {
+		mutex_unlock(&direct_window_init_mutex);
+		return maps_whole_partition;
+	}
 
 	/*
 	 * If we already went through this for a previous function of
@@ -1258,16 +1297,24 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 			  query.page_size);
 		goto out_failed;
 	}
+
 	/* verify the window * number of ptes will map the partition */
-	/* check largest block * page size > max memory hotplug addr */
 	max_addr = ddw_memory_hotplug_max();
 	if (query.largest_available_block < (max_addr >> page_shift)) {
-		dev_dbg(&dev->dev, "can't map partition max 0x%llx with %llu "
-			  "%llu-sized pages\n", max_addr,  query.largest_available_block,
-			  1ULL << page_shift);
-		goto out_failed;
+		dev_dbg(&dev->dev, "can't map partition max 0x%llx with %llu %llu-sized pages\n",
+			max_addr, query.largest_available_block,
+			1ULL << page_shift);
+
+		len = order_base_2(query.largest_available_block << page_shift);
+	} else {
+		maps_whole_partition = true;
+		len = order_base_2(max_addr);
 	}
-	len = order_base_2(max_addr);
+
+	/* DDW + IOMMU on single window may fail if there is any allocation */
+	if (default_win_removed && !maps_whole_partition &&
+	    iommu_table_in_use(tbl))
+		goto out_failed;
 
 	ret = create_ddw(dev, ddw_avail, &create, page_shift, len);
 	if (ret != 0)
@@ -1277,8 +1324,8 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 		create.liobn, dn);
 
 	win_addr = ((u64)create.addr_hi << 32) | create.addr_lo;
-	ret = ddw_property_create(&win64, DIRECT64_PROPNAME, create.liobn, win_addr,
-				  page_shift, len);
+	ret = ddw_property_create(&win64, DMA64_PROPNAME, create.liobn, win_addr,
+				  page_shift, len, maps_whole_partition);
 	if (ret) {
 		dev_info(&dev->dev,
 			 "couldn't allocate property, property name, or value\n");
@@ -1297,12 +1344,25 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	if (!window)
 		goto out_prop_del;
 
-	ret = walk_system_ram_range(0, memblock_end_of_DRAM() >> PAGE_SHIFT,
-			win64->value, tce_setrange_multi_pSeriesLP_walk);
-	if (ret) {
-		dev_info(&dev->dev, "failed to map direct window for %pOF: %d\n",
-			 dn, ret);
-		goto out_free_window;
+	if (maps_whole_partition) {
+		/* DDW maps the whole partition, so enable direct DMA mapping */
+		ret = walk_system_ram_range(0, memblock_end_of_DRAM() >> PAGE_SHIFT,
+					    win64->value, tce_setrange_multi_pSeriesLP_walk);
+		if (ret) {
+			dev_info(&dev->dev, "failed to map direct window for %pOF: %d\n",
+				 dn, ret);
+			goto out_free_window;
+		}
+	} else {
+		/* New table for using DDW instead of the default DMA window */
+		if (iommu_table_update_window(&tbl, pci->phb->node, create.liobn,
+					      win_addr, page_shift, 1UL << len))
+			goto out_free_window;
+
+		set_iommu_table_base(&dev->dev, tbl);
+		WARN_ON(dev->dev.archdata.dma_offset >= SZ_4G);
+		goto out_unlock;
+
 	}
 
 	dev->dev.archdata.dma_offset = win_addr;
@@ -1340,7 +1400,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 
 out_unlock:
 	mutex_unlock(&direct_window_init_mutex);
-	return win64;
+	return win64 && maps_whole_partition;
 }
 
 static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
-- 
2.25.4

