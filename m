Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,PDS_HP_HELO_NORDNS,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42430 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbgCKDoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 23:44:20 -0400
Received: by mail-pl1-f193.google.com with SMTP id t3so400806plz.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 20:44:17 -0700 (PDT)
From: Jason Ekstrand <jason@jlekstrand.net>
Cc: airlied@redhat.com, christian.koenig@amd.com, jessehall@google.com,
        jajones@nvidia.com, daniels@collabora.com, hoegsberg@google.com,
        daniel.vetter@ffwll.ch, bas@basnieuwenhuizen.nl,
        =?UTF-8?q?Christian=20K=C3=B6nig?=
        <ckoenig.leichtzumerken@gmail.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Chenbo Feng <fengc@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dma-buf: add dma_resv_get_singleton (v2)
Date: Tue, 10 Mar 2020 22:43:47 -0500
Message-Id: <20200311034351.1275197-2-jason@jlekstrand.net>
In-Reply-To: <20200311034351.1275197-1-jason@jlekstrand.net>
References: <20200303190318.522103-1-jason@jlekstrand.net>
 <20200311034351.1275197-1-jason@jlekstrand.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: unlisted-recipients:; (no To-header on input)@rostedt.homelinux.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
Message-ID: <20200311034347.WPgufJca2Qy31hnJvjMvkUCUSGnXMn18MCUccjR9TNQ@z>

From: Christian König <ckoenig.leichtzumerken@gmail.com>

Add a helper function to get a single fence representing
all fences in a dma_resv object.

This fence is either the only one in the object or all not
signaled fences of the object in a flatted out dma_fence_array.

v2 (Jason Ekstrand):
 - Take reference of fences both for creating the dma_fence_array and in
   the case where we return one fence.
 - Handle the case where dma_resv_get_list() returns NULL

Signed-off-by: Jason Ekstrand <jason@jlekstrand.net>
---
 drivers/dma-buf/dma-resv.c | 118 +++++++++++++++++++++++++++++++++++++
 include/linux/dma-resv.h   |   3 +
 2 files changed, 121 insertions(+)

diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index 4264e64788c4..66591d8ab7ef 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -33,6 +33,8 @@
  */
 
 #include <linux/dma-resv.h>
+#include <linux/dma-fence-chain.h>
+#include <linux/dma-fence-array.h>
 #include <linux/export.h>
 #include <linux/sched/mm.h>
 
@@ -47,6 +49,19 @@
  * write-side updates.
  */
 
+/**
+ * dma_fence_deep_dive_for_each - deep dive into the fence containers
+ * @fence: resulting fence
+ * @chain: variable for a dma_fence_chain
+ * @index: index into a dma_fence_array
+ * @head: starting point
+ *
+ * Helper to deep dive into the fence containers for flattening them.
+ */
+#define dma_fence_deep_dive_for_each(fence, chain, index, head)	\
+	dma_fence_chain_for_each(chain, head)			\
+		dma_fence_array_for_each(fence, index, chain)
+
 DEFINE_WD_CLASS(reservation_ww_class);
 EXPORT_SYMBOL(reservation_ww_class);
 
@@ -516,6 +531,109 @@ int dma_resv_get_fences_rcu(struct dma_resv *obj,
 }
 EXPORT_SYMBOL_GPL(dma_resv_get_fences_rcu);
 
+/**
+ * dma_resv_get_singleton - get a single fence for the dma_resv object
+ * @obj: the reservation object
+ * @extra: extra fence to add to the resulting array
+ * @result: resulting dma_fence
+ *
+ * Get a single fence representing all unsignaled fences in the dma_resv object
+ * plus the given extra fence. If we got only one fence return a new
+ * reference to that, otherwise return a dma_fence_array object.
+ *
+ * RETURNS
+ * Returns -NOMEM if allocations fail, zero otherwise.
+ */
+int dma_resv_get_singleton(struct dma_resv *obj, struct dma_fence *extra,
+			   struct dma_fence **result)
+{
+	struct dma_resv_list *fobj = dma_resv_get_list(obj);
+	struct dma_fence *excl = dma_resv_get_excl(obj);
+	struct dma_fence *fence, *chain, **fences;
+	struct dma_fence_array *array;
+	unsigned int num_fences, shared_count;
+	unsigned int i, j;
+
+	num_fences = 0;
+	*result = NULL;
+
+	dma_fence_deep_dive_for_each(fence, chain, i, extra) {
+		if (dma_fence_is_signaled(fence))
+			continue;
+
+		*result = fence;
+		++num_fences;
+	}
+
+	dma_fence_deep_dive_for_each(fence, chain, i, excl) {
+		if (dma_fence_is_signaled(fence))
+			continue;
+
+		*result = fence;
+		++num_fences;
+	}
+
+	shared_count = fobj ? fobj->shared_count : 0;
+	for (i = 0; i < shared_count; ++i) {
+		struct dma_fence *f;
+
+		f = rcu_dereference_protected(fobj->shared[i],
+					      dma_resv_held(obj));
+		dma_fence_deep_dive_for_each(fence, chain, j, f) {
+			if (dma_fence_is_signaled(fence))
+				continue;
+
+			*result = fence;
+			++num_fences;
+		}
+	}
+
+	if (num_fences <= 1) {
+		*result = dma_fence_get(*result);
+		return 0;
+	}
+
+	fences = kmalloc_array(num_fences, sizeof(struct dma_fence*),
+			       GFP_KERNEL);
+	if (!fences)
+		return -ENOMEM;
+
+	num_fences = 0;
+
+	dma_fence_deep_dive_for_each(fence, chain, i, extra)
+		if (!dma_fence_is_signaled(fence))
+			fences[num_fences++] = dma_fence_get(fence);
+
+	dma_fence_deep_dive_for_each(fence, chain, i, excl)
+		if (!dma_fence_is_signaled(fence))
+			fences[num_fences++] = dma_fence_get(fence);
+
+	for (i = 0; i < shared_count; ++i) {
+		struct dma_fence *f;
+
+		f = rcu_dereference_protected(fobj->shared[i],
+					      dma_resv_held(obj));
+		dma_fence_deep_dive_for_each(fence, chain, j, f)
+			if (!dma_fence_is_signaled(fence))
+				fences[num_fences++] = dma_fence_get(fence);
+	}
+
+	array = dma_fence_array_create(num_fences, fences,
+				       dma_fence_context_alloc(1),
+				       1, false);
+	if (!array)
+		goto error_free;
+
+	*result = &array->base;
+	return 0;
+
+error_free:
+	while (num_fences--)
+		dma_fence_put(fences[num_fences]);
+	kfree(fences);
+	return -ENOMEM;
+}
+
 /**
  * dma_resv_wait_timeout_rcu - Wait on reservation's objects
  * shared and/or exclusive fences.
diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
index ee50d10f052b..d50e753e4550 100644
--- a/include/linux/dma-resv.h
+++ b/include/linux/dma-resv.h
@@ -287,6 +287,9 @@ int dma_resv_get_fences_rcu(struct dma_resv *obj,
 
 int dma_resv_copy_fences(struct dma_resv *dst, struct dma_resv *src);
 
+int dma_resv_get_singleton(struct dma_resv *obj, struct dma_fence *extra,
+			   struct dma_fence **result);
+
 long dma_resv_wait_timeout_rcu(struct dma_resv *obj, bool wait_all, bool intr,
 			       unsigned long timeout);
 
-- 
2.24.1

