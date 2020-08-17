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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6BFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C2D82065D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiQth7+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgHQXlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 19:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgHQXlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 19:41:23 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33C6C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:41:22 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id i20so2460261qkk.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y7/RxrEgFbiJeIJ6odgzjv0QMFDSvXInIkcTRZMw0eA=;
        b=IiQth7+0e0kRkPXTuZa3ekMLeZ9wkT9s3Y+ETQFOXeUnYOuhb72kf9D0pkNi/MxoLv
         y0fF0bfFWEckv1n1Sw1dBF2Vo5kwVhU8rMuQ01UAMhYYLzt+NzzqSB5QEu4/hwayw9Av
         zB5PCYtduyvUIau6q2mGsAyIAboxD2LdWU2C9KCxddPBcQtiYo0Z+G/cJSqIEmR+YmkT
         /dDMr61Bpazjzj29QTR+S0sTPiH/U+Cg1J2USuYEeF3KFJ0xXvB1wnLK+vsX0wioIF7j
         mhhuxf5PPc6D5sk+e/E36iKhKOEYANPapwK2KXySAGcN7UZfSxl+dDuxC62sje3dLaLZ
         Eulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y7/RxrEgFbiJeIJ6odgzjv0QMFDSvXInIkcTRZMw0eA=;
        b=epvOgnqlyBCQkEINGcxL8G3cE+sKQuVObfyR+BmbkF7cgVcaYozk8sM1V7qg0wxGRK
         /cKffEo2BXknLMd92F7OSilu/LCioJHnN1vPjwZm3MrhkssV/mn4nvTCBorJ1mgCfoy9
         FyxRamW5wzRjTUxTqYVn89orNOodgcHJyN/oAtTambmcS9DTySYE3BbxKCg6+l/xknl1
         BJHZdMxd+zVqxy/RbyQ7EWztBKulYVEUzxKEgbronX4SMFzLrqX9sLAdBODOUE6j1/oj
         o+u6n3Uqpz10CoTGVpdd69y1lkGHlyHXapx3igR2IccP+yGbUH441Eo9QKIdIl5VGppj
         DTxg==
X-Gm-Message-State: AOAM533wwHciBTrp3d4QIx3AXBEm/TINo/ZYzIw9K5PcRZ/LoFOY6oQj
        Bpd6Zf2x5+ECtpp6dDOxHXE=
X-Google-Smtp-Source: ABdhPJw1kObRxpNNPRo2Qby2q/D7S9MPv9OG18YyKtca1zlLVXdtJqtPEqBmEvx+aezgJrJhNuF5zA==
X-Received: by 2002:a37:a293:: with SMTP id l141mr15380301qke.222.1597707682020;
        Mon, 17 Aug 2020 16:41:22 -0700 (PDT)
Received: from LeoBras.ibmuc.com ([177.35.193.93])
        by smtp.gmail.com with ESMTPSA id w58sm22342868qth.95.2020.08.17.16.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 16:41:21 -0700 (PDT)
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
Subject: [PATCH v1 07/10] powerpc/pseries/iommu: Allow DDW windows starting at 0x00
Date:   Mon, 17 Aug 2020 20:40:30 -0300
Message-Id: <20200817234033.442511-8-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200817234033.442511-1-leobras.c@gmail.com>
References: <20200817234033.442511-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enable_ddw() currently returns the address of the DMA window, which is
considered invalid if has the value 0x00.

Also, it only considers valid an address returned from find_existing_ddw
if it's not 0x00.

Changing this behavior makes sense, given the users of enable_ddw() only
need to know if direct mapping is possible. It can also allow a DMA window
starting at 0x00 to be used.

This will be helpful for using a DDW with indirect mapping, as the window
address will be different than 0x00, but it will not map the whole
partition.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 30 ++++++++++++--------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index fcdefcc0f365..4031127c9537 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -852,24 +852,25 @@ static void remove_ddw(struct device_node *np, bool remove_prop)
 			np, ret);
 }
 
-static u64 find_existing_ddw(struct device_node *pdn)
+static bool find_existing_ddw(struct device_node *pdn, u64 *dma_addr)
 {
 	struct direct_window *window;
 	const struct dynamic_dma_window_prop *direct64;
-	u64 dma_addr = 0;
+	bool found = false;
 
 	spin_lock(&direct_window_list_lock);
 	/* check if we already created a window and dupe that config if so */
 	list_for_each_entry(window, &direct_window_list, list) {
 		if (window->device == pdn) {
 			direct64 = window->prop;
-			dma_addr = be64_to_cpu(direct64->dma_base);
+			*dma_addr = be64_to_cpu(direct64->dma_base);
+			found = true;
 			break;
 		}
 	}
 	spin_unlock(&direct_window_list_lock);
 
-	return dma_addr;
+	return found;
 }
 
 static struct direct_window *ddw_list_add(struct device_node *pdn,
@@ -1131,15 +1132,15 @@ static void reset_dma_window(struct pci_dev *dev, struct device_node *par_dn)
  * pdn: the parent pe node with the ibm,dma_window property
  * Future: also check if we can remap the base window for our base page size
  *
- * returns the dma offset for use by the direct mapped DMA code.
+ * returns true if can map all pages (direct mapping), false otherwise..
  */
-static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
+static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 {
 	int len, ret;
 	struct ddw_query_response query;
 	struct ddw_create_response create;
 	int page_shift;
-	u64 dma_addr, max_addr;
+	u64 max_addr;
 	struct device_node *dn;
 	u32 ddw_avail[DDW_APPLICABLE_SIZE];
 	struct direct_window *window;
@@ -1150,8 +1151,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 
 	mutex_lock(&direct_window_init_mutex);
 
-	dma_addr = find_existing_ddw(pdn);
-	if (dma_addr != 0)
+	if (find_existing_ddw(pdn, &dev->dev.archdata.dma_offset))
 		goto out_unlock;
 
 	/*
@@ -1292,7 +1292,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 		goto out_free_window;
 	}
 
-	dma_addr = be64_to_cpu(ddwprop->dma_base);
+	dev->dev.archdata.dma_offset = be64_to_cpu(ddwprop->dma_base);
 	goto out_unlock;
 
 out_free_window:
@@ -1309,6 +1309,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	kfree(win64->name);
 	kfree(win64->value);
 	kfree(win64);
+	win64 = NULL;
 
 out_failed:
 	if (default_win_removed)
@@ -1322,7 +1323,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 
 out_unlock:
 	mutex_unlock(&direct_window_init_mutex);
-	return dma_addr;
+	return win64;
 }
 
 static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
@@ -1401,11 +1402,8 @@ static bool iommu_bypass_supported_pSeriesLP(struct pci_dev *pdev, u64 dma_mask)
 			break;
 	}
 
-	if (pdn && PCI_DN(pdn)) {
-		pdev->dev.archdata.dma_offset = enable_ddw(pdev, pdn);
-		if (pdev->dev.archdata.dma_offset)
-			return true;
-	}
+	if (pdn && PCI_DN(pdn))
+		return enable_ddw(pdev, pdn);
 
 	return false;
 }
-- 
2.25.4

