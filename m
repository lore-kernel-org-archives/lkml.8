Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154F1C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E53C020737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i1bpkIty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634698AbgDOAsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2634608AbgDOAoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 20:44:12 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628E8C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:44:11 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id h16so1332455pgb.16
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UjNERNq8Aq8bZu5IIILXtpvcau9meFsW7FMuBohne+g=;
        b=i1bpkItyD1E346kP/89xta90B+TuHGZiUbt/x3MIvq+bvW15lb05O4/lQkdPiJ9NGQ
         93sLq3bZ0gCmmBs2NzvanaM5+i/dlvyVeSpkp5CAVl26E/vZDbirlDxpFHnFoGt0asff
         De+h6ZaWm9zwZliT9jPHTLXv7N8vr/JVd3LV7PLjsPYaE5eCL7pyvWG7c/boM6S6SiQ8
         DL83Mwca9qPVHPySOD3QPy0y9xpjNuXuzHvASgjvTwBAnYeenWMlqJp7UjOd4mpJU6bD
         EkyJRDjvpgKhXJbcQIC6wQknfksS4JPa7DaDbZInnGYHQ5aD/8fgByYqhQqtygZa3D/6
         Fi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UjNERNq8Aq8bZu5IIILXtpvcau9meFsW7FMuBohne+g=;
        b=W1Za0uKJZZDKAzTOr+B+a2VsCbqA0FO04uhWQnXZ8o4eOxBlXwNkBFrYhazBt+paCp
         MFgMDNQnhkGh3KrTBzH4UzfVMDw+xKGeAnSYoINT2UmNBxwfdzYSumds+KCl957WvrYa
         FPgNHr48j44YEawIzNUhr01QGs787dhta9rrMR7PZqU/oMHo1/TxkrksWMqtQKLjMgwC
         xI20iCQx41lwFjvYulYO5jdKe/el/l0BZDL7+iYfdviFPl7fvLU7t6SabJEXed8TK4yG
         FUWvVHs9SL4K5rXkEu7QuqfzEAs2vcqpq+EP0ynXMXlz5bHXZh35Drq5vO+HzmQC1nU2
         hr5g==
X-Gm-Message-State: AGi0Pua9rFuQZqGhP0HMZoqB0dt58K7WuJVowy+G3b0IkROiUsO7aaNm
        xV4wEcndwEkiryiaHWW5a7W8pM8c9eM=
X-Google-Smtp-Source: APiQypJbfrDGo32N0kQWg0rjiAGglPFM6uGFD1dgxEVO66T2nAcht+qTohafqDdYOoPPr9VCwJjI0Buz46A=
X-Received: by 2002:a63:4625:: with SMTP id t37mr23188575pga.83.1586911450839;
 Tue, 14 Apr 2020 17:44:10 -0700 (PDT)
Date:   Tue, 14 Apr 2020 17:43:49 -0700
In-Reply-To: <20200415004353.130248-1-walken@google.com>
Message-Id: <20200415004353.130248-7-walken@google.com>
Mime-Version: 1.0
References: <20200415004353.130248-1-walken@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v4 06/10] mmap locking API: convert nested write lock sites
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
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michel Lespinasse <walken@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add API for nested write locks and convert the few call sites doing that.

Signed-off-by: Michel Lespinasse <walken@google.com>
---
 arch/um/include/asm/mmu_context.h | 3 ++-
 include/linux/mmap_lock.h         | 5 +++++
 kernel/fork.c                     | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index 62262c5c7785..07e1cb53a89f 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -8,6 +8,7 @@
 
 #include <linux/sched.h>
 #include <linux/mm_types.h>
+#include <linux/mmap_lock.h>
 
 #include <asm/mmu.h>
 
@@ -47,7 +48,7 @@ static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
 	 * when the new ->mm is used for the first time.
 	 */
 	__switch_mm(&new->context.id);
-	down_write_nested(&new->mmap_sem, 1);
+	mmap_write_lock_nested(new, 1);
 	uml_setup_stubs(new);
 	mmap_write_unlock(new);
 }
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 8b5a3cd56118..9d34b0690403 100644
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
diff --git a/kernel/fork.c b/kernel/fork.c
index 9a2511a6714f..bdb5ec3574eb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -499,7 +499,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	/*
 	 * Not linked in yet - no deadlock potential:
 	 */
-	down_write_nested(&mm->mmap_sem, SINGLE_DEPTH_NESTING);
+	mmap_write_lock_nested(mm, SINGLE_DEPTH_NESTING);
 
 	/* No ordering required: file already has been exposed. */
 	RCU_INIT_POINTER(mm->exe_file, get_mm_exe_file(oldmm));
-- 
2.26.0.110.g2183baf09c-goog

