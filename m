Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BCDC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3380C207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="OTjSgTX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbgHTLwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgHTLui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:50:38 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3415BC061387
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 04:50:38 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o23so2166925ejr.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 04:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9KvhtHICF0TxOfrbvj/8zshCyJ1YS3JOgoqNxp3Dtog=;
        b=OTjSgTX26tjI06uphAGdtLggVcIgVcSt1nz4x60CK0u4ojkcFGNakF5cn05N44O/dR
         JXD6+G8MocvROe0iUMI1ZrQ40vkGq7A30yIfErACZJDTCan2wRABxXvixJL45sr3Rr/2
         8xxq5DF+WSzeLDRiQWcbLYeCgl03xjD/tvCtvtMLnfEbR/oaoDdjyZ4DLEKEl98FNYc4
         DV9NXq2L6rrWdMQ9XvoIhc34sEnFVAsnLIr7NvtQWRsgsR8rFDBFNakuSp3QKoLKwgDl
         nPQM+VliGVKGFOp4rv7LGlXSOWRVmxWkAVpEoAKPb0IYvt3QniG6aRRGqqsN+SeXncCP
         kbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9KvhtHICF0TxOfrbvj/8zshCyJ1YS3JOgoqNxp3Dtog=;
        b=oY8e/8RsTOTFJcHeo2XRC2OoqnhcxAckOFP1OfnA4XryiM7WjQrUaw3zFLbpMmSIAJ
         kjJUIbwd98zmdCR+u4sTueQtCB+s+A2TGt87kLDU2DsOP8B2/Zrhypg19/GyzAnju5V+
         KJrUFSkT7YL64Nzi9ZzPf8RdB9qhMV9rdHyZ6q2Yk/QcwNNYI5YjOxLKkUrS6k7f1lzH
         b5lzq2sE+CFcHjcC9MohsUuAu7cYXULInFysSu+t/9Q29zy8w4ABJCkc43FjReP8CPLi
         EYBCwISPPmG4kYa+dYA3nF97p1dawaXrB5tu7WCaO0xFtLa2OFw3QQIFLVnfVc/tqqja
         HLuA==
X-Gm-Message-State: AOAM533IYCLA0tQGjBiPYHg+j8nlT1LhCyPFhFHrvWerh3soUV3Oaarg
        2dd65rX383eHfMhu4G1wQQtyyA==
X-Google-Smtp-Source: ABdhPJz+xq++T0cU+EUORbqtkNA9eSQnIaxdJEeZWGYtdPFVNSQjrdlUNXUw/OLLWuv93oO1tCQvhA==
X-Received: by 2002:a17:906:260c:: with SMTP id h12mr2985086ejc.457.1597924236812;
        Thu, 20 Aug 2020 04:50:36 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id m13sm1185358edi.89.2020.08.20.04.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 04:50:36 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     gregkh@linuxfoundation.org, tkjos@google.com, arve@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        maco@google.com, Martijn Coenen <maco@android.com>
Subject: [PATCH v2] ANDROID: binder: print warnings when detecting oneway spamming.
Date:   Thu, 20 Aug 2020 13:50:33 +0200
Message-Id: <20200820115033.276111-1-maco@android.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The most common cause of the binder transaction buffer filling up is a
client rapidly firing oneway transactions into a process, before it has
a chance to handle them. Yet the root cause of this is often hard to
debug, because either the system or the app will stop, and by that time
binder debug information we dump in bugreports is no longer relevant.

This change warns as soon as a process dips below 80% of its oneway
space (less than 100kB available in the configuration), when any one
process is responsible for either more than 50 transactions, or more
than 50% of the oneway space.

Signed-off-by: Martijn Coenen <maco@android.com>
---
v2: fixed call-site in binder_alloc_selftest

 drivers/android/binder.c                |  2 +-
 drivers/android/binder_alloc.c          | 49 +++++++++++++++++++++++--
 drivers/android/binder_alloc.h          |  5 ++-
 drivers/android/binder_alloc_selftest.c |  2 +-
 4 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index f936530a19b0..946332bc871a 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3136,7 +3136,7 @@ static void binder_transaction(struct binder_proc *proc,
 
 	t->buffer = binder_alloc_new_buf(&target_proc->alloc, tr->data_size,
 		tr->offsets_size, extra_buffers_size,
-		!reply && (t->flags & TF_ONE_WAY));
+		!reply && (t->flags & TF_ONE_WAY), current->tgid);
 	if (IS_ERR(t->buffer)) {
 		/*
 		 * -ESRCH indicates VMA cleared. The target is dying.
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 69609696a843..76e8e633dbd4 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -338,12 +338,48 @@ static inline struct vm_area_struct *binder_alloc_get_vma(
 	return vma;
 }
 
+static void debug_low_async_space_locked(struct binder_alloc *alloc, int pid)
+{
+	/*
+	 * Find the amount and size of buffers allocated by the current caller;
+	 * The idea is that once we cross the threshold, whoever is responsible
+	 * for the low async space is likely to try to send another async txn,
+	 * and at some point we'll catch them in the act. This is more efficient
+	 * than keeping a map per pid.
+	 */
+	struct rb_node *n = alloc->free_buffers.rb_node;
+	struct binder_buffer *buffer;
+	size_t buffer_size;
+	size_t total_alloc_size = 0;
+	size_t num_buffers = 0;
+
+	for (n = rb_first(&alloc->allocated_buffers); n != NULL;
+		 n = rb_next(n)) {
+		buffer = rb_entry(n, struct binder_buffer, rb_node);
+		if (buffer->pid != pid)
+			continue;
+		if (!buffer->async_transaction)
+			continue;
+		buffer_size = binder_alloc_buffer_size(alloc, buffer);
+		total_alloc_size += buffer_size;
+		num_buffers++;
+	}
+
+	// Warn if this pid has more than 50% of async space, or more than 50 txns
+	if (num_buffers > 50 || total_alloc_size > alloc->buffer_size / 4) {
+		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
+			     "%d: pid %d spamming oneway? %zd buffers allocated for a total size of %zd\n",
+			      alloc->pid, pid, num_buffers, total_alloc_size);
+	}
+}
+
 static struct binder_buffer *binder_alloc_new_buf_locked(
 				struct binder_alloc *alloc,
 				size_t data_size,
 				size_t offsets_size,
 				size_t extra_buffers_size,
-				int is_async)
+				int is_async,
+				int pid)
 {
 	struct rb_node *n = alloc->free_buffers.rb_node;
 	struct binder_buffer *buffer;
@@ -486,11 +522,16 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	buffer->offsets_size = offsets_size;
 	buffer->async_transaction = is_async;
 	buffer->extra_buffers_size = extra_buffers_size;
+	buffer->pid = pid;
 	if (is_async) {
 		alloc->free_async_space -= size + sizeof(struct binder_buffer);
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC_ASYNC,
 			     "%d: binder_alloc_buf size %zd async free %zd\n",
 			      alloc->pid, size, alloc->free_async_space);
+		if (alloc->free_async_space < alloc->buffer_size / 10) {
+			// Start detecting spammers once we reach 80% of async space used
+			debug_low_async_space_locked(alloc, pid);
+		}
 	}
 	return buffer;
 
@@ -508,6 +549,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
  * @offsets_size:       user specified buffer offset
  * @extra_buffers_size: size of extra space for meta-data (eg, security context)
  * @is_async:           buffer for async transaction
+ * @pid:				pid to attribute allocation to (used for debugging)
  *
  * Allocate a new buffer given the requested sizes. Returns
  * the kernel version of the buffer pointer. The size allocated
@@ -520,13 +562,14 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 					   size_t data_size,
 					   size_t offsets_size,
 					   size_t extra_buffers_size,
-					   int is_async)
+					   int is_async,
+					   int pid)
 {
 	struct binder_buffer *buffer;
 
 	mutex_lock(&alloc->mutex);
 	buffer = binder_alloc_new_buf_locked(alloc, data_size, offsets_size,
-					     extra_buffers_size, is_async);
+					     extra_buffers_size, is_async, pid);
 	mutex_unlock(&alloc->mutex);
 	return buffer;
 }
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index db9c1b984695..55d8b4106766 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -32,6 +32,7 @@ struct binder_transaction;
  * @offsets_size:       size of array of offsets
  * @extra_buffers_size: size of space for other objects (like sg lists)
  * @user_data:          user pointer to base of buffer space
+ * @pid:                pid to attribute the buffer to (caller)
  *
  * Bookkeeping structure for binder transaction buffers
  */
@@ -51,6 +52,7 @@ struct binder_buffer {
 	size_t offsets_size;
 	size_t extra_buffers_size;
 	void __user *user_data;
+	int    pid;
 };
 
 /**
@@ -117,7 +119,8 @@ extern struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 						  size_t data_size,
 						  size_t offsets_size,
 						  size_t extra_buffers_size,
-						  int is_async);
+						  int is_async,
+						  int pid);
 extern void binder_alloc_init(struct binder_alloc *alloc);
 extern int binder_alloc_shrinker_init(void);
 extern void binder_alloc_vma_close(struct binder_alloc *alloc);
diff --git a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
index 4151d9938255..c2b323bc3b3a 100644
--- a/drivers/android/binder_alloc_selftest.c
+++ b/drivers/android/binder_alloc_selftest.c
@@ -119,7 +119,7 @@ static void binder_selftest_alloc_buf(struct binder_alloc *alloc,
 	int i;
 
 	for (i = 0; i < BUFFER_NUM; i++) {
-		buffers[i] = binder_alloc_new_buf(alloc, sizes[i], 0, 0, 0);
+		buffers[i] = binder_alloc_new_buf(alloc, sizes[i], 0, 0, 0, 0);
 		if (IS_ERR(buffers[i]) ||
 		    !check_buffer_pages_allocated(alloc, buffers[i],
 						  sizes[i])) {
-- 
2.28.0.220.ged08abb693-goog

