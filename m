Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B36C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 03:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21B22207FC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 03:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tsDrwsn6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgHEDFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 23:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHEDFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 23:05:10 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CC6C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 20:05:10 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id d27so32662384qtg.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 20:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KZZhp6G/Nvdr8CubS5lc2IdWicGU//2bZ5AuIAz3WYY=;
        b=tsDrwsn6dw9H9iUUR3XvrWEQiOYRfexsj6w/btAB7+ZzsHuM2fIRTkEUdV2w0KaSFC
         h+IX6i/BpNognd2NP9nnDY28By5W++Z9D1wKijXnSEaKeFvsTyoAQiSC0GISyOn6VkO6
         /izKrL2Lw4lhEwm6j0911VfV/BfOxL8Vu4qTPLxz8EnxznS8EDelcL5ChjBKc0CIhK6a
         50HRa/GfTvzfXdeWKBrxjr9rpKlMUeXzixQoKOKKe2vjT43XaBcKASUqXJsFWR23r4Uo
         c3RAWn0op7UzU+dPXtz4YMyCP/dtAAUsvsAZkbdQ36dh7Ap8Fj2FoLUVktHDcd6czgfh
         eN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KZZhp6G/Nvdr8CubS5lc2IdWicGU//2bZ5AuIAz3WYY=;
        b=Z0UtNOwjDYIVENb3+S9dGEngSTRAFZdrnYruRsyeYkmUgaY601tIeBFqKdnOKhkIKT
         R302mwFyTXkvCXuTKrNM7EluZkv/L3gQS8hEnhcvoSloOLknc0Yy6mr+E3S6synnWK9s
         NWxEJkTSBiJdjX/P1FqvGkxyl/OQsIjdM1fSLWHSOw+888Ju7ELNZ7WD0ALIyILNhUPH
         r4IzSajCssIidbTtEpq7LoT2UotqdbI+FAXAm62HUgWi7Qdo/GFyqY/CifnW9IPhowqj
         Lqqss4Efh424Ut+eqt/fzf1r8OUPsLjj8LZ3j0/PBJDE50LinIlO4jUeU5jUtUfRtgNY
         ling==
X-Gm-Message-State: AOAM532CI4Q+vDh2V6fGq7r7Nk50Lk28G4RoejLE/V8WQ4LtwhfyOIHQ
        0aB+yV0jXpdkWHZl8AyiOnw=
X-Google-Smtp-Source: ABdhPJwEJlDXMiqIxjJ8NWBXOAzyEnPfjVEOVS1TpGiB9pkJhcOwymUcwPehjylHnqE+u6vPhAyQIA==
X-Received: by 2002:ac8:4643:: with SMTP id f3mr1275598qto.128.1596596709387;
        Tue, 04 Aug 2020 20:05:09 -0700 (PDT)
Received: from LeoBras.ibmuc.com (179-125-154-168.dynamic.desktop.com.br. [179.125.154.168])
        by smtp.gmail.com with ESMTPSA id n4sm869946qtr.73.2020.08.04.20.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 20:05:08 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        Murilo Fossa Vicentini <muvic@linux.ibm.com>,
        David Dai <zdai@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] powerpc/pseries/iommu: Create defines for operations in ibm,ddw-applicable
Date:   Wed,  5 Aug 2020 00:04:52 -0300
Message-Id: <20200805030455.123024-2-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200805030455.123024-1-leobras.c@gmail.com>
References: <20200805030455.123024-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create defines to help handling ibm,ddw-applicable values, avoiding
confusion about the index of given operations.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
Tested-by: David Dai <zdai@linux.vnet.ibm.com>
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

