Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9398FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DCA420768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfvpAWhs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389115AbgFXGYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388090AbgFXGY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:24:29 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD20DC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 23:24:28 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f18so911195qkh.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 23:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CMFU2BrhtzarEHTlDS91rYorAYzikVZA2fEUQUXYMWY=;
        b=WfvpAWhs2WYC4WWEUTiFZpISYUYI/DpY7dZR0ddYZxToPAq7vPqjdQFBK46ye7zvk3
         aZ4mCPICNWCayPHyuGqWQXKajQ181A2JXFEKLFsdiONaX0tU4wHmcu12pEtCiJGiBrTi
         P1G8Uej0O7PdjW33wyGQqF/ANbzz/YvBjxzCRhrAzEm6L1UEZb6LHiDn/yMbQKwxe1//
         KAT1imvFcoihUb6j9Pm5680mooPS0gMscojUMPuEdcM3pPGtasxZohRgC4gTKUK6yfs9
         OQXaz7UWJV6PTjGMWExW1wlD4D/583nXOfhuuuYI1Qa+DYNcSbXAdFmo3naXSTwjBMQI
         Pkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CMFU2BrhtzarEHTlDS91rYorAYzikVZA2fEUQUXYMWY=;
        b=Uah+egnGhzLC2VWfhtBM349utNHbvGmQwG3sVNlwMltZO6x7Ve2I89WwYzJv2pYqAs
         XzcSheST1GzJQKp8OUqJ/r1h6fD5J+xsKCdsoNMP66EKcHmNjKTznqx1YgVdd2B8hAsv
         LaFh8V1AbyzN35mi8SFeXy40gmhpEPP6GE2+TD0aKp78f8k+R0B2rOHzRXvNgoNOvazJ
         FmnRp6bamYJFB+MEKZ9wpFrv86tQd5gNfAnIByuvz8HW6ZxQVES1OVHmBtSot58dUutJ
         dNYfXOOWgprJrH1wrZZD0wdHGLbG+sioQ40N3Jpcda3luQfIhiGCCMnaX4uxkS5wMXLS
         dyzg==
X-Gm-Message-State: AOAM530cBp+/ggPZX086Qi/uh3EiAb+vFn0mwi3hcja6H1e/xf+V9UGM
        S/rSoEmMm9teuI+fNAN4VAs=
X-Google-Smtp-Source: ABdhPJxfrLclol7NIZ2zrLOvD4zRxWIf3XzYTudLlZkyqKW5v1rUXobk5baMtxKEBUV959uOTRegTw==
X-Received: by 2002:a37:7e82:: with SMTP id z124mr1594206qkc.307.1592979868089;
        Tue, 23 Jun 2020 23:24:28 -0700 (PDT)
Received: from LeoBras.ibmuc.com (179-125-148-1.dynamic.desktop.com.br. [179.125.148.1])
        by smtp.gmail.com with ESMTPSA id n2sm2489727qtp.45.2020.06.23.23.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 23:24:27 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] powerpc/pseries/iommu: Create defines for operations in ibm,ddw-applicable
Date:   Wed, 24 Jun 2020 03:24:06 -0300
Message-Id: <20200624062411.367796-2-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200624062411.367796-1-leobras.c@gmail.com>
References: <20200624062411.367796-1-leobras.c@gmail.com>
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
 arch/powerpc/platforms/pseries/iommu.c | 40 +++++++++++++++-----------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 6d47b4a3ce39..68d2aa9c71a8 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -39,6 +39,11 @@
 
 #include "pseries.h"
 
+#define DDW_QUERY_PE_DMA_WIN	0
+#define DDW_CREATE_PE_DMA_WIN	1
+#define DDW_REMOVE_PE_DMA_WIN	2
+#define DDW_APPLICABLE_SIZE	3
+
 static struct iommu_table_group *iommu_pseries_alloc_group(int node)
 {
 	struct iommu_table_group *table_group;
@@ -771,12 +776,12 @@ static void remove_ddw(struct device_node *np, bool remove_prop)
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
@@ -798,15 +803,15 @@ static void remove_ddw(struct device_node *np, bool remove_prop)
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
@@ -889,11 +894,11 @@ static int query_ddw(struct pci_dev *dev, const u32 *ddw_avail,
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
 
@@ -920,15 +925,16 @@ static int create_ddw(struct pci_dev *dev, const u32 *ddw_avail,
 
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
@@ -996,7 +1002,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	int page_shift;
 	u64 dma_addr, max_addr;
 	struct device_node *dn;
-	u32 ddw_avail[3];
+	u32 ddw_avail[DDW_APPLICABLE_SIZE];
 	struct direct_window *window;
 	struct property *win64;
 	struct dynamic_dma_window_prop *ddwprop;
@@ -1029,7 +1035,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	 * the property is actually in the parent, not the PE
 	 */
 	ret = of_property_read_u32_array(pdn, "ibm,ddw-applicable",
-					 &ddw_avail[0], 3);
+					 &ddw_avail[0], DDW_APPLICABLE_SIZE);
 	if (ret)
 		goto out_failed;
 
-- 
2.25.4

