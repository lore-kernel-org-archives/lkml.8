Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2CDC2D0F3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C962076B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N5lgoeki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgC0Wva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:51:30 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:51821 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgC0WvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 18:51:25 -0400
Received: by mail-pl1-f202.google.com with SMTP id d4so8099149plr.18
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 15:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=28kVchorg0pFyF9b0ogWAEAHMYZwNEgdx4vJfdA+cNY=;
        b=N5lgoekiDT0KdtpBQyJZN+rAhSDRFgLYlqk+FnMqCC7Nt+l8s5TsP6h3h1hSBisdOk
         lJXgZbgQ9BxYEI6MS6WTnWVZ9B0JV63iz6Ed/0Y4nIeyqDcGI1wwz0kKSy2k1h4K3alO
         laj97wLWd1WxTa2eydnBg1VD5ue6kv5hLxcrc7NYCnGZ09WQ7s16OnxC1MY0DldE1u1+
         pgrRmyCqhY+13dYDwm/DpIfDoa/pXIOd1+dDJ/1ewCa3aZtVE/ePajwt2EfnOY/FFIKQ
         f6nAqkZwT4SeDkYc0/jpG0YZj/cDnDfzUUJJahq1IQ8RX9mGGnFV9boW7gJPggTJB2y4
         bHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=28kVchorg0pFyF9b0ogWAEAHMYZwNEgdx4vJfdA+cNY=;
        b=Q5g6lCz0u7hk3Esp1rt0JPk29c+BbfM/kAKMYwHrjdAJflUN46uSBimV/Qsh4TUAT5
         MY1QK+PorlgRi/601WUCE0mfOrbBdfHXrviyEJne1fsN3eE9qFkrJzgGn4xnXotCMriw
         976O3oCzobJKVsxaX1qhlZEhjCpgDtLjdT+tBKaX5dAyTUu1J3IUMXGHlb6HOY+y3MCD
         9aP8vRxZMO1sh0x4P4QHbkBN9Xd3CaBUNvzLNQUYwucvUYaFbeA88nBEVlmLJkoUWYcq
         b6najlVSc9nyzL+Z881yNEJf6/dLxmUds8IWB1S2YvCfPJijGhS/P8z4XgUn/Vnmkcd6
         zCmA==
X-Gm-Message-State: ANhLgQ2AwCYVxXnn/+yPemzLwMzOPc514TXQ/vzZUMh4TWDsPMpfqRW1
        vPxi1Lg+/PIk5q1KtDUtEZ9rZKJVJaY=
X-Google-Smtp-Source: ADFU+vsZFnC2lgwaR/+bm7vWv24PAezbCSqsEnKPHHSSDCnNK07HbdoMMzr9genfbIzwWEfrvd1MyxKT7QY=
X-Received: by 2002:a17:90a:5a42:: with SMTP id m2mr1746324pji.165.1585349484828;
 Fri, 27 Mar 2020 15:51:24 -0700 (PDT)
Date:   Fri, 27 Mar 2020 15:51:00 -0700
In-Reply-To: <20200327225102.25061-1-walken@google.com>
Message-Id: <20200327225102.25061-9-walken@google.com>
Mime-Version: 1.0
References: <20200327225102.25061-1-walken@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v3 08/10] mmap locking API: add MMAP_LOCK_INITIALIZER
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
index a80cf9695514..25a8a5458b84 100644
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

