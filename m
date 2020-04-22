Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E499AC5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B890120706
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fmE/ZsCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgDVAO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgDVAO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 20:14:29 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8F9C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:14:27 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id e18so530559pfl.17
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nj5jjGLg8IOvfnegjPnvO+hyr9F+Q3RFMzb65ktIqNg=;
        b=fmE/ZsCi12txej32MKxq5Q/M7SA+tr6q8bMHrxgAjcjNoXH82uOrxQ9hl0ksM/ez4f
         NPLpdNrNChzGenZ8mx71A3vcq8jSr23SjXXSs5JSrE1GiF3Gsd6gEiJ2zvEY29rNj2ac
         xIllsk8xqc1Z6k8VjXIaMEhazT8cisE6MUOlrpJfwmVX+L6xMjPj9HolikYBgotuYvcW
         r0Xde8JijOIxT99M4Wus0Ohme4Xh2bv5zz0NuyF5tAK8i+s1Pn1Dh7mc5uPWIz7CSOik
         LwX9Fi9+pGvkXqovzI6v/aNLkyYs+BMwHT6PMjF03zESDlDCfQEAZ1wd/Mm8hiPnuzBI
         q6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nj5jjGLg8IOvfnegjPnvO+hyr9F+Q3RFMzb65ktIqNg=;
        b=qD/0UEZJqe1JdslfzKMOU6n9rbk1yKi1nSINdA6z6IHm83U0elwV76VOVE6KBFE98O
         WwA5CRigIEZRcghzyNeliFxxr2iDbtMnHogBQT+d+BFiuGncx2SQZSLJGWVKHtvRZWKF
         fzWxuAUxcdYBz9TY6vEbbwlfgspXf7xXPG3pCOGIJkexqIU+oFXlW5pf/g7KHCDEuVrM
         PJYTjSlmdFZ22/ggr3IdDY68C5lrLCOyfsmQu2k7gapC/yjNXQ6lF11Ff8gI293WX4wl
         KWBM6ZBi1nfNBFO+cSfrRRHrfOTEZ8XCyLxrQIvFlcZLYjz4j/ipDBVFFBsp2qmusDE0
         TIhQ==
X-Gm-Message-State: AGi0PuZFbbtzWQU5yq+fKY6MJYhBMWpRDY5VviXooc7E5nUBuWh5E9AE
        wJFTC2KO39w10gktf54+7/T2tQahmlw=
X-Google-Smtp-Source: APiQypKlcSekBVajTIOBnih7IYmBCRTnYXbk0AAJ5N3mmuCItzToA2KSG7ErlRz3OGA48q1hRqMoFhPcOY0=
X-Received: by 2002:a17:90a:276a:: with SMTP id o97mr8625466pje.194.1587514467186;
 Tue, 21 Apr 2020 17:14:27 -0700 (PDT)
Date:   Tue, 21 Apr 2020 17:14:13 -0700
In-Reply-To: <20200422001422.232330-1-walken@google.com>
Message-Id: <20200422001422.232330-2-walken@google.com>
Mime-Version: 1.0
References: <20200422001422.232330-1-walken@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v5 01/10] mmap locking API: initial implementation as rwsem wrappers
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
        Michel Lespinasse <walken@google.com>,
        Davidlohr Bueso <dbueso@suse.de>
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
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
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
index 000000000000..97ac53b66052
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
+static inline void mmap_write_downgrade(struct mm_struct *mm)
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
2.26.1.301.g55bc3eb7cb9-goog

