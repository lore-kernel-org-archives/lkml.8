Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10082C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D974C2072B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587221720;
	bh=2TFAKaSdT+EMO+YKZ/LNnCEY582EwDyXXk3/bqOThdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uEbQXKP8casUttS6SaWny9qu7WrlE8usS0FewiomUdK0tJNAtk0i+8lS6L+QDFv/Z
	 p8T0WbjYzjjC98jWr5OZFw8wJoEX/GDOVJbUAA45ls6OqzxtZXdKTcqPKXiXmCOzba
	 eWpkBCNpK+W8eRwIT7qpsv4G7LEFH5GxEzpz5MuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgDROzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:55:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbgDROlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:41:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED05122253;
        Sat, 18 Apr 2020 14:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587220874;
        bh=2TFAKaSdT+EMO+YKZ/LNnCEY582EwDyXXk3/bqOThdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oblOSCOuOxuMFlmFnqdV36GerDpyP10qrKLgpf2ipE6XNowKCpMbTZa+TcksetwTJ
         DaMlM31k3RThyEffc9UowUZnCRPC9GW97vbm9PMLGGBXCeWaILHn4aGw0pEJ3dpM9v
         BfZCtQv0jZj0/QwwxPzzUk6Dy7DkfMT1gKc7uBDw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.4 22/78] dma-direct: fix data truncation in dma_direct_get_required_mask()
Date:   Sat, 18 Apr 2020 10:39:51 -0400
Message-Id: <20200418144047.9013-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144047.9013-1-sashal@kernel.org>
References: <20200418144047.9013-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

[ Upstream commit cdcda0d1f8f4ab84efe7cd9921c98364398aefd7 ]

The upper 32-bit physical address gets truncated inadvertently
when dma_direct_get_required_mask() invokes phys_to_dma_direct().
This results in dma_addressing_limited() return incorrect value
when used in platforms with LPAE enabled.
Fix it here by explicitly type casting 'max_pfn' to phys_addr_t
in order to prevent overflow of intermediate value while evaluating
'(max_pfn - 1) << PAGE_SHIFT'.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/direct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 867fd72cb2605..0a093a675b632 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -45,7 +45,8 @@ static inline dma_addr_t phys_to_dma_direct(struct device *dev,
 
 u64 dma_direct_get_required_mask(struct device *dev)
 {
-	u64 max_dma = phys_to_dma_direct(dev, (max_pfn - 1) << PAGE_SHIFT);
+	phys_addr_t phys = (phys_addr_t)(max_pfn - 1) << PAGE_SHIFT;
+	u64 max_dma = phys_to_dma_direct(dev, phys);
 
 	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
 }
-- 
2.20.1

