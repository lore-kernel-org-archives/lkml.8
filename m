Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92138C2D0F1
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69736207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iSyMxX4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgCZHC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:02:58 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:37442 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbgCZHCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 03:02:52 -0400
Received: by mail-pj1-f73.google.com with SMTP id d9so3599686pjs.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 00:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VJPkzc3VvkOllWTcp9BbAsJmVeKWEmh90BHxu+W0SPE=;
        b=iSyMxX4G5a6GT1URzk8XL8ZwrcSSNoOluzhd3Q6kKJf5nH+++hgpZc8+Kero84dUQn
         hQ2l0ZxQZQQeyshFP2toc54vDnLHysbYXhpyJC6jheTkcmZN8mDjHdw2NBXSwW7h5MYl
         eFWIEY7MQ25gOL2drqrYmIZ85kMwyNVP1qkftYJT/PJLtvyyIPGk2fiv9cgZYsdW5k7x
         T3QNUFZ2fQNfdMSR6kk2e4WnX8N5FStPAo4wpBtxbPLztNzKo7y6x3vcJav3eSy/ZWHo
         3IoJk0FoGf21AMkevgRfR01w37u+uc0IXuVyUn4sRR+82vxaRh+MJbJdMh2J5B3d30Wg
         CGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VJPkzc3VvkOllWTcp9BbAsJmVeKWEmh90BHxu+W0SPE=;
        b=a7bkS8Xedt6v9KSKaomYBm2hIOKS0RdGbGk6Thy7KUzKUwLfgc6lbrmEXCjgcjgbPX
         k+wwjGyrCDHZlZBu83Zml1SZUG6wUbGzjGfzg9JEngHoWcOAXfPsIMFTW73Nyk66XAGb
         X1DO4u1uk/5DoclveUvfleizbtzH1VaM1Q3yhDFNAKZYS2FYQjXDw6+Od2ibFpescQ7w
         H780QfdlZ2YR5svd4kDYNEtEBCgOrMvXhPczQXJQfPEPzESrWASr4hBdUmgSFff5Sz87
         J3e95yPQxaf3+OlVgnLzORvmPKw7gX67S3wdvsVTcMN1Iq6B+lsm5fofIhYuShtIvlSV
         824g==
X-Gm-Message-State: ANhLgQ09ppSvYHTAKXn3nderl8YEspTwhDEF0j9+ksURfo43QhcPz9Fk
        J+6zvQILoIqkCMY7J9raePRfVE+2i40=
X-Google-Smtp-Source: ADFU+vtbMKdXd0svrxK+Bu5vbiPAjPuFcHvl94Xefvme7ocADs4AOtgtiFcFkT3BbPA5L326zK5JQ17mhTM=
X-Received: by 2002:a17:90a:1b22:: with SMTP id q31mr1558267pjq.109.1585206171449;
 Thu, 26 Mar 2020 00:02:51 -0700 (PDT)
Date:   Thu, 26 Mar 2020 00:02:33 -0700
In-Reply-To: <20200326070236.235835-1-walken@google.com>
Message-Id: <20200326070236.235835-6-walken@google.com>
Mime-Version: 1.0
References: <20200326070236.235835-1-walken@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH 5/8] mmap locking API: convert nested write lock sites
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
index cffd25afe92b..40a972a26857 100644
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
2.25.1.696.g5e7596f4ac-goog

