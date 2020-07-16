Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C710C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00AA32070E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNuVGX+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgGPHRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgGPHRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:17:31 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F364C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:17:31 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id a14so2268734qvq.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iAqnNzgFRUJx+axzGrs6hmhSszYF3MKAI0YBJIy15+s=;
        b=QNuVGX+4RyNI9YC4SaLljMp+QrrYUbX430DdkseBtu6+PN0usSwBJvHqkjKGnjk8ju
         RWlkxyjo+bboNqJcWt/C67//vpFpnYugmb3B1a6u7YQHFJzkXQleWlG4ko5SZEZ61kr3
         1ABWWBLTzPCo+TtuKBWkEiM8JkY+zXMMt+x/3ZXGIRXIlMJ4a7/cPzYXzD5HOdYeqxgR
         DH95Bi3r4IShIkc0eQenlN7qRrs/c7v1yudjFE9sNCUadpjF0qRfh973IQTTYHIn7Kz2
         bQQWdHMG80YBmtsp1tbHaJ8OoXTQTTHU67PW/TDxhlQ87r8NW2rDL/JNo2ychk02i0u/
         l1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iAqnNzgFRUJx+axzGrs6hmhSszYF3MKAI0YBJIy15+s=;
        b=ECWVbMk8B890pftSKYbfzRD/Sb4uesDfcAqeLtINEDJitbr2OXM1shK3Fb+XqkPuB3
         LlbyUwzf29CKYrJ/o+fv12wCqser+s8uv+66Tpdt41+FxbYCmsJDi47yIDX0PUYFR9D3
         /K/w2Ag+m4PPF3rmWzrI0xNCEEEncqXB1S/ozEm4/oxeHhDFmCoXtcAu88otUdgJqw/U
         13azZDy6M8FtL6RA13Rcf8EFRufjgPOludEBBG4c3/4DbJ+IRVKTUhisEy+O4AWFL3wd
         zTVQ8NNhWR88P5bwfNgkzGbf8Lr7rzBBjarHf/jD5woADwl5BSh7lpJyiGYLyAtnJMUw
         JfzQ==
X-Gm-Message-State: AOAM530DpaoBQgRvjAeXpYWWCNIiUYFAxznGfwS5JykauyJ5qEy0NrzI
        EN/GxH6nX1wZFgav+ThIpN8=
X-Google-Smtp-Source: ABdhPJw2GKOBko+flx5fkZ8LWvwrLx3P5cJqeCZmrje3tHzkWdb3XvdmXOG+43rGvqThgoaoXEJ3Fw==
X-Received: by 2002:ad4:4672:: with SMTP id z18mr3063449qvv.104.1594883850434;
        Thu, 16 Jul 2020 00:17:30 -0700 (PDT)
Received: from LeoBras.ibmuc.com (200-236-239-31.dynamic.desktop.com.br. [200.236.239.31])
        by smtp.gmail.com with ESMTPSA id a5sm6637989qtd.84.2020.07.16.00.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 00:17:29 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Leonardo Bras <leobras.c@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/7] powerpc/pseries/iommu: Create defines for operations in ibm,ddw-applicable
Date:   Thu, 16 Jul 2020 04:16:53 -0300
Message-Id: <20200716071658.467820-2-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200716071658.467820-1-leobras.c@gmail.com>
References: <20200716071658.467820-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create defines to help handling ibm,ddw-applicable values, avoiding
confusion about the index of given operations.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 43 ++++++++++++++++----------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 6d47b4a3ce39..ac0d6376bdad 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -39,6 +39,14 @@
 
 #include "pseries.h"
 
+enum {
+	DDW_QUERY_PE_DMA_WIN  = 0,
+	DDW_CREATE_PE_DMA_WIN = 1,
+	DDW_REMOVE_PE_DMA_WIN = 2,
+
+	DDW_APPLICABLE_SIZE
+};
+
 static struct iommu_table_group *iommu_pseries_alloc_group(int node)
 {
 	struct iommu_table_group *table_group;
@@ -771,12 +779,12 @@ static void remove_ddw(struct device_node *np, bool remove_prop)
 {
 	struct dynamic_dma_window_prop *dwp;
 	struct property *win64;
-	u32 ddw_avail[3];
+	u32 ddw_avail[DDW_APPLICABLE_SIZE];
 	u64 liobn;
 	int ret = 0;
 
 	ret = of_property_read_u32_array(np, "ibm,ddw-applicable",
-					 &ddw_avail[0], 3);
+					 &ddw_avail[0], DDW_APPLICABLE_SIZE);
 
 	win64 = of_find_property(np, DIRECT64_PROPNAME, NULL);
 	if (!win64)
@@ -798,15 +806,15 @@ static void remove_ddw(struct device_node *np, bool remove_prop)
 		pr_debug("%pOF successfully cleared tces in window.\n",
 			 np);
 
-	ret = rtas_call(ddw_avail[2], 1, 1, NULL, liobn);
+	ret = rtas_call(ddw_avail[DDW_REMOVE_PE_DMA_WIN], 1, 1, NULL, liobn);
 	if (ret)
 		pr_warn("%pOF: failed to remove direct window: rtas returned "
 			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
-			np, ret, ddw_avail[2], liobn);
+			np, ret, ddw_avail[DDW_REMOVE_PE_DMA_WIN], liobn);
 	else
 		pr_debug("%pOF: successfully removed direct window: rtas returned "
 			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
-			np, ret, ddw_avail[2], liobn);
+			np, ret, ddw_avail[DDW_REMOVE_PE_DMA_WIN], liobn);
 
 delprop:
 	if (remove_prop)
@@ -889,11 +897,11 @@ static int query_ddw(struct pci_dev *dev, const u32 *ddw_avail,
 	buid = pdn->phb->buid;
 	cfg_addr = ((pdn->busno << 16) | (pdn->devfn << 8));
 
-	ret = rtas_call(ddw_avail[0], 3, 5, (u32 *)query,
-		  cfg_addr, BUID_HI(buid), BUID_LO(buid));
+	ret = rtas_call(ddw_avail[DDW_QUERY_PE_DMA_WIN], 3, 5, (u32 *)query,
+			cfg_addr, BUID_HI(buid), BUID_LO(buid));
 	dev_info(&dev->dev, "ibm,query-pe-dma-windows(%x) %x %x %x"
-		" returned %d\n", ddw_avail[0], cfg_addr, BUID_HI(buid),
-		BUID_LO(buid), ret);
+		" returned %d\n", ddw_avail[DDW_QUERY_PE_DMA_WIN], cfg_addr,
+		 BUID_HI(buid), BUID_LO(buid), ret);
 	return ret;
 }
 
@@ -920,15 +928,16 @@ static int create_ddw(struct pci_dev *dev, const u32 *ddw_avail,
 
 	do {
 		/* extra outputs are LIOBN and dma-addr (hi, lo) */
-		ret = rtas_call(ddw_avail[1], 5, 4, (u32 *)create,
-				cfg_addr, BUID_HI(buid), BUID_LO(buid),
-				page_shift, window_shift);
+		ret = rtas_call(ddw_avail[DDW_CREATE_PE_DMA_WIN], 5, 4,
+				(u32 *)create, cfg_addr, BUID_HI(buid),
+				BUID_LO(buid), page_shift, window_shift);
 	} while (rtas_busy_delay(ret));
 	dev_info(&dev->dev,
 		"ibm,create-pe-dma-window(%x) %x %x %x %x %x returned %d "
-		"(liobn = 0x%x starting addr = %x %x)\n", ddw_avail[1],
-		 cfg_addr, BUID_HI(buid), BUID_LO(buid), page_shift,
-		 window_shift, ret, create->liobn, create->addr_hi, create->addr_lo);
+		"(liobn = 0x%x starting addr = %x %x)\n",
+		 ddw_avail[DDW_CREATE_PE_DMA_WIN], cfg_addr, BUID_HI(buid),
+		 BUID_LO(buid), page_shift, window_shift, ret, create->liobn,
+		 create->addr_hi, create->addr_lo);
 
 	return ret;
 }
@@ -996,7 +1005,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	int page_shift;
 	u64 dma_addr, max_addr;
 	struct device_node *dn;
-	u32 ddw_avail[3];
+	u32 ddw_avail[DDW_APPLICABLE_SIZE];
 	struct direct_window *window;
 	struct property *win64;
 	struct dynamic_dma_window_prop *ddwprop;
@@ -1029,7 +1038,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	 * the property is actually in the parent, not the PE
 	 */
 	ret = of_property_read_u32_array(pdn, "ibm,ddw-applicable",
-					 &ddw_avail[0], 3);
+					 &ddw_avail[0], DDW_APPLICABLE_SIZE);
 	if (ret)
 		goto out_failed;
 
-- 
2.25.4

