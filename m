Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019C9C38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C570E21D6C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587219210;
	bh=EKyrqKcM92RTUv/jYokQKHedpF2ezK8XL3yesjlpMl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U4cTcwqbmR8m4NbffORiMrZ9bLX9mAUmhbHe7SfX5OzBU5in/Svja3ORIDB5Kk03M
	 TUs1Re7zkaeCs9Uz+DqabFgJ8M6KE4WcDhvaWHcZs3m3bF6L1I7AMBI3CJjd/G98Lz
	 hP+IYfEBLUMaFAzTA2/w0I/0rzVHslcedOoAh22U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgDRON3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:13:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbgDROJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:09:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8DEC22245;
        Sat, 18 Apr 2020 14:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587218979;
        bh=EKyrqKcM92RTUv/jYokQKHedpF2ezK8XL3yesjlpMl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0NwlgfR3HvykIySAKoQazoTIVLcR6ZlGPXvPmj8lRUlYRpWO+OCFUGTK09Y3jkRxb
         uYzijSwXiOeIUGMhEUtLPoe+QXQHTk1sg/LjpBa6HNnDpH3Bg41cglRF9/c4cOF6Dc
         P5q/nJaWiUQIdU5nzotJYN1WNBhTBIxkCDTbxDmo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.5 24/75] dma-debug: fix displaying of dma allocation type
Date:   Sat, 18 Apr 2020 10:08:19 -0400
Message-Id: <20200418140910.8280-24-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418140910.8280-1-sashal@kernel.org>
References: <20200418140910.8280-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

[ Upstream commit 9bb50ed7470944238ec8e30a94ef096caf9056ee ]

The commit 2e05ea5cdc1a ("dma-mapping: implement dma_map_single_attrs using
dma_map_page_attrs") removed "dma_debug_page" enum, but missed to update
type2name string table. This causes incorrect displaying of dma allocation
type.
Fix it by removing "page" string from type2name string table and switch to
use named initializers.

Before (dma_alloc_coherent()):
k3-ringacc 4b800000.ringacc: scather-gather idx 2208 P=d1140000 N=d114 D=d1140000 L=40 DMA_BIDIRECTIONAL dma map error check not applicable
k3-ringacc 4b800000.ringacc: scather-gather idx 2216 P=d1150000 N=d115 D=d1150000 L=40 DMA_BIDIRECTIONAL dma map error check not applicable

After:
k3-ringacc 4b800000.ringacc: coherent idx 2208 P=d1140000 N=d114 D=d1140000 L=40 DMA_BIDIRECTIONAL dma map error check not applicable
k3-ringacc 4b800000.ringacc: coherent idx 2216 P=d1150000 N=d115 D=d1150000 L=40 DMA_BIDIRECTIONAL dma map error check not applicable

Fixes: 2e05ea5cdc1a ("dma-mapping: implement dma_map_single_attrs using dma_map_page_attrs")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/debug.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 2031ed1ad7fa1..9e1777c81f559 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -137,9 +137,12 @@ static const char *const maperr2str[] = {
 	[MAP_ERR_CHECKED] = "dma map error checked",
 };
 
-static const char *type2name[5] = { "single", "page",
-				    "scather-gather", "coherent",
-				    "resource" };
+static const char *type2name[] = {
+	[dma_debug_single] = "single",
+	[dma_debug_sg] = "scather-gather",
+	[dma_debug_coherent] = "coherent",
+	[dma_debug_resource] = "resource",
+};
 
 static const char *dir2name[4] = { "DMA_BIDIRECTIONAL", "DMA_TO_DEVICE",
 				   "DMA_FROM_DEVICE", "DMA_NONE" };
-- 
2.20.1

