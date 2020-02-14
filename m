Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AFCC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19FF20848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1jpe9t3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgBNW7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:59:12 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:56361 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgBNW7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:59:12 -0500
Received: by mail-pl1-f201.google.com with SMTP id 91so5999636plf.23
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 14:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=159AKCujg+gW8fqSsGG8pDd0kcHsLFha/U7wQ4KOefk=;
        b=V1jpe9t30LEtuFBkzCUikejPz9SfFkrsw2gy0kqScijtgPMOXDn33Y6Y22NHzuKX57
         HQnn5udcQ+qlzZ1EIWvpuK3MTgrepegBJ5Wx8X0H+wE0p3WKF0ENmV7mLsmknDnReWxH
         B4cPmmUkSAcJgrcq+pH2Glgh0Yt+DvmnrdZYlyEA6oE7u6mhF8OCE5o75mfe/cokvob5
         2CEKhY4j4gFtDaAO+70TJuxVko90bzS8hmZYwDtL60CPCykRj10ZEEXx9wl19ekFBD/N
         DJ7b0WnKMSc1UMrhmrMN+MJSv02T7gkpCm1IvdzORao60lp3Vg8F0uozjsukknUTRG4W
         gS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=159AKCujg+gW8fqSsGG8pDd0kcHsLFha/U7wQ4KOefk=;
        b=SqwocZfd0CXgwBdbfF25AhxSSVq1z+TLYzyOB1x51XwlCOg6H7n/coXIKt9t0kkABA
         oeJXj5LarLfT8qpnslUO28RmfI47d5KNXtFcvT82goqRwoTnIbDMukJ3kSt4PZFWx8Sj
         KM5oWJJIy8PtWwUVaxTeAF9Eti5JpeyIsGJcP5VuF3aONueufxHNtdpy/uj3Mn/mFSTX
         SpRt9UXSnEBpDi+3gHYhx3U6KAbaNl1YFofSI4t9bhnE3hINQvasLToDiTIUXey78/mU
         AEuXjBJJaoHlzZfbWyyS9+hO+x8yZYWvG16xETI1Eth2SU/3iUdF1NtLsTq54Yanncq3
         cqpg==
X-Gm-Message-State: APjAAAXtWAkPKCLeyJ2UqtZZhZPAt7jjHjS5BgGhYbHEach/h2TOdO5R
        l5KP7rsDZQBCJLrXjBRY1ZTeeH7hrzw7
X-Google-Smtp-Source: APXvYqzwCvOZWCeRS1PqBNuUe+OPc2VKkaWEfaI//TYEzoih7GC0pWCFmsyzy+76Weu1vHGsOCQkFWgRklMx
X-Received: by 2002:a63:4281:: with SMTP id p123mr5723142pga.371.1581721151869;
 Fri, 14 Feb 2020 14:59:11 -0800 (PST)
Date:   Fri, 14 Feb 2020 14:58:49 -0800
Message-Id: <20200214225849.108108-1-bgeffon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [RFC PATCH] userfaultfd: Address race after fault.
From:   Brian Geffon <bgeffon@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Sonny Rao <sonnyrao@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The faulting path is:
  do_user_addr_fault (flags = FAULT_FLAG_ALLOW_RETRY)
  handle_mm_fault
  __handle_mm_fault
  do_anonymous
  handle_userfault (ret = VM_FAULT_RETRY)

At this point the fault is handled and when this call sequence unwinds
it is expected that the PTEs are present as handle_userfault took care
of that and returned VM_FAULT_RETRY. When we unwind back down to
do_user_addr_fault it will attempt to retry after clearing
FAULT_FLAG_ALLOW_RETRY and setting FAULT_FLAG_TRIED.

At any point between the fault being handle and when it's retried a
userspace thread was to zap the page range, let's say via
madvise(MADV_DONTNEED). Now as this fault is being retried the PTEs would
be missing again and we land right back in handle_userfault. Although this
time since FAULT_FLAG_ALLOW_RETRY has been cleared we're going to bail and
return VM_FAULT_SIGBUS.

This scenario is easy to reproduce and I observed it while writing tests for
MREMAP_DONTUNMAP in the userfaultfd selftests. I have a standalone example of
this that uses madvise(MADV_DONTNEED) to cause this race:
   https://gist.github.com/bgaff/3a8b2a890ae4771be22456e014c2e5aa

Given that this is genuinely a new fault, is a SIGBUS the best way to go about
this? Since userfaultfd is designed to be used in a non-cooperative case, could
it be more resilient and instead retry for the new fault?

With that being said for VM_UFFD_MISSING userfaults can we just remove the
check in handle_userfault that FAULT_FLAG_ALLOW_RETRY is set in vmf->flags
and allow it to retry the fault to address this race scenario?

In my testing that does solve the problem, but does it possibly create others?
Is this the best way to go about it? I'll defer to the domain experts for any
recommendations here in case I'm way off.

Thanks for your time.

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 fs/userfaultfd.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index ebf17d7e1093..6407fec798ff 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -416,34 +416,6 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 		goto out;
 	}
 
-	/*
-	 * Check that we can return VM_FAULT_RETRY.
-	 *
-	 * NOTE: it should become possible to return VM_FAULT_RETRY
-	 * even if FAULT_FLAG_TRIED is set without leading to gup()
-	 * -EBUSY failures, if the userfaultfd is to be extended for
-	 * VM_UFFD_WP tracking and we intend to arm the userfault
-	 * without first stopping userland access to the memory. For
-	 * VM_UFFD_MISSING userfaults this is enough for now.
-	 */
-	if (unlikely(!(vmf->flags & FAULT_FLAG_ALLOW_RETRY))) {
-		/*
-		 * Validate the invariant that nowait must allow retry
-		 * to be sure not to return SIGBUS erroneously on
-		 * nowait invocations.
-		 */
-		BUG_ON(vmf->flags & FAULT_FLAG_RETRY_NOWAIT);
-#ifdef CONFIG_DEBUG_VM
-		if (printk_ratelimit()) {
-			printk(KERN_WARNING
-			       "FAULT_FLAG_ALLOW_RETRY missing %x\n",
-			       vmf->flags);
-			dump_stack();
-		}
-#endif
-		goto out;
-	}
-
 	/*
 	 * Handle nowait, not much to do other than tell it to retry
 	 * and wait.
-- 
2.25.0.265.gbab2e86ba0-goog

