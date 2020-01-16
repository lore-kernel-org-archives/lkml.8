Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9850EC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B932073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202550;
	bh=3dY9UzQ5FnrJjjb34dZYUEMkKYZza9PI9MXrctpD6Z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QXxQDFBLJOA0mg0Jk1aL/Y61yqjJeDc5BEqyNbkotXQoe+KqzqNV5w2YwFHVXqY1Q
	 XLplbqV8CnT+xSn2quN7O0LRDfduQYK06rh8sWGlapWG5GJDsz+W6zUccXH0LkuMD3
	 934kJDXVZNzDMv/bB5ctT3HJAp8D/6R84pLpRCJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390261AbgAPTW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:22:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730943AbgAPQx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:53:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70A442081E;
        Thu, 16 Jan 2020 16:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193607;
        bh=3dY9UzQ5FnrJjjb34dZYUEMkKYZza9PI9MXrctpD6Z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rZSp6M301GnniJmB2EJCSeRiZieKla1KH8QXFQg0BR7KeGUqzARKfQt/SC8QqJQVi
         kc0qs08+paKlVj3SRntSVkDaJqsLIM03XBCHKtxKKn+rNsWhZNkBTnKOS74filSbWD
         I/Mdjcxp3yTSLAw8tYVTcCB8wfrw4uB5mYNVz3RE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sasha Levin <sashal@kernel.org>, tee-dev@lists.linaro.org
Subject: [PATCH AUTOSEL 5.4 145/205] tee: optee: Fix dynamic shm pool allocations
Date:   Thu, 16 Jan 2020 11:42:00 -0500
Message-Id: <20200116164300.6705-145-sashal@kernel.org>
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

From: Sumit Garg <sumit.garg@linaro.org>

[ Upstream commit a249dd200d03791cab23e47571f3e13d9c72af6c ]

In case of dynamic shared memory pool, kernel memory allocated using
dmabuf_mgr pool needs to be registered with OP-TEE prior to its usage
during optee_open_session() or optee_invoke_func().

So fix dmabuf_mgr pool allocations via an additional call to
optee_shm_register().

Also, allow kernel pages to be registered as shared memory with OP-TEE.

Fixes: 9733b072a12a ("optee: allow to work without static shared memory")
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tee/optee/call.c     |  7 +++++++
 drivers/tee/optee/shm_pool.c | 12 +++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 13b0269a0abc..cf2367ba08d6 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -554,6 +554,13 @@ static int check_mem_type(unsigned long start, size_t num_pages)
 	struct mm_struct *mm = current->mm;
 	int rc;
 
+	/*
+	 * Allow kernel address to register with OP-TEE as kernel
+	 * pages are configured as normal memory only.
+	 */
+	if (virt_addr_valid(start))
+		return 0;
+
 	down_read(&mm->mmap_sem);
 	rc = __check_mem_type(find_vma(mm, start),
 			      start + num_pages * PAGE_SIZE);
diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
index de1d9b8fad90..0332a5301d61 100644
--- a/drivers/tee/optee/shm_pool.c
+++ b/drivers/tee/optee/shm_pool.c
@@ -17,6 +17,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
 {
 	unsigned int order = get_order(size);
 	struct page *page;
+	int rc = 0;
 
 	page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
 	if (!page)
@@ -26,12 +27,21 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
 	shm->paddr = page_to_phys(page);
 	shm->size = PAGE_SIZE << order;
 
-	return 0;
+	if (shm->flags & TEE_SHM_DMA_BUF) {
+		shm->flags |= TEE_SHM_REGISTER;
+		rc = optee_shm_register(shm->ctx, shm, &page, 1 << order,
+					(unsigned long)shm->kaddr);
+	}
+
+	return rc;
 }
 
 static void pool_op_free(struct tee_shm_pool_mgr *poolm,
 			 struct tee_shm *shm)
 {
+	if (shm->flags & TEE_SHM_DMA_BUF)
+		optee_shm_unregister(shm->ctx, shm);
+
 	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
 	shm->kaddr = NULL;
 }
-- 
2.20.1

