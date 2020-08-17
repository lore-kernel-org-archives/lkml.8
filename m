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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BF7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECB342065D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iM/ie5bQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgHQXle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 19:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgHQXl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 19:41:27 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D01C061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:41:27 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id t23so13860646qto.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aYwMn+0oPilAHK+vV8/rmnjg2+X7jRFYWM75PHJu/Cg=;
        b=iM/ie5bQNp09TXUXMEblPrgy6XtY+CU+Evf0UQLYSiFZITZ6TKHjMJ1ElgzvbVo+bs
         p0oL2AQB2yrAOo+iebAYzgZ7lKHcAZmtbd/4K+hhmyxrIA3bzA4FphD3m0tb9cWxK/Gx
         rVUFBqZ1iNa65Nagde2OYI+BlaiIj5lFhZeSilwkbuFO1gkstdII9382SPKnrny7k0vZ
         uAZcSkze+Ibn1dt6SCKbP9P0vQ6oXG7L/DYoUz/159qR7P9FFpvMkJt8dG6hVay8Dmlo
         0jVxzLNDhHSQHP6CjUKO6CtTCvHbqnMS3FmYaDB3ZGMzqy+CzXzwjpAdoP5DASCaJdJg
         19pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aYwMn+0oPilAHK+vV8/rmnjg2+X7jRFYWM75PHJu/Cg=;
        b=SyUubqUr40cZS/Ah9lOIfjl646GAeDa4SiYIWzRuwB/TABmEFs9Jxg+dyCH94CYLaZ
         LEXkWvOlK346sDJ1GnKZYzBqKU+C/pA7iWe3okQ2u0kItmJf0OC1J/YjM6rtGxlKEOsZ
         xGsgxK7BRzjcER6Fjp3zlTlnUhegdcPAU8R0i7JY2ZP3I3Y6o78/2gXNj0hj37cfdK7V
         f9t5/j1FSqSEz0dxQPRai5V9ECigDMy3w0gWj5fM07iAVDBBOrm9D48mqgDtSyrCcM+h
         ZUXxu/sG4fjm9Nr6ZQ4jONH20ZvVfLl9O6ol3vehByb3KHbhk+/GlEwjG/obYOEEvxrj
         C18w==
X-Gm-Message-State: AOAM530uJaNPQbUbWuN56s2krbgiA2fPShXlGbZYFvDK2kAg3vo/QBDs
        orxCJecdHc3e76TnaQINWmE=
X-Google-Smtp-Source: ABdhPJzAToPHAUILBdDyMBpP7yC+IL/H8MSyYZRln1pxKeyrurCyCMNR3PlrI0vpc9oNICZk53raPg==
X-Received: by 2002:ac8:5143:: with SMTP id h3mr15375864qtn.229.1597707686875;
        Mon, 17 Aug 2020 16:41:26 -0700 (PDT)
Received: from LeoBras.ibmuc.com ([177.35.193.93])
        by smtp.gmail.com with ESMTPSA id w58sm22342868qth.95.2020.08.17.16.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 16:41:26 -0700 (PDT)
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
Subject: [PATCH v1 08/10] powerpc/pseries/iommu: Add ddw_property_create() and refactor enable_ddw()
Date:   Mon, 17 Aug 2020 20:40:31 -0300
Message-Id: <20200817234033.442511-9-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200817234033.442511-1-leobras.c@gmail.com>
References: <20200817234033.442511-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code used to create a ddw property that was previously scattered in
enable_ddw() is now gathered in ddw_property_create(), which deals with
allocation and filling the property, letting it ready for
of_property_add(), which now occurs in sequence.

This created an opportunity to reorganize the second part of enable_ddw():

Without this patch enable_ddw() does, in order:
kzalloc() property & members, create_ddw(), fill ddwprop inside property,
ddw_list_add(), do tce_setrange_multi_pSeriesLP_walk in all memory,
of_add_property().

With this patch enable_ddw() does, in order:
create_ddw(), ddw_property_create(), of_add_property(), ddw_list_add(),
do tce_setrange_multi_pSeriesLP_walk in all memory.

This change requires of_remove_property() in case anything fails after
of_add_property(), but we get to do tce_setrange_multi_pSeriesLP_walk
in all memory, which looks the most expensive operation, only if
everything else succeeds.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 97 +++++++++++++++-----------
 1 file changed, 57 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 4031127c9537..3a1ef02ad9d5 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1123,6 +1123,31 @@ static void reset_dma_window(struct pci_dev *dev, struct device_node *par_dn)
 			 ret);
 }
 
+static int ddw_property_create(struct property **ddw_win, const char *propname,
+			       u32 liobn, u64 dma_addr, u32 page_shift, u32 window_shift)
+{
+	struct dynamic_dma_window_prop *ddwprop;
+	struct property *win64;
+
+	*ddw_win = win64 = kzalloc(sizeof(*win64), GFP_KERNEL);
+	if (!win64)
+		return -ENOMEM;
+
+	win64->name = kstrdup(propname, GFP_KERNEL);
+	ddwprop = kzalloc(sizeof(*ddwprop), GFP_KERNEL);
+	win64->value = ddwprop;
+	win64->length = sizeof(*ddwprop);
+	if (!win64->name || !win64->value)
+		return -ENOMEM;
+
+	ddwprop->liobn = cpu_to_be32(liobn);
+	ddwprop->dma_base = cpu_to_be64(dma_addr);
+	ddwprop->tce_shift = cpu_to_be32(page_shift);
+	ddwprop->window_shift = cpu_to_be32(window_shift);
+
+	return 0;
+}
+
 /*
  * If the PE supports dynamic dma windows, and there is space for a table
  * that can map all pages in a linear offset, then setup such a table,
@@ -1140,12 +1165,11 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	struct ddw_query_response query;
 	struct ddw_create_response create;
 	int page_shift;
-	u64 max_addr;
+	u64 max_addr, win_addr;
 	struct device_node *dn;
 	u32 ddw_avail[DDW_APPLICABLE_SIZE];
 	struct direct_window *window;
-	struct property *win64;
-	struct dynamic_dma_window_prop *ddwprop;
+	struct property *win64 = NULL;
 	struct failed_ddw_pdn *fpdn;
 	bool default_win_removed = false;
 
@@ -1244,38 +1268,34 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 		goto out_failed;
 	}
 	len = order_base_2(max_addr);
-	win64 = kzalloc(sizeof(struct property), GFP_KERNEL);
-	if (!win64) {
-		dev_info(&dev->dev,
-			"couldn't allocate property for 64bit dma window\n");
+
+	ret = create_ddw(dev, ddw_avail, &create, page_shift, len);
+	if (ret != 0)
 		goto out_failed;
-	}
-	win64->name = kstrdup(DIRECT64_PROPNAME, GFP_KERNEL);
-	win64->value = ddwprop = kmalloc(sizeof(*ddwprop), GFP_KERNEL);
-	win64->length = sizeof(*ddwprop);
-	if (!win64->name || !win64->value) {
+
+	dev_dbg(&dev->dev, "created tce table LIOBN 0x%x for %pOF\n",
+		create.liobn, dn);
+
+	win_addr = ((u64)create.addr_hi << 32) | create.addr_lo;
+	ret = ddw_property_create(&win64, DIRECT64_PROPNAME, create.liobn, win_addr,
+				  page_shift, len);
+	if (ret) {
 		dev_info(&dev->dev,
-			"couldn't allocate property name and value\n");
+			 "couldn't allocate property, property name, or value\n");
 		goto out_free_prop;
 	}
 
-	ret = create_ddw(dev, ddw_avail, &create, page_shift, len);
-	if (ret != 0)
+	ret = of_add_property(pdn, win64);
+	if (ret) {
+		dev_err(&dev->dev, "unable to add dma window property for %pOF: %d",
+			pdn, ret);
 		goto out_free_prop;
-
-	ddwprop->liobn = cpu_to_be32(create.liobn);
-	ddwprop->dma_base = cpu_to_be64(((u64)create.addr_hi << 32) |
-			create.addr_lo);
-	ddwprop->tce_shift = cpu_to_be32(page_shift);
-	ddwprop->window_shift = cpu_to_be32(len);
-
-	dev_dbg(&dev->dev, "created tce table LIOBN 0x%x for %pOF\n",
-		  create.liobn, dn);
+	}
 
 	/* Add new window to existing DDW list */
-	window = ddw_list_add(pdn, ddwprop);
+	window = ddw_list_add(pdn, win64->value);
 	if (!window)
-		goto out_clear_window;
+		goto out_prop_del;
 
 	ret = walk_system_ram_range(0, memblock_end_of_DRAM() >> PAGE_SHIFT,
 			win64->value, tce_setrange_multi_pSeriesLP_walk);
@@ -1285,14 +1305,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 		goto out_free_window;
 	}
 
-	ret = of_add_property(pdn, win64);
-	if (ret) {
-		dev_err(&dev->dev, "unable to add dma window property for %pOF: %d",
-			 pdn, ret);
-		goto out_free_window;
-	}
-
-	dev->dev.archdata.dma_offset = be64_to_cpu(ddwprop->dma_base);
+	dev->dev.archdata.dma_offset = win_addr;
 	goto out_unlock;
 
 out_free_window:
@@ -1302,14 +1315,18 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 
 	kfree(window);
 
-out_clear_window:
-	remove_ddw(pdn, true);
+out_prop_del:
+	of_remove_property(pdn, win64);
 
 out_free_prop:
-	kfree(win64->name);
-	kfree(win64->value);
-	kfree(win64);
-	win64 = NULL;
+	if (win64) {
+		kfree(win64->name);
+		kfree(win64->value);
+		kfree(win64);
+		win64 = NULL;
+	}
+
+	remove_ddw(pdn, true);
 
 out_failed:
 	if (default_win_removed)
-- 
2.25.4

