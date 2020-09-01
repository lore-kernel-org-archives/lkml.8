Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D56C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0EC4206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZZxynk0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgIAJTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 05:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgIAJTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 05:19:38 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEA6C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 02:19:38 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f18so440628pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 02:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U1h0WFxrmlZti/5PdriJmCxO8e4BuJ9nFjihIY3qycs=;
        b=ZZxynk0QlZfIRPJ4QGFzdKtFDLdfBU4R03PfY90TJ1NvYSWDbI0J9xD1LWHS8sJrEO
         Z550Jx5HfEQ3+mYsR3tdgjx8JVldlKUh+xa1Zg8d9Y5nEWWBXg/9FVMbCOTxmDUnHXOX
         xgnmx/rEhFv2BDg7w6UcV1niuf49OQV4lZ4m1syZHamEPTa7VryLxjRel9O+T9y5nAiW
         yDcJ0Yw+5H9QCVwGKCB/puFq4Og4mu4AVJlAQbOm1rwhOW/abH2hARkKzZVw/zWA21Gm
         xkCSsB18jzELz/vi7ZS/hUH6O7zwPtpAWJcGTENAJl05+M+UiM7mvi8bv4vtAZlhTnQz
         Jegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U1h0WFxrmlZti/5PdriJmCxO8e4BuJ9nFjihIY3qycs=;
        b=eh7SIpEtZAwuRi/eYuD/YnZP47WljuvQSbOCHLdIjlk8g2r/fyDy6qz8O0jKT2jkd+
         d6pQ9RNg74oovHJ3cm3J5+Sjr3c33FxYhx+ekywbs5WfbFamnlT0p7AbpHhdpv1AaYtL
         poCYrlY7RMVNyNDg9PZHQGl/lMvs/6WhIYLpagGRj0M05D9/6FDPkwWnpatMpR37KAx4
         WshIf4WZKem/xdX3YVysPVOwdM+dlISn7m60VwPpoyFfa6DollLhuVKB32mI9LMClM5q
         zzGLfejQTAmi9AJKcrFe6JeL1ZrD16tu6b6nIgc0M6A1rrOjekjQrrtOi6LixX2wn0gb
         NlYw==
X-Gm-Message-State: AOAM531l5g4q4AiDfQCczYoNN4PS8p5iRRr73BnbrXjSfm5OFqCSCvQ3
        Og+WkVfGT8Bdpxx82P/OLsIjZQ==
X-Google-Smtp-Source: ABdhPJzVLT26wXuJg9u2T4boVuRqfvUnGNG0RnLFl6IKknv4osKlaL5cs8MXwfoVPfY2s2rSIUQIPA==
X-Received: by 2002:a63:3fc4:: with SMTP id m187mr737501pga.322.1598951978300;
        Tue, 01 Sep 2020 02:19:38 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id u191sm1337707pgu.56.2020.09.01.02.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 02:19:37 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>,
        Colin Cross <ccross@google.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Michel Lespinasse <walken@google.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Song Liu <songliubraving@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        chenqiwu <chenqiwu@xiaomi.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Christie <mchristi@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Adrian Reber <areber@redhat.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Cedeno <thomascedeno@google.com>,
        linux-fsdevel@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v6 2/3] mm: memory: Add access_remote_vm_locked variant
Date:   Tue,  1 Sep 2020 14:49:00 +0530
Message-Id: <20200901091901.19779-3-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901091901.19779-1-sumit.semwal@linaro.org>
References: <20200901091901.19779-1-sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows accessing a remote vm while the mmap_lock is already
held by the caller.

While adding support for anonymous vma naming, show_map_vma()
needs to access the remote vm to get the name of the anonymous vma.
Since show_map_vma() already holds the mmap_lock, so this _locked
variant was required.

Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 49 ++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ca6e6a81576b..e9212c0bb5ac 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1708,6 +1708,8 @@ extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
 		void *buf, int len, unsigned int gup_flags);
 extern int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned long addr, void *buf, int len, unsigned int gup_flags);
+extern int access_remote_vm_locked(struct mm_struct *mm, unsigned long addr,
+				   void *buf, int len, unsigned int gup_flags);
 
 long get_user_pages_remote(struct mm_struct *mm,
 			    unsigned long start, unsigned long nr_pages,
diff --git a/mm/memory.c b/mm/memory.c
index 602f4283122f..207be99390e9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4726,17 +4726,17 @@ EXPORT_SYMBOL_GPL(generic_access_phys);
 /*
  * Access another process' address space as given in mm.  If non-NULL, use the
  * given task for page fault accounting.
+ * This variant assumes that the mmap_lock is already held by the caller, so
+ * doesn't take the mmap_lock.
  */
-int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
-		unsigned long addr, void *buf, int len, unsigned int gup_flags)
+int __access_remote_vm_locked(struct task_struct *tsk, struct mm_struct *mm,
+			      unsigned long addr, void *buf, int len,
+			      unsigned int gup_flags)
 {
 	struct vm_area_struct *vma;
 	void *old_buf = buf;
 	int write = gup_flags & FOLL_WRITE;
 
-	if (mmap_read_lock_killable(mm))
-		return 0;
-
 	/* ignore errors, just check how much was successfully transferred */
 	while (len) {
 		int bytes, ret, offset;
@@ -4785,9 +4785,46 @@ int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
 		buf += bytes;
 		addr += bytes;
 	}
+	return buf - old_buf;
+}
+
+/*
+ * Access another process' address space as given in mm.  If non-NULL, use the
+ * given task for page fault accounting.
+ */
+int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
+		       unsigned long addr, void *buf, int len, unsigned int gup_flags)
+{
+	int ret;
+
+	if (mmap_read_lock_killable(mm))
+		return 0;
+
+	ret = __access_remote_vm_locked(tsk, mm, addr, buf, len, gup_flags);
 	mmap_read_unlock(mm);
 
-	return buf - old_buf;
+	return ret;
+}
+
+/**
+ * access_remote_vm_locked - access another process' address space, without
+ * taking the mmap_lock. This allows nested calls from callers that already have
+ * taken the lock.
+ *
+ * @mm:		the mm_struct of the target address space
+ * @addr:	start address to access
+ * @buf:	source or destination buffer
+ * @len:	number of bytes to transfer
+ * @gup_flags:	flags modifying lookup behaviour
+ *
+ * The caller must hold a reference on @mm, as well as hold the mmap_lock
+ *
+ * Return: number of bytes copied from source to destination.
+ */
+int access_remote_vm_locked(struct mm_struct *mm, unsigned long addr, void *buf,
+			    int len, unsigned int gup_flags)
+{
+	return __access_remote_vm_locked(NULL, mm, addr, buf, len, gup_flags);
 }
 
 /**
-- 
2.28.0

