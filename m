Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526DDC2D0ED
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEC32078B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QzIZMvvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgC3CeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:34:03 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41059 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgC3Cdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 22:33:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id i3so13899365qtv.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 19:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GUEUjnZByBMLXXgM/0YNDI/bxdwR+I0Cjr1aQHLknOs=;
        b=QzIZMvvKWmxMiOU35hOs8CLclttdCYXncAnCQ+hBWiQayLQhtd54ejH+VB98qoGytL
         jL4QHOy47RVa5FzCvrDWf8Y+mlYDsycomyOHalE85DcVFRzlvjF04cfiJQiaX6rxsrTb
         vvECi0mg+SEVN6NPXug5XDilRNcywkAzXeCnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GUEUjnZByBMLXXgM/0YNDI/bxdwR+I0Cjr1aQHLknOs=;
        b=EC21iTUXHlWNJk+tLijkXQ0ZSvIvitBaNeUg3j3V4RyecVh+mvpGFss5gtX34D5UlG
         lhPQMxBbBX/BWinftaANKv09+ZJuSCYh91Jt/T6/Vs5k7qWTfQjE8JAPyJpdb5A/1D9f
         VnZFCypwKiYbGVLqHf/SCP1tY5CC5Di79AOmJO9iekZ6hWkdp6/2URWLrUZjOgs1zzZ9
         RQWnzaQrmAh/idvuJ6t5CKsNcfTYU0EkRyIJ+gMaUZvQlFo0nTrV9ERGAUu8QzkVO19u
         dd581N3Mhi+Kkfq4PPgccit7OL1Yw+35TOcjuX/XIdf0QLVpSTIvCAKBPumQtlKU1nxf
         FkwA==
X-Gm-Message-State: ANhLgQ1m32JRPeYaZA+hDd5NtzBHhOqgf+sigOwdYB6ZZRWAoHwcuff5
        HZsg/5FULDICSmCPnIfOalYMgj9SUDo=
X-Google-Smtp-Source: ADFU+vuY3vIdhCVs5nHfOdatShJUCKQJyQx8NufJHl0QmK67xOuIERE/nmABHpB1Lz3V3kwdOI7DTA==
X-Received: by 2002:aed:3e8e:: with SMTP id n14mr10113639qtf.245.1585535626447;
        Sun, 29 Mar 2020 19:33:46 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q15sm10030625qtj.83.2020.03.29.19.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 19:33:45 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 15/18] rcu: Support headless variant in the kvfree_rcu()
Date:   Sun, 29 Mar 2020 22:32:45 -0400
Message-Id: <20200330023248.164994-16-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200330023248.164994-1-joel@joelfernandes.org>
References: <20200330023248.164994-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Make it possible to pass one or two arguments to the
kvfree_rcu() macro what corresponds to either headless
case or not, so it becomes a bit versatile.

As a result we obtain two ways of using that macro,
below are two examples:

a) kvfree_rcu(ptr, rhf);
    struct X {
        struct rcu_head rhf;
        unsigned char data[100];
    };

    void *ptr = kvmalloc(sizeof(struct X), GFP_KERNEL);
    if (ptr)
        kvfree_rcu(ptr, rhf);

b) kvfree_rcu(ptr);
    void *ptr = kvmalloc(some_bytes, GFP_KERNEL);
    if (ptr)
        kvfree_rcu(ptr);

Last one, we name it headless variant, only needs one
argument, means it does not require any rcu_head to be
present within the type of ptr.

There is a restriction the (b) context has to fall into
might_sleep() annotation. To check that, please activate
the CONFIG_DEBUG_ATOMIC_SLEEP option in your kernel.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcupdate.h | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index edb6eeba49f83..7d04bbeeeef14 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -872,12 +872,42 @@ do {									\
 
 /**
  * kvfree_rcu() - kvfree an object after a grace period.
- * @ptr:	pointer to kvfree
- * @rhf:	the name of the struct rcu_head within the type of @ptr.
  *
- * Same as kfree_rcu(), just simple alias.
+ * This macro consists of one or two arguments and it is
+ * based on whether an object is head-less or not. If it
+ * has a head then a semantic stays the same as it used
+ * to be before:
+ *
+ *     kvfree_rcu(ptr, rhf);
+ *
+ * where @ptr is a pointer to kvfree(), @rhf is the name
+ * of the rcu_head structure within the type of @ptr.
+ *
+ * When it comes to head-less variant, only one argument
+ * is passed and that is just a pointer which has to be
+ * freed after a grace period. Therefore the semantic is
+ *
+ *     kvfree_rcu(ptr);
+ *
+ * where @ptr is a pointer to kvfree().
+ *
+ * Please note, head-less way of freeing is permitted to
+ * use from a context that has to follow might_sleep()
+ * annotation. Otherwise, please switch and embed the
+ * rcu_head structure within the type of @ptr.
  */
-#define kvfree_rcu(ptr, rhf) kfree_rcu(ptr, rhf)
+#define kvfree_rcu(...) KVFREE_GET_MACRO(__VA_ARGS__,		\
+	kvfree_rcu_arg_2, kvfree_rcu_arg_1)(__VA_ARGS__)
+
+#define KVFREE_GET_MACRO(_1, _2, NAME, ...) NAME
+#define kvfree_rcu_arg_2(ptr, rhf) kfree_rcu(ptr, rhf)
+#define kvfree_rcu_arg_1(ptr)					\
+do {								\
+	typeof(ptr) ___p = (ptr);				\
+								\
+	if (___p)						\
+		kvfree_call_rcu(NULL, (rcu_callback_t) (___p));	\
+} while (0)
 
 /*
  * Place this after a lock-acquisition primitive to guarantee that
-- 
2.26.0.rc2.310.g2932bb562d-goog

