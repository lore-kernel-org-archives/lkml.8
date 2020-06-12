Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8007AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 18:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CCFC20801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 18:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S74xKWuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgFLSfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 14:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgFLSfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 14:35:03 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306A4C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 11:35:03 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id h185so4706914pfg.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 11:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lo23MkK3oKdy4eP+VnzY6Z8lJ6ELcmkBOBeirsdef6w=;
        b=S74xKWuAXXukOQlwacSEcEdt1GgjV38lUB4QRPuRWJL/ZEWtRpBCmS/DR2BDqixQq4
         dpuZrg+TFAqn5gtk0gQyAk/PzbCJTSlH7/y7DRq+ZRALtZr9lzyQaNnS7uzDNAHjeCKq
         0onKFvecNb5QdESMgLCpN6ALow3kidAVUSwL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lo23MkK3oKdy4eP+VnzY6Z8lJ6ELcmkBOBeirsdef6w=;
        b=WQFuJIZOTe9FJkgNL7KOqCi3K3E7ORP/gnPIfpaGCuZYw6XNFx4wSPNq3nyCGpDT+u
         w/FSexLfBhRRK08qRpYQrtfBI3mbKXVIF1Wn/elmuFmJiFx3CucwE+7IvCImbdlgX3Y3
         uRWWK17xs6K8DoMXmWkYtEHQKvxgWqwlIsh5f1SIs69poKd9NkA3K26aO+ZUQ32u+4Nu
         bX6C+mMdlL+5wINT+pfNd/Qf4qVm/hG7xsuOUAVQ1z88BfWqdLTZ3pE/GZqAmIYnG9DS
         uscJJ/miCFWdQQOMt+bW/bWwGr3aih6EOYcLKgGFDzMEut7U2nIrQcK9WpOLO1NBGcNV
         zdig==
X-Gm-Message-State: AOAM533Hh7GjMyPYF5eOcTwfd8Qx4nS6oYA464352w545KfQBR0Wg1+G
        yahsJePf5pHZoSOMuYCnlXItuA==
X-Google-Smtp-Source: ABdhPJxhwGwkzKdk9t7CQwMydxRXXOeJ7UAS9/ZuSNwcjXG0p3iRqAjZ7HiZ6IsnOfVijRtf3Dr5Ig==
X-Received: by 2002:a63:3587:: with SMTP id c129mr12357594pga.190.1591986902726;
        Fri, 12 Jun 2020 11:35:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w190sm6750641pfw.35.2020.06.12.11.35.01
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
Subject: [PATCH 2/3] groups: convert group_info.usage to refcount_t
Date:   Fri, 12 Jun 2020 11:34:49 -0700
Message-Id: <20200612183450.4189588-3-keescook@chromium.org>
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

The variable group_info.usage is used as pure reference counter.
Convert it to refcount_t and fix up the operations.

**Important note for maintainers:

Some functions from refcount_t API defined in lib/refcount.c
have different memory ordering guarantees than their atomic
counterparts. Please check Documentation/core-api/refcount-vs-atomic.rst
for more information.

Normally the differences should not matter since refcount_t provides
enough guarantees to satisfy the refcounting use cases, but in
some rare cases it might matter.
Please double check that you don't have some undocumented
memory guarantees for this variable usage.

For the group_info.usage it might make a difference
in following places:
 - put_group_info(): decrement in refcount_dec_and_test() only
   provides RELEASE ordering and ACQUIRE ordering on success
   vs. fully ordered atomic counterpart

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Link: https://lore.kernel.org/r/20190306110549.7628-3-elena.reshetova@intel.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/cred.h | 7 ++++---
 kernel/cred.c        | 2 +-
 kernel/groups.c      | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 18639c069263..32be0daf5a32 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/key.h>
 #include <linux/atomic.h>
+#include <linux/refcount.h>
 #include <linux/uidgid.h>
 #include <linux/sched.h>
 #include <linux/sched/user.h>
@@ -23,7 +24,7 @@ struct inode;
  * COW Supplementary groups list
  */
 struct group_info {
-	atomic_t	usage;
+	refcount_t	usage;
 	int		ngroups;
 	kgid_t		gid[0];
 } __randomize_layout;
@@ -39,7 +40,7 @@ struct group_info {
  */
 static inline struct group_info *get_group_info(struct group_info *gi)
 {
-	atomic_inc(&gi->usage);
+	refcount_inc(&gi->usage);
 	return gi;
 }
 
@@ -49,7 +50,7 @@ static inline struct group_info *get_group_info(struct group_info *gi)
  */
 #define put_group_info(group_info)			\
 do {							\
-	if (atomic_dec_and_test(&(group_info)->usage))	\
+	if (refcount_dec_and_test(&(group_info)->usage))	\
 		groups_free(group_info);		\
 } while (0)
 
diff --git a/kernel/cred.c b/kernel/cred.c
index 421b1149c651..ed95117d07c4 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -33,7 +33,7 @@ do {									\
 static struct kmem_cache *cred_jar;
 
 /* init to 2 - one for init_task, one to ensure it is never freed */
-struct group_info init_groups = { .usage = ATOMIC_INIT(2) };
+struct group_info init_groups = { .usage = REFCOUNT_INIT(2) };
 
 /*
  * The initial credentials for the initial task
diff --git a/kernel/groups.c b/kernel/groups.c
index 6ee6691f6839..22f2892dbaf3 100644
--- a/kernel/groups.c
+++ b/kernel/groups.c
@@ -24,7 +24,7 @@ struct group_info *groups_alloc(int gidsetsize)
 	if (!gi)
 		return NULL;
 
-	atomic_set(&gi->usage, 1);
+	refcount_set(&gi->usage, 1);
 	gi->ngroups = gidsetsize;
 	return gi;
 }
-- 
2.25.1

