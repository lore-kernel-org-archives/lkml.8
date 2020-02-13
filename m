Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8ED0C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8EA24698
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Mbo6mH13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgBMQtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:49:55 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37955 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgBMQtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:49:55 -0500
Received: by mail-qk1-f196.google.com with SMTP id z19so6308801qkj.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 08:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=p0Q6hlzmT378e7z6l0VbudwtzHddZYb7fL48aFnyhQI=;
        b=Mbo6mH13hg4FUj125LjT49IpZfh5Dx6Clki2I0o1qK/+D9ig3+4zc4sKXV2vv6btj1
         pILY/jvB9oMw042WivFSkyFuyi002K8QSBH8g7G5IYFhAeRkVFqn4K1IxSugQwloaDiE
         TDwi8Jm9mCp6b++s7AaBiVU12pFuzpog9T2YHNzfVJeBQTTkm39VSxXqyut0s1Y1Jdo1
         RlYsOsvKmX+0OVACh5XYikOuQdz9FfQZVWicqP2kHfh6vFuInHRIS1t+w1i+0/49PlJi
         d6JQD+q5uRtv8xcQ76t3KY3p8jzI1MN9Jg3yG2tmFzjK0YabGL1iKjtmb+6KPqNTTJd9
         bMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p0Q6hlzmT378e7z6l0VbudwtzHddZYb7fL48aFnyhQI=;
        b=hO2CFKdXW+NOV5ARm4489LbV+isncTebbjoScRdinBg9T6ZmSc94b0JkkiFemfxju/
         LgLiJtSfxzdi28XYquq2OSAImuvkYff+xffjP0OQn2QREi3mIWAZ85X96plREcSMpKwF
         cO9ilI7+o6Z326PaeV0sPOyvG4vklBfsa1nptVILuJZzb7pYHyNcSnuiqqteLUX3Tbum
         3K7Sa097kzM8vQ803uoaX8gfemcAr93Yg/AUM/5thDj7UZfJfS40CL2y8ObyAyAxyVD0
         BzgVaxZaDMAHl3mu6sk1vKlhMFz0WaGZMa4/33aEly2x1Td8WKwF/TSxUM9Ih1R00kuG
         Ym5Q==
X-Gm-Message-State: APjAAAVDvfQ4ajBUorbfn53O1lVvfGQcc08VdmXijjz5CThna3iFuoWe
        T7HhYAlX0srXU5P3iNxz7+VVYcUCeDVw4Q==
X-Google-Smtp-Source: APXvYqxToB0ZdUztLY2jCfM16G2vL2IzQ177XzC8UoL9bZJGCZ2p2bepzb7wDW94brCIeWaQ+NUXQA==
X-Received: by 2002:a37:a116:: with SMTP id k22mr16169504qke.340.1581612594173;
        Thu, 13 Feb 2020 08:49:54 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c45sm1785126qtd.43.2020.02.13.08.49.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2020 08:49:53 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     elver@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next v2] mm/page_io: mark various intentional data races
Date:   Thu, 13 Feb 2020 11:49:45 -0500
Message-Id: <1581612585-5812-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
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

 read to 0xffff9095cbaa8400 of 8 bytes by interrupt on cpu 72:
  swap_slot_free_notify+0x121/0x2e0
  swap_slot_free_notify at mm/page_io.c:89

The write is under &si->lock, but the reads are done as lockless. Since
the reads only check for a specific bit in the flag, it is harmless even
if a data race happens. Thus, just mark them as intentional data races
using the data_race() macro.

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: add a missing annotation.

 mm/page_io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 76965be1d40e..26935db0676c 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -86,7 +86,7 @@ static void swap_slot_free_notify(struct page *page)
 		return;
 
 	sis = page_swap_info(page);
-	if (!(sis->flags & SWP_BLKDEV))
+	if (data_race(!(sis->flags & SWP_BLKDEV)))
 		return;
 
 	/*
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
1.8.3.1

