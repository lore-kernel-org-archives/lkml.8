Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A57C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1AD20838
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgAJRT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:19:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:53260 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgAJRTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:19:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D9D29B2B7;
        Fri, 10 Jan 2020 17:19:53 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     phil@raspberrypi.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma-contiguous: CMA: give precedence to cmdline
Date:   Fri, 10 Jan 2020 18:19:33 +0100
Message-Id: <20200110171933.15014-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although the device tree might contain a reserved-memory DT node
dedicated as the default CMA pool, users might want to change CMA's
parameters using the kernel command line for debugging purposes and
whatnot. Honor this by bypassing the reserved memory CMA setup, which
will ultimately end up freeing the memblock and allow the command line
CMA configuration routine to run.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

NOTE: Tested this on arm and arm64 with the Raspberry Pi 4.

 kernel/dma/contiguous.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index daa4e6eefdde..8bc6f2d670f9 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -302,9 +302,16 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 	phys_addr_t align = PAGE_SIZE << max(MAX_ORDER - 1, pageblock_order);
 	phys_addr_t mask = align - 1;
 	unsigned long node = rmem->fdt_node;
+	bool default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
 	struct cma *cma;
 	int err;
 
+	if (size_cmdline != -1 && default_cma) {
+		pr_info("Reserved memory: bypass %s node, using cmdline CMA params instead\n",
+			rmem->name);
+		return -EBUSY;
+	}
+
 	if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
 	    of_get_flat_dt_prop(node, "no-map", NULL))
 		return -EINVAL;
@@ -322,7 +329,7 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 	/* Architecture specific contiguous memory fixup. */
 	dma_contiguous_early_fixup(rmem->base, rmem->size);
 
-	if (of_get_flat_dt_prop(node, "linux,cma-default", NULL))
+	if (default_cma)
 		dma_contiguous_set_default(cma);
 
 	rmem->ops = &rmem_cma_ops;
-- 
2.24.1

