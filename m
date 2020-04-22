Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2621DC54FCC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F23A42076C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZBxfSTH4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgDVAO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgDVAOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 20:14:41 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E41C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:14:39 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id y14so199922pgk.18
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BiEEiVkzSVoyEqKh7AVUXyeKMpCUvM4D35tqNT5BDzI=;
        b=ZBxfSTH4Jf/kixOoAnairq3UwrJnJI9xCIxf/bGiCkHeAm9ChAhBbaaQdZ/RqNx/6v
         py3PlzefCpfQkI5EZo2elGDyIMyP4qb0jDB2WzxJt8RrKrqsDDVD290X5CA51GNf3SaY
         knC0BULD9D+uDIaSdTzAnm5JBMYj+9C77WmxTcRL03wMyePjbrDM/pL9PkSx9dzVzNpv
         41MmKfgXzWaJ5JmHaLQ0EJ5q0aPZ1FyLo4tEPxBTVjsjJGxr7du0pbW+Er7qeK+eEump
         Gs7IoopoPEQxl8aHYPPTNvnRsLS4NuqttG0iX6mbR+ZDTybj23mV+0nNOFT9XqYFjigK
         7PrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BiEEiVkzSVoyEqKh7AVUXyeKMpCUvM4D35tqNT5BDzI=;
        b=RODRg4LKS3ajdqQXJK0zCGiWQo6HmCBzC/jBzw4SCeSfSp71tNM3MphPQAr6xwMZj9
         bX9JLYXQgEBlpBQePl83lzqyhPlGa84rr4EeQfKsvex4aQgeC9LHQ51qrvN7wacuaA6S
         9pr02vQ9SNnebHUkNUMAiKvlBpMQ1viz6BSREGOKMIVDCCuDS/v/c+AsLAWlOAgIamhR
         lVZLnIvBuRLYSsZ6nnFKHApkyVwwXN7r6C5wKhQdk3aGYWh3FwNRKYSIQVzoCPoIexci
         wQR64NqvQ2RPrTMT6V09QJItq/Ku6d6o1BiOwNRE2gOhOVGOIE6ZXn+4xORGx3hylg9G
         puDg==
X-Gm-Message-State: AGi0PubNsuFDgadc32EmTC2NBJMXHyX073dDFTl7qxAGSYfI9Tl72dBT
        yX9cJtsTi1kbGTQjku1tyGL3KEQkHUY=
X-Google-Smtp-Source: APiQypLiKMr0o5RL5Ux7FELtq4rZpz0gRc5jfxGfMu8ywH2+NFGs5Ampy6i+wXiJMpGmReBMmSUWBmgzcio=
X-Received: by 2002:a63:c007:: with SMTP id h7mr23391466pgg.428.1587514479245;
 Tue, 21 Apr 2020 17:14:39 -0700 (PDT)
Date:   Tue, 21 Apr 2020 17:14:18 -0700
In-Reply-To: <20200422001422.232330-1-walken@google.com>
Message-Id: <20200422001422.232330-7-walken@google.com>
Mime-Version: 1.0
References: <20200422001422.232330-1-walken@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v5 06/10] mmap locking API: convert nested write lock sites
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
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 arch/um/include/asm/mmu_context.h | 3 ++-
 include/linux/mmap_lock.h         | 5 +++++
 kernel/fork.c                     | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index 62262c5c7785..17ddd4edf875 100644
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
+	mmap_write_lock_nested(new, SINGLE_DEPTH_NESTING);
 	uml_setup_stubs(new);
 	mmap_write_unlock(new);
 }
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 97ac53b66052..a757cb30ae77 100644
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
index 41d3f45c058e..a5d1d20ccba7 100644
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
2.26.1.301.g55bc3eb7cb9-goog

