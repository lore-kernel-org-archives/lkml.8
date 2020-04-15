Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D41C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C2EF21556
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586955216;
	bh=yySHHLraBwaEa7eTZ12dTCbxl9BA6uw6sL6wccS0dZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oOBuyzkoAB86TY7MmcXFNYkmMOSB2NUnrc6Zt6Ln1c9MDtber4HsV+SVJ5fDlXOSw
	 zK4un7xFGFdlNq17oXJOAmA7k13AabGUCkPkDA5wcReSXwTqB7oYWLnS0Qv4dKrjcH
	 oOsB0Dh71I0FyeYOHzlgPiYmf7IDH7g052SsyOEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898247AbgDOMxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:53:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897222AbgDOLhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:37:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32CDF214D8;
        Wed, 15 Apr 2020 11:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950635;
        bh=yySHHLraBwaEa7eTZ12dTCbxl9BA6uw6sL6wccS0dZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PnRCs/LFzLeQy8ZkKV/R50bpeeQKYTzYsCbpbNmzcVxNfRshzHNOm9bj5a7tK4G50
         zTzVVFs/i8azSKH7RNLyVGbqAuGXhkiA5u44gywcHOpqxu/lb8GJLnzv1/sWW0k2+8
         g0KYvyAx5Mze6gg7U0uTlBfHeb14gNEJQZzOGKmA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Adrian Huang <ahuang12@lenovo.com>, Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.6 126/129] iommu/amd: Fix the configuration of GCR3 table root pointer
Date:   Wed, 15 Apr 2020 07:34:41 -0400
Message-Id: <20200415113445.11881-126-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
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
index f8d01d6b00da7..ca8c4522045b3 100644
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

