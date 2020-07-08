Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153D7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3EDA2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aF99qXFL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ISo+kVYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgGHJvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbgGHJvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:51:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7CBC08C5DC;
        Wed,  8 Jul 2020 02:51:49 -0700 (PDT)
Date:   Wed, 08 Jul 2020 09:51:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594201907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Zy3ybiBNjr/H0af95SIF94cU72PMtPmzrkLbDmx8gs=;
        b=aF99qXFLMZOq+W9GUTnMcVCQy1SOCq4AjzrDGIkQh+npLo7W1OqO3uXVoWTuF5IUbCY8p7
        N/umC0XK9Neh5/ZtmFFJigMWxX9fcBLrer2TEJHY+N7JpjoKb0Frp2y1tHzU1j103kElts
        93pcrFCD+aT7OgiIjeHcAEbLuSNP9V11zsCiQoVcLMuKVHxi/v2FNemM6fxkbZuGn2kwtK
        iepGH4w3gTHx7oJhWmctVFnD+pQ5PiBoP30y/yA0eBeNRKPnIie+hdywvsWpsRU5TXGtok
        Xm+TwPMvPJ2vH6fPOdC599/692Z84y7wtgerdrQanmeSTCQ9s7O2HZxUlRl/ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594201907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Zy3ybiBNjr/H0af95SIF94cU72PMtPmzrkLbDmx8gs=;
        b=ISo+kVYaTxQoiZnUcpWjfJ9ViyP5CSHsbxqc35UCBk/y8noDZELX/ccNkfrYO8J9kJBiun
        /9CtUlC5xVip1IAA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Use kmem_cache to allocate the PMU specific data
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1593780569-62993-17-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-17-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159420190705.4006.11190540790919295173.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     217c2a633ebb36f1cc6d249f4ef2e4a809d46818
Gitweb:        https://git.kernel.org/tip/217c2a633ebb36f1cc6d249f4ef2e4a809d46818
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 03 Jul 2020 05:49:22 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:38:55 +02:00

perf/core: Use kmem_cache to allocate the PMU specific data

Currently, the PMU specific data task_ctx_data is allocated by the
function kzalloc() in the perf generic code. When there is no specific
alignment requirement for the task_ctx_data, the method works well for
now. However, there will be a problem once a specific alignment
requirement is introduced in future features, e.g., the Architecture LBR
XSAVE feature requires 64-byte alignment. If the specific alignment
requirement is not fulfilled, the XSAVE family of instructions will fail
to save/restore the xstate to/from the task_ctx_data.

The function kzalloc() itself only guarantees a natural alignment. A
new method to allocate the task_ctx_data has to be introduced, which
has to meet the requirements as below:
- must be a generic method can be used by different architectures,
  because the allocation of the task_ctx_data is implemented in the
  perf generic code;
- must be an alignment-guarantee method (The alignment requirement is
  not changed after the boot);
- must be able to allocate/free a buffer (smaller than a page size)
  dynamically;
- should not cause extra CPU overhead or space overhead.

Several options were considered as below:
- One option is to allocate a larger buffer for task_ctx_data. E.g.,
    ptr = kmalloc(size + alignment, GFP_KERNEL);
    ptr &= ~(alignment - 1);
  This option causes space overhead.
- Another option is to allocate the task_ctx_data in the PMU specific
  code. To do so, several function pointers have to be added. As a
  result, both the generic structure and the PMU specific structure
  will become bigger. Besides, extra function calls are added when
  allocating/freeing the buffer. This option will increase both the
  space overhead and CPU overhead.
- The third option is to use a kmem_cache to allocate a buffer for the
  task_ctx_data. The kmem_cache can be created with a specific alignment
  requirement by the PMU at boot time. A new pointer for kmem_cache has
  to be added in the generic struct pmu, which would be used to
  dynamically allocate a buffer for the task_ctx_data at run time.
  Although the new pointer is added to the struct pmu, the existing
  variable task_ctx_size is not required anymore. The size of the
  generic structure is kept the same.

The third option which meets all the aforementioned requirements is used
to replace kzalloc() for the PMU specific data allocation. A later patch
will remove the kzalloc() method and the related variables.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1593780569-62993-17-git-send-email-kan.liang@linux.intel.com
---
 include/linux/perf_event.h | 5 +++++
 kernel/events/core.c       | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 46fe5cf..09915ae 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -425,6 +425,11 @@ struct pmu {
 	size_t				task_ctx_size;
 
 	/*
+	 * Kmem cache of PMU specific data
+	 */
+	struct kmem_cache		*task_ctx_cache;
+
+	/*
 	 * PMU specific parts of task perf event context (i.e. ctx->task_ctx_data)
 	 * can be synchronized using this function. See Intel LBR callstack support
 	 * implementation and Perf core context switch handling callbacks for usage
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7509040..30d9b31 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1240,12 +1240,18 @@ static void get_ctx(struct perf_event_context *ctx)
 
 static void *alloc_task_ctx_data(struct pmu *pmu)
 {
+	if (pmu->task_ctx_cache)
+		return kmem_cache_zalloc(pmu->task_ctx_cache, GFP_KERNEL);
+
 	return kzalloc(pmu->task_ctx_size, GFP_KERNEL);
 }
 
 static void free_task_ctx_data(struct pmu *pmu, void *task_ctx_data)
 {
-	kfree(task_ctx_data);
+	if (pmu->task_ctx_cache && task_ctx_data)
+		kmem_cache_free(pmu->task_ctx_cache, task_ctx_data);
+	else
+		kfree(task_ctx_data);
 }
 
 static void free_ctx(struct rcu_head *head)
