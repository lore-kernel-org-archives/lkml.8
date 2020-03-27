Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF65C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E73520787
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ctQS9IVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgC0CLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:11:06 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:36543 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgC0CLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:11:06 -0400
Received: by mail-pg1-f202.google.com with SMTP id b130so6665174pga.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 19:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=k3mg/Xv1vow8pC5LkbfxQBusgzgffIOWBI4VPXD50U0=;
        b=ctQS9IVGYiGEW7rl+HmsBcEN7a8KNQhybe0fatUUL80bnaVg07X0r4Z76JZLH6V0Mo
         XpfvBX77aacV8cFXAYg4+Enm8dakUMTe6Jv/0It0M5CK6Md1vNkyHlw0PYEOEhWdxQfz
         L8HIXNoIstB3xK67EM/3psplE6E57IGlmG8eGLyJ4HmPHXi978x5J1W/b+DOuhyajt3I
         FVyCRvmzmXKduPC4z/1rKsUD1MRGkDiPDkXBsjsNCOsGSQtBpZ+Piv47z+PRwUzDv4Go
         +wAIo9kqMzgIoh50ZgkmbqZSye8yDI8U/MrFVTzz+Ovs4miWa7OAzcBRRT1yYqsAdPXn
         ue+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=k3mg/Xv1vow8pC5LkbfxQBusgzgffIOWBI4VPXD50U0=;
        b=qLJHLwKVZWNMG+iIrMKTzgGplj9Ks3eaWfMdC9n/33ZXJb1+XjkypO2u1q9You7yVg
         IELLHQ4M39pywpaSXnmti+v/kT9uZUHEFKpxSQbTAjkL45USIlX0DLMevF9apdNVC0d7
         pYsaSByzExKf/FErvN5x4dUKw4HrPoCx7jSvyH+uruMxPClCY9ayCnh/GaDRV7TxxPcf
         e1wtKCcRL3ahLpSOJvxv/R/6ou7/tSiNzIMOaiE5JMIFpWl20z6mI3+x+gEwnebVBfcx
         99XjyDDpq+b4iybdei3jFkg55XlczVUCHHszzOC4QAoiGX3ej9xOQYrBzRznKG7veoHH
         oCBQ==
X-Gm-Message-State: ANhLgQ1izt91XM2GhTqV5wJo0p4trHZkib5JdaJnJ/K9/2JUgo16MHpB
        DED6s3q3W7R9TxR5E8+DmJtbEBqb2tI=
X-Google-Smtp-Source: ADFU+vsFGah9Sh4ZVgJlSbmDCL6eph1s6ibCkBkTza6XI3kWyCX6f4qL10bauS5CGXkC8UgYhDMAiiQFlwI=
X-Received: by 2002:a65:4d09:: with SMTP id i9mr10912905pgt.403.1585275063502;
 Thu, 26 Mar 2020 19:11:03 -0700 (PDT)
Date:   Thu, 26 Mar 2020 19:10:49 -0700
In-Reply-To: <20200327021058.221911-1-walken@google.com>
Message-Id: <20200327021058.221911-2-walken@google.com>
Mime-Version: 1.0
References: <20200327021058.221911-1-walken@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v2 01/10] mmap locking API: initial implementation as rwsem wrappers
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
2.26.0.rc2.310.g2932bb562d-goog

