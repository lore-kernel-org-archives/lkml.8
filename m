Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3212DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09A372075B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZwNZMdOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgHRGNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgHRGNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:13:06 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C88C061343
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 23:13:05 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id k142so12436360qke.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 23:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uEsosFURBjONd+/+zLGkVplNTPfQUMPsbnxJn8l+5vc=;
        b=ZwNZMdOmDrLPGKWoU7+xUPQWuT5oFIHuub4ejn1ekJsju5Wwy4BLyJBNVFY7s7BOld
         z3j7VbHfP0i4lVA1JENTx0vcSL03Ivy7dRS9ixIgK6o9EnEGMJMVSN27CQhbCwLUUGja
         g2kOE4ob+pHuuCV3lxWoW781kDluCgRGWDnAPhZxeaR/O94K6cNgRXgdK/AQ0tq08LM/
         HTnNGkc2Hr1LW06qlLL1igs/cd0cIwr/k5am8Yq+ZUlq2W/bZqQPuN/yvos43bmZzKui
         vGmfTNebqL+H4H3PJeXssHpUinSJ181aWS1QvdMT+BzOZLkJTgY+MgaAplPmApsiySYe
         alww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uEsosFURBjONd+/+zLGkVplNTPfQUMPsbnxJn8l+5vc=;
        b=aljO/+GyNpDob/p5QmzvVawYv1yTyrFBpLwSdbpqaXoSO3a50iQngc6pg7IPYdAO5a
         9rV3Zy1Ty/wBauwdE3bdwAKpQyoDrjDp4F+sMN0tV8SxJIAok155D6YJppT1qeHToxeJ
         fCeAc1Jpi7Zps7UvtjQfz4PtLTkXycuQvYBb2gUsu/s+yApOAjWa732pQX+7pX4Wou4l
         jvaOLZLGCSp2X9X0W2772d5YEypPShgyJLublngqUwDI9SJhmS93m7icBiDUzyjjJFq5
         s5rIZwlTC+0XQkW3LbTzyZePYNcmCCOQR060bgeGDjsBt1x3fD+ClYQCfYEn3ao98RNj
         4FBQ==
X-Gm-Message-State: AOAM533dABjzMuvgQrewig6KBBGsN8B0tI9WSkuqz3Y2D8nuAmLS+jjx
        d//TFMs+H1j+ggHR2Wt39iPG15PMKg==
X-Google-Smtp-Source: ABdhPJxP3VNaCKztfKGOZRUkeGpGigQsg+G3JDfTvOzuksmwqiQeamW72iYG3Jd8rw3YImyyUmlMeGtIjQ==
X-Received: by 2002:ad4:40cb:: with SMTP id x11mr18084057qvp.176.1597731184753;
 Mon, 17 Aug 2020 23:13:04 -0700 (PDT)
Date:   Tue, 18 Aug 2020 08:12:39 +0200
In-Reply-To: <20200818061239.29091-1-jannh@google.com>
Message-Id: <20200818061239.29091-6-jannh@google.com>
Mime-Version: 1.0
References: <20200818061239.29091-1-jannh@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v3 5/5] mm/gup: Take mmap_lock in get_dump_page()
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
2.28.0.220.ged08abb693-goog

