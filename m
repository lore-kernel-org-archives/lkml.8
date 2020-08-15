Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DAFC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E6D20639
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mFFM1Oyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgHOWHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbgHOVuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:50:46 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B98C061342
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 17:40:29 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id x6so5298298pgx.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 17:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=diqXePpQfxSpJLpQQOfQC8i1Pcl/TtcLU6rF23zLEEI=;
        b=mFFM1OygZI2msD4NTsf2qqkDTzcazgCzMa+x1S+3E7NDIbucbrUaZJXrQAO5XqPT7j
         994hZW9FDTJZoE8D3ocHok2kHs+6lSidKRHwjucc5TSKpCSmyEm20JfKJNp5+b8hknwu
         yhXBezxdxNCuKTbFVZSbBewHzfL1vg/358SYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=diqXePpQfxSpJLpQQOfQC8i1Pcl/TtcLU6rF23zLEEI=;
        b=fsY374gO6s9G71NHvvaUkcjTTHMZ4XEvuSGjjNJ7zZLd4QO+oC41+fyEOQL+fyceAb
         6Smn010Ksy2G5c6SsckX6dWA+juh5aMUdMF4XToHO4Ue3bMDfTr1dJI5b16PsnEILp5j
         vOpPzkPBGt6Aig6G1H4RHNZ4hIbbQ8o/yxDXF77uX/vFcMK/ZmsAO9jJfwV/QeWfFO6A
         If2aAh9BB1deBwCUqDpvCU1PmT/MgU+G7D5KHv6tkJ+zJiGqYbK7LY/U3zwtbCeJz5lq
         vXL7MlvXLBMfOjUYyCXenLHYDQwCYh2B+z6PPP3enOFu4UYrPo6eK3GgRjM3U0Jflv1G
         lCrQ==
X-Gm-Message-State: AOAM532k6L7ZCrTFYOJAsdPYi8qtsfVrcrH2gNAOZy+CjSMqp2Y8lTAO
        9uvHtCg+VQiPUwGoAf1lsJTvYRUkmXEmMQ==
X-Google-Smtp-Source: ABdhPJwIEUsjzuZryI8OB5suIelqF+iGmrSZ+43qbqZgQgxF629z2p9LizMiUeUWyOKhvDlkbwRH0A==
X-Received: by 2002:a05:6a00:1509:: with SMTP id q9mr3583237pfu.24.1597452029406;
        Fri, 14 Aug 2020 17:40:29 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id x6sm10577131pfd.53.2020.08.14.17.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 17:40:28 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] debugobjects: Allow debug_obj_descr to be const
Date:   Fri, 14 Aug 2020 17:40:26 -0700
Message-Id: <20200815004027.2046113-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
In-Reply-To: <20200815004027.2046113-1-swboyd@chromium.org>
References: <20200815004027.2046113-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugobject core could be slightly harder to corrupt if we make the
debug_obj_descr a pointer to const memory. Depending on the
architecture, const datastructures are placed into read-only memory and
thus are harder to corrupt or hijack. This descriptor is used to fix up
stuff like timers and workqueues when core kernel datastructures are
busted, so moving the descriptors to read-only memory will make
debugobjects more resilient to something going wrong and then corrupting
the function pointers inside struct debug_obj_descr.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 include/linux/debugobjects.h | 32 ++++++++++++++++----------------
 lib/debugobjects.c           | 30 +++++++++++++++---------------
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/include/linux/debugobjects.h b/include/linux/debugobjects.h
index afc416e5dcab..8d2dde23e9fb 100644
--- a/include/linux/debugobjects.h
+++ b/include/linux/debugobjects.h
@@ -30,7 +30,7 @@ struct debug_obj {
 	enum debug_obj_state	state;
 	unsigned int		astate;
 	void			*object;
-	struct debug_obj_descr	*descr;
+	const struct debug_obj_descr *descr;
 };
 
 /**
@@ -64,14 +64,14 @@ struct debug_obj_descr {
 };
 
 #ifdef CONFIG_DEBUG_OBJECTS
-extern void debug_object_init      (void *addr, struct debug_obj_descr *descr);
+extern void debug_object_init      (void *addr, const struct debug_obj_descr *descr);
 extern void
-debug_object_init_on_stack(void *addr, struct debug_obj_descr *descr);
-extern int debug_object_activate  (void *addr, struct debug_obj_descr *descr);
-extern void debug_object_deactivate(void *addr, struct debug_obj_descr *descr);
-extern void debug_object_destroy   (void *addr, struct debug_obj_descr *descr);
-extern void debug_object_free      (void *addr, struct debug_obj_descr *descr);
-extern void debug_object_assert_init(void *addr, struct debug_obj_descr *descr);
+debug_object_init_on_stack(void *addr, const struct debug_obj_descr *descr);
+extern int debug_object_activate  (void *addr, const struct debug_obj_descr *descr);
+extern void debug_object_deactivate(void *addr, const struct debug_obj_descr *descr);
+extern void debug_object_destroy   (void *addr, const struct debug_obj_descr *descr);
+extern void debug_object_free      (void *addr, const struct debug_obj_descr *descr);
+extern void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr);
 
 /*
  * Active state:
@@ -79,26 +79,26 @@ extern void debug_object_assert_init(void *addr, struct debug_obj_descr *descr);
  * - Must return to 0 before deactivation.
  */
 extern void
-debug_object_active_state(void *addr, struct debug_obj_descr *descr,
+debug_object_active_state(void *addr, const struct debug_obj_descr *descr,
 			  unsigned int expect, unsigned int next);
 
 extern void debug_objects_early_init(void);
 extern void debug_objects_mem_init(void);
 #else
 static inline void
-debug_object_init      (void *addr, struct debug_obj_descr *descr) { }
+debug_object_init      (void *addr, const struct debug_obj_descr *descr) { }
 static inline void
-debug_object_init_on_stack(void *addr, struct debug_obj_descr *descr) { }
+debug_object_init_on_stack(void *addr, const struct debug_obj_descr *descr) { }
 static inline int
-debug_object_activate  (void *addr, struct debug_obj_descr *descr) { return 0; }
+debug_object_activate  (void *addr, const struct debug_obj_descr *descr) { return 0; }
 static inline void
-debug_object_deactivate(void *addr, struct debug_obj_descr *descr) { }
+debug_object_deactivate(void *addr, const struct debug_obj_descr *descr) { }
 static inline void
-debug_object_destroy   (void *addr, struct debug_obj_descr *descr) { }
+debug_object_destroy   (void *addr, const struct debug_obj_descr *descr) { }
 static inline void
-debug_object_free      (void *addr, struct debug_obj_descr *descr) { }
+debug_object_free      (void *addr, const struct debug_obj_descr *descr) { }
 static inline void
-debug_object_assert_init(void *addr, struct debug_obj_descr *descr) { }
+debug_object_assert_init(void *addr, const struct debug_obj_descr *descr) { }
 
 static inline void debug_objects_early_init(void) { }
 static inline void debug_objects_mem_init(void) { }
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index fe4557955d97..e2a3171b6c63 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -90,7 +90,7 @@ static int			debug_objects_pool_size __read_mostly
 				= ODEBUG_POOL_SIZE;
 static int			debug_objects_pool_min_level __read_mostly
 				= ODEBUG_POOL_MIN_LEVEL;
-static struct debug_obj_descr	*descr_test  __read_mostly;
+static const struct debug_obj_descr *descr_test  __read_mostly;
 static struct kmem_cache	*obj_cache __read_mostly;
 
 /*
@@ -223,7 +223,7 @@ static struct debug_obj *__alloc_object(struct hlist_head *list)
  * Must be called with interrupts disabled.
  */
 static struct debug_obj *
-alloc_object(void *addr, struct debug_bucket *b, struct debug_obj_descr *descr)
+alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *descr)
 {
 	struct debug_percpu_free *percpu_pool = this_cpu_ptr(&percpu_obj_pool);
 	struct debug_obj *obj;
@@ -475,7 +475,7 @@ static struct debug_bucket *get_bucket(unsigned long addr)
 
 static void debug_print_object(struct debug_obj *obj, char *msg)
 {
-	struct debug_obj_descr *descr = obj->descr;
+	const struct debug_obj_descr *descr = obj->descr;
 	static int limit;
 
 	if (limit < 5 && descr != descr_test) {
@@ -529,7 +529,7 @@ static void debug_object_is_on_stack(void *addr, int onstack)
 }
 
 static void
-__debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
+__debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack)
 {
 	enum debug_obj_state state;
 	bool check_stack = false;
@@ -587,7 +587,7 @@ __debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
  * @addr:	address of the object
  * @descr:	pointer to an object specific debug description structure
  */
-void debug_object_init(void *addr, struct debug_obj_descr *descr)
+void debug_object_init(void *addr, const struct debug_obj_descr *descr)
 {
 	if (!debug_objects_enabled)
 		return;
@@ -602,7 +602,7 @@ EXPORT_SYMBOL_GPL(debug_object_init);
  * @addr:	address of the object
  * @descr:	pointer to an object specific debug description structure
  */
-void debug_object_init_on_stack(void *addr, struct debug_obj_descr *descr)
+void debug_object_init_on_stack(void *addr, const struct debug_obj_descr *descr)
 {
 	if (!debug_objects_enabled)
 		return;
@@ -617,7 +617,7 @@ EXPORT_SYMBOL_GPL(debug_object_init_on_stack);
  * @descr:	pointer to an object specific debug description structure
  * Returns 0 for success, -EINVAL for check failed.
  */
-int debug_object_activate(void *addr, struct debug_obj_descr *descr)
+int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 {
 	enum debug_obj_state state;
 	struct debug_bucket *db;
@@ -695,7 +695,7 @@ EXPORT_SYMBOL_GPL(debug_object_activate);
  * @addr:	address of the object
  * @descr:	pointer to an object specific debug description structure
  */
-void debug_object_deactivate(void *addr, struct debug_obj_descr *descr)
+void debug_object_deactivate(void *addr, const struct debug_obj_descr *descr)
 {
 	struct debug_bucket *db;
 	struct debug_obj *obj;
@@ -747,7 +747,7 @@ EXPORT_SYMBOL_GPL(debug_object_deactivate);
  * @addr:	address of the object
  * @descr:	pointer to an object specific debug description structure
  */
-void debug_object_destroy(void *addr, struct debug_obj_descr *descr)
+void debug_object_destroy(void *addr, const struct debug_obj_descr *descr)
 {
 	enum debug_obj_state state;
 	struct debug_bucket *db;
@@ -797,7 +797,7 @@ EXPORT_SYMBOL_GPL(debug_object_destroy);
  * @addr:	address of the object
  * @descr:	pointer to an object specific debug description structure
  */
-void debug_object_free(void *addr, struct debug_obj_descr *descr)
+void debug_object_free(void *addr, const struct debug_obj_descr *descr)
 {
 	enum debug_obj_state state;
 	struct debug_bucket *db;
@@ -838,7 +838,7 @@ EXPORT_SYMBOL_GPL(debug_object_free);
  * @addr:	address of the object
  * @descr:	pointer to an object specific debug description structure
  */
-void debug_object_assert_init(void *addr, struct debug_obj_descr *descr)
+void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr)
 {
 	struct debug_bucket *db;
 	struct debug_obj *obj;
@@ -886,7 +886,7 @@ EXPORT_SYMBOL_GPL(debug_object_assert_init);
  * @next:	state to move to if expected state is found
  */
 void
-debug_object_active_state(void *addr, struct debug_obj_descr *descr,
+debug_object_active_state(void *addr, const struct debug_obj_descr *descr,
 			  unsigned int expect, unsigned int next)
 {
 	struct debug_bucket *db;
@@ -934,7 +934,7 @@ EXPORT_SYMBOL_GPL(debug_object_active_state);
 static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 {
 	unsigned long flags, oaddr, saddr, eaddr, paddr, chunks;
-	struct debug_obj_descr *descr;
+	const struct debug_obj_descr *descr;
 	enum debug_obj_state state;
 	struct debug_bucket *db;
 	struct hlist_node *tmp;
@@ -1052,7 +1052,7 @@ struct self_test {
 	unsigned long	dummy2[3];
 };
 
-static __initdata struct debug_obj_descr descr_type_test;
+static __initconst const struct debug_obj_descr descr_type_test;
 
 static bool __init is_static_object(void *addr)
 {
@@ -1177,7 +1177,7 @@ check_results(void *addr, enum debug_obj_state state, int fixups, int warnings)
 	return res;
 }
 
-static __initdata struct debug_obj_descr descr_type_test = {
+static __initconst const struct debug_obj_descr descr_type_test = {
 	.name			= "selftest",
 	.is_static_object	= is_static_object,
 	.fixup_init		= fixup_init,
-- 
Sent by a computer, using git, on the internet

