Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF26AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97531204EA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNo19FdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgGCGUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 02:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgGCGUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 02:20:16 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA252C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 23:20:15 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id o38so23170563qtf.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 23:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mebfXUtgaF/P3pmBuzX+FN6HkwkE/UkBA4RJBwCTdYQ=;
        b=nNo19FdNnZwS2E7l14OE/wUz44LBZiosT6Pg1BNcVkLOTntzD+AyXRd8t78T3qky2X
         xP0/afRzvUtk9Zu4y2odECbcZiz7PhtZz0dsgwtU/umAZLABm8C1G1D6NgSr9oxbw+2G
         FrNU8kzkG6LPejKumP07y8O5F+HM35+KCyeJJJnRr1FZca60W8iP2Qm3lUEGjfqorYbN
         rhyiqs3wvXVme5vbY2ryz10jYOhZSIl2U8XmkYm54XiFiKpsespS4CAkuTNT+dQPf17n
         oegWey2RKtrMQfJWuBaBhqmBNP/Asx7B465eJHTIjJKwbr2gEaPVCEdWxAqFIR81nJ3j
         847Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mebfXUtgaF/P3pmBuzX+FN6HkwkE/UkBA4RJBwCTdYQ=;
        b=TCrtb/cqJaenfwWcHdpYrVmdsJeh2v4EvRBaGSiXdke8RWtZ6jeh0U/72O/uhNIdd0
         DIf43KUK3NSigTN7Hn5BS4FTmn1ysBkHySqgvY42I55Fxa3okhyjFfSstDI3/sOeNDvk
         /DUTKnGXsCdEkHO7ASmQ17FtzEqdpmikJ4knmSlD08WfnoIVq7hmNyA7fBXHCMy3ay3/
         Tf+LrJ8TevIsCp/6NT/bxOEe68O40aEI4yCWIOtUlXrhyXotOExl8dXvcdNuu6SO2THJ
         D7zyV79ufB9gMLHrRsP8BOZjmE2387639yH+YqWjnVSLAbHViZGK4L6LNS/uyx7Y8Bf6
         +8LQ==
X-Gm-Message-State: AOAM532+uNuYPKlv1qhkGnrpYCENlTuhW63rizWbHEwt73CEqP9w7xrm
        SeWJ8locFjKhiNKNyAZI6QI=
X-Google-Smtp-Source: ABdhPJwGsydAo1kbJV7jvYNFRuekEWo1wvgiqF836x62uv3sD9ZI5HpKdBrU7yO5niI5XNMElrq5kw==
X-Received: by 2002:ac8:228b:: with SMTP id f11mr27607319qta.342.1593757215083;
        Thu, 02 Jul 2020 23:20:15 -0700 (PDT)
Received: from LeoBras.ibmuc.com (200-236-245-17.dynamic.desktop.com.br. [200.236.245.17])
        by smtp.gmail.com with ESMTPSA id n28sm11165288qtf.8.2020.07.02.23.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 23:20:14 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Leonardo Bras <leobras.c@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] powerpc/pseries/iommu: Make use of DDW even if it does not map the partition
Date:   Fri,  3 Jul 2020 03:18:43 -0300
Message-Id: <20200703061844.111865-6-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200703061844.111865-1-leobras.c@gmail.com>
References: <20200703061844.111865-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of today, if the biggest DDW that can be created can't map the whole
partition, it's creation is skipped and the default DMA window
"ibm,dma-window" is used instead.

Usually this DDW is bigger than the default DMA window, and it performs
better, so it would be nice to use it instead.

The ddw created will be used for direct mapping by default.
If it's not available, indirect mapping sill be used instead.

As there will never have both mappings at the same time, the same property
name can be used for the created DDW.

So renaming
define DIRECT64_PROPNAME "linux,direct64-ddr-window-info"
to
define DMA64_PROPNAME "linux,dma64-ddr-window-info"
looks the right thing to do.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 38 ++++++++++++++++----------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 5b520ac354c6..c652177de09c 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -364,7 +364,7 @@ static LIST_HEAD(direct_window_list);
 static DEFINE_SPINLOCK(direct_window_list_lock);
 /* protects initializing window twice for same device */
 static DEFINE_MUTEX(direct_window_init_mutex);
-#define DIRECT64_PROPNAME "linux,direct64-ddr-window-info"
+#define DMA64_PROPNAME "linux,dma64-ddr-window-info"
 
 static int tce_clearrange_multi_pSeriesLP(unsigned long start_pfn,
 					unsigned long num_pfn, const void *arg)
@@ -690,7 +690,7 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 	struct iommu_table *tbl;
 	struct device_node *dn, *pdn;
 	struct pci_dn *ppci;
-	const __be32 *dma_window = NULL;
+	const __be32 *dma_window = NULL, *alt_dma_window = NULL;
 
 	dn = pci_bus_to_OF_node(bus);
 
@@ -704,8 +704,13 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 			break;
 	}
 
+	/* If there is a DDW available, use it instead */
+	alt_dma_window = of_get_property(pdn, DMA64_PROPNAME, NULL);
+	if (alt_dma_window)
+		dma_window = alt_dma_window;
+
 	if (dma_window == NULL) {
-		pr_debug("  no ibm,dma-window property !\n");
+		pr_debug("  no ibm,dma-window nor linux,dma64-ddr-window-info property !\n");
 		return;
 	}
 
@@ -823,7 +828,7 @@ static void remove_ddw(struct device_node *np, bool remove_prop)
 	if (ret)
 		return;
 
-	win = of_find_property(np, DIRECT64_PROPNAME, NULL);
+	win = of_find_property(np, DMA64_PROPNAME, NULL);
 	if (!win)
 		return;
 
@@ -869,8 +874,8 @@ static int find_existing_ddw_windows(void)
 	if (!firmware_has_feature(FW_FEATURE_LPAR))
 		return 0;
 
-	for_each_node_with_property(pdn, DIRECT64_PROPNAME) {
-		direct64 = of_get_property(pdn, DIRECT64_PROPNAME, &len);
+	for_each_node_with_property(pdn, DMA64_PROPNAME) {
+		direct64 = of_get_property(pdn, DMA64_PROPNAME, &len);
 		if (!direct64)
 			continue;
 
@@ -1205,23 +1210,26 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 			  query.page_size);
 		goto out_restore_defwin;
 	}
+
 	/* verify the window * number of ptes will map the partition */
-	/* check largest block * page size > max memory hotplug addr */
 	max_addr = ddw_memory_hotplug_max();
 	if (query.largest_available_block < (max_addr >> page_shift)) {
-		dev_dbg(&dev->dev, "can't map partition max 0x%llx with %llu "
-			  "%llu-sized pages\n", max_addr,  query.largest_available_block,
-			  1ULL << page_shift);
-		goto out_restore_defwin;
+		dev_dbg(&dev->dev, "can't map partition max 0x%llx with %llu %llu-sized pages\n",
+			max_addr, query.largest_available_block,
+			1ULL << page_shift);
+
+		len = order_base_2(query.largest_available_block << page_shift);
+	} else {
+		len = order_base_2(max_addr);
 	}
-	len = order_base_2(max_addr);
+
 	win64 = kzalloc(sizeof(struct property), GFP_KERNEL);
 	if (!win64) {
 		dev_info(&dev->dev,
 			"couldn't allocate property for 64bit dma window\n");
 		goto out_restore_defwin;
 	}
-	win64->name = kstrdup(DIRECT64_PROPNAME, GFP_KERNEL);
+	win64->name = kstrdup(DMA64_PROPNAME, GFP_KERNEL);
 	win64->value = ddwprop = kmalloc(sizeof(*ddwprop), GFP_KERNEL);
 	win64->length = sizeof(*ddwprop);
 	if (!win64->name || !win64->value) {
@@ -1268,7 +1276,9 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	list_add(&window->list, &direct_window_list);
 	spin_unlock(&direct_window_list_lock);
 
-	dma_addr = be64_to_cpu(ddwprop->dma_base);
+	/* Only returns the dma_addr if DDW maps the whole partition */
+	if (len == order_base_2(max_addr))
+		dma_addr = be64_to_cpu(ddwprop->dma_base);
 	goto out_unlock;
 
 out_free_window:
-- 
2.25.4

