Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2F8C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C1E020757
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rpSOhgpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgD2Vub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 17:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727875AbgD2Vu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 17:50:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE481C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 14:50:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w15so5155106ybp.16
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 14:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=j9WUvKonPgTjIUwjN6gAw2Ow91kmiZMiVo0dKn965xM=;
        b=rpSOhgpZAHdOAwMyVgY0CFeQV4JBSuitbsj273BpBIYbY5RLsc4oU8PEL0H8l2TB5Q
         jG553aIKfQF2YF6o13fsBMT5zGN9segQ20ek4BoudBSd1oldgaKUIzQE1gUENm6VWCJL
         rwV8ZCHjEEotGPzpCJokeDTsN3sON5Be1JY9+ilHhlCYSwmVmYep7UjgmJeL0j+AtidP
         A/WuYCLR/baWvIOOSlanC6XH+h7tjaSu5ed9lIJtvsjuLczSBPgDCXkkJ+gL9HeXObZ4
         LPEB4qS5TfOwPWx/cfdcs+Q13OO74wWcsFq39oxOHl9vj9OcZRqB9BpSiip4xH6q2UDi
         xagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=j9WUvKonPgTjIUwjN6gAw2Ow91kmiZMiVo0dKn965xM=;
        b=SWnSSrSI6pGBjjp4OSYhdzJ+H5cmfGYEeZ747Ej5qVV2efAuuVzLlXckeBjy+J5hxY
         +VM+6piQ7ivcAx8P0/ZPTjpn2q36lknaiTvXXHw4hRUuDqLCcVzrtLX+tAd7ftOioeJb
         wtl++1SNmaMb5C5BpNXBvsNLnSPPnRh7eJvSAkk60rKS2t0jg7eTrdsS9DUOb4KBY/XI
         pXPSKgqd8pezNxCifBuEf3LLASemjoaOyo3YFa3UWGibAuFqkyG/QznxCKdq9yVAmHg9
         /s0Rg3CvEKfvU3ILypMlkQ8V12rwaUbGYse4K0ggd0pbiYvQQk2wRCd3n8uvOLbCsyNI
         s3/g==
X-Gm-Message-State: AGi0PuYMiNC+5ngEUuRJKDK4avjwZrLsJQKsvqhKwaV5BUM4BCAOW4QM
        lGxTMVHEN93E40f87h2rZ6veM3nVig==
X-Google-Smtp-Source: APiQypIHJ7rV1yTDZpZYpBo1v+hnjoUzGur3b82l9wJsRlWX+KQ5lDvvOT4btIQYmN3rHDSbWDUnK04YhA==
X-Received: by 2002:a25:23d4:: with SMTP id j203mr618266ybj.97.1588197027087;
 Wed, 29 Apr 2020 14:50:27 -0700 (PDT)
Date:   Wed, 29 Apr 2020 23:49:54 +0200
In-Reply-To: <20200429214954.44866-1-jannh@google.com>
Message-Id: <20200429214954.44866-6-jannh@google.com>
Mime-Version: 1.0
References: <20200429214954.44866-1-jannh@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH v2 5/5] mm/gup: Take mmap_sem in get_dump_page()
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properly take the mmap_sem before calling into the GUP code from
get_dump_page(); and play nice, allowing the GUP code to drop the mmap_sem
if it has to sleep.

As Linus pointed out, we don't actually need the VMA because
__get_user_pages() will flush the dcache for us if necessary.

Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/gup.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 9a7e83772f1fe..03f659ddd830a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1548,19 +1548,23 @@ static long __get_user_pages_locked(struct task_struct *tsk,
  * NULL wherever the ZERO_PAGE, or an anonymous pte_none, has been found -
  * allowing a hole to be left in the corefile to save diskspace.
  *
- * Called without mmap_sem, but after all other threads have been killed.
+ * Called without mmap_sem (takes and releases the mmap_sem by itself).
  */
 struct page *get_dump_page(unsigned long addr)
 {
-	struct vm_area_struct *vma;
+	struct mm_struct *mm = current->mm;
 	struct page *page;
+	int locked = 1;
+	int ret;
 
-	if (__get_user_pages(current, current->mm, addr, 1,
-			     FOLL_FORCE | FOLL_DUMP | FOLL_GET, &page, &vma,
-			     NULL) < 1)
+	if (down_read_killable(&mm->mmap_sem))
 		return NULL;
-	flush_cache_page(vma, addr, page_to_pfn(page));
-	return page;
+	ret = __get_user_pages_locked(current, mm, addr, 1, &page, NULL,
+				      &locked,
+				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
+	if (locked)
+		up_read(&mm->mmap_sem);
+	return (ret == 1) ? page : NULL;
 }
 
 #if defined(CONFIG_FS_DAX) || defined (CONFIG_CMA)
-- 
2.26.2.526.g744177e7f7-goog

