Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A12C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 05:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7552206D3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 05:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vKP+S4rd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgDBF52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 01:57:28 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53160 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgDBF52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 01:57:28 -0400
Received: by mail-pj1-f65.google.com with SMTP id ng8so1115095pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 22:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5zQQHlAdkKi/5/LHbljBLnmP/SWJe90/jtmz6ntc02A=;
        b=vKP+S4rdrk3RFrr58T+aSCG4j40KYwNWTXW33a5c5FSl/Eu2lTdZDRL3d8k15FffOK
         x/X+jXgt2DWtlLZl0+J8oEJIz1eizTOdyfwwTugra+NZ7U2A3EJIcchzjragpfXhTgtf
         ZRpKdHlH3nKdxlJjZ7A2zcCmgqzWgM63k8oJH/jLEtQCFg9M1SB4xWNYt0ytbkd0Gfpp
         FM4le5f3s8+scGjcgOg4Mx35mLdFWD6/v0M8UGKgZNukQn/Wfz67onzsR2LiPbVZffKv
         9nWWe5pRx+UM2QRpHodRyxL5PLEHe5eYikPolhEord7zXqUYPaWfrErk4hd1/xqzE0ry
         gkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5zQQHlAdkKi/5/LHbljBLnmP/SWJe90/jtmz6ntc02A=;
        b=S+SuQJNK3TrwP6Lv0QRyanlJgruhLXprmj9CESf7JjErTw4SgZKvF6Lwr2aTw5Y1Us
         rTDx0B+O6qGomqJYd6PRR3nSPehA6jyfL0OO3CenL6N8Cr+ebK6XtcMx7OIMKY3/HI6i
         k+TgSpnppdh1+68Z8CK6k3rPFssjgHuDeFqs3E7u9+da3OKFIwfYaxXqai1dC0/MFB3g
         GDbrvdvdsbXVSl5MFQyhCTaE+iG2hUCcucn1ZoW13n5FMeVnFvC+pLZk16ymar7GnzHT
         gvV2lN/s6yqHMOAUIc+gMJGL9uhZmsrYRQ3Ciiu7tA3mBwbLMANWW9bM4NEQFRGKFKFO
         juPw==
X-Gm-Message-State: AGi0PuZHloqHkC/BjO04G1F1M4X9sAx8uto0E6Fgb+Sp17JXSS9oRoW3
        0TdxpY4XGvLUjNEv3h2qO/M=
X-Google-Smtp-Source: APiQypIk1wMcGt7vUXSVK1MJW9YRaCXHyaTjB6smeZ6u0GO8uNCLQSJJgk4xubTEKp/AI5wOSj0bHA==
X-Received: by 2002:a17:902:7581:: with SMTP id j1mr1461361pll.171.1585807046892;
        Wed, 01 Apr 2020 22:57:26 -0700 (PDT)
Received: from localhost.localdomain ([103.87.57.161])
        by smtp.googlemail.com with ESMTPSA id 207sm2776058pgg.19.2020.04.01.22.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 22:57:26 -0700 (PDT)
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
Subject: [PATCH 2/3 RESEND] cred: Do not use RCU primitives to access cred pointer
Date:   Thu,  2 Apr 2020 11:26:39 +0530
Message-Id: <20200402055640.6677-2-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200402055640.6677-1-frextrite@gmail.com>
References: <20200402055640.6677-1-frextrite@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since task_struct::cred can only be used task-synchronously,
and is not visible to other threads under RCU context,
we do not require RCU primitives to read/write to it and incur
heavy barriers.

Suggested-by: Jann Horn <jannh@google.com>
Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 include/linux/cred.h | 5 ++---
 kernel/cred.c        | 6 +++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 18639c069263..5973791e5fe4 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -291,11 +291,10 @@ static inline void put_cred(const struct cred *_cred)
 /**
  * current_cred - Access the current task's subjective credentials
  *
- * Access the subjective credentials of the current task.  RCU-safe,
- * since nobody else can modify it.
+ * Access the subjective credentials of the current task.
  */
 #define current_cred() \
-	rcu_dereference_protected(current->cred, 1)
+	(current->cred)
 
 /**
  * current_real_cred - Access the current task's objective credentials
diff --git a/kernel/cred.c b/kernel/cred.c
index 809a985b1793..3956c31d068d 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -485,7 +485,7 @@ int commit_creds(struct cred *new)
 	if (new->user != old->user)
 		atomic_inc(&new->user->processes);
 	rcu_assign_pointer(task->real_cred, new);
-	rcu_assign_pointer(task->cred, new);
+	task->cred = new;
 	if (new->user != old->user)
 		atomic_dec(&old->user->processes);
 	alter_cred_subscribers(old, -2);
@@ -562,7 +562,7 @@ const struct cred *override_creds(const struct cred *new)
 	 */
 	get_new_cred((struct cred *)new);
 	alter_cred_subscribers(new, 1);
-	rcu_assign_pointer(current->cred, new);
+	current->cred = new;
 	alter_cred_subscribers(old, -1);
 
 	kdebug("override_creds() = %p{%d,%d}", old,
@@ -590,7 +590,7 @@ void revert_creds(const struct cred *old)
 	validate_creds(old);
 	validate_creds(override);
 	alter_cred_subscribers(old, 1);
-	rcu_assign_pointer(current->cred, old);
+	current->cred = old;
 	alter_cred_subscribers(override, -1);
 	put_cred(override);
 }
-- 
2.24.1

