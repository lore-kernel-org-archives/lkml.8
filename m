Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C2FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 436A0207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="tD8NW3F1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgESUfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:35:25 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:35392 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728018AbgESUfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:35:05 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 8D33630D83D;
        Tue, 19 May 2020 13:33:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 8D33630D83D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1589920421;
        bh=VpnotEhiNEPSL/h1q0ZC3ux+vegZ1N4bcsFwvtQO+FE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tD8NW3F1ADu3W5qZO8tm5cZkY83a5YfdW7Pok6YJk0J1MpyyryIIm/cxU9CkPMVTc
         +5gYtA0NGWpyE8xH+allbbIhLgRkOvpoHf8j6wb1JOVgEqSXswIoctk4C48jTkUBfI
         5cTjhW6JJKAbljyC57848rTE07nHe9qnVK5NhHxY=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 29C5D140239;
        Tue, 19 May 2020 13:35:02 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     james.quinlan@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien.grall@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 11/15] arm: dma-mapping: Invoke dma offset func if needed
Date:   Tue, 19 May 2020 16:34:09 -0400
Message-Id: <20200519203419.12369-12-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519203419.12369-1-james.quinlan@broadcom.com>
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like dma_pfn_offset, another offset is added to
the dma/phys translation if there happen to be multiple
regions that have different mapping offsets.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 arch/arm/include/asm/dma-mapping.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index bdd80ddbca34..f0c0a1fa9ac0 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -35,8 +35,14 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 #ifndef __arch_pfn_to_dma
 static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
 {
-	if (dev)
+	if (dev) {
+#ifdef CONFIG_DMA_PFN_OFFSET_MAP
+		if (unlikely(dev->dma_offset_map))
+			pfn -= dma_pfn_offset_frm_phys_addr(
+				dev->dma_offset_map, PFN_PHYS(pfn));
+#endif
 		pfn -= dev->dma_pfn_offset;
+	}
 	return (dma_addr_t)__pfn_to_bus(pfn);
 }
 
@@ -44,9 +50,14 @@ static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
 {
 	unsigned long pfn = __bus_to_pfn(addr);
 
-	if (dev)
+	if (dev) {
+#ifdef CONFIG_DMA_PFN_OFFSET_MAP
+		if (unlikely(dev->dma_offset_map))
+			pfn += dma_pfn_offset_frm_dma_addr(
+				dev->dma_offset_map, addr);
+#endif
 		pfn += dev->dma_pfn_offset;
-
+	}
 	return pfn;
 }
 
-- 
2.17.1

