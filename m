Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56D7C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D97720776
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YU+Dpsuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgDVAOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgDVAOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 20:14:45 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B62C03C1A6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:14:44 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id t18so237126pgi.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2opZsbHIn/7vppLXalOzj/KzjaH4KmbCOQZ36m9L9lE=;
        b=YU+DpsujXi0dVqJJUn+VODEzULokQfOL0DEI1YbafX+yE0cHnEjcF9d9u7UqxpJGa7
         3BcZBWBvk9crC3TVt+cufx3Fss2NCMhw6FWgs071GWBCKXJeIFvaWfxJEzUxbNvaYkJa
         j+6TfuSj3AiBez+mBQSM2YW7w9QCdSp+sFTVVQ8ugkK2yjdrw3Toaiel9ipwHGk+lGFu
         Kc4IY/Ztnjd1luBlFc1lraZ2m3sNb6BzDrJGoeXVNV/Xh8gbvbaViErJH43THqBdEFOf
         p2hSFugDNMm6rwwkVT+KxJC/7Q/n5/sZwMRsJ0SqpOPicpMfREqWL++llmwCv0eqVjCJ
         ZukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2opZsbHIn/7vppLXalOzj/KzjaH4KmbCOQZ36m9L9lE=;
        b=TUx+04JxFtCb08kPokEAXRFOgWZv36RBsgtGYjeh8T+AoFthwiNtGlW05+HrFII/Cb
         CbM9+xGAX6eadNvmgN6visEFN1DjZAFnVftcr09HBHt0P0SR7OjA5PVSDIV6kV86dYSC
         9PX1eXzJC2C2E3oGt5nWdQ1u1foXVbFTqQm5/8hh7DCQn9b0bpiMkL/d3ZOyOt0s2Sji
         YHK3qJW/JUQWc2UXpPCx64U08ZbLgTBULLIwKlKu+mDjF6UKKwWoApfr4xj8ZrJeK6Ag
         CqANbjLNLPtHXLHTOekj638GWA0sdYcfmjQaengg0R0cwScvs8DJcFMR5KNsMX/oX71U
         WsPg==
X-Gm-Message-State: AGi0PuYGe3XgymPd21SbOCxL2w6XAbVg8E0RUZLTFG0cEa0TviaPr9RW
        pb6T6nlYys8YI4dE2PEcag2JLItiqqI=
X-Google-Smtp-Source: APiQypIXTchO/qnvCAeRZjmkZ2EVbLqjiP88Fl2FWaZemSZbbMCYcFq80mBz45/FOR986aYwIIFHjDIfBSc=
X-Received: by 2002:a17:90a:2709:: with SMTP id o9mr8504791pje.168.1587514483951;
 Tue, 21 Apr 2020 17:14:43 -0700 (PDT)
Date:   Tue, 21 Apr 2020 17:14:20 -0700
In-Reply-To: <20200422001422.232330-1-walken@google.com>
Message-Id: <20200422001422.232330-9-walken@google.com>
Mime-Version: 1.0
References: <20200422001422.232330-1-walken@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v5 08/10] mmap locking API: add MMAP_LOCK_INITIALIZER
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

Define a new initializer for the mmap locking api.
Initially this just evaluates to __RWSEM_INITIALIZER as the API
is defined as wrappers around rwsem.

Signed-off-by: Michel Lespinasse <walken@google.com>
---
 arch/x86/kernel/tboot.c    | 2 +-
 drivers/firmware/efi/efi.c | 2 +-
 include/linux/mmap_lock.h  | 3 +++
 mm/init-mm.c               | 2 +-
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index b89f6ac6a0c0..885058325c20 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -90,7 +90,7 @@ static struct mm_struct tboot_mm = {
 	.pgd            = swapper_pg_dir,
 	.mm_users       = ATOMIC_INIT(2),
 	.mm_count       = ATOMIC_INIT(1),
-	.mmap_sem       = __RWSEM_INITIALIZER(init_mm.mmap_sem),
+	MMAP_LOCK_INITIALIZER(init_mm)
 	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
 	.mmlist         = LIST_HEAD_INIT(init_mm.mmlist),
 };
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 911a2bd0f6b7..916313ec8acb 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -54,7 +54,7 @@ struct mm_struct efi_mm = {
 	.mm_rb			= RB_ROOT,
 	.mm_users		= ATOMIC_INIT(2),
 	.mm_count		= ATOMIC_INIT(1),
-	.mmap_sem		= __RWSEM_INITIALIZER(efi_mm.mmap_sem),
+	MMAP_LOCK_INITIALIZER(efi_mm)
 	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
 	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
 	.cpu_bitmap		= { [BITS_TO_LONGS(NR_CPUS)] = 0},
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index d1826ce42f00..9e104835a0d1 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -1,6 +1,9 @@
 #ifndef _LINUX_MMAP_LOCK_H
 #define _LINUX_MMAP_LOCK_H
 
+#define MMAP_LOCK_INITIALIZER(name) \
+	.mmap_sem = __RWSEM_INITIALIZER(name.mmap_sem),
+
 static inline void mmap_init_lock(struct mm_struct *mm)
 {
 	init_rwsem(&mm->mmap_sem);
diff --git a/mm/init-mm.c b/mm/init-mm.c
index 19603302a77f..fe9c03d8e07b 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -31,7 +31,7 @@ struct mm_struct init_mm = {
 	.pgd		= swapper_pg_dir,
 	.mm_users	= ATOMIC_INIT(2),
 	.mm_count	= ATOMIC_INIT(1),
-	.mmap_sem	= __RWSEM_INITIALIZER(init_mm.mmap_sem),
+	MMAP_LOCK_INITIALIZER(init_mm)
 	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
 	.arg_lock	=  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
 	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
-- 
2.26.1.301.g55bc3eb7cb9-goog

