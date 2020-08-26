Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E77C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35DF92075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="PZRtl3oE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgHZPQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgHZPQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:16:01 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEC1C061798
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:15:54 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id p15so1807820qvv.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=7aZgefibZrTCs6XQP3SSXIsvAQ9RHGTwgc0UHLaNuJc=;
        b=PZRtl3oEvcUqv3W5Kf6A433P7e2W3tl/mCCy3xK3DV/7P/aXv0u06wYmjDvvZEQWOT
         ec/yeyDjZzlkcqBgnSCJVm01y8rwgXg0XhozXR3K/Qt+NSPOvhHC8OdoYrSdOhv7TZjP
         mXNFSgjT8pyGVkBj5APT7WYyRtNTxMfIeHp+vXwRYaP0z6eee2VPXSr30DB6lbnor3YM
         18ZIzWMCS3dqI9hPlOsgn5kk4s2gN+rMvTtl9/3sT+zhcVisuexKfn5RTr/4IVWvn76D
         eiwl+5wyVMCTrHqG84CNQSdNJYTgnxdCwBdzLqSxPpQEE31nmdOkhMePpT4krSphqKqP
         xYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7aZgefibZrTCs6XQP3SSXIsvAQ9RHGTwgc0UHLaNuJc=;
        b=LvVzLRdmpD1uhjbIJVnY7+rKGsfo1uZ6Xerd/WMEjUjLq8dMbFzIRHuh30t5saVh07
         2UgokLPoaqifU7tighnWGPFQPaKfQayZdQn2PeHg4zO2vm4r6KBazawVE8iQsKZqBVUr
         5JRXbK7/RgI1FR/E2t8VlPb2lTTIl+KwbUmcO4OdWoQGe7JKZvcZ3UekVcs0FiHYMQxH
         a+xoQUTqXh7qx3SvGnvbGux/wZ4luhpA6bEhlRN9LPeVVKbR7rnlr8EccpTZXzPbDXZr
         sDp+5OUAFMiXGI6Kwy3kgEph0xqYl3L8aZz3iMEYfYo0oumRRVaYp4/3HoBj90TgabHq
         /b2A==
X-Gm-Message-State: AOAM530gACoySOMS4VUkQRGtfsQ0s1FOlU4/shCyLKa9Q91AY1+AEcvx
        YhBLoTbSC89KQdPhv266oBFaxKhUMA==
X-Google-Smtp-Source: ABdhPJzslNHRMbDlTLSVH+ySRuZDYmPvdWgqFZD9I7LbDYlgShjS4rqt60Xa4GlkiwlcHLvW6gI3Hs+U2A==
X-Received: from jannh2.zrh.corp.google.com ([2a00:79e0:1b:201:1a60:24ff:fea6:bf44])
 (user=jannh job=sendgmr) by 2002:a0c:f4d0:: with SMTP id o16mr14300775qvm.225.1598454952452;
 Wed, 26 Aug 2020 08:15:52 -0700 (PDT)
Date:   Wed, 26 Aug 2020 17:14:48 +0200
In-Reply-To: <20200826151448.3404695-1-jannh@google.com>
Message-Id: <20200826151448.3404695-6-jannh@google.com>
Mime-Version: 1.0
References: <20200826151448.3404695-1-jannh@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v4 5/5] mm/gup: Take mmap_lock in get_dump_page()
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properly take the mmap_lock before calling into the GUP code from
get_dump_page(); and play nice, allowing the GUP code to drop the mmap_lock
if it has to sleep.

As Linus pointed out, we don't actually need the VMA because
__get_user_pages() will flush the dcache for us if necessary.

Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/gup.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 92519e5a44b3..bd0f7311c5c6 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1552,19 +1552,23 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
  * NULL wherever the ZERO_PAGE, or an anonymous pte_none, has been found -
  * allowing a hole to be left in the corefile to save diskspace.
  *
- * Called without mmap_lock, but after all other threads have been killed.
+ * Called without mmap_lock (takes and releases the mmap_lock by itself).
  */
 #ifdef CONFIG_ELF_CORE
 struct page *get_dump_page(unsigned long addr)
 {
-	struct vm_area_struct *vma;
+	struct mm_struct *mm = current->mm;
 	struct page *page;
+	int locked = 1;
+	int ret;
 
-	if (__get_user_pages_locked(current->mm, addr, 1, &page, &vma, NULL,
-				    FOLL_FORCE | FOLL_DUMP | FOLL_GET) < 1)
+	if (mmap_read_lock_killable(mm))
 		return NULL;
-	flush_cache_page(vma, addr, page_to_pfn(page));
-	return page;
+	ret = __get_user_pages_locked(mm, addr, 1, &page, NULL, &locked,
+				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
+	if (locked)
+		mmap_read_unlock(mm);
+	return (ret == 1) ? page : NULL;
 }
 #endif /* CONFIG_ELF_CORE */
 
-- 
2.28.0.297.g1956fa8f8d-goog

