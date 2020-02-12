Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124C6C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC84021569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581545785;
	bh=mdbfZmZxKp4BXiI9nWGzPbce9TpU4KGJbJKBBU2/Dro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UwoMs5u3ukHcv5zs3GKUSVo642PJNPZ3BxGH7tv7S0q3dq8IeiefVoPK4OL2C87ji
	 HJfCOkfTRXShYNtx4AEcMSDPrW7fTHWeeSKYibiGI6454gM8w/VyVdWUUgVbe2qMBd
	 g/NfX3kwZg/CEO1UubKb7CSHEKPI3sJ7DuAAWMbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgBLWQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 17:16:25 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39002 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgBLWQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 17:16:24 -0500
Received: by mail-pg1-f194.google.com with SMTP id j15so1934841pgm.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 14:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qaiwdcinbwslO7EdATKJ134QGtzda46/f8mdpO086dY=;
        b=m6bE/7RqwfLpD1mq61rTzvjRR2ys5Ij1JFM0A0GKtF9HVX0WWCVA77x9kY/KpJrTfU
         JJSLpjs4+AlmTmCyUIciT3fcM6GnLxXwmzhl7i5raq1xxhDq2f93RnnIqEalWPJlEdwh
         JIhk6W9WGGsPQrafEVVXH+BhMV99HudisqiAGi0cyG/JwY3bw2cLmzjOK1hH6XJkuSrE
         YcKEbSinpUKN1NKpgYVsCo3VYMH33kH78gCd/DXZk+cVBUTCGpE6cnYRYOEvElvjvWbo
         1L9lzfXy4ziL6/Y5k5HXPBcOSqL9FUEBkqFcpzqevigihsGkJimKiYplosv8jbHFaR4e
         e0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=qaiwdcinbwslO7EdATKJ134QGtzda46/f8mdpO086dY=;
        b=dxU9g8MN/6otmrurBFGkdZv0z/w//p/ZKB/OgvoEqwBNa62rFpUL3CCg2tejhTEh74
         P41trh6D5ATCy0mGafgRRbhRG3E5BWkRjZgzfWMkL9qzMgSe2d+DO5n4qhSSuxM8x5fw
         GQXaCiCBYr4w7fXIh1yJTKj1k/vLS35UWt/pACZGG1sgmJYgIOQzCF9h/MMD26mtBFox
         melPWUKvxY2RqbhxfIyoAUzsUBKa6TZtXtPNPlqrXVmBBqsGEvCPxFdMRkbKAjHf3LBs
         Cx33vbpCNnSBivyfzFXIx/YTyTbzkEIvPH7Fdt79hUjndH7Dk+qNouvkKKN9aE2sA5aj
         NJyg==
X-Gm-Message-State: APjAAAWCpgJXQSIRyOlMNNxDENF3R5gCcqYT2TvD6zPpJljiry1SRVR+
        bJIQAbJ6EGsQ+zmBTjTsCk0=
X-Google-Smtp-Source: APXvYqxEdmfgRh8AIV8cmXo8MbUCE3MelnAT6e18QMejlP/S1J+YS648UCx0O+NpBLpkC87Z+qw4Wg==
X-Received: by 2002:a63:c30e:: with SMTP id c14mr15447571pgd.168.1581545783496;
        Wed, 12 Feb 2020 14:16:23 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id o10sm117683pgq.68.2020.02.12.14.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 14:16:22 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>, Robert Stupp <snazy@gmx.de>
Subject: [PATCH 2/3] mm: fix long time stall from mm_populate
Date:   Wed, 12 Feb 2020 14:16:13 -0800
Message-Id: <20200212221614.215302-2-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
In-Reply-To: <20200212221614.215302-1-minchan@kernel.org>
References: <20200212221614.215302-1-minchan@kernel.org>
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

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
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

