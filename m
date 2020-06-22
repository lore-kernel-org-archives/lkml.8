Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA895C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A55E62075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbgFVRc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:32:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6307 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730123AbgFVRc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:32:56 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 905A44100360CC9089D5;
        Tue, 23 Jun 2020 01:32:53 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 23 Jun 2020 01:32:42 +0800
From:   John Garry <john.garry@huawei.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <trivial@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <maz@kernel.org>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 1/4] iommu/arm-smmu-v3: Fix trivial typo
Date:   Tue, 23 Jun 2020 01:28:37 +0800
Message-ID: <1592846920-45338-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
References: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set "cmq" -> "cmdq".

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f578677a5c41..a8e814c652fe 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1479,7 +1479,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 		}
 
 		/*
-		 * Try to unlock the cmq lock. This will fail if we're the last
+		 * Try to unlock the cmdq lock. This will fail if we're the last
 		 * reader, in which case we can safely update cmdq->q.llq.cons
 		 */
 		if (!arm_smmu_cmdq_shared_tryunlock(cmdq)) {
-- 
2.26.2

