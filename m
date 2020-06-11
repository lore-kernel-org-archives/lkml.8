Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7238DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48921207ED
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQjGhruF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgFKTUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 15:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgFKTUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:20:32 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0008C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 12:20:32 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z63so2167958pfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 12:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=9bbiOsDMVztchdkicPMjy84vDC6pYDsE3gWzL9+ymoc=;
        b=XQjGhruFzMHHQgB4Zy4X5dQbcKz9vjEXrit5SAvrCK5QPKjZ+l7tvfR0ba69ZgL9gm
         khfTkDKN8XAcKs1zfblop0/zLzMvz3pjzXbUrKQ/Qf+Qxy2nBR4KfsQctcPX4udAbTSl
         vcpR5dUEZuKk8N+ph6X73T9PyDMMabM6s1iYI86eKrsRsNyBgvmhf6uMxObDipndNKdn
         5w7E9XWjkPxPkLsr9C82PeAxJXWtZ3GIePeerssU3YedpZMYKLcAyOJCBqEt74cKiucW
         XTf3ch1vyHKbxRoEIYQ6OflS0ecdgSEoBAUej0v28MsNiVlcykmMkHX7Ok2pNzyiQqeT
         W5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=9bbiOsDMVztchdkicPMjy84vDC6pYDsE3gWzL9+ymoc=;
        b=IV5mA6PQaYGyer7gJzkqgTmVMx2uZU78u3t6maXjJDGt8qvcm9k1AWbxUzxk/SbivO
         t7zPztiOn8msgEgVrSJOkBxVoC/uR0kmPmYQBWyCmNPbrgRQiNg6FzveIUJf/KCzP39g
         bgT8ahvgpNRrYNiq+ckuwwwx4RlhJahN2+MMNQuVfpRTwg30C72lULA2mj08JMSAtlXC
         a0FiuV6j1JxPZJCUk3xeCYyRlxqgaVJLH0utSo8SeuQKB+rRqOMQNE+5ykvF4a0FlG2a
         8oKUbPNtjf19WZIt1VFWtqMzy42ClXNzIXJv74aOhzL5csXp28gdtecQK5eX/7W1WnY/
         iEtQ==
X-Gm-Message-State: AOAM533+InDIrQJ7+88pkx7JFibwqazQVYMSZy1nwO3jxjUKgHtLOVUd
        MocIQkcyjoBHPF4QFKLkO16RLA==
X-Google-Smtp-Source: ABdhPJxG2P9nH5r1G62i8Rxg0NJO4j6KzhMS4gR9YqZWKYkkG/6xq6nFS6lpMXkiRAG6l5IgQPXfTg==
X-Received: by 2002:a05:6a00:1486:: with SMTP id v6mr8211804pfu.83.1591903231866;
        Thu, 11 Jun 2020 12:20:31 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id k126sm4135905pfd.129.2020.06.11.12.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 12:20:31 -0700 (PDT)
Date:   Thu, 11 Jun 2020 12:20:30 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Thomas Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [patch for-5.8 3/4] dma-direct: check return value when encrypting
 or decrypting memory
In-Reply-To: <alpine.DEB.2.22.394.2006111218200.153880@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.22.394.2006111219410.153880@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2006111218200.153880@chino.kir.corp.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__change_page_attr() can fail which will cause set_memory_encrypted() and
set_memory_decrypted() to return non-zero.

If the device requires unencrypted DMA memory and decryption fails, simply
free the memory and fail.

If attempting to re-encrypt in the failure path and that encryption fails,
there is no alternative other than to leak the memory.

Fixes: c10f07aa27da ("dma/direct: Handle force decryption for DMA coherent
buffers in common code")
Cc: stable@vger.kernel.org # 4.17+
Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/direct.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -158,6 +158,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 {
 	struct page *page;
 	void *ret;
+	int err;
 
 	size = PAGE_ALIGN(size);
 
@@ -210,8 +211,12 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
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
 
@@ -229,9 +234,13 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 		*dma_handle = phys_to_dma(dev, page_to_phys(page));
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
