Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A940C2D0E7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9562082D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aM2NoReH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgCZHDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:03:02 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:50544 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbgCZHC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 03:02:58 -0400
Received: by mail-yb1-f201.google.com with SMTP id s5so5203690ybj.17
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 00:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6cPzqY4b80WWa29eiLyrEV/lfe6Ajij7bnzw5uITzXo=;
        b=aM2NoReHcssDrr2yxV6rHddBQXBxn2hg+/WxGz60+JG7QxK+e1+4HJS50I2BpVA6Sh
         iElPWI/anwEFXk7oFo8prH8pi6sprRM8LL9XqFONtzEj2E9k0pKC52dm0UXIZktap3Bv
         UNP5LqgME5RTiDZFZnAm2ycb+k49qK/VulCkipgEtUTocFmUPyUGwqtHxDGNeY3yCn2g
         64yC9ywQQ0uyd42AzqyuGkz44+7OXwT7cDaKi2irkjb3K5WC/jifpp4RCQmurmVtd/f4
         ZogRMELR+Dkb3TjEXkbp1LM/P2ZPyHD1bZzkXJ2iIFDrsJEhKvXLX9ZFuK80+nxcairp
         P6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6cPzqY4b80WWa29eiLyrEV/lfe6Ajij7bnzw5uITzXo=;
        b=PoeGeZIfvry1W9X4/m73H4dGcuzWLwFNxIqYe1E0Rv78RmXlJI+rUnysmw4+fDlDtd
         M6mdhEoSUHCPG5I+L0ZtOydZlJFRir/1rLc/nr1Zj6vyjOe1Fq3+nPE8CAY5aMHOKmGn
         5tduYE7FayMXU5ApPPznMMcmMmye0aIUvu7bmDOZxEYaSs52i74i2KmX66KGBOrMreZu
         whJSg5dFV6RJ3RPXwLn/jQC2v1doWIrSNqM2a8KkK2BVsE5k+K/SaXa3YfHuI2Q32jks
         t4rJPZdt1MTlX5Rx5aNCt4GsL92uf8Q+fHVHRQCAQ/kI7lVl5xj6U8Fis15usL1epgZ9
         mbSQ==
X-Gm-Message-State: ANhLgQ0W2+nxG8kuTGmIF9L00tvsOOSuzus7b0F6m7lg3uhnm2QpNtPX
        Voypa6wwrG23/+z1DL6OCNF49nKlZps=
X-Google-Smtp-Source: ADFU+vvZtWBlaNE6VIsdzCAizDWWQriP3y9eoeonnGH8gSYoiCPARDW+INsKQMbIojvlvkHslIavVruIuwg=
X-Received: by 2002:a25:a108:: with SMTP id z8mr12020490ybh.418.1585206176362;
 Thu, 26 Mar 2020 00:02:56 -0700 (PDT)
Date:   Thu, 26 Mar 2020 00:02:35 -0700
In-Reply-To: <20200326070236.235835-1-walken@google.com>
Message-Id: <20200326070236.235835-8-walken@google.com>
Mime-Version: 1.0
References: <20200326070236.235835-1-walken@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH 7/8] mmap locking API: add MMAP_LOCK_INITIALIZER
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
2.25.1.696.g5e7596f4ac-goog

