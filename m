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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1E9C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 977EF2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxWjW/D7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgHQXlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 19:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgHQXk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 19:40:59 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910DCC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:40:59 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id x12so13873241qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RjgwGRxdBS3CJp5E+JEkyraM8vOppBs1YDLxTK5wbyg=;
        b=UxWjW/D7rIwoPmW420O/n0NNF2zEDTI34NFG87JTiOdOvC5B3kQxYtmdI62uwMRemR
         koDJdeZn0jAMWHHk5IzB2JfCsnZZ9uJ/TWwEDbLBbMcjdGqk3ad3IJeN4VQMJ49rZhMh
         mY5L/jyj1WGawxCrVwsH1n+zzg5h3HPonmKBwJSYbj2nW9YtC7l0dwV8yvnZy2+PT/yf
         fEKOCKbyR8PbwIlwm0t3YxZyRgL/u1Sn1TE9aCCtXnnm3bgQu5Ir9Qehma05SMTIM/YV
         O6QAvmh+g/gmVldFeNusreKYPq3c1FlFQU62KLjYpNmtdGnlLVKq+h+UkkQA0ZVk+aPa
         O1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RjgwGRxdBS3CJp5E+JEkyraM8vOppBs1YDLxTK5wbyg=;
        b=MfMMkCn2Hlmn0K+0AS8ypti4zFrP0sKy/TjcQqpSwWmF05Vu8JV7HvK2kKAY4smjV7
         fJIUvsAjjNw2CZIPplNA77Q3bqWtANAgKP0+wsC2EavU+IAyyZsrnuMj+cWwWOCPiGOy
         gYCZem+7pmvJItm3upL6ZcFs5Pkdp/kMzoIXQc7XMiVZgL/Of8XRVhSb1C5tLjMvD+b2
         F5H7pSPymHRIiEb0oW6RvyDcYq+Z9dYG8Y6QUrR9kz4j1W/5x3sBU2INH4969CGNCCXS
         nSxvXpNe58eDwXWEVwfewI3e89e/Y3WJMTae4AUSCRCzzo62GJyd1oRpMdMmHMyZPpC5
         +1uw==
X-Gm-Message-State: AOAM531oaG/lQXswjGDnovkP0fZIJradKdDL12wbQKWkaP9SpL1kCpMP
        EgGf9lP8nBGyUsz8rSP+EUc=
X-Google-Smtp-Source: ABdhPJwdtEVA+ecpCjAMtBhx9QjPLpaTD1ltjRMZO2bzmBNbk9dq2e7IckM4wM1jw6K8XvzXc1OexQ==
X-Received: by 2002:aed:36c8:: with SMTP id f66mr15680464qtb.6.1597707658747;
        Mon, 17 Aug 2020 16:40:58 -0700 (PDT)
Received: from LeoBras.ibmuc.com ([177.35.193.93])
        by smtp.gmail.com with ESMTPSA id w58sm22342868qth.95.2020.08.17.16.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 16:40:58 -0700 (PDT)
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
Subject: [PATCH v1 02/10] powerpc/kernel/iommu: Align size for IOMMU_PAGE_SIZE on iommu_*_coherent()
Date:   Mon, 17 Aug 2020 20:40:25 -0300
Message-Id: <20200817234033.442511-3-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200817234033.442511-1-leobras.c@gmail.com>
References: <20200817234033.442511-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both iommu_alloc_coherent() and iommu_free_coherent() assume that once
size is aligned to PAGE_SIZE it will be aligned to IOMMU_PAGE_SIZE.

Update those functions to guarantee alignment with requested size
using IOMMU_PAGE_ALIGN() before doing iommu_alloc() / iommu_free().

Also, on iommu_range_alloc(), replace ALIGN(n, 1 << tbl->it_page_shift)
with IOMMU_PAGE_ALIGN(n, tbl), which seems easier to read.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/kernel/iommu.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 9704f3f76e63..d7086087830f 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -237,10 +237,9 @@ static unsigned long iommu_range_alloc(struct device *dev,
 	}
 
 	if (dev)
-		boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
-				      1 << tbl->it_page_shift);
+		boundary_size = IOMMU_PAGE_ALIGN(dma_get_seg_boundary(dev) + 1, tbl);
 	else
-		boundary_size = ALIGN(1UL << 32, 1 << tbl->it_page_shift);
+		boundary_size = IOMMU_PAGE_ALIGN(1UL << 32, tbl);
 	/* 4GB boundary for iseries_hv_alloc and iseries_hv_map */
 
 	n = iommu_area_alloc(tbl->it_map, limit, start, npages, tbl->it_offset,
@@ -858,6 +857,7 @@ void *iommu_alloc_coherent(struct device *dev, struct iommu_table *tbl,
 	unsigned int order;
 	unsigned int nio_pages, io_order;
 	struct page *page;
+	size_t size_io = size;
 
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
@@ -884,8 +884,9 @@ void *iommu_alloc_coherent(struct device *dev, struct iommu_table *tbl,
 	memset(ret, 0, size);
 
 	/* Set up tces to cover the allocated range */
-	nio_pages = size >> tbl->it_page_shift;
-	io_order = get_iommu_order(size, tbl);
+	size_io = IOMMU_PAGE_ALIGN(size_io, tbl);
+	nio_pages = size_io >> tbl->it_page_shift;
+	io_order = get_iommu_order(size_io, tbl);
 	mapping = iommu_alloc(dev, tbl, ret, nio_pages, DMA_BIDIRECTIONAL,
 			      mask >> tbl->it_page_shift, io_order, 0);
 	if (mapping == DMA_MAPPING_ERROR) {
@@ -900,11 +901,11 @@ void iommu_free_coherent(struct iommu_table *tbl, size_t size,
 			 void *vaddr, dma_addr_t dma_handle)
 {
 	if (tbl) {
-		unsigned int nio_pages;
+		size_t size_io = IOMMU_PAGE_ALIGN(size, tbl);
+		unsigned int nio_pages = size_io >> tbl->it_page_shift;
 
-		size = PAGE_ALIGN(size);
-		nio_pages = size >> tbl->it_page_shift;
 		iommu_free(tbl, dma_handle, nio_pages);
+
 		size = PAGE_ALIGN(size);
 		free_pages((unsigned long)vaddr, get_order(size));
 	}
-- 
2.25.4

