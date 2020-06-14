Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E42C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 23:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6651206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 23:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LMhTh5pw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgFNXdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 19:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbgFNXdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 19:33:44 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08479C05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 16:33:43 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id r15so11813183qvv.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 16:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=M2MXt5Il/BsNFktk3okT7g4F0dfmoWdEqcRIPAnRbcE=;
        b=LMhTh5pw/U9JHefpcHbqjU28o+dW5UwGRfLxdZj6h3yircs/tFdPEwuAoVMPym+D2H
         2nVqctN8LfoUOBk5YighPEV/mCNAC/m1YboG1mSI/PygF7GX0KUSlKJZXLr7d5Tx3yvg
         rPniKBWfxAa1MuqfBiLu0AOyIGV43+aLyM7wlNDJxTUtDoIkWQrIYz0K0CD+3ow7LZKx
         ks66+s3dqpIfp8aQCS6H65e7HRt1TqTPDkCz/fqCYsiVgND1dwI88KpYeeUMtEx3pJ0m
         o8PimNT5CPRZ+qmIpnUfpSd5RG9yRGgZxYxUaZlPQEL0FXkeR3v/oexeUJ1GF1dJMCFQ
         90Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M2MXt5Il/BsNFktk3okT7g4F0dfmoWdEqcRIPAnRbcE=;
        b=TaN4HT+2JX01RqtTl8DSWjLvtOe1jJmHmMwyTT+KtARSyUOSQ3OX3pzOv0o3XHLPy6
         MNGOQDGhIzubIjwZ8bTErBYfbQFrMXgKIMMdTVHE7PUc5re4D6Ld+e+uYao203aqFTXn
         8tExCptAayGQXldMqOSQ5EKhl/VgN0ibz1eYdW1832fQvh9/wus1hz6grqKEAuL0ZLCl
         aGv9NtKoA0UDHPb1DoA5lqizvYoFeDYQxtHSDUBRqLVdOso1vcaypxdUIOgUuoEHT5tz
         6d0M2BE3zsdUTn8AM/K4zp+HD7DztkWVN37DjEGezOR4LFnSqnaORu29NDQW1eI9yP3s
         M/8g==
X-Gm-Message-State: AOAM533yWlzWU8B8keRMaTwuUryfoxxfiulXfwCfDIKD43k/XOkYQAQI
        9rJqVg0XQ632IDbx/6+2oP3wbfYYj/7n
X-Google-Smtp-Source: ABdhPJwcegGqbyBBA1s0w1TiQ5GxpX+dkThjZc32fm5s8iotpcYRgj8qDbwc/HlMdycgbTnpx3KF/RxHIkCj
X-Received: by 2002:a0c:ee41:: with SMTP id m1mr21625569qvs.95.1592177622244;
 Sun, 14 Jun 2020 16:33:42 -0700 (PDT)
Date:   Sun, 14 Jun 2020 16:32:35 -0700
In-Reply-To: <37af499e-2b8b-7e78-ed4b-0aaf711fcb38@csgroup.eu>
Message-Id: <20200614233235.121432-1-gthelen@google.com>
Mime-Version: 1.0
References: <37af499e-2b8b-7e78-ed4b-0aaf711fcb38@csgroup.eu>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH v2] powerpc/powernv/pci: use ifdef to avoid dead code
From:   Greg Thelen <gthelen@google.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Oliver O'Halloran" <oohall@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit dc3d8f85bb57 ("powerpc/powernv/pci: Re-work bus PE
configuration") removed a couple pnv_ioda_setup_bus_dma() calls.  The
only remaining calls are behind CONFIG_IOMMU_API.  Thus builds without
CONFIG_IOMMU_API see:
  arch/powerpc/platforms/powernv/pci-ioda.c:1888:13: error: 'pnv_ioda_setup_bus_dma' defined but not used

Move pnv_ioda_setup_bus_dma() under CONFIG_IOMMU_API to avoid dead code.

Fixes: dc3d8f85bb57 ("powerpc/powernv/pci: Re-work bus PE configuration")
Signed-off-by: Greg Thelen <gthelen@google.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 26 +++++++++++------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 73a63efcf855..743d840712da 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1885,19 +1885,6 @@ static bool pnv_pci_ioda_iommu_bypass_supported(struct pci_dev *pdev,
 	return false;
 }
 
-static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		set_iommu_table_base(&dev->dev, pe->table_group.tables[0]);
-		dev->dev.archdata.dma_offset = pe->tce_bypass_base;
-
-		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
-			pnv_ioda_setup_bus_dma(pe, dev->subordinate);
-	}
-}
-
 static inline __be64 __iomem *pnv_ioda_get_inval_reg(struct pnv_phb *phb,
 						     bool real_mode)
 {
@@ -2501,6 +2488,19 @@ static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
 #endif
 
 #ifdef CONFIG_IOMMU_API
+static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		set_iommu_table_base(&dev->dev, pe->table_group.tables[0]);
+		dev->dev.archdata.dma_offset = pe->tce_bypass_base;
+
+		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
+			pnv_ioda_setup_bus_dma(pe, dev->subordinate);
+	}
+}
+
 unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
 		__u64 window_size, __u32 levels)
 {
-- 
2.27.0.290.gba653c62da-goog

