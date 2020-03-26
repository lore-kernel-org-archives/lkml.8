Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1973C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DFD20719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+rb2gtq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgCZHCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:02:44 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:42272 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgCZHCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 03:02:44 -0400
Received: by mail-pf1-f202.google.com with SMTP id j2so4422345pfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 00:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xxvyxjj91melXa2f3O0p5YGO5yfdIf2InM2lDPE9tIk=;
        b=S+rb2gtqH3Mle1QzHX8tBmJKYQt8IOQhCKT8GNmojRB6bUWcTc2zCtEYWPPOXh3raR
         KfZuAnS5qLywjBjfFSZFvlD52vx1ktBHNB1BFhpeqkugFuvfrI16BTHF0FtoUHxZ0dVp
         TQE6+Lykq+FwLKbyOHFBMTwlVg6LYtJquwrx3qIGfrIBCU8YK9i/h0LiHp2l6wRGigxz
         u4N/9klDmr3UAS3arA9uDAqhoxX+eqe6xy6jeIKwbl5GBEmcAVfJ2hWexeJYL1YyJfsv
         wCmSV830WdwO6IkvYg1rF0EXNVgfBv1p4nzSZZoY7E9hn1SdoY4nSiy8A2oQc4AgD8dE
         gCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xxvyxjj91melXa2f3O0p5YGO5yfdIf2InM2lDPE9tIk=;
        b=FsbAhHtvcLSM7Dc0+zIy0ypU9y3kb26OM+5seHca3Q+BVRrkIxtdreBpqNNRjOYbJA
         gQoaz4X6w0CSj4eaFfHS4NWb6q+l+xzo9/HbnXODWMz2n+DwMZTIE4tMF2Sn35LjPooY
         KxWmtp1QHMNQnkbFrvbBgqWj+mQlf0em6gvp6lNQIqGU45n03IfnTHCdO8vBt2AcSeze
         XzdPSUVm59rNniJjxe5Jgl/nCjk8ZWNJCcZ+KDJ20gReavZh///5/I20CLaWZ6ts7rW6
         oOvIH2+ixxFm/G7s666MBju7J7/NUbK+dPomQ9ey9wk+w6NU1QNmvTJbfE2ZrprHmHWw
         EE2A==
X-Gm-Message-State: ANhLgQ11+SxT79UU1jl0e4Ic5JdhnUMP08KnF00N66HdfTd18rlVSwPy
        D0sy/Hcc0wfu1ED8bPc5+TzKtzzmsP8=
X-Google-Smtp-Source: ADFU+vtNeNSXu+zk+G9qTMevsl/EO/OZ7hP+2bvX9a40agCXFI6f7Ltq/McjSMLAed50Ejoy3tAOmtow6I0=
X-Received: by 2002:a17:90a:5d16:: with SMTP id s22mr1610999pji.118.1585206161146;
 Thu, 26 Mar 2020 00:02:41 -0700 (PDT)
Date:   Thu, 26 Mar 2020 00:02:29 -0700
In-Reply-To: <20200326070236.235835-1-walken@google.com>
Message-Id: <20200326070236.235835-2-walken@google.com>
Mime-Version: 1.0
References: <20200326070236.235835-1-walken@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH 1/8] mmap locking API: initial implementation as rwsem wrappers
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

This change wraps the existing mmap_sem related rwsem calls into a new
mmap locking API. There are two justifications for the new API:

- At first, it provides an easy hooking point to instrument mmap_sem
  locking latencies independently of any other rwsems.

- In the future, it may be a starting point for replacing the rwsem
  implementation with a different one, such as range locks.

Signed-off-by: Michel Lespinasse <walken@google.com>
---
 include/linux/mm.h        |  1 +
 include/linux/mmap_lock.h | 59 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)
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
index 000000000000..cffd25afe92b
--- /dev/null
+++ b/include/linux/mmap_lock.h
@@ -0,0 +1,59 @@
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
+static inline bool mmap_is_locked(struct mm_struct *mm)
+{
+	return rwsem_is_locked(&mm->mmap_sem) != 0;
+}
+
+#endif /* _LINUX_MMAP_LOCK_H */
-- 
2.25.1.696.g5e7596f4ac-goog

