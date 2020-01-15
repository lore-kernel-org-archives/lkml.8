Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18505C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1B12081E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Epaig+j3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbgAOWkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 17:40:06 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41203 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbgAOWkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 17:40:05 -0500
Received: by mail-pg1-f195.google.com with SMTP id x8so8871161pgk.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 14:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IXmIKKmukBEkXeNi4zoisoHlMWXP2Nla9bX+JfIYkA4=;
        b=Epaig+j3Q8BABzjX6vvHr5MViUZJ+IN1pJJfY/Rv6QWlOI58yQU84UXdjdSdWtYT9l
         VH+rpsQg/eNApS9UGzqxpZGhNgpwO57U95BlR+qN2ngm26bd1+nSFyohlchnTfH7CDp6
         KamS7ymMV22wqRuj6I/nm51pQaWgFfGQ3alhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IXmIKKmukBEkXeNi4zoisoHlMWXP2Nla9bX+JfIYkA4=;
        b=TecZH86XocblFhnZ9KNFd8rRw/MaswdNL9mtNhTfxWJG+Yss+75ea9TX78dDuMZKie
         q677fZ5C8NG3FtTjwSZKHZ2XqBdMUQemweaks6CFZ1BJd132m955G+X7VhOLYoBVtFiE
         d3chSgVkiZAc27jhSk+t91amvNkM8Qtk2Gn66c0t05XRpY5K0jGC9vjGk7UBfUVWaUNx
         IhlM0g+JQvqnCe6W+ZwnFtkWv+bcMmhlcM/h1C8pI94zEcw7ltFmfCJE/0yITdjYZLHR
         rfZW7xKnqqMloRi0LJJp0shUbW3DD1KYleocDwVpcyYRriTv3ewv0F31pTxCS7+B9w1W
         BSFA==
X-Gm-Message-State: APjAAAV66dttix0adwn/9WzKOXoZGmA3E1zxOnFhY9cJJLGlumtQpCBL
        f3qU4Fp6+xoFosx79znqT96r2x68ecY=
X-Google-Smtp-Source: APXvYqzra6LvWdEFBbAvveb1ubtyJmHLKJG4aq4te15MdcRRcrJ2WUHUBe3t4B+bPrvX4DFa3Std3Q==
X-Received: by 2002:a05:6a00:2ae:: with SMTP id q14mr33736628pfs.155.1579128004890;
        Wed, 15 Jan 2020 14:40:04 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id c18sm22625470pfr.40.2020.01.15.14.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 14:40:04 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joelaf@google.com>, urezki@gmail.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 1/2] rcuperf: Add support to vary the slab object sizes
Date:   Wed, 15 Jan 2020 17:40:00 -0500
Message-Id: <20200115224001.244781-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Fernandes <joelaf@google.com>

This patch varies the allocated size of objects to be more realistic in
comparison to production workloads.

Cc: urezki@gmail.com
Signed-off-by: Joel Fernandes <joelaf@google.com>

---
 kernel/rcu/rcuperf.c | 48 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index da94b89cd531..1fd0cc72022e 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -87,6 +87,7 @@ torture_param(bool, shutdown, RCUPERF_SHUTDOWN,
 torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
 torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() perf test?");
+torture_param(bool, kfree_vary_obj_size, 0, "Vary the kfree_rcu object size");
 
 static char *perf_type = "rcu";
 module_param(perf_type, charp, 0444);
@@ -599,17 +600,29 @@ static int kfree_nrealthreads;
 static atomic_t n_kfree_perf_thread_started;
 static atomic_t n_kfree_perf_thread_ended;
 
-struct kfree_obj {
-	char kfree_obj[8];
-	struct rcu_head rh;
-};
+/*
+ * Define a kfree_obj with size as the @size parameter + the size of rcu_head
+ * (rcu_head is 16 bytes on 64-bit arch).
+ */
+#define DEFINE_KFREE_OBJ(size)	\
+struct kfree_obj_ ## size {	\
+	char kfree_obj[size];	\
+	struct rcu_head rh;	\
+}
+
+/* This should goto the right sized slabs on both 32-bit and 64-bit arch */
+DEFINE_KFREE_OBJ(16); // goes on kmalloc-32 slab
+DEFINE_KFREE_OBJ(32); // goes on kmalloc-64 slab
+DEFINE_KFREE_OBJ(64); // goes on kmalloc-96 slab
+DEFINE_KFREE_OBJ(96); // goes on kmalloc-128 slab
 
 static int
 kfree_perf_thread(void *arg)
 {
 	int i, loop = 0;
 	long me = (long)arg;
-	struct kfree_obj *alloc_ptr;
+	void *alloc_ptr;
+
 	u64 start_time, end_time;
 
 	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
@@ -627,11 +640,32 @@ kfree_perf_thread(void *arg)
 
 	do {
 		for (i = 0; i < kfree_alloc_num; i++) {
-			alloc_ptr = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
+			int kfree_type = i % 4;
+
+			// Allocate only kfree_obj_16 if rcuperf.kfree_vary_obj_size not passed.
+			if (!kfree_vary_obj_size)
+				kfree_type = 0;
+
+			if (kfree_type == 0)
+				alloc_ptr = kmalloc(sizeof(struct kfree_obj_16), GFP_KERNEL);
+			else if (kfree_type == 1)
+				alloc_ptr = kmalloc(sizeof(struct kfree_obj_32), GFP_KERNEL);
+			else if (kfree_type == 2)
+				alloc_ptr = kmalloc(sizeof(struct kfree_obj_64), GFP_KERNEL);
+			else
+				alloc_ptr = kmalloc(sizeof(struct kfree_obj_96),  GFP_KERNEL);
+
 			if (!alloc_ptr)
 				return -ENOMEM;
 
-			kfree_rcu(alloc_ptr, rh);
+			if (kfree_type == 0)
+				kfree_rcu((struct kfree_obj_16 *)alloc_ptr, rh);
+			else if (kfree_type == 1)
+				kfree_rcu((struct kfree_obj_32 *)alloc_ptr, rh);
+			else if (kfree_type == 2)
+				kfree_rcu((struct kfree_obj_64 *)alloc_ptr, rh);
+			else
+				kfree_rcu((struct kfree_obj_96 *)alloc_ptr, rh);
 		}
 
 		cond_resched();
-- 
2.25.0.rc1.283.g88dfdc4193-goog

