Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEBBC35247
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 00:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C14214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 00:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="FodglYyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgBGAhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:37:07 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46117 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgBGAhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 19:37:06 -0500
Received: by mail-qt1-f194.google.com with SMTP id e25so580215qtr.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 16:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ccGsetlHRBQHQD+TRFsRkJd6uqscbTJj5iGJ2mviylc=;
        b=FodglYycis59ditxWAvnQpx+LNp4ofogknZAt1B5ArEuamxh4AM/EYcubfRNL2bGlK
         fQqTIhLipyfohkj2Gw8LOTQomjbySXjSteTeKcz+ISmRhZ1pRuzhEiEQl1bU/iIixmZ0
         f8HS2yca5xbPCp6dcCI3hozUujmiSistmfIRUQrJEMw/Yf0/ufvHwMWatBb2+iPVLCiK
         l1GPDK4KU0wy6VJGH2//Y3Yh42jyS+c/KN36bTIcXLr1iUQvOyeu6r1q8lcwS/F8Lt9C
         S912wxwrEXYJaho5lfmhqcrvAgYwIm62vG1eWJo4cvhB49Mj4LCSGGJwE6eyFLj/BCZ1
         rtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ccGsetlHRBQHQD+TRFsRkJd6uqscbTJj5iGJ2mviylc=;
        b=VOeu/4DttGE8rDRqn2d4r21mKz5OoqlLCW99qRwzK4ePSjK/uGk/BLeXpyWmH/IIsc
         h+qXVITHFQOXSr/06arf0WjE9D7tIEYrAiRV2R4pCWrYtekx/G7zvJJkHkuYn6KqDs+C
         fx8VH/QhhSeLiKlo6+hyaAYj+zX/+HME41oRUTTfbqZfLONlgSoIHsQoLGdN01dvKbLb
         mu7m3TL84SXwYh3Rs12okKgG/otOCENYcM0SRWbvoWgeMaBOStn5pwtEWTVJaxiz/oGJ
         T7Xz/imIsKnvZ82mQdbNhfcPV5BZGmbqpazZnn6I80cO0Q+xpc1DfumwmcYpa9BY8Mgr
         U0wA==
X-Gm-Message-State: APjAAAXHnbaHX5NL9zB2MSXaFi5eUhmXsuMRJSgSrKWWfD922IvKuq0s
        KwnRBrVk7f9WtGk0wStHS6uXlQ==
X-Google-Smtp-Source: APXvYqz1de3M/fXMXoH6nLHq6OjLfJwxzirf0EIUh5I9HJbqqdPqeVhAd+Q55ZT70hy4DFFur6wVWg==
X-Received: by 2002:ac8:3fa9:: with SMTP id d38mr4938507qtk.333.1581035825944;
        Thu, 06 Feb 2020 16:37:05 -0800 (PST)
Received: from ovpn-121-126.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v10sm539918qtj.26.2020.02.06.16.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Feb 2020 16:37:05 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     elver@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/page_io: mark various intentional data races
Date:   Thu,  6 Feb 2020 19:36:01 -0500
Message-Id: <20200207003601.1526-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct swap_info_struct si.flags could be accessed concurrently as
noticed by KCSAN,

 BUG: KCSAN: data-race in scan_swap_map_slots / swap_readpage

 write to 0xffff9c77b80ac400 of 8 bytes by task 91325 on cpu 16:
  scan_swap_map_slots+0x6fe/0xb50
  scan_swap_map_slots at mm/swapfile.c:887
  get_swap_pages+0x39d/0x5c0
  get_swap_page+0x377/0x524
  add_to_swap+0xe4/0x1c0
  shrink_page_list+0x1740/0x2820
  shrink_inactive_list+0x316/0x8b0
  shrink_lruvec+0x8dc/0x1380
  shrink_node+0x317/0xd80
  do_try_to_free_pages+0x1f7/0xa10
  try_to_free_pages+0x26c/0x5e0
  __alloc_pages_slowpath+0x458/0x1290
  __alloc_pages_nodemask+0x3bb/0x450
  alloc_pages_vma+0x8a/0x2c0
  do_anonymous_page+0x170/0x700
  __handle_mm_fault+0xc9f/0xd00
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

 read to 0xffff9c77b80ac400 of 8 bytes by task 5422 on cpu 7:
  swap_readpage+0x204/0x6a0
  swap_readpage at mm/page_io.c:380
  read_swap_cache_async+0xa2/0xb0
  swapin_readahead+0x6a0/0x890
  do_swap_page+0x465/0xeb0
  __handle_mm_fault+0xc7a/0xd00
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

 Reported by Kernel Concurrency Sanitizer on:
 CPU: 7 PID: 5422 Comm: gmain Tainted: G        W  O L 5.5.0-next-20200204+ #6
 Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019

Other reads,

 read to 0xffff91ea33eac400 of 8 bytes by task 11276 on cpu 120:
  __swap_writepage+0x140/0xc20
  __swap_writepage at mm/page_io.c:289

 read to 0xffff91ea33eac400 of 8 bytes by task 11264 on cpu 16:
  swap_set_page_dirty+0x44/0x1f4
  swap_set_page_dirty at mm/page_io.c:442

The write is under &si->lock, but the reads are done as lockless. Since
the reads only check for a specific bit in the flag, it is harmless even
if load tearing happens. Thus, just mark them as intentional data races
using the data_race() macro.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/page_io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 76965be1d40e..1ee5957deb88 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -286,7 +286,7 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 	struct swap_info_struct *sis = page_swap_info(page);
 
 	VM_BUG_ON_PAGE(!PageSwapCache(page), page);
-	if (sis->flags & SWP_FS) {
+	if (data_race(sis->flags & SWP_FS)) {
 		struct kiocb kiocb;
 		struct file *swap_file = sis->swap_file;
 		struct address_space *mapping = swap_file->f_mapping;
@@ -377,7 +377,7 @@ int swap_readpage(struct page *page, bool synchronous)
 		goto out;
 	}
 
-	if (sis->flags & SWP_FS) {
+	if (data_race(sis->flags & SWP_FS)) {
 		struct file *swap_file = sis->swap_file;
 		struct address_space *mapping = swap_file->f_mapping;
 
@@ -439,7 +439,7 @@ int swap_set_page_dirty(struct page *page)
 {
 	struct swap_info_struct *sis = page_swap_info(page);
 
-	if (sis->flags & SWP_FS) {
+	if (data_race(sis->flags & SWP_FS)) {
 		struct address_space *mapping = sis->swap_file->f_mapping;
 
 		VM_BUG_ON_PAGE(!PageSwapCache(page), page);
-- 
2.21.0 (Apple Git-122.2)

