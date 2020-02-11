Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D73C352A5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 00:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE5620715
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 00:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581380408;
	bh=2u/RhpeyhZbyGo5n8b7k2lWjMrohTRxWgqVkpmvJVIQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=S8EloAxG3UdLgzl+XmmSbID0CYOavSM6nI95t4LD5UBH9MI6ZxIDtONHANQQA5S3d
	 xN3hnmoqXYVXoTqpNO89crhIuL15StzQHg8kgZFCOd42DfRvhfrkAV1dBCKWReAoGq
	 P6fnL5crw9mkHW/v7WVgy3os2y/Fg203/7LSOF84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgBKAUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 19:20:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41142 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbgBKAUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 19:20:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id t14so3491325plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 16:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3OTREQOKy0gnIvXKXGDvE24tk+qLBMpu/Of2xHZqo/4=;
        b=hA6VDB/o9xlXGxz9a3Jeb+DNW1qd5ufupvTSSjGfmKl1n4YanuCFru5Maw8WqpTWce
         j4mqh4Darcqmj85XbyBJ9DuxBAgAyn03iQZuG88hqQEV2rOhxb2m4EyqzMNjt2PXHyg7
         NUzcPEyyOU8dB0zDP1zV0B+ei6+d//2Mw7xfGgL/H/oT+pZNZySvjnlPZOUuBfXoZxbc
         n5T/lj5bQ34VSC9MRZy0P/KMoWdJ562jRPrASKJ765OhI6YKnlKUPOe9kdLxpEGGqCxR
         9wioDqCp+pHDcytTT5Lgnuq7TfeXC04Z7dUNOKfvIZMnO3FH8JnhPhG7/2NLNVbFNjQP
         04HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=3OTREQOKy0gnIvXKXGDvE24tk+qLBMpu/Of2xHZqo/4=;
        b=en2JxHmOgHQ6rmemFy3graeogYv8T0IOxUyuDiXMmp/BXAs19BP9G1FrxjcyRmFhcS
         Xc/DM6Wu9oF1eWsyRfPzE5xsgskstyq0EMuApo7wrv0bCaZxHJ3SGhceV5tA5j8+3DZn
         /sN8YPgOpOTRlvPlLq2qdlVYvdYG5eCaE+wyGIiYCgSFGQeh/QQ2pHIHpRW1kbuCoYoq
         5yU8q0kVkVxXVcdGcGhCPGOdNoGjtHXdduBDV6fyfLhhSuJ+F5I1JZfAFHV1Pa5c596r
         zPZAxrULfPTnnIVPZn/M7e7xqtjKM27Ual8BrXby5G5FTKTq1lGDcww/OfnhOfx8Ww4F
         B3Jw==
X-Gm-Message-State: APjAAAX8JQlkXv2GJh+wLjbjN0y3Oh1pgUVV/DPHHJqQlyM0XaUY5B6f
        ywddB+5LzJKG0oGcV7vx6+ntTAOB
X-Google-Smtp-Source: APXvYqyPeBczzNeYHJektBpOOUNWHawkwwYAhlRlcaRSELf4hUQd5E/C2uBZ3S7zpP0KWFXaRuBS2A==
X-Received: by 2002:a17:90a:fb41:: with SMTP id iq1mr502054pjb.89.1581380404487;
        Mon, 10 Feb 2020 16:20:04 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id c15sm1503020pfo.137.2020.02.10.16.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 16:20:03 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH] mm: fix long time stall from mm_populate
Date:   Mon, 10 Feb 2020 16:19:58 -0800
Message-Id: <20200211001958.170261-1-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Basically, fault handler releases mmap_sem before requesting readahead
and then it is supposed to retry lookup the page from page cache with
FAULT_FLAG_TRIED so that it avoids the live lock of infinite retry.

However, what happens if the fault handler find a page from page
cache and the page has readahead marker but are waiting under
writeback? Plus one more condition, it happens under mm_populate
which repeats faulting unless it encounters error. So let's assemble
conditions below.

__mm_populate
for (...)
  get_user_pages(faluty_address)
    handle_mm_fault
      filemap_fault
        find a page form page(PG_uptodate|PG_readahead|PG_writeback)
	it will return VM_FAULT_RETRY
  continue with faulty_address

IOW, it will repeat fault retry logic until the page will be written
back in the long run. It makes big spike latency of several seconds.

This patch solves the issue by turning off fault retry logic in second
trial.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
It was orignated from code review once I have seen several user reports
but didn't confirm yet it's the root cause.

 mm/gup.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 1b521e0ac1de..b3f825092abf 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1196,6 +1196,7 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 	struct vm_area_struct *vma = NULL;
 	int locked = 0;
 	long ret = 0;
+	bool tried = false;
 
 	end = start + len;
 
@@ -1226,14 +1227,18 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 		 * double checks the vma flags, so that it won't mlock pages
 		 * if the vma was already munlocked.
 		 */
-		ret = populate_vma_page_range(vma, nstart, nend, &locked);
+		ret = populate_vma_page_range(vma, nstart, nend,
+						tried ? NULL : &locked);
 		if (ret < 0) {
 			if (ignore_errors) {
 				ret = 0;
 				continue;	/* continue at next VMA */
 			}
 			break;
-		}
+		} else if (ret == 0)
+			tried = true;
+		else
+			tried = false;
 		nend = nstart + ret * PAGE_SIZE;
 		ret = 0;
 	}
-- 
2.25.0.225.g125e21ebc7-goog

