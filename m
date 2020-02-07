Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E87C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC36217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q66upDkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgBGSIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 13:08:20 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:51443 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbgBGSIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 13:08:19 -0500
Received: by mail-pj1-f67.google.com with SMTP id fa20so1226966pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 10:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6dJnmRISnXhx/tid8L3bkFndKLLLawXzGhi1aYEmqBI=;
        b=q66upDkhWWqCv7RN3g0JjmwCJmoQSdSo46/A9eK5grTxsRkeNIeWBTqyrXbechcCCT
         ofFauNOWxK/BySUuN53q5didySxl8kkTrfKFPJmt0m3F8dS7N2YHHf5BWcXN5kp3PgAG
         qaDYsmYc1TVijYr/tfnXGm9DeRVGo3lzeIrWj/zmEZA4wF606Kdk+NKGY7UHxpkwJ2Vx
         2f0IgA01hxIWl1aSf3g7w89o6LflVQIf9D4xhGe3Zu8bOc2Xf4ZGG3L96/pKGrSRJe5N
         DVQmkJDxxxkO1CPxMOVmKk7UBVgXyT5+5QjZ40441Jl0ZxBH2q3HV13H7VfKcSWSh+jT
         RfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6dJnmRISnXhx/tid8L3bkFndKLLLawXzGhi1aYEmqBI=;
        b=E4coWN4XFCSURwgkdBY8fs35nuGNjaWQXihycOBMpUNaO10izct89V+VsBpvj813r3
         BNgwhynNF55L8GGi5VaQl1TuyhV3s3SGZ1h+0buu8fC0Isi6XTc9EUJ1Ol7MqPOyX0hR
         rMw4eLxLZ1se+kJEaR6S8oUs0NuKivt6tKoLRoe7+jadvppjmXQy6T5OMi6Y7iD2dgLh
         zbWa13oPcRpt6uwpP3ez0FgBMyV2Pedwvhw9ynlwArZ0ddXzHHjXrMxeTFFNWTWtwvyN
         lmiCJN5a6cTGU0pPuZMt8HkzWAh8ygLAERa+XVFcEXhDB06lsQ4daq8Tv/dUtIWm4alG
         jcKQ==
X-Gm-Message-State: APjAAAXwVe8XuqqHmkfcaMx5ihRHkiXVFUiPzSuYQo5SQ3LU5eGRqgqH
        VocCjuDaxk766GPd6nMUJ1k=
X-Google-Smtp-Source: APXvYqym2YQSzc5+DaUKX0EDmz+UD0MoeyQVJEc9evlzGvMkuEWZiJSglWMQzb2WBkKyVuAow9dRtw==
X-Received: by 2002:a17:902:a616:: with SMTP id u22mr10769740plq.173.1581098898305;
        Fri, 07 Feb 2020 10:08:18 -0800 (PST)
Received: from localhost.localdomain ([103.211.17.120])
        by smtp.googlemail.com with ESMTPSA id gx18sm3088795pjb.8.2020.02.07.10.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 10:08:17 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        James Morris <jamorris@linux.microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH 3/3] auditsc: Do not use RCU primitive to read from cred pointer
Date:   Fri,  7 Feb 2020 23:35:05 +0530
Message-Id: <20200207180504.4200-3-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207180504.4200-1-frextrite@gmail.com>
References: <20200207180504.4200-1-frextrite@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

task_struct::cred is only used task-synchronously and does
not require any RCU locks, hence, rcu_dereference_check is
not required to read from it.

Suggested-by: Jann Horn <jannh@google.com>
Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 kernel/auditsc.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 4effe01ebbe2..d3510513cdd1 100644
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
+	cred = tsk->cred;
 
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
-- 
2.24.1

