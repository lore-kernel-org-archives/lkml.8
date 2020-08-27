Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AF2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A65A207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qAl3aYBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgH0MMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 08:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbgH0Lu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:50:58 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9054C0619C0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 04:50:03 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id d23so1427895edv.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 04:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=7aZgefibZrTCs6XQP3SSXIsvAQ9RHGTwgc0UHLaNuJc=;
        b=qAl3aYBuljMXDgGHSGVDp+hgxe+gqGFmAWy4rRnhiga/eisuFw16UE3XkV1gF06/rw
         N49bdbuxV6EwXiDzAvesC/DoZmDX3L/5rN1/EUfXfknzL6Yq25+xirgAm6bTrx1qdzlg
         48kPTyb1jWCxPQ5QRpbpvOLyB4xMZj9SQ33HjhROU6Y4JbC/ffa6Ppz1ujabxx0i/W7p
         biZ/pGZTE2ifWHW9M2HQ1aj7T23aompUwxKttebsptCS0lMr62sq7+TFDJi0bPS0vKEs
         U0e7G5uYqwdIfHjhgM/r/9A/u1lUQ1eGs8hqvXJNCAjlDAVw1eHVdErrdoNQ6173LzqE
         ujeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7aZgefibZrTCs6XQP3SSXIsvAQ9RHGTwgc0UHLaNuJc=;
        b=Ka/uSoz3KQmEwX+eUZiciWOFq+Y99uWNVNduLYQDlTeHqJWgvZ6G//zUkEozj/d8Cc
         fJsSQxpUFts3hU1O2kPcOjpiA+NaDVuhkauO6JjlhfSprld1ooyZZS9PO9mG8XxlDN++
         mYGRQeu/RdRKAY4qpuKoFdwaySOeSUIR7KWCAqB2rx19H4cuHRo1BMm+yP/zyYZ2RYqi
         c75Lt6Y1Gt8fW45z7AgGcMSn8zCJgzHfnmK9qmkZzuWBMhH6q0qx+z1mgKOMewuzpaOY
         Ii2+hsMzzlfHT5OngwGy7TSNrua1hWtdadGAZox6+rUVFU6NKvf5RZNPbklxwqcj7mKw
         sD9Q==
X-Gm-Message-State: AOAM533kfPDrGlo8VJpJ34QwUz1ldcjUUo2LUj0RvjfSbD+v0nSY5w9E
        ExHzdmvS2Fsxhn2Zhbz+X3w7BERFvg==
X-Google-Smtp-Source: ABdhPJwhBCyiHrz/+IMDKbZ52GDgcHe+j5akrd2gdlCfhjevzWrep4IKiEZ8xF0Uw2rMa5in+uH4gw5rKg==
X-Received: from jannh2.zrh.corp.google.com ([2a00:79e0:1b:201:1a60:24ff:fea6:bf44])
 (user=jannh job=sendgmr) by 2002:a17:906:c792:: with SMTP id
 cw18mr12340246ejb.285.1598529002516; Thu, 27 Aug 2020 04:50:02 -0700 (PDT)
Date:   Thu, 27 Aug 2020 13:49:31 +0200
In-Reply-To: <20200827114932.3572699-1-jannh@google.com>
Message-Id: <20200827114932.3572699-7-jannh@google.com>
Mime-Version: 1.0
References: <20200827114932.3572699-1-jannh@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v5 6/7] mm/gup: Take mmap_lock in get_dump_page()
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

