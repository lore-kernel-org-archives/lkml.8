Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7CCC433F2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0A5E206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594420491;
	bh=cbWejgBryP3wyPjTJqgvL1vW18Wt3qtjvaAEe9kL0pA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V9ltl9GjPN7E8tKL9j7BeCzDxYIx2LMm1d3xifzgrlARISm6+jN9G7wWrqcLSMiuw
	 Hwe6D0kMHl8G0sOKF1d8f36UG7MGli9lgOYodYWRLRyrii/6oToCUSraInCRxYqMgY
	 JYEFJJZwmRrfWc0dvbTeotD0Ak6k8fEQ4rKp27ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgGJWer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 18:34:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgGJWee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 18:34:34 -0400
Received: from sstabellini-ThinkPad-T480s.hsd1.ca.comcast.net (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1306420842;
        Fri, 10 Jul 2020 22:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594420474;
        bh=cbWejgBryP3wyPjTJqgvL1vW18Wt3qtjvaAEe9kL0pA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FMZ1pvxBAj/UqOMhOUE4LnQZIiFubMpVx7zHItoWPFKhBrWbTBYPVAdTBFCy2+0G1
         9WCbwxcHHxgEqTzBBWG2k82KXIWM2L+Q1svJMEePdQc1BWjdG3rg+K0IjMVi9IuZ5m
         Fahls4gJEmbcd12Pe6pig9hLI9mD2vlA5ttxzRQQ=
From:   Stefano Stabellini <sstabellini@kernel.org>
To:     jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: [PATCH v3 11/11] xen/arm: call dma_to_phys on the dma_addr_t parameter of dma_cache_maint
Date:   Fri, 10 Jul 2020 15:34:27 -0700
Message-Id: <20200710223427.6897-11-sstabellini@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2007101521290.4124@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2007101521290.4124@sstabellini-ThinkPad-T480s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Stabellini <stefano.stabellini@xilinx.com>

dma_cache_maint is getting called passing a dma address which could be
different from a physical address.

Add a struct device* parameter to dma_cache_maint.

Translate the dma_addr_t parameter of dma_cache_maint by calling
dma_to_phys. Do it for the first page and all the following pages, in
case of multipage handling.

Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Tested-by: Corey Minyard <cminyard@mvista.com>
Tested-by: Roman Shaposhnik <roman@zededa.com>
---
Changes in v2:
- improve commit message
---
 arch/arm/xen/mm.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index a8251a70f442..396797ffe2b1 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -43,15 +43,18 @@ unsigned long xen_get_swiotlb_free_pages(unsigned int order)
 static bool hypercall_cflush = false;
 
 /* buffers in highmem or foreign pages cannot cross page boundaries */
-static void dma_cache_maint(dma_addr_t handle, size_t size, u32 op)
+static void dma_cache_maint(struct device *dev, dma_addr_t handle,
+			    size_t size, u32 op)
 {
 	struct gnttab_cache_flush cflush;
 
-	cflush.a.dev_bus_addr = handle & XEN_PAGE_MASK;
 	cflush.offset = xen_offset_in_page(handle);
 	cflush.op = op;
+	handle &= XEN_PAGE_MASK;
 
 	do {
+		cflush.a.dev_bus_addr = dma_to_phys(dev, handle);
+
 		if (size + cflush.offset > XEN_PAGE_SIZE)
 			cflush.length = XEN_PAGE_SIZE - cflush.offset;
 		else
@@ -60,7 +63,7 @@ static void dma_cache_maint(dma_addr_t handle, size_t size, u32 op)
 		HYPERVISOR_grant_table_op(GNTTABOP_cache_flush, &cflush, 1);
 
 		cflush.offset = 0;
-		cflush.a.dev_bus_addr += cflush.length;
+		handle += cflush.length;
 		size -= cflush.length;
 	} while (size);
 }
@@ -76,16 +79,16 @@ void xen_dma_sync_for_cpu(struct device *dev, dma_addr_t handle,
 			  size_t size, enum dma_data_direction dir)
 {
 	if (dir != DMA_TO_DEVICE)
-		dma_cache_maint(handle, size, GNTTAB_CACHE_INVAL);
+		dma_cache_maint(dev, handle, size, GNTTAB_CACHE_INVAL);
 }
 
 void xen_dma_sync_for_device(struct device *dev, dma_addr_t handle,
 			     size_t size, enum dma_data_direction dir)
 {
 	if (dir == DMA_FROM_DEVICE)
-		dma_cache_maint(handle, size, GNTTAB_CACHE_INVAL);
+		dma_cache_maint(dev, handle, size, GNTTAB_CACHE_INVAL);
 	else
-		dma_cache_maint(handle, size, GNTTAB_CACHE_CLEAN);
+		dma_cache_maint(dev, handle, size, GNTTAB_CACHE_CLEAN);
 }
 
 bool xen_arch_need_swiotlb(struct device *dev,
-- 
2.17.1

