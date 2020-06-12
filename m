Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E801EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 18:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6A15206DC
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 18:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b6e1Ceye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgFLSfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 14:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgFLSfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 14:35:05 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBE9C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 11:35:03 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t7so4510599pgt.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 11:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BKq2bqjoIrTxoszw+QjbBisLqsmMqZ1oiRk0VcTa+rw=;
        b=b6e1CeyehqcVZ+b1y8LNMq44/UsTWrA7jMw9137JjYrq04Fg9eQuNDfbFYlwKk5548
         o028X1KTz4zDiz1RALJtRxUpcWcNn8ojihcqPULTySWuzfMTHt96pkY2Z9yIK6uZ7uRO
         cu/r83h4hea7aVWhSuoXGDugUp4F4Jv5eJD1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BKq2bqjoIrTxoszw+QjbBisLqsmMqZ1oiRk0VcTa+rw=;
        b=CSskZkF+A7fkvRLS4g4ciZt1nMzAkcVxuH2cUKpGNVpah8NIp6iJfYNksLzaft+KCD
         cKxTFLzM44VlXJEjc9NRzGi6r/o7A5HO79UheBvW6ogEuJ+4rIqK1Ute5fjZJQC//VVZ
         XD4QSvymoQ/uMQ7cQsgFxxEKJOJn9EQAhFGaOENwHsvF5fcXjlb5C2IVx9mH4vF8e9h6
         nVTF4WlLCZFGiCl51qi1i+qaNW390GK+Hl8G5N2jnMaQGnRvIBqedZuJt0ZmjaPSxDCi
         RLSNowoBhIcEUP74NkMvySGWwTW2XlsDk8mDQFsHDzDWT2g0sHO3XnB8doDs1i5/GlIg
         kZcA==
X-Gm-Message-State: AOAM533sJlOOs3C82JGfPP4ww5PL/UZekhbRqg1phTUeK8PHLKmLO3az
        /kDLOjy6qZVc5NAzc78bIOrNDg==
X-Google-Smtp-Source: ABdhPJxy5NL5bhiiB6uL020qNJQdds/btTl46j4hloEfhe1Zgihz6SILoFPrQ2zVh4Q2Aa6ESp8/dg==
X-Received: by 2002:a62:2f45:: with SMTP id v66mr13684525pfv.45.1591986903296;
        Fri, 12 Jun 2020 11:35:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b6sm6725353pfp.24.2020.06.12.11.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 11:35:01 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Paul Moore <paul@paul-moore.com>, edumazet@google.com,
        paulmck@kernel.org, David Howells <dhowells@redhat.com>,
        shakeelb@google.com, James Morris <jamorris@linux.microsoft.com>,
        alex.huangjianhui@huawei.com, dylix.dailei@huawei.com,
        chenzefeng2@huawei.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] nsproxy: convert nsproxy.count to refcount_t
Date:   Fri, 12 Jun 2020 11:34:48 -0700
Message-Id: <20200612183450.4189588-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200612183450.4189588-1-keescook@chromium.org>
References: <20200612183450.4189588-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elena Reshetova <elena.reshetova@intel.com>

atomic_t variables are currently used to implement reference
counters with the following properties:
 - counter is initialized to 1 using atomic_set()
 - a resource is freed upon counter reaching zero
 - once counter reaches zero, its further
   increments aren't allowed
 - counter schema uses basic atomic operations
   (set, inc, inc_not_zero, dec_and_test, etc.)

Such atomic variables should be converted to a newly provided
refcount_t type and API that prevents accidental counter overflows
and underflows. This is important since overflows and underflows
can lead to use-after-free situation and be exploitable.

The variable nsproxy.count is used as pure reference counter.
Convert it to refcount_t and fix up the operations.

**Important note for maintainers:

Some functions from refcount_t API defined in lib/refcount.c
have different memory ordering guarantees than their atomic
counterparts.Please check Documentation/core-api/refcount-vs-atomic.rst
for more information.

Normally the differences should not matter since refcount_t provides
enough guarantees to satisfy the refcounting use cases, but in
some rare cases it might matter.
Please double check that you don't have some undocumented
memory guarantees for this variable usage.

For the nsproxy.count it might make a difference
in following places:
 - put_nsproxy() and switch_task_namespaces(): decrement in
   refcount_dec_and_test() only provides RELEASE ordering
   and ACQUIRE ordering on success vs. fully ordered
   atomic counterpart

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Link: https://lore.kernel.org/r/20190306110549.7628-2-elena.reshetova@intel.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/nsproxy.h | 7 +++----
 kernel/nsproxy.c        | 6 +++---
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index cdb171efc7cb..6bd95f02de05 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -29,7 +29,7 @@ struct fs_struct;
  * nsproxy is copied.
  */
 struct nsproxy {
-	atomic_t count;
+	refcount_t count;
 	struct uts_namespace *uts_ns;
 	struct ipc_namespace *ipc_ns;
 	struct mnt_namespace *mnt_ns;
@@ -101,14 +101,13 @@ int __init nsproxy_cache_init(void);
 
 static inline void put_nsproxy(struct nsproxy *ns)
 {
-	if (atomic_dec_and_test(&ns->count)) {
+	if (refcount_dec_and_test(&ns->count))
 		free_nsproxy(ns);
-	}
 }
 
 static inline void get_nsproxy(struct nsproxy *ns)
 {
-	atomic_inc(&ns->count);
+	refcount_inc(&ns->count);
 }
 
 #endif
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index b03df67621d0..74b5e6925e0f 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -30,7 +30,7 @@
 static struct kmem_cache *nsproxy_cachep;
 
 struct nsproxy init_nsproxy = {
-	.count			= ATOMIC_INIT(1),
+	.count			= REFCOUNT_INIT(1),
 	.uts_ns			= &init_uts_ns,
 #if defined(CONFIG_POSIX_MQUEUE) || defined(CONFIG_SYSVIPC)
 	.ipc_ns			= &init_ipc_ns,
@@ -55,7 +55,7 @@ static inline struct nsproxy *create_nsproxy(void)
 
 	nsproxy = kmem_cache_alloc(nsproxy_cachep, GFP_KERNEL);
 	if (nsproxy)
-		atomic_set(&nsproxy->count, 1);
+		refcount_set(&nsproxy->count, 1);
 	return nsproxy;
 }
 
@@ -250,7 +250,7 @@ void switch_task_namespaces(struct task_struct *p, struct nsproxy *new)
 	p->nsproxy = new;
 	task_unlock(p);
 
-	if (ns && atomic_dec_and_test(&ns->count))
+	if (ns && refcount_dec_and_test(&ns->count))
 		free_nsproxy(ns);
 }
 
-- 
2.25.1

