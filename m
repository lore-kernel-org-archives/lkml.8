Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13484C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E85252067B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgFHIwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgFHIwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:52:35 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382D0C08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 01:52:35 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:c85f:a5bf:b1bd:702b])
        by michel.telenet-ops.be with bizsmtp
        id oYsY2200L0R8aca06YsY5g; Mon, 08 Jun 2020 10:52:32 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jiDWC-0006nd-84; Mon, 08 Jun 2020 10:52:32 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jiDWC-0002Ki-5C; Mon, 08 Jun 2020 10:52:32 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] dma-pool: Fix too large DMA pools on medium systems
Date:   Mon,  8 Jun 2020 10:52:31 +0200
Message-Id: <20200608085231.8924-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On systems with at least 32 MiB, but less than 32 GiB of RAM, the DMA
memory pools are much larger than intended (e.g. 2 MiB instead of 128
KiB on a 256 MiB system).

Fix this by correcting the calculation of the number of GiBs of RAM in
the system.

Fixes: 1d659236fb43c4d2 ("dma-pool: scale the default DMA coherent pool size with memory capacity")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 kernel/dma/pool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 35bb51c31fff370f..1c7eab2cc0498003 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -175,8 +175,8 @@ static int __init dma_atomic_pool_init(void)
 	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER-1.
 	 */
 	if (!atomic_pool_size) {
-		atomic_pool_size = max(totalram_pages() >> PAGE_SHIFT, 1UL) *
-					SZ_128K;
+		unsigned long gigs = totalram_pages() >> (30 - PAGE_SHIFT);
+		atomic_pool_size = max(gigs, 1UL) * SZ_128K;
 		atomic_pool_size = min_t(size_t, atomic_pool_size,
 					 1 << (PAGE_SHIFT + MAX_ORDER-1));
 	}
-- 
2.17.1

