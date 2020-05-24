Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32E6C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 844CC207C3
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="2Ls3+QLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388128AbgEXTWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 15:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387744AbgEXTWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 15:22:17 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4B4C05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 12:22:17 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j21so7769200pgb.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 12:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fQihCl0dLbHaElgiRrlXkibi9/E8OKsaJ7lF0uUyO/s=;
        b=2Ls3+QLCLeno0jCON841EcWXGQKWPnDvCePQ3gzUcj9mNawaAgmwjotTCl0/7xbnda
         rfxeTUTHpN3qCYhSv6xAt8Ant4ZfpAttPgjaMPnqiBrqlKdjHbTCVwhoAj8/Hb970o35
         6v3SO2V1GK52FaER0WaJA+/6MYb7O1/C9c2j1MWKSLceSlecvpDxRZr5wYCbQ3y3sT1F
         vp3sOzstbaxM5MzE8nggK0lWKSOdFNKCUjqvlIACct9959BpZmY5bBCc84O/BXO9klJw
         KD55lffQl2jrhCxficFT0VRaS/iOfhiJ8jApT9QjIGenWhJtjx7T0ZT6PipOddmqq97e
         PS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fQihCl0dLbHaElgiRrlXkibi9/E8OKsaJ7lF0uUyO/s=;
        b=YWNxVxpc59tnaRJx650Sy9p2t6xHFhouRAb+NiILuD8Wftc+sx8/g3lo+fvmtSxrvd
         etGd6UqoS+QV1DrjcGCoIi88ej8phHnh1ty/nyT/i+M/hNzsVK0oc5+84mesf6Trd6At
         pKoaliqxL2vTZ7F/HxNyihP680x0eJmo2cU5mM+rKkNHcsmd9BXCdw1x8yICKmTn+j1d
         Sl/5Rz+sO3qOEHnUQwpByP0lfXupv2T3m066/BLLzb+Bi+ISNTB3uYco2U3v+jMr4JOu
         Z4w64k7QiOnIz2MFBHSq1/QnVJ8dTuH2MIIgT8rCMD1NMmQL4hjwBZoucGH++0Cvgj4G
         vnKQ==
X-Gm-Message-State: AOAM531Xrct4w1EJXfY2dvetYTt9n7wpXwiks9t7PgMcmPYagYJPs4M2
        qmUb6x5dq7N9mS5mJbFJ4fK8Tw==
X-Google-Smtp-Source: ABdhPJyhydzeyBlKQCRTW6m8/JKp1oOARrRFIDQLFSR3T+UzUCwXLRBHN9D1E2V8YIjgAYJPFkMCtw==
X-Received: by 2002:a63:dd0c:: with SMTP id t12mr23468725pgg.293.1590348136731;
        Sun, 24 May 2020 12:22:16 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c871:e701:52fa:2107])
        by smtp.gmail.com with ESMTPSA id t21sm10312426pgu.39.2020.05.24.12.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 12:22:16 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/12] mm: abstract out wake_page_match() from wake_page_function()
Date:   Sun, 24 May 2020 13:21:57 -0600
Message-Id: <20200524192206.4093-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200524192206.4093-1-axboe@kernel.dk>
References: <20200524192206.4093-1-axboe@kernel.dk>
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

