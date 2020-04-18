Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B113EC38A2F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8685D21D82
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587218953;
	bh=l7RO7QjmdtOWfegVU4aHVRqeF+UIoUVQppVy5fyZFd8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ZbW4jCB8vAB3pigBbyY3Eud/gr1GVxsBfDFQuMwxV8uUiinhGGvodVZlCe2igJH0l
	 uEiMQVVfPurVi0XZ4ST7/LJw+o2GSAL/YSelaHAonV5I6ykH06gnK6/Jd7Os59d/E7
	 T6I/P7UjsmYhSuAconAASKAI5ieNKpNrsYkIsqao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgDROJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:09:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgDROJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:09:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97D7621BE5;
        Sat, 18 Apr 2020 14:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587218952;
        bh=l7RO7QjmdtOWfegVU4aHVRqeF+UIoUVQppVy5fyZFd8=;
        h=From:To:Cc:Subject:Date:From;
        b=qYPvrkWD55gTTl5F4FfduWu9NPT63XoKSJen1YuDzlHAEoKAFoJcU3NsRB3l7Yyb4
         rWAW/peL6T/yj/3mX63pFLzOkyXO160TfeJGCC8P+ojR1Dyl/2aZ2603IQFSdTkKAR
         mA94utYKvFZL5Efdv/NFyiM7HsNObpCJsZr53ZKg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Adrian Huang <ahuang12@lenovo.com>, Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.5 01/75] iommu/amd: Fix the configuration of GCR3 table root pointer
Date:   Sat, 18 Apr 2020 10:07:56 -0400
Message-Id: <20200418140910.8280-1-sashal@kernel.org>
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
index 798e1533a1471..d336ae8f5c73b 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -348,7 +348,7 @@
 
 #define DTE_GCR3_VAL_A(x)	(((x) >> 12) & 0x00007ULL)
 #define DTE_GCR3_VAL_B(x)	(((x) >> 15) & 0x0ffffULL)
-#define DTE_GCR3_VAL_C(x)	(((x) >> 31) & 0xfffffULL)
+#define DTE_GCR3_VAL_C(x)	(((x) >> 31) & 0x1fffffULL)
 
 #define DTE_GCR3_INDEX_A	0
 #define DTE_GCR3_INDEX_B	1
-- 
2.20.1

