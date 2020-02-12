Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F518C3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734852082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581545789;
	bh=xWKxGR9jZZLM8Fi96N9f70zttlqIrIjWLntWGvtmqaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DWtfWiCbSGTZQIbu7ho4u1ME6huieC4nP3giZCZlw0uRTL45N3uMTxO7Kuo9oXH8R
	 y5OSkjPLD2S+yHuMibkBnvzkTkjzZ69LfhH5cIXBAZgu7gen3vqcZVwj6GBPHxlOhk
	 MRbXDIX+IPXv1ZD1trhw3XKpS5ojsDvRbzBB9qCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgBLWQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 17:16:28 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39006 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgBLWQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 17:16:26 -0500
Received: by mail-pg1-f195.google.com with SMTP id j15so1934888pgm.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 14:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D/5iSeGXxDP+lyJUNU19NRvUdswxslkbz5wrgabobm4=;
        b=RgghztW93FIsObaDVTciRjZtfHpXEir8OzbNJN4SLfBEcm0ZxYvARrdoRfoXg+LwMe
         jwiPMshiVt5Onf2q1iAfqMGoHt/WNe9/ARKxkJHYkx8V4VZQ/dzVrs3R+y43UPMVH6Gd
         rkB8L7CTQkylxONFx0N68n5Yt4bLQPcZj9G0Dg2dw1d9ksO8J5Gha2Ci5J2LEMK30HQO
         AzHycbYzANEqFI7IuT4k4eUWczU6MiwGLtqSos2qS+eaEfioQMTKAXhXKWFO4ifupbG3
         E6/7183vg2hJ+yeMpUJh+q9TdtbUJbf+s9+wi9ObLW3GaWrcAfrc9g/LKACZVKX6dNzH
         g0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=D/5iSeGXxDP+lyJUNU19NRvUdswxslkbz5wrgabobm4=;
        b=oGsfzc/MKpkw+sL01j6LZp9696fMhiJQvmq7ZrRR6/qwdLZF/gqW9fno1BUqyZlshM
         rZ8YZIJuatCZZ3urnGXYPTwOMYeDYRAmtSHdmSG0hg6BoJyOgJzMNMf579C36bv680i9
         QDNEQECWsiCHVNaqm8+ioiKj2EpEOXAXNnDzqgr9t/hlU6CV0hJ3sJAMJySZGq7FkZrH
         MXycJzQMF4MtuS6frwGby4u3vE0SSNNcDlsAWS3mqhBKzYWrv4+bsWgIZjcLqDQHL6Ua
         wFhLk69fj3SplyI2c253N3QfT4XngLX800qINlfXkUw4XmubtvDEIckjSwsJNll1l8vF
         VVxA==
X-Gm-Message-State: APjAAAW68v0q510KzeWKUjSRcTfKMIBaypl9uGPHj8zdrugESxwNphUX
        x3uPNHx2/AjoKOVQ1V83bTI=
X-Google-Smtp-Source: APXvYqz1nem2XDQSzeUCQA8Znbwsf82xp456uPoXIqYlQNqSSDiN2zIXgfgWRsDJA3ckF8qu9qTo7w==
X-Received: by 2002:a63:42c4:: with SMTP id p187mr14713432pga.57.1581545785766;
        Wed, 12 Feb 2020 14:16:25 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id o10sm117683pgq.68.2020.02.12.14.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 14:16:24 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>, Robert Stupp <snazy@gmx.de>
Subject: [PATCH 3/3] mm: make PageReadahead more strict
Date:   Wed, 12 Feb 2020 14:16:14 -0800
Message-Id: <20200212221614.215302-3-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
In-Reply-To: <20200212221614.215302-1-minchan@kernel.org>
References: <20200212221614.215302-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PG_readahead flag is shared with PG_reclaim but PG_reclaim is only
used in write context while PG_readahead is used for read context.

To make it clear, let's introduce PageReadahead wrapper with
!PageWriteback so it could make code clear and we could drop
PageWriteback check in page_cache_async_readahead, which removes
pointless dropping mmap_sem.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/page-flags.h | 28 ++++++++++++++++++++++++++--
 mm/readahead.c             |  6 ------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 1bf83c8fcaa7..f91a9b2a49bd 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -363,8 +363,32 @@ PAGEFLAG(MappedToDisk, mappedtodisk, PF_NO_TAIL)
 /* PG_readahead is only used for reads; PG_reclaim is only for writes */
 PAGEFLAG(Reclaim, reclaim, PF_NO_TAIL)
 	TESTCLEARFLAG(Reclaim, reclaim, PF_NO_TAIL)
-PAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
-	TESTCLEARFLAG(Readahead, reclaim, PF_NO_COMPOUND)
+
+SETPAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
+CLEARPAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
+
+/*
+ * Since PG_readahead is shared with PG_reclaim of the page flags,
+ * PageReadahead should double check whether it's readahead marker
+ * or PG_reclaim. It could be done by PageWriteback check because
+ * PG_reclaim is always with PG_writeback.
+ */
+static inline int PageReadahead(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(PageCompound(page), page);
+
+	return (page->flags & (1UL << PG_reclaim | 1UL << PG_writeback)) ==
+		(1UL << PG_reclaim);
+}
+
+/* Clear PG_readahead only if it's PG_readahead, not PG_reclaim */
+static inline int TestClearPageReadahead(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(PageCompound(page), page);
+
+	return !PageWriteback(page) ||
+			test_and_clear_bit(PG_reclaim, &page->flags);
+}
 
 #ifdef CONFIG_HIGHMEM
 /*
diff --git a/mm/readahead.c b/mm/readahead.c
index 2fe72cd29b47..85b15e5a1d7b 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -553,12 +553,6 @@ page_cache_async_readahead(struct address_space *mapping,
 	if (!ra->ra_pages)
 		return;
 
-	/*
-	 * Same bit is used for PG_readahead and PG_reclaim.
-	 */
-	if (PageWriteback(page))
-		return;
-
 	ClearPageReadahead(page);
 
 	/*
-- 
2.25.0.225.g125e21ebc7-goog

