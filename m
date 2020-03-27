Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27651C2D0F0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E202071B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mOxcA4kt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgC0WvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:51:25 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:37851 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbgC0WvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 18:51:20 -0400
Received: by mail-pg1-f201.google.com with SMTP id q15so9150464pgb.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 15:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9JjmHpcSetUzd2DQK65fziZHzZsJKOqreOscrjvhn1w=;
        b=mOxcA4ktC5UqT4y7L4l/BUK52XTyHPa9goELov+T+H7q5BNgQv4ayBvYB3qZIq9JD5
         BkrHzzRy/mikJbiyQehvSUDR14j4lc/SbRKPhL9SAWz1X46altDUabXYu7JBewzLNhH7
         pS9hADkzlEnvPIHN/WaCGYkx5egXD8vAVXJLDFGHDZwQO3mW7QarQNLDLYr/HPIplrzN
         AqeNYlxnIIHjDB0mfNordUwzkzCuYd8y9bB4YaOqpj/GGG625fPja9UFrVPih7fWRV6n
         fVQD0AsnlmIaD6dXFcUaWdvhs9nnb6+egsYg2TytI/wJXBHhtU03HIm7koHhFeJsmG42
         552w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9JjmHpcSetUzd2DQK65fziZHzZsJKOqreOscrjvhn1w=;
        b=LmrtC0/jen61WsQkHRKPH6+MT05dlx53Ya7xdJ1Ge4kJP0o7VIP7CCcpuvYoNxrV1l
         nmujkD4/PGlRzmvd2HXMMnGF/+grdUull6uB/CZ6ugiG+n9bx0v3EIb9yrKvwBLsbR6i
         E3ll0qkCsAZK0h/7yhARPQunGr2hh9y7oIth4vL108uQBfl8WlADipN6lMdd3wvT+9Ml
         etoRHDmg+nvkt8dYe/gnFly3F9KsFXkvcHCcdgTDDB3LqWjtC4mJVws/Yne3Kqc96kv9
         HDBVWvAoY0wmFwLRCPcnnkKMsTChxZbjiuiJ461dHz01FsMpZl9Pd31+wN+2VZZvBcib
         cLgQ==
X-Gm-Message-State: ANhLgQ3XrP8uuyQkaTdAObEM1MF+6IfJmMm6uhAEq7d+Z2SVUHl20erX
        75NjfGu8BqhC2sFJjuS/84ETONqY4jI=
X-Google-Smtp-Source: ADFU+vuSsgM/jrzZ4eZBp7cSHVGsQXOE2CSs9MIM1i2Xg2Z0bI/jIRcAISkde1W+6I9nqAHgiJTRgVoY8Lk=
X-Received: by 2002:a63:f243:: with SMTP id d3mr1605790pgk.254.1585349479677;
 Fri, 27 Mar 2020 15:51:19 -0700 (PDT)
Date:   Fri, 27 Mar 2020 15:50:58 -0700
In-Reply-To: <20200327225102.25061-1-walken@google.com>
Message-Id: <20200327225102.25061-7-walken@google.com>
Mime-Version: 1.0
References: <20200327225102.25061-1-walken@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v3 06/10] mmap locking API: convert nested write lock sites
From:   Michel Lespinasse <walken@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Markus Elfring <Markus.Elfring@web.de>,
        Michel Lespinasse <walken@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add API for nested write locks and convert the few call sites doing that.

Signed-off-by: Michel Lespinasse <walken@google.com>
---
 arch/um/include/asm/mmu_context.h |  5 +++--
 include/linux/mmap_lock.h         | 11 +++++++++++
 kernel/fork.c                     |  4 ++--
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index 62262c5c7785..cc15173f7518 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -8,6 +8,7 @@
 
 #include <linux/sched.h>
 #include <linux/mm_types.h>
+#include <linux/mmap_lock.h>
 
 #include <asm/mmu.h>
 
@@ -47,9 +48,9 @@ static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
 	 * when the new ->mm is used for the first time.
 	 */
 	__switch_mm(&new->context.id);
-	down_write_nested(&new->mmap_sem, 1);
+	mmap_write_lock_nested(new, 1);
 	uml_setup_stubs(new);
-	mmap_write_unlock(new);
+	mmap_write_unlock_nested(new);
 }
 
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, 
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 8b5a3cd56118..36fb758401d6 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -11,6 +11,11 @@ static inline void mmap_write_lock(struct mm_struct *mm)
 	down_write(&mm->mmap_sem);
 }
 
+static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
+{
+	down_write_nested(&mm->mmap_sem, subclass);
+}
+
 static inline int mmap_write_lock_killable(struct mm_struct *mm)
 {
 	return down_write_killable(&mm->mmap_sem);
@@ -26,6 +31,12 @@ static inline void mmap_write_unlock(struct mm_struct *mm)
 	up_write(&mm->mmap_sem);
 }
 
+/* Pairs with mmap_write_lock_nested() */
+static inline void mmap_write_unlock_nested(struct mm_struct *mm)
+{
+	up_write(&mm->mmap_sem);
+}
+
 static inline void mmap_downgrade_write_lock(struct mm_struct *mm)
 {
 	downgrade_write(&mm->mmap_sem);
diff --git a/kernel/fork.c b/kernel/fork.c
index c321910d46e8..3460308b2213 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -497,7 +497,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	/*
 	 * Not linked in yet - no deadlock potential:
 	 */
-	down_write_nested(&mm->mmap_sem, SINGLE_DEPTH_NESTING);
+	mmap_write_lock_nested(mm, SINGLE_DEPTH_NESTING);
 
 	/* No ordering required: file already has been exposed. */
 	RCU_INIT_POINTER(mm->exe_file, get_mm_exe_file(oldmm));
@@ -612,7 +612,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	/* a new mm has just been created */
 	retval = arch_dup_mmap(oldmm, mm);
 out:
-	mmap_write_unlock(mm);
+	mmap_write_unlock_nested(mm);
 	flush_tlb_mm(oldmm);
 	mmap_write_unlock(oldmm);
 	dup_userfaultfd_complete(&uf);
-- 
2.26.0.rc2.310.g2932bb562d-goog

