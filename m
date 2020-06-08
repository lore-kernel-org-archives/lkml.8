Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96934C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 13:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CE8A2076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 13:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgFHNWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 09:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgFHNWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 09:22:22 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD32C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 06:22:22 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:c85f:a5bf:b1bd:702b])
        by xavier.telenet-ops.be with bizsmtp
        id odNJ2200D0R8aca01dNJ0S; Mon, 08 Jun 2020 15:22:18 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jiHjG-00013I-97; Mon, 08 Jun 2020 15:22:18 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jiHjG-0007nj-6d; Mon, 08 Jun 2020 15:22:18 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2] dma-pool: Fix too large DMA pools on medium systems
Date:   Mon,  8 Jun 2020 15:22:17 +0200
Message-Id: <20200608132217.29945-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On systems with at least 32 MiB, but less than 32 GiB of RAM, the DMA
memory pools are much larger than intended (e.g. 2 MiB instead of 128
KiB on a 256 MiB system).

Fix this by correcting the calculation of the number of GiBs of RAM in
the system.  Invert the order of the min/max operations, to keep on
calculating in pages until the last step, which aids readability.

Fixes: 1d659236fb43c4d2 ("dma-pool: scale the default DMA coherent pool size with memory capacity")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2:
  - Improve readability:
      - Divide by (SZ_1G / SZ_128K) instead of using a shift,
      - Invert min/max order to keep calculating in pages until the last
	step.
---
 kernel/dma/pool.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 35bb51c31fff370f..8cfa01243ed27b6f 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -175,10 +175,9 @@ static int __init dma_atomic_pool_init(void)
 	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER-1.
 	 */
 	if (!atomic_pool_size) {
-		atomic_pool_size = max(totalram_pages() >> PAGE_SHIFT, 1UL) *
-					SZ_128K;
-		atomic_pool_size = min_t(size_t, atomic_pool_size,
-					 1 << (PAGE_SHIFT + MAX_ORDER-1));
+		unsigned long pages = totalram_pages() / (SZ_1G / SZ_128K);
+		pages = min_t(unsigned long, pages, MAX_ORDER_NR_PAGES);
+		atomic_pool_size = max_t(size_t, pages << PAGE_SHIFT, SZ_128K);
 	}
 	INIT_WORK(&atomic_pool_work, atomic_pool_work_fn);
 
-- 
2.17.1

