Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EB4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACA8D2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iI2TrOLv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FlUuzQ2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgG2Oed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:34:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43030 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgG2Odj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:39 -0400
Date:   Wed, 29 Jul 2020 14:33:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033215;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KopvyF/JDXG9p8fKYXdexCesCEv+QMbEs4lnjnJSQ0c=;
        b=iI2TrOLvfPwoDrt/59Uc7RlEHQ3Cqb6D431ET4X4wJwO1ASTjlyX5d6mv3Ir0l96mph0mr
        yIReOeEtC1twCSFEQhZOhvOnfmnC4OxxV1pHG0HmicUAMdCCOHoBnlB4NKQPHjNANE6TmX
        GwiKW8K9PunUFYFeThTeb2U9DVGncYfiRV9ROfmlaqF1/AZ52s+1CoBTedw1iaakUF1TPB
        WEtSO9zYitnpfbxCTN5eZExgTo3Nwrkz/J6vHhjgGqVYG9d6LqDvNJ48FGIav9sfQrd/bO
        kx0XZej9o4jrdRtUk0SAa9vc5ErIX55ftwcRoYHB/Hs9pq7GcqfONKAZyYYEZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033215;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KopvyF/JDXG9p8fKYXdexCesCEv+QMbEs4lnjnJSQ0c=;
        b=FlUuzQ2ZN4SBp15HLJ4CjFNwfDFQ/x5QQAFTHAAqmJ59AGroYFd3YAiV+cEvt8aSnauKR/
        8W5eKh9nVH609pAQ==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] dma-buf: Use sequence counter with associated
 wound/wait mutex
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720155530.1173732-13-a.darwish@linutronix.de>
References: <20200720155530.1173732-13-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159603321521.4006.14335079451565543001.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     cd29f22019ec4ab998d2e1e8c831c7c42db4aa7d
Gitweb:        https://git.kernel.org/tip/cd29f22019ec4ab998d2e1e8c831c7c42db4aa7d
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Mon, 20 Jul 2020 17:55:18 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:25 +02:00

dma-buf: Use sequence counter with associated wound/wait mutex

A sequence counter write side critical section must be protected by some
form of locking to serialize writers. If the serialization primitive is
not disabling preemption implicitly, preemption has to be explicitly
disabled before entering the sequence counter write side critical
section.

The dma-buf reservation subsystem uses plain sequence counters to manage
updates to reservations. Writer serialization is accomplished through a
wound/wait mutex.

Acquiring a wound/wait mutex does not disable preemption, so this needs
to be done manually before and after the write side critical section.

Use the newly-added seqcount_ww_mutex_t instead:

  - It associates the ww_mutex with the sequence count, which enables
    lockdep to validate that the write side critical section is properly
    serialized.

  - It removes the need to explicitly add preempt_disable/enable()
    around the write side critical section because the write_begin/end()
    functions for this new data type automatically do this.

If lockdep is disabled this ww_mutex lock association is compiled out
and has neither storage size nor runtime overhead.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://lkml.kernel.org/r/20200720155530.1173732-13-a.darwish@linutronix.de
---
 drivers/dma-buf/dma-resv.c                       | 8 +-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 --
 include/linux/dma-resv.h                         | 2 +-
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index 15efa0c..a763135 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -129,7 +129,7 @@ subsys_initcall(dma_resv_lockdep);
 void dma_resv_init(struct dma_resv *obj)
 {
 	ww_mutex_init(&obj->lock, &reservation_ww_class);
-	seqcount_init(&obj->seq);
+	seqcount_ww_mutex_init(&obj->seq, &obj->lock);
 
 	RCU_INIT_POINTER(obj->fence, NULL);
 	RCU_INIT_POINTER(obj->fence_excl, NULL);
@@ -260,7 +260,6 @@ void dma_resv_add_shared_fence(struct dma_resv *obj, struct dma_fence *fence)
 	fobj = dma_resv_get_list(obj);
 	count = fobj->shared_count;
 
-	preempt_disable();
 	write_seqcount_begin(&obj->seq);
 
 	for (i = 0; i < count; ++i) {
@@ -282,7 +281,6 @@ replace:
 	smp_store_mb(fobj->shared_count, count);
 
 	write_seqcount_end(&obj->seq);
-	preempt_enable();
 	dma_fence_put(old);
 }
 EXPORT_SYMBOL(dma_resv_add_shared_fence);
@@ -309,14 +307,12 @@ void dma_resv_add_excl_fence(struct dma_resv *obj, struct dma_fence *fence)
 	if (fence)
 		dma_fence_get(fence);
 
-	preempt_disable();
 	write_seqcount_begin(&obj->seq);
 	/* write_seqcount_begin provides the necessary memory barrier */
 	RCU_INIT_POINTER(obj->fence_excl, fence);
 	if (old)
 		old->shared_count = 0;
 	write_seqcount_end(&obj->seq);
-	preempt_enable();
 
 	/* inplace update, no shared fences */
 	while (i--)
@@ -394,13 +390,11 @@ retry:
 	src_list = dma_resv_get_list(dst);
 	old = dma_resv_get_excl(dst);
 
-	preempt_disable();
 	write_seqcount_begin(&dst->seq);
 	/* write_seqcount_begin provides the necessary memory barrier */
 	RCU_INIT_POINTER(dst->fence_excl, new);
 	RCU_INIT_POINTER(dst->fence, dst_list);
 	write_seqcount_end(&dst->seq);
-	preempt_enable();
 
 	dma_resv_list_free(src_list);
 	dma_fence_put(old);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index b91b517..ff4b583 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -258,11 +258,9 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
 	new->shared_count = k;
 
 	/* Install the new fence list, seqcount provides the barriers */
-	preempt_disable();
 	write_seqcount_begin(&resv->seq);
 	RCU_INIT_POINTER(resv->fence, new);
 	write_seqcount_end(&resv->seq);
-	preempt_enable();
 
 	/* Drop the references to the removed fences or move them to ef_list */
 	for (i = j, k = 0; i < old->shared_count; ++i) {
diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
index a6538ae..d44a77e 100644
--- a/include/linux/dma-resv.h
+++ b/include/linux/dma-resv.h
@@ -69,7 +69,7 @@ struct dma_resv_list {
  */
 struct dma_resv {
 	struct ww_mutex lock;
-	seqcount_t seq;
+	seqcount_ww_mutex_t seq;
 
 	struct dma_fence __rcu *fence_excl;
 	struct dma_resv_list __rcu *fence;
