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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1111CC2D0EE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FB52074D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vff5HijL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgC0CLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:11:21 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:47043 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbgC0CLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:11:19 -0400
Received: by mail-pg1-f202.google.com with SMTP id s18so6631988pgd.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 19:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oxDWeBm7sOHjpiApO9NbnvZLKdMBOgGtnj1GVCKM9PM=;
        b=vff5HijLm3rVFWQg1Q6tILibVb0/t3dACKm0UD0fwBJMKC9ohGcRlug/Kuglwu1XyW
         7ahlsaaY+O/P+CM86RifHiol654wkqYYPFnbzAP1Epq+gRAvZ8G6houEHhq9Dd4FOGA8
         LFas61baJo5B8lNp/Ro7RhBxKogZEauq+zhA+7v9tTtNPw9GWfaO2z2+5nNh1/GYfhgQ
         JLUzwzAqNmpmCdF5H1M3vldBSYZkhtjyMvWBzestCGLa956M1XKtKaSRByaM5ib8N0Bg
         kAJlN3LxNobDGIKEQANlS/2PS9VRCrhMzqttI0gyG3zqH5bD2HO1F03dC4GtKGIYb3f4
         pfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oxDWeBm7sOHjpiApO9NbnvZLKdMBOgGtnj1GVCKM9PM=;
        b=QF8Cy6vcFVTbgVEvG8P0RHitLTXlEavQ0ixF0hBtRQbRndiXd1IbZpBimQQCR6k+K9
         OLL1gSaI24S2sg00wBA/O0ZOLYtI0AzasldMWiw584xoc1KKSmbZjokq4XEoj8ejz5zm
         4K/FxMMVPXnlhjgtYBySZVyoNSCNhR0//NLKGf34QQ8C2gMOJKYdlyRW6Bsv/G5coBhB
         /0SBwvLsgVhmEcwHUC544uNBcNXZu63wcGEkqpFuimXaLuaqNnFuNwGE+YeAOjol+gFY
         q27mv3CulgY9/Et+C7CzS16s7qT3Hn1VbsYSsqz/cXbhogr87NK7U3CcUGzhQyJgGyuf
         6odQ==
X-Gm-Message-State: ANhLgQ17RHdK2V5ZZIpZynixETXGuTZm2sYK1/5NGaMAfjrcKj2Fesm7
        W5DXkye8Q1a6cZFL2x03HZyDCY/OI5I=
X-Google-Smtp-Source: ADFU+vuh3Psmnwb5B2KXKfiPZ7gW9ScpNWqCS0cyKYTi8+z/ypo7VtLCrBAXmFLp6QjG5Evl+DPNu+S2aKw=
X-Received: by 2002:a17:90a:d78b:: with SMTP id z11mr2409659pju.34.1585275076325;
 Thu, 26 Mar 2020 19:11:16 -0700 (PDT)
Date:   Thu, 26 Mar 2020 19:10:54 -0700
In-Reply-To: <20200327021058.221911-1-walken@google.com>
Message-Id: <20200327021058.221911-7-walken@google.com>
Mime-Version: 1.0
References: <20200327021058.221911-1-walken@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v2 06/10] mmap locking API: convert nested write lock sites
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
2.26.0.rc2.310.g2932bb562d-goog

