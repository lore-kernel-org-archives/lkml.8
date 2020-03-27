Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38350C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105B820787
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="At+xhy3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgC0CL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:11:27 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:37415 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgC0CLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:11:23 -0400
Received: by mail-pl1-f202.google.com with SMTP id t12so5926327plo.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 19:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wKHWtKZXZ1jV5SPUsD2wXtJbpgHx5U7xHaRPqBEbazY=;
        b=At+xhy3bvcI8P6Yc9VFXhUNItfjaM47ENdzxAMxzs+lh79KmCnOH+DcQN5SdCRavdj
         r/9c68l7xeOc5p5Lv9UAbfIjXvPbIFWmg0/VBTrBpckAneIgr/afsQVBwF0mqAj2XyEu
         PnqcwBtPgI3PFCQbjvrGpB0R1uBE96hPorM8TGO+RvgpPvpRw9o5WxuACZ2LAMgrgBsX
         rwOsP7THEroAIoQ7tk2ObCt2/K6DOLDPogChYJveR2PdHQTulRBVxxJrdEDlk+h93o0x
         EswhFKcSNDdc1l5pJs8ZwuTY+jlPQghzLg1PcRInigqfwXRZFbZmZwJ3P57vmUfaoB0P
         XufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wKHWtKZXZ1jV5SPUsD2wXtJbpgHx5U7xHaRPqBEbazY=;
        b=rcBRpSmEApJz7ok+LAG9h0NaKXXdxRyhe4AuSXRA51LY4UiBgJ3+3hVVkbpcKzX9qA
         HVHaZdVsqU7LCriUb0rXUM7hG7x83CMtPkazZXB2ceGz3sIv2BDLwd/ig6BWnJenukKP
         GmZNJCR43SgMjm+3DSD5cSEr8cjnuH2Zq2fAjGv7VFxRVqrphOZ/HcXrA9zaCqqbJCfS
         c5yMC+KiXitAiT1f+PawXEAsw7IZl8oi7mPKR3WGQeqFuHzk03ldF+jvyU/D1zNmxG9+
         YG1rZ/mdSELrwnxyuSFFdsi+87A2BVGUOzsxkywQF3Vvmp6aDNFYgaIREZ8sfqUwQXe+
         +IUg==
X-Gm-Message-State: ANhLgQ2EJ0R2UOxn3Lxl+CZWdrtDuDbu6lmKEJne+2izcroI6lKsxgNP
        LdKvZ1FCaf+hsnjC1y9JntgYD2VtJzQ=
X-Google-Smtp-Source: ADFU+vvExyAv/OwWEEYNlmMFQDR227S8p/tJ1ZA9i/UH27AjA6V7+1ax3JYRqqLD8k6EwwISQNiuTVn6krw=
X-Received: by 2002:a17:90a:b391:: with SMTP id e17mr3408370pjr.55.1585275081027;
 Thu, 26 Mar 2020 19:11:21 -0700 (PDT)
Date:   Thu, 26 Mar 2020 19:10:56 -0700
In-Reply-To: <20200327021058.221911-1-walken@google.com>
Message-Id: <20200327021058.221911-9-walken@google.com>
Mime-Version: 1.0
References: <20200327021058.221911-1-walken@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v2 08/10] mmap locking API: add MMAP_LOCK_INITIALIZER
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

Define a new initializer for the mmap locking api.
Initially this just evaluates to __RWSEM_INITIALIZER as the API
is defined as wrappers around rwsem.

Signed-off-by: Michel Lespinasse <walken@google.com>
---
 arch/x86/kernel/tboot.c    | 2 +-
 drivers/firmware/efi/efi.c | 2 +-
 include/linux/mmap_lock.h  | 2 ++
 mm/init-mm.c               | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index b89f6ac6a0c0..4b79335624b1 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -90,7 +90,7 @@ static struct mm_struct tboot_mm = {
 	.pgd            = swapper_pg_dir,
 	.mm_users       = ATOMIC_INIT(2),
 	.mm_count       = ATOMIC_INIT(1),
-	.mmap_sem       = __RWSEM_INITIALIZER(init_mm.mmap_sem),
+	.mmap_sem       = MMAP_LOCK_INITIALIZER(init_mm.mmap_sem),
 	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
 	.mmlist         = LIST_HEAD_INIT(init_mm.mmlist),
 };
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 21ea99f65113..5bdfe698cd7f 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -60,7 +60,7 @@ struct mm_struct efi_mm = {
 	.mm_rb			= RB_ROOT,
 	.mm_users		= ATOMIC_INIT(2),
 	.mm_count		= ATOMIC_INIT(1),
-	.mmap_sem		= __RWSEM_INITIALIZER(efi_mm.mmap_sem),
+	.mmap_sem		= MMAP_LOCK_INITIALIZER(efi_mm.mmap_sem),
 	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
 	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
 	.cpu_bitmap		= { [BITS_TO_LONGS(NR_CPUS)] = 0},
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 00d6cc02581d..7474b15bba38 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -1,6 +1,8 @@
 #ifndef _LINUX_MMAP_LOCK_H
 #define _LINUX_MMAP_LOCK_H
 
+#define MMAP_LOCK_INITIALIZER(name) __RWSEM_INITIALIZER(name)
+
 static inline void mmap_init_lock(struct mm_struct *mm)
 {
 	init_rwsem(&mm->mmap_sem);
diff --git a/mm/init-mm.c b/mm/init-mm.c
index 19603302a77f..3c128bd6a30c 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -31,7 +31,7 @@ struct mm_struct init_mm = {
 	.pgd		= swapper_pg_dir,
 	.mm_users	= ATOMIC_INIT(2),
 	.mm_count	= ATOMIC_INIT(1),
-	.mmap_sem	= __RWSEM_INITIALIZER(init_mm.mmap_sem),
+	.mmap_sem	= MMAP_LOCK_INITIALIZER(init_mm.mmap_sem),
 	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
 	.arg_lock	=  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
 	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
-- 
2.26.0.rc2.310.g2932bb562d-goog

