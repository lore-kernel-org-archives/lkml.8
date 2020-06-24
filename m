Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F30C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25700206E2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389897AbgFXHiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:38:21 -0400
Received: from verein.lst.de ([213.95.11.211]:43198 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389583AbgFXHiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:38:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BB98368B02; Wed, 24 Jun 2020 09:38:16 +0200 (CEST)
Date:   Wed, 24 Jun 2020 09:38:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2] dma-pool: Fix too large DMA pools on medium systems
Message-ID: <20200624073815.GE18609@lst.de>
References: <20200608132217.29945-1-geert@linux-m68k.org> <20200620200936.GA106151@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620200936.GA106151@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

can you try the patch below?  This just converts the huge allocations
in mptbase to use GFP_KERNEL.  Christophe (added to Cc) actually has
a scripted conversion for the rest that he hasn't posted yet, so I'll
aim for the minimal version here.


diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index 68aea22f2b8978..5216487db4fbea 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -1324,13 +1324,13 @@ mpt_host_page_alloc(MPT_ADAPTER *ioc, pIOCInit_t ioc_init)
 			return 0; /* fw doesn't need any host buffers */
 
 		/* spin till we get enough memory */
-		while(host_page_buffer_sz > 0) {
-
-			if((ioc->HostPageBuffer = pci_alloc_consistent(
-			    ioc->pcidev,
-			    host_page_buffer_sz,
-			    &ioc->HostPageBuffer_dma)) != NULL) {
-
+		while (host_page_buffer_sz > 0) {
+			ioc->HostPageBuffer =
+				dma_alloc_coherent(&ioc->pcidev->dev,
+						host_page_buffer_sz,
+						&ioc->HostPageBuffer_dma,
+						GFP_KERNEL);
+			if (ioc->HostPageBuffer) {
 				dinitprintk(ioc, printk(MYIOC_s_DEBUG_FMT
 				    "host_page_buffer @ %p, dma @ %x, sz=%d bytes\n",
 				    ioc->name, ioc->HostPageBuffer,
@@ -2741,8 +2741,8 @@ mpt_adapter_disable(MPT_ADAPTER *ioc)
 		sz = ioc->alloc_sz;
 		dexitprintk(ioc, printk(MYIOC_s_INFO_FMT "free  @ %p, sz=%d bytes\n",
 		    ioc->name, ioc->alloc, ioc->alloc_sz));
-		pci_free_consistent(ioc->pcidev, sz,
-				ioc->alloc, ioc->alloc_dma);
+		dma_free_coherent(&ioc->pcidev->dev, sz, ioc->alloc,
+				ioc->alloc_dma);
 		ioc->reply_frames = NULL;
 		ioc->req_frames = NULL;
 		ioc->alloc = NULL;
@@ -2751,8 +2751,8 @@ mpt_adapter_disable(MPT_ADAPTER *ioc)
 
 	if (ioc->sense_buf_pool != NULL) {
 		sz = (ioc->req_depth * MPT_SENSE_BUFFER_ALLOC);
-		pci_free_consistent(ioc->pcidev, sz,
-				ioc->sense_buf_pool, ioc->sense_buf_pool_dma);
+		dma_free_coherent(&ioc->pcidev->dev, sz, ioc->sense_buf_pool,
+				ioc->sense_buf_pool_dma);
 		ioc->sense_buf_pool = NULL;
 		ioc->alloc_total -= sz;
 	}
@@ -2802,7 +2802,7 @@ mpt_adapter_disable(MPT_ADAPTER *ioc)
 			"HostPageBuffer free  @ %p, sz=%d bytes\n",
 			ioc->name, ioc->HostPageBuffer,
 			ioc->HostPageBuffer_sz));
-		pci_free_consistent(ioc->pcidev, ioc->HostPageBuffer_sz,
+		dma_free_coherent(&ioc->pcidev->dev, ioc->HostPageBuffer_sz,
 		    ioc->HostPageBuffer, ioc->HostPageBuffer_dma);
 		ioc->HostPageBuffer = NULL;
 		ioc->HostPageBuffer_sz = 0;
@@ -4497,7 +4497,8 @@ PrimeIocFifos(MPT_ADAPTER *ioc)
 			 	ioc->name, sz, sz, num_chain));
 
 		total_size += sz;
-		mem = pci_alloc_consistent(ioc->pcidev, total_size, &alloc_dma);
+		mem = dma_alloc_coherent(&ioc->pcidev->dev, total_size,
+				&alloc_dma, GFP_KERNEL);
 		if (mem == NULL) {
 			printk(MYIOC_s_ERR_FMT "Unable to allocate Reply, Request, Chain Buffers!\n",
 				ioc->name);
@@ -4574,8 +4575,8 @@ PrimeIocFifos(MPT_ADAPTER *ioc)
 		spin_unlock_irqrestore(&ioc->FreeQlock, flags);
 
 		sz = (ioc->req_depth * MPT_SENSE_BUFFER_ALLOC);
-		ioc->sense_buf_pool =
-			pci_alloc_consistent(ioc->pcidev, sz, &ioc->sense_buf_pool_dma);
+		ioc->sense_buf_pool = dma_alloc_coherent(&ioc->pcidev->dev, sz,
+				&ioc->sense_buf_pool_dma, GFP_KERNEL);
 		if (ioc->sense_buf_pool == NULL) {
 			printk(MYIOC_s_ERR_FMT "Unable to allocate Sense Buffers!\n",
 				ioc->name);
@@ -4613,18 +4614,16 @@ PrimeIocFifos(MPT_ADAPTER *ioc)
 
 	if (ioc->alloc != NULL) {
 		sz = ioc->alloc_sz;
-		pci_free_consistent(ioc->pcidev,
-				sz,
-				ioc->alloc, ioc->alloc_dma);
+		dma_free_coherent(&ioc->pcidev->dev, sz, ioc->alloc,
+				ioc->alloc_dma);
 		ioc->reply_frames = NULL;
 		ioc->req_frames = NULL;
 		ioc->alloc_total -= sz;
 	}
 	if (ioc->sense_buf_pool != NULL) {
 		sz = (ioc->req_depth * MPT_SENSE_BUFFER_ALLOC);
-		pci_free_consistent(ioc->pcidev,
-				sz,
-				ioc->sense_buf_pool, ioc->sense_buf_pool_dma);
+		dma_free_coherent(&ioc->pcidev->dev, sz, ioc->sense_buf_pool,
+				ioc->sense_buf_pool_dma);
 		ioc->sense_buf_pool = NULL;
 	}
 
