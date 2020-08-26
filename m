Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27ED4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 01:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 007232072D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 01:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Gp9NVG0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgHZBkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 21:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgHZBkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 21:40:12 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446DBC061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 18:40:10 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id g7so320382pja.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 18:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=QrfOzc6XPAwCgYDeycXOM2EpifoygU2U9TLCo43uwFY=;
        b=Gp9NVG0ZESXHmSZItMfVjNi/mKQmY5fuiZVCI7LgbDD0Pfi5ybSYImPwOJa25MEa0X
         ua6+a0hlj8fL33Ya6kESSfJaHhGxhu/4UzOsuKnHGDnPc0MvLqlfI0SMX5ojLWt7USFD
         EXz/vaGOAUXmVjNXZN3g8s1dfXUf6J3kKrRhURksX/sFRerGdp71sW+i0VzxsBf9T3sQ
         e1iV4RNOUXMnH+EWLrUSNuXtF+OVWHtPdBgqAHCoP4u3JT/21DOFHpVimdFLws/rA1m5
         9+8F+8hdgjZzjRo4l3zAZpR6XbQWv5lixZubr53cBM9RaGqpjmL5m5Qmt10/Z87pyxQd
         RX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QrfOzc6XPAwCgYDeycXOM2EpifoygU2U9TLCo43uwFY=;
        b=KQTts6nYgTUUILDql2OfxMOEkyVO6uLYY2HBqsKzDL3CHGH3ma4GwAskxkkZ64JNJM
         OKTlzWkLuAB57q59XptnYlLesvWdLdUSBboa6CgLqRlTnqjxHfw1g1ouAGKH3Jc9tS2v
         qCJyAhw/8/09cF7KenaYstvQhU62YT3ZP6SNy8QkDLJWujEp61LTendnQVwy2wTKhnJu
         JXKMn6+qTuPl24RyOSHgEFALX+Kr75hlmqqf2TXa1Gb3Lezvvg6XsPcGHFuYuoA3zDv0
         fFTHjXAhmOg3VLi5n6rjj49I7LMt70rbs1gRo4008lq4FvNpZcaOc4eo2+OrFnyP6P1F
         znbQ==
X-Gm-Message-State: AOAM530ZluKfMK5hcNvh/91F+3VpUkEbLi1BEvA7mUA5LMSr/+HCg78I
        0lEC3J9asml5o401U8XOXYD1F/YvzxW6d8JiVQ==
X-Google-Smtp-Source: ABdhPJyuRHyDek0VQzUH9/QGNGLtchxKND8ZsBU0EPK7mBXtEMW1Vk/5gFl9Wx92oYp93X1Yy9DmZ2wtuCvjjxP7RQ==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a17:90b:1b47:: with SMTP id
 nv7mr3677042pjb.128.1598406009623; Tue, 25 Aug 2020 18:40:09 -0700 (PDT)
Date:   Tue, 25 Aug 2020 18:39:58 -0700
In-Reply-To: <20200826013959.1981270-1-lokeshgidra@google.com>
Message-Id: <20200826013959.1981270-2-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20200826013959.1981270-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v3 1/2] Add UFFD_USER_MODE_ONLY
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kaleshsingh@google.com,
        calin@google.com, surenb@google.com, nnk@google.com,
        jeffv@google.com, kernel-team@android.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Jerome Glisse <jglisse@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nitin Gupta <nigupta@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

userfaultfd handles page faults from both user and kernel code.
Add a new UFFD_USER_MODE_ONLY flag for userfaultfd(2) that makes
the resulting userfaultfd object refuse to handle faults from kernel
mode, treating these faults as if SIGBUS were always raised, causing
the kernel code to fail with EFAULT.

A future patch adds a knob allowing administrators to give some
processes the ability to create userfaultfd file objects only if they
pass UFFD_USER_MODE_ONLY, reducing the likelihood that these processes
will exploit userfaultfd's ability to delay kernel page faults to open
timing windows for future exploits.

Signed-off-by: Daniel Colascione <dancol@google.com>
Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 fs/userfaultfd.c                 | 6 +++++-
 include/uapi/linux/userfaultfd.h | 9 +++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0e4a3837da52..3191434057f3 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -405,6 +405,9 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 
 	if (ctx->features & UFFD_FEATURE_SIGBUS)
 		goto out;
+	if ((vmf->flags & FAULT_FLAG_USER) == 0 &&
+	    ctx->flags & UFFD_USER_MODE_ONLY)
+		goto out;
 
 	/*
 	 * If it's already released don't get it. This avoids to loop
@@ -1975,10 +1978,11 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	BUG_ON(!current->mm);
 
 	/* Check the UFFD_* constants for consistency.  */
+	BUILD_BUG_ON(UFFD_USER_MODE_ONLY & UFFD_SHARED_FCNTL_FLAGS);
 	BUILD_BUG_ON(UFFD_CLOEXEC != O_CLOEXEC);
 	BUILD_BUG_ON(UFFD_NONBLOCK != O_NONBLOCK);
 
-	if (flags & ~UFFD_SHARED_FCNTL_FLAGS)
+	if (flags & ~(UFFD_SHARED_FCNTL_FLAGS | UFFD_USER_MODE_ONLY))
 		return -EINVAL;
 
 	ctx = kmem_cache_alloc(userfaultfd_ctx_cachep, GFP_KERNEL);
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index e7e98bde221f..5f2d88212f7c 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -257,4 +257,13 @@ struct uffdio_writeprotect {
 	__u64 mode;
 };
 
+/*
+ * Flags for the userfaultfd(2) system call itself.
+ */
+
+/*
+ * Create a userfaultfd that can handle page faults only in user mode.
+ */
+#define UFFD_USER_MODE_ONLY 1
+
 #endif /* _LINUX_USERFAULTFD_H */
-- 
2.28.0.297.g1956fa8f8d-goog

