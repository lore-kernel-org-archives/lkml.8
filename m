Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC12AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB23920873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XgZ0MYBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgETF3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 01:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbgETF3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 01:29:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF460C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 22:29:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k186so793079ybc.19
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 22:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=baUrqRjT3RvpPQiJbNrpdqbCcCfZQeZzSpidKaRl4yM=;
        b=XgZ0MYBjp/QQ5RAKRllpCcwYravdKAtbrF5pMXkCUVf2NCm/jXuE1rxMjvK40nn86F
         DBqDKWi3pmk69dsffz+PyGCYlsCNUn8xFoDFJtM630/9YiCIvg0En7kluix7NcPVTnxc
         5M8kncj7yYHBYxSf6fjrMpqIY5h3RWdgz6NHEmAH8SS+sHsXvemZvUZkC5DHGZzSX7Vz
         alNNdWUB7/5QfWcZghaVCMiep/3qn3af4qAXrYIb8747nRYG77iUkvCEXzUycAnqu3vv
         OGtEbq7oPzUP8zHBnAV62mt1zrq8ygagulTDW7PNy9va3lOGHo8KrHBiIE4WyjrXOnGN
         8Rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=baUrqRjT3RvpPQiJbNrpdqbCcCfZQeZzSpidKaRl4yM=;
        b=TJVIs0WYKsZ4ywPz5e51SwOldAMQdgvagqkogveAHPvfUUhGW5zv3SeGKZkksyyQs1
         C0C9vDWHuvrOjNn+KLGvBEXsmXrgtumYJhRGYUv/QtX8YQJd5SFcDZjhyi3pEVO84Cpa
         pVVFVTyFD7vsWfSFTNaQKT8JaTysm+MV/CmkYwvVu+VEivaf7Lb9GcL2Fr73iQl6O59H
         GnArjSNTNNr27TSxV+NKZkc1m9WJZlFUquqTMHteKLriSpNzZuYPJtAMaz2WoMmO4pri
         onaZyID6J6VVQ+DkgAVkHBSTL6O0Ur3xFdde4WJLWTkTDq+1zx9og3K8OTVAsAf4R0O4
         iYFQ==
X-Gm-Message-State: AOAM531AS7lZdDds1ISEJNYOsjkxIcSkngWhGJDmGYDO0iQV5DcwSBBj
        Y7Ts/eRPIZ6t2pM019igI/v6v+foJyk=
X-Google-Smtp-Source: ABdhPJwX7AKolR7rvFLD8FiK5S+rC4975CmSeuOF7aUaBCeim62UAoqyPuR4CPyNCTa4l4lVobVU5TsjgDE=
X-Received: by 2002:a5b:345:: with SMTP id q5mr4540485ybp.494.1589952569960;
 Tue, 19 May 2020 22:29:29 -0700 (PDT)
Date:   Tue, 19 May 2020 22:29:04 -0700
In-Reply-To: <20200520052908.204642-1-walken@google.com>
Message-Id: <20200520052908.204642-9-walken@google.com>
Mime-Version: 1.0
References: <20200520052908.204642-1-walken@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v6 08/12] mmap locking API: add MMAP_LOCK_INITIALIZER
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
        John Hubbard <jhubbard@nvidia.com>,
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
Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
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
index d1826ce42f00..acac1bf5ecd2 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -1,6 +1,9 @@
 #ifndef _LINUX_MMAP_LOCK_H
 #define _LINUX_MMAP_LOCK_H
 
+#define MMAP_LOCK_INITIALIZER(name) \
+	.mmap_sem = __RWSEM_INITIALIZER((name).mmap_sem),
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
2.26.2.761.g0e0b3e54be-goog

