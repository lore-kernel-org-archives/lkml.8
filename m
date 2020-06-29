Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13BEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C11EC206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593468045;
	bh=0hGTAF6FQOoPxWnG+9gP2MAMKZocEFQKeDcy44MXjUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r3T907q392xM5tbXqmEYYIRoprC90Ge0N0G9tHTDaFXX/VgpcTSI5AhN6K4Z9r8KH
	 1ipiqhVcSlYKP+vwV9bWSnbE/GiFtZAIt0WYCC6+Nll1H3B547D+qbEbkP3yYasK0e
	 hzDqscSCxK6PpixYyOhfqhBz7v9/BRQQsX5BkVWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404694AbgF2WAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:00:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgF2SfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6413223CD1;
        Mon, 29 Jun 2020 15:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444017;
        bh=0hGTAF6FQOoPxWnG+9gP2MAMKZocEFQKeDcy44MXjUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zhIfCLHwQjFi/C6dS+slQpnDApLd86pClN+kSfbZBxczLaZp3Pba2lZL6ShoPOX46
         E4eLUT0CLtJzTT39P0n5AJGjm+SAdr6X0J7IgZ2w66gzYv+MN4JMqkzNv0wj7mOaOz
         YER7agwW+zz2gtQZNAFRel615hHYvZCkEXs+pdJQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 123/265] dma-direct: check return value when encrypting or decrypting memory
Date:   Mon, 29 Jun 2020 11:15:56 -0400
Message-Id: <20200629151818.2493727-124-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Rientjes <rientjes@google.com>

[ Upstream commit 56fccf21d1961a06e2a0c96ce446ebf036651062 ]

__change_page_attr() can fail which will cause set_memory_encrypted() and
set_memory_decrypted() to return non-zero.

If the device requires unencrypted DMA memory and decryption fails, simply
free the memory and fail.

If attempting to re-encrypt in the failure path and that encryption fails,
there is no alternative other than to leak the memory.

Fixes: c10f07aa27da ("dma/direct: Handle force decryption for DMA coherent buffers in common code")
Signed-off-by: David Rientjes <rientjes@google.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/direct.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4e789c46ff0bf..98c445dcb308b 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -124,6 +124,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 {
 	struct page *page;
 	void *ret;
+	int err;
 
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
 	    dma_alloc_need_uncached(dev, attrs) &&
@@ -176,8 +177,12 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	}
 
 	ret = page_address(page);
-	if (force_dma_unencrypted(dev))
-		set_memory_decrypted((unsigned long)ret, 1 << get_order(size));
+	if (force_dma_unencrypted(dev)) {
+		err = set_memory_decrypted((unsigned long)ret,
+					   1 << get_order(size));
+		if (err)
+			goto out_free_pages;
+	}
 
 	memset(ret, 0, size);
 
@@ -196,9 +201,13 @@ done:
 	return ret;
 
 out_encrypt_pages:
-	if (force_dma_unencrypted(dev))
-		set_memory_encrypted((unsigned long)page_address(page),
-				     1 << get_order(size));
+	if (force_dma_unencrypted(dev)) {
+		err = set_memory_encrypted((unsigned long)page_address(page),
+					   1 << get_order(size));
+		/* If memory cannot be re-encrypted, it must be leaked */
+		if (err)
+			return NULL;
+	}
 out_free_pages:
 	dma_free_contiguous(dev, page, size);
 	return NULL;
-- 
2.25.1

