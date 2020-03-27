Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1830C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B362071B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UtfMSsLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgC0WvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:51:10 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:54005 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgC0WvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 18:51:09 -0400
Received: by mail-pg1-f201.google.com with SMTP id c33so9119193pgl.20
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 15:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iJr2O2VSdEom9sprdjesxwFTcbpm7uxFQvrhb+UJ72I=;
        b=UtfMSsLbIJWTCdC6gcQujtnuCwJdlNL2TdP7GN/lyZyF/ng1Gj6++wz8IRuYYirWkU
         lXA0f+DpZpArOueuC0JI/EA50iBr2CbSeWDJCS3EepWgTP3Af1wZS8GDpAlXW/yEYoDo
         dbhB1R9/8P0Yf7j4MB45xYK1rkOhn6pb8ntXveSr0m5KR4i8Ruq/r2nh+mJvR5MFU5Bs
         q0Mj03dQtH2Jx8V4Ufqd4hDUDFaFP8pPXukhn4kJVHi8OZVJPRWq41fRNycs1RZghZdY
         1PGQwN/PEjZHA1oKUK1upzMDUY67HPf9gwMRApzvDMbf8qm9kwqtGw4YPxH6k1B90IAw
         m9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iJr2O2VSdEom9sprdjesxwFTcbpm7uxFQvrhb+UJ72I=;
        b=UhsoTaUVWiCMsogqWHNVf676FVkOUBQWXViXaPk93RRuohwPGCP4MR9bmk5b58hcr1
         1lj8rLsOUTYvPm/QnOSMoJvSVGCXL6ctPoEqj72byo+SO5UUWD2PJJpx2thrkJnz69EL
         /zfUaOcya3xTLB1e72XGcJDjm4sO/JU3ucf/tKiePeaLFflNQfb17Rps5DooA0VJ8FN0
         SbTtXORFyzvaSVPBpZMqYjtcoqck2Iv1Lb/3Y7C78Aakp/90p2tZgy/eIRgjk+joB/4Q
         bMqGux7Fu2UyUviOR/F8gVhtpliyd4CWdsPu9qvUaZRsy4uYM0nQCglmRQAFS8FrIy31
         rgXQ==
X-Gm-Message-State: ANhLgQ1PF9hc14O7KcxN5wbPoGda13K7PtZIDa4uBacSY3ewftq3vFXI
        7B8XxUqtZWUJagT3ki5nA2ePe3PT3QM=
X-Google-Smtp-Source: ADFU+vtfGqYCjoJCoa5/Pqp1L/DbletTVslglgFg5AREr+0yvewn2NwfxuOB0Nr5QmzyV0NLyUpGbguTqE4=
X-Received: by 2002:a63:4e22:: with SMTP id c34mr1636202pgb.263.1585349466748;
 Fri, 27 Mar 2020 15:51:06 -0700 (PDT)
Date:   Fri, 27 Mar 2020 15:50:53 -0700
In-Reply-To: <20200327225102.25061-1-walken@google.com>
Message-Id: <20200327225102.25061-2-walken@google.com>
Mime-Version: 1.0
References: <20200327225102.25061-1-walken@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v3 01/10] mmap locking API: initial implementation as rwsem wrappers
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

This change wraps the existing mmap_sem related rwsem calls into a new
mmap locking API. There are two justifications for the new API:

- At first, it provides an easy hooking point to instrument mmap_sem
  locking latencies independently of any other rwsems.

- In the future, it may be a starting point for replacing the rwsem
  implementation with a different one, such as range locks.

Signed-off-by: Michel Lespinasse <walken@google.com>
---
 include/linux/mm.h        |  1 +
 include/linux/mmap_lock.h | 54 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 include/linux/mmap_lock.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c54fb96cb1e6..2f13c9198999 100644
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
2.26.0.rc2.310.g2932bb562d-goog

