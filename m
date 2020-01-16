Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1871AC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F9B2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202455;
	bh=pYUCGLdMi6gDXVvxrUjAARZ0xY91qBFUik0lqrR9TTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=odTzK6zN9VnYKdTB8ybc8VhTbA7OmbGVQsMS5kmXRtQChzslhOe1j1FfN5LWxu6Rx
	 Fy3GLNo1UcWB1r/YnsLk2uZfTEJWZl+4o8Oa+KZ+aa0At87bQV9fTc6OdQvjyFZss4
	 9lgTZL0SFwHff6ztDkk81w74paTExWjBIHXjSv94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437653AbgAPTUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:20:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:37812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731179AbgAPQxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:53:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 748DC2176D;
        Thu, 16 Jan 2020 16:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193627;
        bh=pYUCGLdMi6gDXVvxrUjAARZ0xY91qBFUik0lqrR9TTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dH995/4+8IWYVT/rxPyF/t4Uq6El59Hwf6S1KRacmZ+7o4GnUlKSnprMUlCjb2O7M
         HX18UkBq84wm0E/NvNxp7MWDEHC/g+7yO6ie8pRLgCbBVL9GjEGa6CKMXzo3g/SgaY
         KsXfSGOQstg4TSEaGCpz1B9Ph7PjyGLNKiSCE4c0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.4 161/205] dma-direct: don't check swiotlb=force in dma_direct_map_resource
Date:   Thu, 16 Jan 2020 11:42:16 -0500
Message-Id: <20200116164300.6705-161-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 4268ac6ae5870af10a7417b22990d615f72f77e2 ]

When mapping resources we can't just use swiotlb ram for bounce
buffering.  Switch to a direct dma_capable check instead.

Fixes: cfced786969c ("dma-mapping: remove the default map_resource implementation")
Reported-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 8402b29c280f..867fd72cb260 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -375,7 +375,7 @@ dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
 {
 	dma_addr_t dma_addr = paddr;
 
-	if (unlikely(!dma_direct_possible(dev, dma_addr, size))) {
+	if (unlikely(!dma_capable(dev, dma_addr, size))) {
 		report_addr(dev, dma_addr, size);
 		return DMA_MAPPING_ERROR;
 	}
-- 
2.20.1

