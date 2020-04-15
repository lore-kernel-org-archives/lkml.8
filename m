Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18092C38A29
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7E5E20737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ds/J6oOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634655AbgDOApz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2634611AbgDOAoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 20:44:17 -0400
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com [IPv6:2607:f8b0:4864:20::a4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC585C061A41
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:44:16 -0700 (PDT)
Received: by mail-vk1-xa4a.google.com with SMTP id j68so977123vkj.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zcekvyQ/72KhxhLDP4al7ATAbVuK8V+d9wz4X2X0YtE=;
        b=Ds/J6oOwyzOTUwwXAlvlhp+O91+I2jQ/wIee1X/rtO6hzkFM6Hux/qJ4ucZc/fa61q
         3hifVqNY2O9qiCAP79Swxo5Jgqc5M1aKhjT92O0dZZH8yLwsLpMNfqD97YbAH2mk9YD8
         DHLcz1zNk4SEax4MiqbLaE79+dfUkgYWJveiRpSv6AsTLtkLXtUccqHU8yxR8cGHlSQq
         fN71c4vnkwDPYio69zt8lckEir+kx2e/KPz++/eg+sxMMxqVb89hzwv8k5IBNZFWUzds
         oUMyiOcIb988ZEkc96Fc/laWjRtpNFN/re90lEvjZXJ9Plmkz9EfcvqW3t0FVN7za+4k
         cvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zcekvyQ/72KhxhLDP4al7ATAbVuK8V+d9wz4X2X0YtE=;
        b=jAh5Wy5iStblsspn/Wewmw3o6VwTQNPrjnCnfhJkyO1Ft+m9Xb+45UOLCwTOgCMc8C
         BAB+cSBQUMlkPsCc+J7i7W4E0yWLsKnekchwpIGWW4Z9izxeHeh1t0eXjFKP35SN/Ll8
         frRUCpfkaynzaKlgYcnnhEJ9Yu4VsY6GruwsrVNWZHfxFELCguQlsEox1iAVy7uN6fpC
         r8dedzOORTNujKosTZBNjgZPIZK8w6+D1NBvDIPc7jP+mpe79qCJ0faf8rIPnm2N8rHw
         bz98P55pXaQY1oh8WDgQuLuH664gmZGiRFRbfK4c24zvuWxFpVsdBsjS5z3ct8zJUbI4
         3Cqw==
X-Gm-Message-State: AGi0PubuHD3q7LrAVjbpFp/EvOyczHCEZKPeahKDrMI407fn37V+XNXh
        TihVLI1SLN7oh+bVh3xOzvD9JriBncw=
X-Google-Smtp-Source: APiQypJZ2eXP7ulP/b4UP2i1f+YdW/QLsG7S+zDoTgeqUfr3cwhuJZnYws3QuzMg8m+Pq5z8IX1BuuzgmAI=
X-Received: by 2002:ab0:6449:: with SMTP id j9mr2559890uap.19.1586911455892;
 Tue, 14 Apr 2020 17:44:15 -0700 (PDT)
Date:   Tue, 14 Apr 2020 17:43:51 -0700
In-Reply-To: <20200415004353.130248-1-walken@google.com>
Message-Id: <20200415004353.130248-9-walken@google.com>
Mime-Version: 1.0
References: <20200415004353.130248-1-walken@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v4 08/10] mmap locking API: add MMAP_LOCK_INITIALIZER
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
index 911a2bd0f6b7..4bac9d7a48a6 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -54,7 +54,7 @@ struct mm_struct efi_mm = {
 	.mm_rb			= RB_ROOT,
 	.mm_users		= ATOMIC_INIT(2),
 	.mm_count		= ATOMIC_INIT(1),
-	.mmap_sem		= __RWSEM_INITIALIZER(efi_mm.mmap_sem),
+	.mmap_sem		= MMAP_LOCK_INITIALIZER(efi_mm.mmap_sem),
 	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
 	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
 	.cpu_bitmap		= { [BITS_TO_LONGS(NR_CPUS)] = 0},
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 1050257361aa..07efa379664a 100644
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
2.26.0.110.g2183baf09c-goog

