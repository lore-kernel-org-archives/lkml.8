Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86BDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85227207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437168AbgE1W2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 18:28:23 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:44674 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437107AbgE1WYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:24:16 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 8DB348030778;
        Thu, 28 May 2020 22:24:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5UMa74twAlQZ; Fri, 29 May 2020 01:24:14 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 09/11] dmaengine: dw: Initialize min_burst capability
Date:   Fri, 29 May 2020 01:23:59 +0300
Message-ID: <20200528222401.26941-10-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200528222401.26941-1-Sergey.Semin@baikalelectronics.ru>
References: <20200528222401.26941-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the DW APB DMAC data book the minimum burst transaction
length is 1 and it's true for any version of the controller since
isn't parametrised in the coreAssembler so can't be changed at the
IP-core synthesis stage. Let's initialise the min_burst member of the
DMA controller descriptor so the DMA clients could use it to properly
optimize the DMA requests.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org

---

Changelog v4:
- This is a new patch suggested by Andy.
---
 drivers/dma/dw/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index ceded21537e2..a8cebb1dbb68 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -1229,6 +1229,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 	dw->dma.device_issue_pending = dwc_issue_pending;
 
 	/* DMA capabilities */
+	dw->dma.min_burst = 1;
 	dw->dma.src_addr_widths = DW_DMA_BUSWIDTHS;
 	dw->dma.dst_addr_widths = DW_DMA_BUSWIDTHS;
 	dw->dma.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) |
-- 
2.26.2

