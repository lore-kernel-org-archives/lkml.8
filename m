Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA4BC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3148A206D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbgEDMze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 08:55:34 -0400
Received: from 8bytes.org ([81.169.241.247]:41112 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728434AbgEDMyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:54:16 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 05DA5477; Mon,  4 May 2020 14:54:15 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Qian Cai <cai@lca.pw>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 3/5] iommu/amd: Call domain_flush_complete() in update_domain()
Date:   Mon,  4 May 2020 14:54:11 +0200
Message-Id: <20200504125413.16798-4-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504125413.16798-1-joro@8bytes.org>
References: <20200504125413.16798-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The update_domain() function is expected to also inform the hardware
about domain changes. This needs a COMPLETION_WAIT command to be sent
to all IOMMUs which use the domain.

Tested-by: Qian Cai <cai@lca.pw>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 68da484a69dd..d2499c86d395 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2321,6 +2321,7 @@ static void update_domain(struct protection_domain *domain)
 
 	domain_flush_devices(domain);
 	domain_flush_tlb_pde(domain);
+	domain_flush_complete(domain);
 }
 
 int __init amd_iommu_init_api(void)
-- 
2.17.1

