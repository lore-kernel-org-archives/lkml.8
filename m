Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578F3C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 308D12076C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ti+khZf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634639AbgDOApQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407891AbgDOAoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 20:44:02 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E27C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:44:01 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d16so1409955pfo.15
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=suz1EhXK6txScI3xpdwgKIxDFIXOtGI8ldkhb5885kw=;
        b=Ti+khZf/3/BEcJAj8S4NmTmXOgN2weqkT9E7KR3kMX9UTDO3u19tqZDru+Gk1D3mPg
         zdy4003AK3Ye8wdXX8Dd3KudSWfUOcnJT8S5E15M++2KJK9CF10ldO/CuushRrUes0Bl
         lR/Q8G6Ad2BZFk0QLQy/wzEJYOljcyJPeH902KX//W4T+ZQ7+6VThLRLYM7ZzTxcvTpG
         3+P+rWtjfDQuyxLIdHF4rHxZn8aZYYlASbzgK99zebEV1dEB1asgsqmsMggbW+uPmF8X
         CczglqLr11PivEr50456AteD4O/AGBgDn7uebWXnuZhOyIy474yZfaZg973Vt+9QbXe9
         z7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=suz1EhXK6txScI3xpdwgKIxDFIXOtGI8ldkhb5885kw=;
        b=M/LxOWivfEx3ycUdmZxeT0Y15nqF5daBQDxdVvOhB5+64IEVclgjrbVU2ggmtl3Rtf
         qUwXL7OsBXZ3LA+vJklGkVhiec21m9DonGqSfsEb4Th/JLlXkXMIGhu7KmXnXxCcMrO/
         kmL5u65eh+jARHUZmeVT/zvdCjJVCQ5s+ohCI4Ur5DpMfH00ogowN9MQKWQtSeWSO8Ar
         xCzGY2RyaEScIngGwxdbMbHjFXZrFRJqSsbSwtZQtUJupL9ZIllZZOdIY2wZLgr0HwjK
         xM/Fuoby7ogBSolnnUWer3lx9+6bXXIw7krUdDa3neCXMojOVn1dow/dkfUDKlNeH8Py
         I1mA==
X-Gm-Message-State: AGi0PubxUMIuyyMQuCJWa4LNRBfueYw3fAFjJFd6l/KZVmt2RyqpZTLy
        Spqb9yovLKnUCJrc74VMPCQiU0OFBIw=
X-Google-Smtp-Source: APiQypKAyv1yhvkkRbPjctxvsdVkI68qOYFwQHYRVDFvlXVI+VU7KLIhejLI3Mzwnld85g5owbOMzHVsItI=
X-Received: by 2002:a17:90a:1681:: with SMTP id o1mr3128649pja.55.1586911440827;
 Tue, 14 Apr 2020 17:44:00 -0700 (PDT)
Date:   Tue, 14 Apr 2020 17:43:45 -0700
In-Reply-To: <20200415004353.130248-1-walken@google.com>
Message-Id: <20200415004353.130248-3-walken@google.com>
Mime-Version: 1.0
References: <20200415004353.130248-1-walken@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v4 02/10] MMU notifier: use the new mmap locking API
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

This use is converted manually ahead of the next patch in the series,
as it requires including a new header which the automated conversion
would miss.

Signed-off-by: Michel Lespinasse <walken@google.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 include/linux/mmu_notifier.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 736f6918335e..2f462710a1a4 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -5,6 +5,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/mm_types.h>
+#include <linux/mmap_lock.h>
 #include <linux/srcu.h>
 #include <linux/interval_tree.h>
 
@@ -277,9 +278,9 @@ mmu_notifier_get(const struct mmu_notifier_ops *ops, struct mm_struct *mm)
 {
 	struct mmu_notifier *ret;
 
-	down_write(&mm->mmap_sem);
+	mmap_write_lock(mm);
 	ret = mmu_notifier_get_locked(ops, mm);
-	up_write(&mm->mmap_sem);
+	mmap_write_unlock(mm);
 	return ret;
 }
 void mmu_notifier_put(struct mmu_notifier *subscription);
-- 
2.26.0.110.g2183baf09c-goog

