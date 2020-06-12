Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46897C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 18:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F166206DC
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 18:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jyjF4272"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgFLSfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 14:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgFLSfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 14:35:06 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ACCC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 11:35:05 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ne5so3974476pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 11:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SkaAn/epjFU9uyaVibJ1w2aI298y4T9C6QxLskFfdmE=;
        b=jyjF4272bAjc9iiHXEAp3h79XUCi6DBcdud8BzC7USwf45t4DXV/7YmvKrl4Xt6Ah1
         +vo1MI7p4zvs3KnS6txTTX80fiNLH8x419IPa/ua/nhF/7n3LOhdSNg3w+iAck2Ki4w8
         uX1ToJRcyBnHp+h50m83NOIyzUQ27OH+UvQ/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SkaAn/epjFU9uyaVibJ1w2aI298y4T9C6QxLskFfdmE=;
        b=VSDyW7F6CLaruCm7ZM8jWySUmDdCQ9eI7VUOjfVAg41lKlgC3eb4d87wWwk04k0uxX
         U4WxVrf7iH/spPYBzsnlXMQ6UzvtjP+AEvyXi3z72P6BeB1xks+H8eWFRuk+VoHbCL/M
         LORwRUA+PP1/MvPauqrERbdFqlWIQuJXKuhiUEV5frds0viHGs/F+i+quXvK6ju7izI5
         bbKMzgaciEOD5EDwMFX2NjHsDnnLY2Sd0yV1edIZKLQg2QZ1LU9b/f44KB9jyCNlRc+Y
         HnAk+mFibBt8Io4p2d3JKFKoXvqrfKlWsvWaIC+5sdNug39Hk5wV5uf87Dabp5LrYfkq
         NcOg==
X-Gm-Message-State: AOAM533d3BA0zeI75+oAR1K8evsPxoPs49MmA8JVoMaZnIskHnYqO+g7
        sdiwtnBGR8m+PXaCgg2En8HT/w==
X-Google-Smtp-Source: ABdhPJwOj7l96pDvW5pdFilYqAX9ypZiqGMCLGYiaccIlluUwzhuarmLt47dSxSl/aMFUOWfU4BHGA==
X-Received: by 2002:a17:90a:1ad0:: with SMTP id p74mr246561pjp.117.1591986904737;
        Fri, 12 Jun 2020 11:35:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m5sm5744362pga.3.2020.06.12.11.35.01
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
Subject: [PATCH 3/3] creds: convert cred.usage to refcount_t
Date:   Fri, 12 Jun 2020 11:34:50 -0700
Message-Id: <20200612183450.4189588-4-keescook@chromium.org>
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

The variable cred.usage is used as pure reference counter.
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

For the cred.usage it might make a difference
in following places:
 - get_task_cred(): increment in refcount_inc_not_zero() only
   guarantees control dependency on success vs. fully ordered
   atomic counterpart
 - put_cred(): decrement in refcount_dec_and_test() only
   provides RELEASE ordering and ACQUIRE ordering on success
   vs. fully ordered atomic counterpart

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Link: https://lore.kernel.org/r/20190306110549.7628-4-elena.reshetova@intel.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/cred.h |  8 ++++----
 kernel/cred.c        | 42 +++++++++++++++++++++---------------------
 net/sunrpc/auth.c    |  2 +-
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 32be0daf5a32..d624b91de095 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -110,7 +110,7 @@ static inline int groups_search(const struct group_info *group_info, kgid_t grp)
  * same context as task->real_cred.
  */
 struct cred {
-	atomic_t	usage;
+	refcount_t	usage;
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	atomic_t	subscribers;	/* number of processes subscribed */
 	void		*put_addr;
@@ -228,7 +228,7 @@ static inline bool cap_ambient_invariant_ok(const struct cred *cred)
  */
 static inline struct cred *get_new_cred(struct cred *cred)
 {
-	atomic_inc(&cred->usage);
+	refcount_inc(&cred->usage);
 	return cred;
 }
 
@@ -260,7 +260,7 @@ static inline const struct cred *get_cred_rcu(const struct cred *cred)
 	struct cred *nonconst_cred = (struct cred *) cred;
 	if (!cred)
 		return NULL;
-	if (!atomic_inc_not_zero(&nonconst_cred->usage))
+	if (!refcount_inc_not_zero(&nonconst_cred->usage))
 		return NULL;
 	validate_creds(cred);
 	nonconst_cred->non_rcu = 0;
@@ -284,7 +284,7 @@ static inline void put_cred(const struct cred *_cred)
 
 	if (cred) {
 		validate_creds(cred);
-		if (atomic_dec_and_test(&(cred)->usage))
+		if (refcount_dec_and_test(&(cred)->usage))
 			__put_cred(cred);
 	}
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index ed95117d07c4..efde7ded71d4 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -39,7 +39,7 @@ struct group_info init_groups = { .usage = REFCOUNT_INIT(2) };
  * The initial credentials for the initial task
  */
 struct cred init_cred = {
-	.usage			= ATOMIC_INIT(4),
+	.usage			= REFCOUNT_INIT(4),
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	.subscribers		= ATOMIC_INIT(2),
 	.magic			= CRED_MAGIC,
@@ -98,17 +98,17 @@ static void put_cred_rcu(struct rcu_head *rcu)
 
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	if (cred->magic != CRED_MAGIC_DEAD ||
-	    atomic_read(&cred->usage) != 0 ||
+	    refcount_read(&cred->usage) != 0 ||
 	    read_cred_subscribers(cred) != 0)
 		panic("CRED: put_cred_rcu() sees %p with"
 		      " mag %x, put %p, usage %d, subscr %d\n",
 		      cred, cred->magic, cred->put_addr,
-		      atomic_read(&cred->usage),
+		      refcount_read(&cred->usage),
 		      read_cred_subscribers(cred));
 #else
-	if (atomic_read(&cred->usage) != 0)
+	if (refcount_read(&cred->usage) != 0)
 		panic("CRED: put_cred_rcu() sees %p with usage %d\n",
-		      cred, atomic_read(&cred->usage));
+		      cred, refcount_read(&cred->usage));
 #endif
 
 	security_cred_free(cred);
@@ -132,10 +132,10 @@ static void put_cred_rcu(struct rcu_head *rcu)
 void __put_cred(struct cred *cred)
 {
 	kdebug("__put_cred(%p{%d,%d})", cred,
-	       atomic_read(&cred->usage),
+	       refcount_read(&cred->usage),
 	       read_cred_subscribers(cred));
 
-	BUG_ON(atomic_read(&cred->usage) != 0);
+	BUG_ON(refcount_read(&cred->usage) != 0);
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	BUG_ON(read_cred_subscribers(cred) != 0);
 	cred->magic = CRED_MAGIC_DEAD;
@@ -159,7 +159,7 @@ void exit_creds(struct task_struct *tsk)
 	struct cred *cred;
 
 	kdebug("exit_creds(%u,%p,%p,{%d,%d})", tsk->pid, tsk->real_cred, tsk->cred,
-	       atomic_read(&tsk->cred->usage),
+	       refcount_read(&tsk->cred->usage),
 	       read_cred_subscribers(tsk->cred));
 
 	cred = (struct cred *) tsk->real_cred;
@@ -218,7 +218,7 @@ struct cred *cred_alloc_blank(void)
 	if (!new)
 		return NULL;
 
-	atomic_set(&new->usage, 1);
+	refcount_set(&new->usage, 1);
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	new->magic = CRED_MAGIC;
 #endif
@@ -265,7 +265,7 @@ struct cred *prepare_creds(void)
 	memcpy(new, old, sizeof(struct cred));
 
 	new->non_rcu = 0;
-	atomic_set(&new->usage, 1);
+	refcount_set(&new->usage, 1);
 	set_cred_subscribers(new, 0);
 	get_group_info(new->group_info);
 	get_uid(new->user);
@@ -349,7 +349,7 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
 		get_cred(p->cred);
 		alter_cred_subscribers(p->cred, 2);
 		kdebug("share_creds(%p{%d,%d})",
-		       p->cred, atomic_read(&p->cred->usage),
+		       p->cred, refcount_read(&p->cred->usage),
 		       read_cred_subscribers(p->cred));
 		atomic_inc(&p->cred->user->processes);
 		return 0;
@@ -440,7 +440,7 @@ int commit_creds(struct cred *new)
 	const struct cred *old = task->real_cred;
 
 	kdebug("commit_creds(%p{%d,%d})", new,
-	       atomic_read(&new->usage),
+	       refcount_read(&new->usage),
 	       read_cred_subscribers(new));
 
 	BUG_ON(task->cred != old);
@@ -449,7 +449,7 @@ int commit_creds(struct cred *new)
 	validate_creds(old);
 	validate_creds(new);
 #endif
-	BUG_ON(atomic_read(&new->usage) < 1);
+	BUG_ON(refcount_read(&new->usage) < 1);
 
 	get_cred(new); /* we will require a ref for the subj creds too */
 
@@ -523,13 +523,13 @@ EXPORT_SYMBOL(commit_creds);
 void abort_creds(struct cred *new)
 {
 	kdebug("abort_creds(%p{%d,%d})", new,
-	       atomic_read(&new->usage),
+	       refcount_read(&new->usage),
 	       read_cred_subscribers(new));
 
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	BUG_ON(read_cred_subscribers(new) != 0);
 #endif
-	BUG_ON(atomic_read(&new->usage) < 1);
+	BUG_ON(refcount_read(&new->usage) < 1);
 	put_cred(new);
 }
 EXPORT_SYMBOL(abort_creds);
@@ -546,7 +546,7 @@ const struct cred *override_creds(const struct cred *new)
 	const struct cred *old = current->cred;
 
 	kdebug("override_creds(%p{%d,%d})", new,
-	       atomic_read(&new->usage),
+	       refcount_read(&new->usage),
 	       read_cred_subscribers(new));
 
 	validate_creds(old);
@@ -569,7 +569,7 @@ const struct cred *override_creds(const struct cred *new)
 	alter_cred_subscribers(old, -1);
 
 	kdebug("override_creds() = %p{%d,%d}", old,
-	       atomic_read(&old->usage),
+	       refcount_read(&old->usage),
 	       read_cred_subscribers(old));
 	return old;
 }
@@ -587,7 +587,7 @@ void revert_creds(const struct cred *old)
 	const struct cred *override = current->cred;
 
 	kdebug("revert_creds(%p{%d,%d})", old,
-	       atomic_read(&old->usage),
+	       refcount_read(&old->usage),
 	       read_cred_subscribers(old));
 
 	validate_creds(old);
@@ -699,7 +699,7 @@ struct cred *prepare_kernel_cred(struct task_struct *daemon)
 
 	*new = *old;
 	new->non_rcu = 0;
-	atomic_set(&new->usage, 1);
+	refcount_set(&new->usage, 1);
 	set_cred_subscribers(new, 0);
 	get_uid(new->user);
 	get_user_ns(new->user_ns);
@@ -810,7 +810,7 @@ static void dump_invalid_creds(const struct cred *cred, const char *label,
 	printk(KERN_ERR "CRED: ->magic=%x, put_addr=%p\n",
 	       cred->magic, cred->put_addr);
 	printk(KERN_ERR "CRED: ->usage=%d, subscr=%d\n",
-	       atomic_read(&cred->usage),
+	       refcount_read(&cred->usage),
 	       read_cred_subscribers(cred));
 	printk(KERN_ERR "CRED: ->*uid = { %d,%d,%d,%d }\n",
 		from_kuid_munged(&init_user_ns, cred->uid),
@@ -884,7 +884,7 @@ void validate_creds_for_do_exit(struct task_struct *tsk)
 {
 	kdebug("validate_creds_for_do_exit(%p,%p{%d,%d})",
 	       tsk->real_cred, tsk->cred,
-	       atomic_read(&tsk->cred->usage),
+	       refcount_read(&tsk->cred->usage),
 	       read_cred_subscribers(tsk->cred));
 
 	__validate_process_creds(tsk, __FILE__, __LINE__);
diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index a9f0d17fdb0d..b2b7195536ae 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -39,7 +39,7 @@ static LIST_HEAD(cred_unused);
 static unsigned long number_cred_unused;
 
 static struct cred machine_cred = {
-	.usage = ATOMIC_INIT(1),
+	.usage = REFCOUNT_INIT(1),
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	.magic = CRED_MAGIC,
 #endif
-- 
2.25.1

