Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52582C38A2F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E8B21BE5
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587221256;
	bh=vqyA98ISkgtNizDCDh4+BfcOp+FH3LtWJpuHIiV0s3U=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=J3Qk4UcnFV4upMNlobPq7jMKebDUVHTq8G1fUl4OddsFhps1mT9DcP12rlsZETQQ6
	 Ph7MwEe4RLJILOp3jabMorrm06IJi/T0w5q8fHgdYQWeeRdPWB07uDYhewr29SYHWo
	 VuUtxZgdV0WYYKUwVQsoWGK9Wm5QYGII5o9PHpfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgDROrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:47:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728740AbgDROoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:44:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3A6A21974;
        Sat, 18 Apr 2020 14:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587221047;
        bh=vqyA98ISkgtNizDCDh4+BfcOp+FH3LtWJpuHIiV0s3U=;
        h=From:To:Cc:Subject:Date:From;
        b=vlXT1WzqKKEyomJ6ZBEKiXMTBJIrP/E6oZwKTE6Hjm3jPDwSowjxrWXjiMCyYMr5l
         at/7Dvs2widBnZqMKjPlltPDu4Qw1UniuBN0mKHcg/AUMCrYhJER5NHf3YHm82gm0y
         8u3KPaeDLjBpPTtF4X/+ZS4F5Oy5BHHJ7GR05cFc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Adrian Huang <ahuang12@lenovo.com>, Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.9 01/23] iommu/amd: Fix the configuration of GCR3 table root pointer
Date:   Sat, 18 Apr 2020 10:43:43 -0400
Message-Id: <20200418144405.10565-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Huang <ahuang12@lenovo.com>

[ Upstream commit c20f36534666e37858a14e591114d93cc1be0d34 ]

The SPA of the GCR3 table root pointer[51:31] masks 20 bits. However,
this requires 21 bits (Please see the AMD IOMMU specification).
This leads to the potential failure when the bit 51 of SPA of
the GCR3 table root pointer is 1'.

Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
Fixes: 52815b75682e2 ("iommu/amd: Add support for IOMMUv2 domain mode")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 0d91785ebdc34..da3fbf82d1cf4 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -329,7 +329,7 @@
 
 #define DTE_GCR3_VAL_A(x)	(((x) >> 12) & 0x00007ULL)
 #define DTE_GCR3_VAL_B(x)	(((x) >> 15) & 0x0ffffULL)
-#define DTE_GCR3_VAL_C(x)	(((x) >> 31) & 0xfffffULL)
+#define DTE_GCR3_VAL_C(x)	(((x) >> 31) & 0x1fffffULL)
 
 #define DTE_GCR3_INDEX_A	0
 #define DTE_GCR3_INDEX_B	1
-- 
2.20.1

