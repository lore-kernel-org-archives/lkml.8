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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5308FC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31B97207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QvaAR/Z1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgETF3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 01:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbgETF31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 01:29:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0738DC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 22:29:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h129so791968ybc.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 22:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l1uoa86T5i4IFuilenMyhOPWP4qckBe++S0EocRcQls=;
        b=QvaAR/Z1wFWclp2SJqNPyqR+d0jKSmW68eXhKD/5TIJ2urgqSmzVtXTqeojvszjNna
         zD3dHpNhkNSgq9KY5pNpqM1isqORrzmgBmmBy2t0RKNIvUDiXXVjlHDAbxxwN9kxm5yT
         EwlMBAvXuBJNOZAaMmCE4rw76wCn+y1ifVSQ1UFZBx0Md6wCB1QuGxrYRaUI/HQVNCfy
         GNvT5lMosujsnrREDE8eLE3XN6tOiSyfnKLOraUVB0d1FfvbF/Sjilw4KM/gYzHJBdvb
         FtJ+xmhCwLCSuAp+1RTUXcxGc7oQ1DlV5/m0u0BuNqjtQ4L0fCxtamAwhw/IzEOVLvEd
         C5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l1uoa86T5i4IFuilenMyhOPWP4qckBe++S0EocRcQls=;
        b=n6+cwXtBetLFI2Z1LVsKL49t0OYPAlTduhGxpXKLQ05+3xeTKfaEh5podLXDvl8qhF
         IIKb1GgdPnxZSc3kUvCIL7eusWKKBiJzwZaDVRd7yzweNGfX9yj6T69gErr00jDKRa6Y
         caFKORSZXZ07yNbdN7D5W/HzvC1p6yFnsqDNnaMOhpNHnx2jW57TKqLFbtiG7IpZbVxj
         UWLcseDn8wmIwvF15WIgFQleBPonu6TrGmzEwCn2lOX8gz+R7C+qlP98fm9ueTwgAqdK
         12jcYerM9lp6JQZoRTgEzMlCtUv350+B5oA2W41Aw6XLfT/IpijuCzKhVzJXS/ZYzqGR
         hPJA==
X-Gm-Message-State: AOAM530fneplwPyHbZwkJ28BTI8XYniq/HlsXCaD9Sy/5CMt9cickMEA
        yyUIz37iUQwgfWpwv1jhLufVDbowbEA=
X-Google-Smtp-Source: ABdhPJzr214Hi5yAoUaM72rIONWP69vka+unUZbT8FrKYJ/57UOx6B462OyViG4mcaGjpR2gxdg1NB3GA1w=
X-Received: by 2002:a25:e86:: with SMTP id 128mr4998694ybo.344.1589952565280;
 Tue, 19 May 2020 22:29:25 -0700 (PDT)
Date:   Tue, 19 May 2020 22:29:02 -0700
In-Reply-To: <20200520052908.204642-1-walken@google.com>
Message-Id: <20200520052908.204642-7-walken@google.com>
Mime-Version: 1.0
References: <20200520052908.204642-1-walken@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v6 06/12] mmap locking API: convert nested write lock sites
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

Add API for nested write locks and convert the few call sites doing that.

Signed-off-by: Michel Lespinasse <walken@google.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
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
index a4db6bc952c6..e702e84897fa 100644
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
2.26.2.761.g0e0b3e54be-goog

