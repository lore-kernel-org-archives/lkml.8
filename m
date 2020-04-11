Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362B7C2BBFD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 22:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FE220769
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 22:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgf+yG0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgDKWEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 18:04:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36953 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgDKWEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 18:04:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id z6so6238592wml.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 15:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7awknHCHreVUL7HOgEtOc8fPTfDMmoiQP0NsrxPQ1o8=;
        b=cgf+yG0ytzZcljetiqszYQFSLXzHNdp4ie3DCzZjeBS7YN3iEEtZTMmns/RaStrAJl
         dNx0Cx9XpgZEpCvqS+85DM9C/qN0T2ydqQF71ExyeHpWmkkW0FjiCRp/GK8ft5rH6NlW
         HQG7uT88zPJGoHg39qODkdBkDYncSd1pC7oX7NWFUNGeYHxvUW86wXT6PLCA2q17Cju3
         29ffg1/dakVM7ZJyBSKF+3f8K1QZLF05AEQqNPVdFx43ft6xY6ICPb4bpRIpVL0i45UC
         jwpeFQQRqkYtFzerBwFdtR6u4znwFKE4dE7A9gmA28ArizyHXcbGELzv2duPsSZbpCy6
         Oryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7awknHCHreVUL7HOgEtOc8fPTfDMmoiQP0NsrxPQ1o8=;
        b=JgTlHfy9n3mA7/WUqNG7PZlUsghkl0Z6ZuerRzQ0WDJ1mCXaH+ls+XIKNgZiuNJiXe
         TIZkeC3hVvkCF1/QKKo+QinGy1BmVh9Oh4FAxNJ7vUyBSv9vrp5eLGAcw9wTWz1xBGnY
         GoEbRQ/fRKBzPJtgGXMl3dUkOsjbeZdnG+7on2grnwUKD+4jL/5VBS8BJarfKrDlH60V
         tTfKBT2TJgopY7adwwbMZYKj0+KADyz1gXgOH3Gd8NVP5l5842o5siZZUpbDwZ288xrD
         AputBmhQohDrzJhyL32UCX1WMPjtYIxc64eRZ+RlkG5OJOrIhk3KjTUbbwqQRlbIE/KD
         /qXg==
X-Gm-Message-State: AGi0PuZgjblO6WeCFBpSqDqoGdrlrLmLbXMiGAyT+QiRvO33D2e0UlEP
        2S+L1F3qbb6l6DLek1A0GnU=
X-Google-Smtp-Source: APiQypLJte/8h1XPH3mWhbw57nwf2wLT6tGlCTzV7+vyIqii7e/6lamZUdFuOsmP/vekvPKrUbGV2g==
X-Received: by 2002:a1c:8106:: with SMTP id c6mr11350070wmd.88.1586642664302;
        Sat, 11 Apr 2020 15:04:24 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id h2sm7939369wmb.16.2020.04.11.15.04.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Apr 2020 15:04:23 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        rientjes@google.com, anshuman.khandual@arm.com, david@redhat.com,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v3 1/5] mm/page_alloc.c: bad_[reason|flags] is not necessary when PageHWPoison
Date:   Sat, 11 Apr 2020 22:03:53 +0000
Message-Id: <20200411220357.9636-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200411220357.9636-1-richard.weiyang@gmail.com>
References: <20200411220357.9636-1-richard.weiyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since function returns directly, bad_[reason|flags] is not used any
where. And move this to the first.

This is a following cleanup for commit e570f56cccd21 ("mm:
check_new_page_bad() directly returns in __PG_HWPOISON case")

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: David Hildenbrand <david@redhat.com>

---
v3:
  * move this handling to the first case
---
 mm/page_alloc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f49f28f1220b..7327dc039069 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2037,19 +2037,17 @@ static void check_new_page_bad(struct page *page)
 	const char *bad_reason = NULL;
 	unsigned long bad_flags = 0;
 
+	if (unlikely(page->flags & __PG_HWPOISON)) {
+		/* Don't complain about hwpoisoned pages */
+		page_mapcount_reset(page); /* remove PageBuddy */
+		return;
+	}
 	if (unlikely(atomic_read(&page->_mapcount) != -1))
 		bad_reason = "nonzero mapcount";
 	if (unlikely(page->mapping != NULL))
 		bad_reason = "non-NULL mapping";
 	if (unlikely(page_ref_count(page) != 0))
 		bad_reason = "nonzero _refcount";
-	if (unlikely(page->flags & __PG_HWPOISON)) {
-		bad_reason = "HWPoisoned (hardware-corrupted)";
-		bad_flags = __PG_HWPOISON;
-		/* Don't complain about hwpoisoned pages */
-		page_mapcount_reset(page); /* remove PageBuddy */
-		return;
-	}
 	if (unlikely(page->flags & PAGE_FLAGS_CHECK_AT_PREP)) {
 		bad_reason = "PAGE_FLAGS_CHECK_AT_PREP flag set";
 		bad_flags = PAGE_FLAGS_CHECK_AT_PREP;
-- 
2.23.0

