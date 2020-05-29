Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802D8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62BAD2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgE2ULJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 16:11:09 -0400
Received: from mail.ispras.ru ([83.149.199.45]:38116 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbgE2ULJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 16:11:09 -0400
Received: from localhost.localdomain (unknown [46.188.10.168])
        by mail.ispras.ru (Postfix) with ESMTPSA id 3BDC8CD461;
        Fri, 29 May 2020 23:11:06 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Monakov <amonakov@ispras.ru>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/amd: Fix event counter availability check
Date:   Fri, 29 May 2020 23:07:38 +0300
Message-Id: <20200529200738.1923-1-amonakov@ispras.ru>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver performs an extra check if the IOMMU's capabilities advertise
presence of performance counters: it verifies that counters are writable
by writing a hard-coded value to a counter and testing that reading that
counter gives back the same value.

Unfortunately it does so quite early, even before pci_enable_device is
called for the IOMMU, i.e. when accessing its MMIO space is not
guaranteed to work. On Ryzen 4500U CPU, this actually breaks the test:
the driver assumes the counters are not writable, and disables the
functionality.

Moving init_iommu_perf_ctr just after iommu_flush_all_caches resolves
the issue. This is the earliest point in amd_iommu_init_pci where the
call succeeds on my laptop.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: iommu@lists.linux-foundation.org
---

PS. I'm seeing another hiccup with IOMMU probing on my system:
pci 0000:00:00.2: can't derive routing for PCI INT A
pci 0000:00:00.2: PCI INT A: not connected

Hopefully I can figure it out, but I'd appreciate hints.

 drivers/iommu/amd_iommu_init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 5b81fd16f5fa..1b7ec6b6a282 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1788,8 +1788,6 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE))
 		amd_iommu_np_cache = true;
 
-	init_iommu_perf_ctr(iommu);
-
 	if (is_rd890_iommu(iommu->dev)) {
 		int i, j;
 
@@ -1891,8 +1889,10 @@ static int __init amd_iommu_init_pci(void)
 
 	init_device_table_dma();
 
-	for_each_iommu(iommu)
+	for_each_iommu(iommu) {
 		iommu_flush_all_caches(iommu);
+		init_iommu_perf_ctr(iommu);
+	}
 
 	if (!ret)
 		print_iommu_info();

base-commit: 75caf310d16cc5e2f851c048cd597f5437013368
-- 
2.26.2

