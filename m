Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDAEC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 01:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A171220661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 01:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ZonwwxFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgBFBcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 20:32:55 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40411 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbgBFBcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 20:32:55 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so1627900plp.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 17:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ow2vQE3C+7BXlAOT63N0VIIs36hAecsh6hvlNQAC+MY=;
        b=ZonwwxFgzIHsNlnAlKKoctQ8AqpUsY2LJRN4a1jvqlfmY31wK+D/iRNPCGWIc9GQ3h
         7bnePQz1xFpeAcKBq4qM7jDTVAAe8zfSE4GaFSOwDL3ySWvTAa02AkbOkW3jAhDA5/D1
         64sIzqUQ4kLgaZ48ekE6l+g7+UvGv5vBzxPQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ow2vQE3C+7BXlAOT63N0VIIs36hAecsh6hvlNQAC+MY=;
        b=T0j6smIKbQ6EzDSjYgcm5AjJj4NRXYv9oIZfrwqQOvLp4EDZSrl2NQCKNDyAxi21+l
         H7gbvvQBk6iCz1cXdd3R3/egWxDX7kR4zlo/jXqEwNkCPPrEsTSupqbXYX4FUB/SBF1W
         BooEXmd5WvLHQFDSKc9Gst2nDB2DgZnYoqKaFhIR0Z33vw5SuM/JGZka54VevYejDNze
         OJpmo6SVCKGLhWeW86xqpEeRatJaewyzFyxV9Ft2G/KpnkG2RFn1qnSmcO9+UwZtipWD
         b/PwAXxSoe7Mm58vKcUmc4BMNXo459y0767G+LN0D+sCLbfbPNgtk0TmAYe0yL0Q/9sm
         o3tw==
X-Gm-Message-State: APjAAAXa3zacNmT2MX9IaCt2tm9Nhy/3ZkkFh5HoHCNMHupbXYnK9snR
        CJSMYi7cQ1UElA6+S7qcpXnmFC2fleo=
X-Google-Smtp-Source: APXvYqyAWHMfUIQ6i1mIZGDAY+6AxeDRmtH7pnf+lh6VPeIRqnN/GRqP5aKOX641CIQpQ4MeELsMQw==
X-Received: by 2002:a17:902:8b85:: with SMTP id ay5mr926774plb.253.1580952772991;
        Wed, 05 Feb 2020 17:32:52 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l7sm1034185pga.27.2020.02.05.17.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 17:32:52 -0800 (PST)
Date:   Wed, 5 Feb 2020 20:32:51 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Jann Horn <jannh@google.com>
Cc:     Amol Grover <frextrite@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] cred: Use RCU primitives to access RCU pointers
Message-ID: <20200206013251.GC55522@google.com>
References: <20200128072740.21272-1-frextrite@gmail.com>
 <CAG48ez3ZcO+kVPJVG6XpCPyGUKF2o4UJ6AVdgZXGQ6XJJpcdmg@mail.gmail.com>
 <20200128170426.GA10277@workstation-portable>
 <CAG48ez3bLC3dzXn7Ep0YmBENg7wp6TMrocGa6q2RLtYoOdUSxg@mail.gmail.com>
 <20200129065738.GA17486@workstation-portable>
 <CAG48ez2Yc-J1gV4=sTMizySmeFkiZGU+j1NTnZaqyPPo1mYQ=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2Yc-J1gV4=sTMizySmeFkiZGU+j1NTnZaqyPPo1mYQ=Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 03:14:56PM +0100, Jann Horn wrote:
> On Wed, Jan 29, 2020 at 7:57 AM Amol Grover <frextrite@gmail.com> wrote:
> > On Tue, Jan 28, 2020 at 08:09:17PM +0100, Jann Horn wrote:
> > > On Tue, Jan 28, 2020 at 6:04 PM Amol Grover <frextrite@gmail.com> wrote:
> > > > On Tue, Jan 28, 2020 at 10:30:19AM +0100, Jann Horn wrote:
> > > > > On Tue, Jan 28, 2020 at 8:28 AM Amol Grover <frextrite@gmail.com> wrote:
> > > > > > task_struct.cred and task_struct.real_cred are annotated by __rcu,
> > > > >
> > > > > task_struct.cred doesn't actually have RCU semantics though, see
> > > > > commit d7852fbd0f0423937fa287a598bfde188bb68c22. For task_struct.cred,
> > > > > it would probably be more correct to remove the __rcu annotation?
> > > >
> > > > Hi Jann,
> > > >
> > > > I went through the commit you mentioned. If I understand it correctly,
> > > > ->cred was not being accessed concurrently (via RCU), hence, a non_rcu
> > > > flag was introduced, which determined if the clean-up should wait for
> > > > RCU grace-periods or not. And since, the changes were 'thread local'
> > > > there was no need to wait for an entire RCU GP to elapse.
> > >
> > > Yeah.
> > >
> > > > The commit too, as you said, mentions the removal of __rcu annotation.
> > > > However, simply removing the annotation won't work, as there are quite a
> > > > few instances where RCU primitives are used. Even get_current_cred()
> > > > uses RCU APIs to get a reference to ->cred.
> > >
> > > Luckily, there aren't too many places that directly access ->cred,
> > > since luckily there are helper functions like get_current_cred() that
> > > will do it for you. Grepping through the kernel, I see:
> [...]
> > > So actually, the number of places that already don't use RCU accessors
> > > is much higher than the number of places that use them.
> > >
> > > > So, currently, maybe we
> > > > should continue to use RCU APIs and leave the __rcu annotation in?
> > > > (Until someone who takes it on himself to remove __rcu annotation and
> > > > fix all the instances). Does that sound good? Or do you want me to
> > > > remove __rcu annotation and get the process started?
> > >
> > > I don't think it's a good idea to add more uses of RCU APIs for
> > > ->cred; you shouldn't "fix" warnings by making the code more wrong.
> > >
> > > If you want to fix this, I think it would be relatively easy to fix
> > > this properly - as far as I can tell, there are only seven places that
> > > you'll have to change, although you may have to split it up into three
> > > patches.
> >
> > Thank you for the detailed analysis. I'll try my best and send you a
> > patch.

Amol, Jann, if I understand the discussion correctly, objects ->cred
point (the subjective creds) are never (or never need to be) RCU-managed.
This makes sense in light of the commit Jann pointed out
(d7852fbd0f0423937fa287a598bfde188bb68c22).

How about the following diff as a starting point?

1. Remove all ->cred accessing happening through RCU primitive.
2. Remove __rcu from task_struct ->cred
3. Also I removed the whole non_rcu flag, and introduced a new put_cred_non_rcu() API
   which places that task-synchronously use ->cred can overwrite. Callers
   doing such accesses like access() can use this API instead.

I have only build tested the below diff and it is likely buggy but Amol you
can use it as a starting point, or we can discuss more on this thread.

---8<-----------------------

diff --git a/fs/open.c b/fs/open.c
index 8cdb2b6758678..bbdd1f352e4e3 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -374,25 +374,6 @@ long do_faccessat(int dfd, const char __user *filename, int mode)
 				override_cred->cap_permitted;
 	}
 
-	/*
-	 * The new set of credentials can *only* be used in
-	 * task-synchronous circumstances, and does not need
-	 * RCU freeing, unless somebody then takes a separate
-	 * reference to it.
-	 *
-	 * NOTE! This is _only_ true because this credential
-	 * is used purely for override_creds() that installs
-	 * it as the subjective cred. Other threads will be
-	 * accessing ->real_cred, not the subjective cred.
-	 *
-	 * If somebody _does_ make a copy of this (using the
-	 * 'get_current_cred()' function), that will clear the
-	 * non_rcu field, because now that other user may be
-	 * expecting RCU freeing. But normal thread-synchronous
-	 * cred accesses will keep things non-RCY.
-	 */
-	override_cred->non_rcu = 1;
-
 	old_cred = override_creds(override_cred);
 retry:
 	res = user_path_at(dfd, filename, lookup_flags, &path);
@@ -436,7 +417,13 @@ long do_faccessat(int dfd, const char __user *filename, int mode)
 	}
 out:
 	revert_creds(old_cred);
-	put_cred(override_cred);
+
+	/*
+	 * override_cred points to current task's ->cred and will not be used
+	 * by anyone but the current task. Since we are done using it, remove it
+	 * without waiting for a grace period.
+	 */
+	put_cred_non_rcu(override_cred);
 	return res;
 }
 
diff --git a/include/linux/cred.h b/include/linux/cred.h
index 18639c069263f..2f41a0fa75741 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -145,14 +145,10 @@ struct cred {
 	struct user_struct *user;	/* real user ID subscription */
 	struct user_namespace *user_ns; /* user_ns the caps and keyrings are relative to. */
 	struct group_info *group_info;	/* supplementary groups for euid/fsgid */
-	/* RCU deletion */
-	union {
-		int non_rcu;			/* Can we skip RCU deletion? */
-		struct rcu_head	rcu;		/* RCU deletion hook */
-	};
+	struct rcu_head	rcu;		/* RCU deletion hook if needed*/
 } __randomize_layout;
 
-extern void __put_cred(struct cred *);
+extern void __put_cred(struct cred *, bool rcu);
 extern void exit_creds(struct task_struct *);
 extern int copy_creds(struct task_struct *, unsigned long);
 extern const struct cred *get_task_cred(struct task_struct *);
@@ -250,7 +246,6 @@ static inline const struct cred *get_cred(const struct cred *cred)
 	if (!cred)
 		return cred;
 	validate_creds(cred);
-	nonconst_cred->non_rcu = 0;
 	return get_new_cred(nonconst_cred);
 }
 
@@ -262,7 +257,6 @@ static inline const struct cred *get_cred_rcu(const struct cred *cred)
 	if (!atomic_inc_not_zero(&nonconst_cred->usage))
 		return NULL;
 	validate_creds(cred);
-	nonconst_cred->non_rcu = 0;
 	return cred;
 }
 
@@ -270,8 +264,9 @@ static inline const struct cred *get_cred_rcu(const struct cred *cred)
  * put_cred - Release a reference to a set of credentials
  * @cred: The credentials to release
  *
- * Release a reference to a set of credentials, deleting them when the last ref
- * is released.  If %NULL is passed, nothing is done.
+ * Release a reference to a set of credentials, deleting them after an RCU
+ * grace period when the last ref is released.
+ * If %NULL is passed, nothing is done.
  *
  * This takes a const pointer to a set of credentials because the credentials
  * on task_struct are attached by const pointers to prevent accidental
@@ -284,18 +279,35 @@ static inline void put_cred(const struct cred *_cred)
 	if (cred) {
 		validate_creds(cred);
 		if (atomic_dec_and_test(&(cred)->usage))
-			__put_cred(cred);
+			__put_cred(cred, true);
+	}
+}
+
+/**
+ * put_cred - Release a reference to a set of credentials
+ * @cred: The credentials to release
+ *
+ * Same as put_cred() except that the freeing of the cred object is done
+ * immediately without waiting for RCU grace period. This is useful when
+ * using a task's temporary subjective credentials (task_struct::cred).
+ */
+static inline void put_cred_non_rcu(const struct cred *_cred)
+{
+	struct cred *cred = (struct cred *) _cred;
+
+	if (cred) {
+		validate_creds(cred);
+		if (atomic_dec_and_test(&(cred)->usage))
+			__put_cred(cred, false);
 	}
 }
 
 /**
  * current_cred - Access the current task's subjective credentials
  *
- * Access the subjective credentials of the current task.  RCU-safe,
- * since nobody else can modify it.
+ * Access the subjective credentials of the current task.
  */
-#define current_cred() \
-	rcu_dereference_protected(current->cred, 1)
+#define current_cred() READ_ONCE(current->cred)
 
 /**
  * current_real_cred - Access the current task's objective credentials
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 716ad1d8d95e1..227375311d992 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -879,8 +879,9 @@ struct task_struct {
 	/* Objective and real subjective task credentials (COW): */
 	const struct cred __rcu		*real_cred;
 
-	/* Effective (overridable) subjective task credentials (COW): */
-	const struct cred __rcu		*cred;
+	/* Effective (overridable) subjective task credentials (COW):
+	 * Access is not managed by RCU and is used task-synchronously */
+	const struct cred		*cred;
 
 #ifdef CONFIG_KEYS
 	/* Cached requested key. */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 4effe01ebbe2b..2e70a73646d53 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -430,24 +430,19 @@ static int audit_field_compare(struct task_struct *tsk,
 /* Determine if any context name data matches a rule's watch data */
 /* Compare a task_struct with an audit_rule.  Return 1 on match, 0
  * otherwise.
- *
- * If task_creation is true, this is an explicit indication that we are
- * filtering a task rule at task creation time.  This and tsk == current are
- * the only situations where tsk->cred may be accessed without an rcu read lock.
  */
 static int audit_filter_rules(struct task_struct *tsk,
 			      struct audit_krule *rule,
 			      struct audit_context *ctx,
 			      struct audit_names *name,
-			      enum audit_state *state,
-			      bool task_creation)
+			      enum audit_state *state)
 {
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
 	unsigned int sessionid;
 
-	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
+	cred = READ_ONCE(tsk->cred);
 
 	for (i = 0; i < rule->field_count; i++) {
 		struct audit_field *f = &rule->fields[i];
@@ -745,7 +740,7 @@ static enum audit_state audit_filter_task(struct task_struct *tsk, char **key)
 	rcu_read_lock();
 	list_for_each_entry_rcu(e, &audit_filter_list[AUDIT_FILTER_TASK], list) {
 		if (audit_filter_rules(tsk, &e->rule, NULL, NULL,
-				       &state, true)) {
+				       &state)) {
 			if (state == AUDIT_RECORD_CONTEXT)
 				*key = kstrdup(e->rule.filterkey, GFP_ATOMIC);
 			rcu_read_unlock();
@@ -791,7 +786,7 @@ static enum audit_state audit_filter_syscall(struct task_struct *tsk,
 	list_for_each_entry_rcu(e, list, list) {
 		if (audit_in_mask(&e->rule, ctx->major) &&
 		    audit_filter_rules(tsk, &e->rule, ctx, NULL,
-				       &state, false)) {
+				       &state)) {
 			rcu_read_unlock();
 			ctx->current_state = state;
 			return state;
@@ -815,7 +810,7 @@ static int audit_filter_inode_name(struct task_struct *tsk,
 
 	list_for_each_entry_rcu(e, list, list) {
 		if (audit_in_mask(&e->rule, ctx->major) &&
-		    audit_filter_rules(tsk, &e->rule, ctx, n, &state, false)) {
+		    audit_filter_rules(tsk, &e->rule, ctx, n, &state)) {
 			ctx->current_state = state;
 			return 1;
 		}
diff --git a/kernel/cred.c b/kernel/cred.c
index 809a985b17934..120258b9d87df 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -129,7 +129,7 @@ static void put_cred_rcu(struct rcu_head *rcu)
  *
  * Destroy a set of credentials on which no references remain.
  */
-void __put_cred(struct cred *cred)
+void __put_cred(struct cred *cred, bool rcu)
 {
 	kdebug("__put_cred(%p{%d,%d})", cred,
 	       atomic_read(&cred->usage),
@@ -144,10 +144,10 @@ void __put_cred(struct cred *cred)
 	BUG_ON(cred == current->cred);
 	BUG_ON(cred == current->real_cred);
 
-	if (cred->non_rcu)
-		put_cred_rcu(&cred->rcu);
-	else
+	if (rcu)
 		call_rcu(&cred->rcu, put_cred_rcu);
+	else
+		put_cred_rcu(&cred->rcu);
 }
 EXPORT_SYMBOL(__put_cred);
 
@@ -264,7 +264,6 @@ struct cred *prepare_creds(void)
 	old = task->cred;
 	memcpy(new, old, sizeof(struct cred));
 
-	new->non_rcu = 0;
 	atomic_set(&new->usage, 1);
 	set_cred_subscribers(new, 0);
 	get_group_info(new->group_info);
@@ -485,7 +484,7 @@ int commit_creds(struct cred *new)
 	if (new->user != old->user)
 		atomic_inc(&new->user->processes);
 	rcu_assign_pointer(task->real_cred, new);
-	rcu_assign_pointer(task->cred, new);
+	WRITE_ONCE(task->cred, new);
 	if (new->user != old->user)
 		atomic_dec(&old->user->processes);
 	alter_cred_subscribers(old, -2);
@@ -549,20 +548,9 @@ const struct cred *override_creds(const struct cred *new)
 	validate_creds(old);
 	validate_creds(new);
 
-	/*
-	 * NOTE! This uses 'get_new_cred()' rather than 'get_cred()'.
-	 *
-	 * That means that we do not clear the 'non_rcu' flag, since
-	 * we are only installing the cred into the thread-synchronous
-	 * '->cred' pointer, not the '->real_cred' pointer that is
-	 * visible to other threads under RCU.
-	 *
-	 * Also note that we did validate_creds() manually, not depending
-	 * on the validation in 'get_cred()'.
-	 */
-	get_new_cred((struct cred *)new);
+	get_cred(new);
 	alter_cred_subscribers(new, 1);
-	rcu_assign_pointer(current->cred, new);
+	WRITE_ONCE(current->cred, new);
 	alter_cred_subscribers(old, -1);
 
 	kdebug("override_creds() = %p{%d,%d}", old,
@@ -590,7 +578,7 @@ void revert_creds(const struct cred *old)
 	validate_creds(old);
 	validate_creds(override);
 	alter_cred_subscribers(old, 1);
-	rcu_assign_pointer(current->cred, old);
+	WRITE_ONCE(current->cred, old);
 	alter_cred_subscribers(override, -1);
 	put_cred(override);
 }
@@ -697,7 +685,6 @@ struct cred *prepare_kernel_cred(struct task_struct *daemon)
 	validate_creds(old);
 
 	*new = *old;
-	new->non_rcu = 0;
 	atomic_set(&new->usage, 1);
 	set_cred_subscribers(new, 0);
 	get_uid(new->user);
