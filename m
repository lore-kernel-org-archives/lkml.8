Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB54CC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C703C20678
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ppeFKkXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634622AbgDOAoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407890AbgDOAn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 20:43:59 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4EEC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:43:58 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 190so1402152pfb.19
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l94C8AK+mUgLYQwrQ+fXnOHMPf8DqDjIiWG1XX6H7Ec=;
        b=ppeFKkXHMm35q46GgKPv9sdZ6Tqxtm1z5m3TTB4oOmL4XBF34pgNgI6POCdpKssT/N
         v8CbRWth1V61g5Htw4NIsfPEuz2B/zrwMCC0nV3MUriV9RMFMz2ctgkgeaadhIT3cL9W
         42UjpsCFHJxtX7awBdUm2MxhirlGajVmngK5A5fEkaKV8l/xjNAbUjXgY7Sw8DZsOyKJ
         nc1afK8YKYkFVJLXNntGuukspPexoy1FK2YyevBcpjZ+pTS//WjwfA5HEclvXDHM2vxu
         nSDzpc6Bzic4DDLDekRerWGm53M6OIWmxgn/tHhHztto5f+d8cxcOdKZo5rLfWY4KAQM
         zBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l94C8AK+mUgLYQwrQ+fXnOHMPf8DqDjIiWG1XX6H7Ec=;
        b=S55YQZhZjw8G4WNjxw884rqWFY9bnlOHw93HSulrXLl18SUXyD/LPSeydzDqYErD6J
         +j062rksk1CRReP/DQ3KMHv86vSNZvE66A5QVL+ELxzAf7WDJg0qwn++/y7lRj4gfIi/
         +M2ST2eCwJWTmxQrAdLyXxAFXHqE2DeOJrHf9uAKjAp0RYG1F4sqsKLzb6Ei5/b0aZUe
         tlu6Q5ppjdDBRO5tmKO8DLmrcwu6FwLnEsRjoBjDCh7NS6Q/OMuBUSPQf+9Ww5k5xRnQ
         lcKYIM250SgCf5RtV0P41YoLLmsqK4JrRPFYC4ght+hyDhUTOGmDGOztQcdxHAf7tHsc
         BvAA==
X-Gm-Message-State: AGi0PubE2mDnjI7VNBCmB1kwLlS+j5LaESu5OKXnuAb5fnfqPpjoDHzb
        37RDAM8x2u4HPZF9Swy9mBhCN5NK2Vo=
X-Google-Smtp-Source: APiQypLqLcVmwiH9GYjRHsC6Au6hrD2No9rLdY7vhYQd1JK6hU4NUeWrBiYgMQdiT4ZiLVjhe+Vuo2tOODA=
X-Received: by 2002:a17:90a:1a10:: with SMTP id 16mr3269326pjk.31.1586911438402;
 Tue, 14 Apr 2020 17:43:58 -0700 (PDT)
Date:   Tue, 14 Apr 2020 17:43:44 -0700
In-Reply-To: <20200415004353.130248-1-walken@google.com>
Message-Id: <20200415004353.130248-2-walken@google.com>
Mime-Version: 1.0
References: <20200415004353.130248-1-walken@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v4 01/10] mmap locking API: initial implementation as rwsem wrappers
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

This change wraps the existing mmap_sem related rwsem calls into a new
mmap locking API. There are two justifications for the new API:

- At first, it provides an easy hooking point to instrument mmap_sem
  locking latencies independently of any other rwsems.

- In the future, it may be a starting point for replacing the rwsem
  implementation with a different one, such as range locks.

Signed-off-by: Michel Lespinasse <walken@google.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 include/linux/mm.h        |  1 +
 include/linux/mmap_lock.h | 54 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 include/linux/mmap_lock.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5a323422d783..051ec782bdbb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -15,6 +15,7 @@
 #include <linux/atomic.h>
 #include <linux/debug_locks.h>
 #include <linux/mm_types.h>
+#include <linux/mmap_lock.h>
 #include <linux/range.h>
 #include <linux/pfn.h>
 #include <linux/percpu-refcount.h>
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
new file mode 100644
index 000000000000..8b5a3cd56118
--- /dev/null
+++ b/include/linux/mmap_lock.h
@@ -0,0 +1,54 @@
+#ifndef _LINUX_MMAP_LOCK_H
+#define _LINUX_MMAP_LOCK_H
+
+static inline void mmap_init_lock(struct mm_struct *mm)
+{
+	init_rwsem(&mm->mmap_sem);
+}
+
+static inline void mmap_write_lock(struct mm_struct *mm)
+{
+	down_write(&mm->mmap_sem);
+}
+
+static inline int mmap_write_lock_killable(struct mm_struct *mm)
+{
+	return down_write_killable(&mm->mmap_sem);
+}
+
+static inline bool mmap_write_trylock(struct mm_struct *mm)
+{
+	return down_write_trylock(&mm->mmap_sem) != 0;
+}
+
+static inline void mmap_write_unlock(struct mm_struct *mm)
+{
+	up_write(&mm->mmap_sem);
+}
+
+static inline void mmap_downgrade_write_lock(struct mm_struct *mm)
+{
+	downgrade_write(&mm->mmap_sem);
+}
+
+static inline void mmap_read_lock(struct mm_struct *mm)
+{
+	down_read(&mm->mmap_sem);
+}
+
+static inline int mmap_read_lock_killable(struct mm_struct *mm)
+{
+	return down_read_killable(&mm->mmap_sem);
+}
+
+static inline bool mmap_read_trylock(struct mm_struct *mm)
+{
+	return down_read_trylock(&mm->mmap_sem) != 0;
+}
+
+static inline void mmap_read_unlock(struct mm_struct *mm)
+{
+	up_read(&mm->mmap_sem);
+}
+
+#endif /* _LINUX_MMAP_LOCK_H */
-- 
2.26.0.110.g2183baf09c-goog

