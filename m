Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53450C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3347920787
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eaWQu5rI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388091AbgEWS6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 14:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387580AbgEWS6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 14:58:05 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FB8C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 11:58:04 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n15so6779764pfd.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 11:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fQihCl0dLbHaElgiRrlXkibi9/E8OKsaJ7lF0uUyO/s=;
        b=eaWQu5rIF65IIe8LNBzP1VhRXuhf/K8YuXmyjWuD3csLufjFBKBEZDaJbIB6RwswAQ
         rDBP5Ms4v5GriXypOxasHghq7UnINAs0gaI86yQ/hNhK85oUXxh9tCLqJ+1ReVF5l/ix
         tPRMxxn5OJgrvK94v8gqoHCYdCO3fgQMAXr+vr1QgQvnYsZJ/wdm4/qp2eaVtNDY2sgH
         LDz+wH7VwwOwdN2+SX1xQCFbPnBR8BZ8SA2j96fkibGQYbL5STDJ4sUUYmLUjN6asTWW
         kgkWS4yZfdrzVsXNsu8c22UnUv/buUDX4ks7m/nlfPqKjekl11LSVTWWEwpgJg0OiRni
         cSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fQihCl0dLbHaElgiRrlXkibi9/E8OKsaJ7lF0uUyO/s=;
        b=cMtJsw4LyUSXsS+9WxO14YV5qfrjga3v3rnApATcBbdJ1fAPrxd8Z5xC3x9QF4qyBB
         R6YV7huonWHZz7KgudOB5DGIdI2oXb28+55azeApGS7S0PrS9Rco5e6zWd2yuQJ3JUdn
         pT8KOn838GnclFc5hA4zk9U6i6sl8257RFk+zrh3l44pHzCDbTMK0zAX+jSYvbdS2kG2
         fth7OSoforWVHeNcomgXPzgEzOzc6BIbT/m+fuf6/1DYV6wv1p8kj9+E65qfHgkdurom
         +dKKGhZa3pzBg9f/RCnv1O5Gp5/bD41TfEsM/Q5kAr8XRGOSqkXzHvgE865C6dIYwnhP
         juOg==
X-Gm-Message-State: AOAM533fUK9ZXYfihbS5urzk7BLF6SOg1eLi4gnGkFdhkx3YIuTep3oG
        Xc98vXEziubQZFaOFKAjeOWNvA==
X-Google-Smtp-Source: ABdhPJz9vqnGrCG9qj0wEnBzhySeVMrYNwRHjDaahSZXAg0rEuCiNKORSORIP7O+cxiJTr2yWj4euQ==
X-Received: by 2002:a63:3114:: with SMTP id x20mr20316638pgx.52.1590260283492;
        Sat, 23 May 2020 11:58:03 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c94:a67a:9209:cf5f])
        by smtp.gmail.com with ESMTPSA id 25sm9297319pjk.50.2020.05.23.11.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 11:58:03 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/12] mm: abstract out wake_page_match() from wake_page_function()
Date:   Sat, 23 May 2020 12:57:46 -0600
Message-Id: <20200523185755.8494-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523185755.8494-1-axboe@kernel.dk>
References: <20200523185755.8494-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes in this patch, just in preparation for allowing
more callers.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h | 37 +++++++++++++++++++++++++++++++++++++
 mm/filemap.c            | 35 ++++-------------------------------
 2 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a8f7bd8ea1c6..53d980f2208d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -456,6 +456,43 @@ static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
 	return pgoff;
 }
 
+/* This has the same layout as wait_bit_key - see fs/cachefiles/rdwr.c */
+struct wait_page_key {
+	struct page *page;
+	int bit_nr;
+	int page_match;
+};
+
+struct wait_page_queue {
+	struct page *page;
+	int bit_nr;
+	wait_queue_entry_t wait;
+};
+
+static inline int wake_page_match(struct wait_page_queue *wait_page,
+				  struct wait_page_key *key)
+{
+	if (wait_page->page != key->page)
+	       return 0;
+	key->page_match = 1;
+
+	if (wait_page->bit_nr != key->bit_nr)
+		return 0;
+
+	/*
+	 * Stop walking if it's locked.
+	 * Is this safe if put_and_wait_on_page_locked() is in use?
+	 * Yes: the waker must hold a reference to this page, and if PG_locked
+	 * has now already been set by another task, that task must also hold
+	 * a reference to the *same usage* of this page; so there is no need
+	 * to walk on to wake even the put_and_wait_on_page_locked() callers.
+	 */
+	if (test_bit(key->bit_nr, &key->page->flags))
+		return -1;
+
+	return 1;
+}
+
 extern void __lock_page(struct page *page);
 extern int __lock_page_killable(struct page *page);
 extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
diff --git a/mm/filemap.c b/mm/filemap.c
index 80747f1377d5..e891b5bee8fd 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -990,43 +990,16 @@ void __init pagecache_init(void)
 	page_writeback_init();
 }
 
-/* This has the same layout as wait_bit_key - see fs/cachefiles/rdwr.c */
-struct wait_page_key {
-	struct page *page;
-	int bit_nr;
-	int page_match;
-};
-
-struct wait_page_queue {
-	struct page *page;
-	int bit_nr;
-	wait_queue_entry_t wait;
-};
-
 static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync, void *arg)
 {
 	struct wait_page_key *key = arg;
 	struct wait_page_queue *wait_page
 		= container_of(wait, struct wait_page_queue, wait);
+	int ret;
 
-	if (wait_page->page != key->page)
-	       return 0;
-	key->page_match = 1;
-
-	if (wait_page->bit_nr != key->bit_nr)
-		return 0;
-
-	/*
-	 * Stop walking if it's locked.
-	 * Is this safe if put_and_wait_on_page_locked() is in use?
-	 * Yes: the waker must hold a reference to this page, and if PG_locked
-	 * has now already been set by another task, that task must also hold
-	 * a reference to the *same usage* of this page; so there is no need
-	 * to walk on to wake even the put_and_wait_on_page_locked() callers.
-	 */
-	if (test_bit(key->bit_nr, &key->page->flags))
-		return -1;
-
+	ret = wake_page_match(wait_page, key);
+	if (ret != 1)
+		return ret;
 	return autoremove_wake_function(wait, mode, sync, key);
 }
 
-- 
2.26.2

