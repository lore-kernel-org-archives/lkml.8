Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E84C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 03:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D6720786
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 03:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="aRbRS+a/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgH1DL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 23:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgH1DL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 23:11:56 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748DCC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 20:11:56 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o13so4800236pgf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 20:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZlYTv+JQLd9JVlnCrCmTKqrBb5QXVLCgV6EqO1wAudk=;
        b=aRbRS+a/K6+8m0Wq0iiI6pwgzwGwvnUxg5hZ7czz9iu/UB8RLw+EIMwUL9kelKGyr0
         NN49zGXqUexjxqASR4rLzbEUWfD0/EYKhRN85ZiWO/MSdlsHzDwlRv+dYo1Nit79axJv
         Yca7ixUGGn8kUCN2pbuB6nVrkIXYdEnt0G06pj8myHlQ20XxL86aQEhkJkP0wuoBvMvi
         3nkfUgb7/wriMgLs3S6euhibCk2HcJ22lzaHEhAA/yRQk5UVbWirAvBSzaY6E9uZzTsy
         NirIDELoXiiESDuV8GG6xLuH9wjAtFboqZeHP2GAnY4SHduuu546R8zofBkpG5+F4loo
         k7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZlYTv+JQLd9JVlnCrCmTKqrBb5QXVLCgV6EqO1wAudk=;
        b=X25Q8hCsS4pCvZOTxhf6tfI8qD90Do2xk2/Pr85MOrEz+tEmoZn2+VkYkKsO7KohQ/
         q00dk4GuyOBQ4pAh28rm53mxSeCconC9XACrFVcoO/pS/PnYfASUmXSQ3cXO81G2g88I
         kJWU2QlrTLiPuJZL7qTYEQqRLVmNhke1alih1AgoEUhHD7pO/l9HD7SGrlsJ+NnqR1JN
         EiuKjfZRxlKafRGBkrSGLLGTTvu6UWfufzKaEU0iVt1gwq+9HolhKK0xlQnSIsJxQjhK
         eh0TzeuMvAE8oKNSto5F8ey2wxVjy88If+jxlRf33vt3SeM8xFv2scL/5n1idi7mwHIB
         dCBQ==
X-Gm-Message-State: AOAM533oLdjya9mLgGJFZtxr2xPEBjEUsuOqEH+ClmZts1RsexRLf8Rv
        AqMje3MouMNpIU/7Wq3FM7DJlYN9EHlTJWaO
X-Google-Smtp-Source: ABdhPJy63F9dKcU45c7+iR+5xgW9uxkVEvKkUb5bcUsVW2QzvXtLs2YRPQTI0qZTEijAMt2rMUbzVg==
X-Received: by 2002:a62:144b:: with SMTP id 72mr18687406pfu.111.1598584315598;
        Thu, 27 Aug 2020 20:11:55 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id 78sm4453297pfv.200.2020.08.27.20.11.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 20:11:55 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     ak@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] mm/hugetlb: Fix a race between hugetlb sysctl handlers
Date:   Fri, 28 Aug 2020 11:11:46 +0800
Message-Id: <20200828031146.43035-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race between the assignment of `table->data` and write value
to the pointer of `table->data` in the __do_proc_doulongvec_minmax() on
the other thread.

CPU0:                                 CPU1:
                                      proc_sys_write
hugetlb_sysctl_handler                  proc_sys_call_handler
hugetlb_sysctl_handler_common             hugetlb_sysctl_handler
  table->data = &tmp;                       hugetlb_sysctl_handler_common
                                              table->data = &tmp;
    proc_doulongvec_minmax
      do_proc_doulongvec_minmax           sysctl_head_finish
        __do_proc_doulongvec_minmax         unuse_table
          i = table->data;
          *i = val;  // corrupt CPU1's stack

Fix this by duplicating the `table`, and only update the duplicate of
it. And introduce a helper of proc_hugetlb_doulongvec_minmax() to
simplify the code.

The following oops was seen:

    BUG: kernel NULL pointer dereference, address: 0000000000000000
    #PF: supervisor instruction fetch in kernel mode
    #PF: error_code(0x0010) - not-present page
    Code: Bad RIP value.
    ...
    Call Trace:
     ? set_max_huge_pages+0x3da/0x4f0
     ? alloc_pool_huge_page+0x150/0x150
     ? proc_doulongvec_minmax+0x46/0x60
     ? hugetlb_sysctl_handler_common+0x1c7/0x200
     ? nr_hugepages_store+0x20/0x20
     ? copy_fd_bitmaps+0x170/0x170
     ? hugetlb_sysctl_handler+0x1e/0x20
     ? proc_sys_call_handler+0x2f1/0x300
     ? unregister_sysctl_table+0xb0/0xb0
     ? __fd_install+0x78/0x100
     ? proc_sys_write+0x14/0x20
     ? __vfs_write+0x4d/0x90
     ? vfs_write+0xef/0x240
     ? ksys_write+0xc0/0x160
     ? __ia32_sys_read+0x50/0x50
     ? __close_fd+0x129/0x150
     ? __x64_sys_write+0x43/0x50
     ? do_syscall_64+0x6c/0x200
     ? entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: e5ff215941d5 ("hugetlb: multiple hstates for multiple page sizes")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
chagelogs in v2:
 1. Add more details about how the race happened to the commit message.
 2. Remove unnecessary assignment of table->maxlen.

 mm/hugetlb.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a301c2d672bf..4c2a2620eeed 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3454,6 +3454,22 @@ static unsigned int allowed_mems_nr(struct hstate *h)
 }
 
 #ifdef CONFIG_SYSCTL
+static int proc_hugetlb_doulongvec_minmax(struct ctl_table *table, int write,
+					  void *buffer, size_t *length,
+					  loff_t *ppos, unsigned long *out)
+{
+	struct ctl_table dup_table;
+
+	/*
+	 * In order to avoid races with __do_proc_doulongvec_minmax(), we
+	 * can duplicate the @table and alter the duplicate of it.
+	 */
+	dup_table = *table;
+	dup_table.data = out;
+
+	return proc_doulongvec_minmax(&dup_table, write, buffer, length, ppos);
+}
+
 static int hugetlb_sysctl_handler_common(bool obey_mempolicy,
 			 struct ctl_table *table, int write,
 			 void *buffer, size_t *length, loff_t *ppos)
@@ -3465,9 +3481,8 @@ static int hugetlb_sysctl_handler_common(bool obey_mempolicy,
 	if (!hugepages_supported())
 		return -EOPNOTSUPP;
 
-	table->data = &tmp;
-	table->maxlen = sizeof(unsigned long);
-	ret = proc_doulongvec_minmax(table, write, buffer, length, ppos);
+	ret = proc_hugetlb_doulongvec_minmax(table, write, buffer, length, ppos,
+					     &tmp);
 	if (ret)
 		goto out;
 
@@ -3510,9 +3525,8 @@ int hugetlb_overcommit_handler(struct ctl_table *table, int write,
 	if (write && hstate_is_gigantic(h))
 		return -EINVAL;
 
-	table->data = &tmp;
-	table->maxlen = sizeof(unsigned long);
-	ret = proc_doulongvec_minmax(table, write, buffer, length, ppos);
+	ret = proc_hugetlb_doulongvec_minmax(table, write, buffer, length, ppos,
+					     &tmp);
 	if (ret)
 		goto out;
 
-- 
2.11.0

