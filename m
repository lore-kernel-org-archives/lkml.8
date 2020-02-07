Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2068C35242
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 17:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB41C214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 17:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jFgyXpwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgBGRGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 12:06:18 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43366 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgBGRGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 12:06:17 -0500
Received: by mail-qt1-f195.google.com with SMTP id d18so2343618qtj.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 09:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RdUZszUoRKky8NvIk124GtZHPfeOOpksA+eMKXZrPwo=;
        b=jFgyXpwSNBAe6yTrmnldmAseRFzf3b/SAgQk4YAM/KQzVPxZOlK+3s/DTU6rcL0RgS
         QRRcVz33uTW9GDVZqOzjArlQlx+rBE4lOtwfFtWPJja9NueP9cA63LpDVl0L1W9q1gIG
         igiYQMpzlqZ6Z9DIzjegQ2U1pdXLiVplf3Ss5NEEmaZTH0wpljoWaocw13M3jxVc+2v9
         gVoxqQNuupk8JSBla7T/nOS/WjfUILz+EAvFMtkXXwBw6VtsEvbbWdQdJzMv0wiaDrPi
         wcs+dHW0gYfpYkNkOw+A9e5IUxZNlahjdL5Nh2HX66nRKfMW39eKUE07Vkas1ypAMOFZ
         TbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RdUZszUoRKky8NvIk124GtZHPfeOOpksA+eMKXZrPwo=;
        b=KVhtih9l6R4hkWAcS7RpKrIXLudPr6h7VLNrDeXo/Sqrc8VTKDAp4pLxfK23w1HaIp
         5gDJ9CBl9fDa+/7T/tX3Q/u5sEcrI9DI4jVnpi+Ly2lC2GmcUhVVBOvL+kE4IIVAWdpZ
         MDznY500+SIkRdJ7nhAzku3RmKxZu69dL1M0dFjmgynHazPiXXwn+zK4BGtMpMlnp0rh
         Y989yGOpgMceclXDxXTrHHYaji7CYYkVruJ5yhSm8qO3iZg+A+46I9wSDRkE1TB1Q5oz
         XSQLoru+1ewF9//YT6qB7SopuWt7Wzwrn1KYZVk2ZqkzG2KjwXz40hcixV68P7H6LLlV
         wSrw==
X-Gm-Message-State: APjAAAVByH144eLcejNCu6QL1wWfcnbgEnUzt01VvtL3bOfiOMq/TwlJ
        2me5/aihGxZQalKJjTFJppKyPQ==
X-Google-Smtp-Source: APXvYqy1nMwySTpCErvAhcO5hy8YL+6y5ALh6683X73aqbdKLCwKk6/+h9VTHjQF/qdjhuIuLtpI9g==
X-Received: by 2002:ac8:4b7c:: with SMTP id g28mr8226012qts.180.1581095174601;
        Fri, 07 Feb 2020 09:06:14 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l184sm1544219qkc.107.2020.02.07.09.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Feb 2020 09:06:13 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     elver@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/swapfile: fix and annotate various data races
Date:   Fri,  7 Feb 2020 12:06:03 -0500
Message-Id: <1581095163-12198-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

swap_info_struct si.highest_bit, si.swap_map[offset] and si.flags could
be accessed concurrently separately as noticed by KCSAN,

=== si.highest_bit ===

 write to 0xffff8d5abccdc4d4 of 4 bytes by task 5353 on cpu 24:
  swap_range_alloc+0x81/0x130
  swap_range_alloc at mm/swapfile.c:681
  scan_swap_map_slots+0x371/0xb90
  get_swap_pages+0x39d/0x5c0
  get_swap_page+0xf2/0x524
  add_to_swap+0xe4/0x1c0
  shrink_page_list+0x1795/0x2870
  shrink_inactive_list+0x316/0x880
  shrink_lruvec+0x8dc/0x1380
  shrink_node+0x317/0xd80
  do_try_to_free_pages+0x1f7/0xa10
  try_to_free_pages+0x26c/0x5e0
  __alloc_pages_slowpath+0x458/0x1290

 read to 0xffff8d5abccdc4d4 of 4 bytes by task 6672 on cpu 70:
  scan_swap_map_slots+0x4a6/0xb90
  scan_swap_map_slots at mm/swapfile.c:892
  get_swap_pages+0x39d/0x5c0
  get_swap_page+0xf2/0x524
  add_to_swap+0xe4/0x1c0
  shrink_page_list+0x1795/0x2870
  shrink_inactive_list+0x316/0x880
  shrink_lruvec+0x8dc/0x1380
  shrink_node+0x317/0xd80
  do_try_to_free_pages+0x1f7/0xa10
  try_to_free_pages+0x26c/0x5e0
  __alloc_pages_slowpath+0x458/0x1290

 Reported by Kernel Concurrency Sanitizer on:
 CPU: 70 PID: 6672 Comm: oom01 Tainted: G        W    L 5.5.0-next-20200205+ #3
 Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019

=== si.swap_map[offset] ===

 write to 0xffffbc370c29a64c of 1 bytes by task 6856 on cpu 86:
  __swap_entry_free_locked+0x8c/0x100
  __swap_entry_free_locked at mm/swapfile.c:1209 (discriminator 4)
  __swap_entry_free.constprop.20+0x69/0xb0
  free_swap_and_cache+0x53/0xa0
  unmap_page_range+0x7f8/0x1d70
  unmap_single_vma+0xcd/0x170
  unmap_vmas+0x18b/0x220
  exit_mmap+0xee/0x220
  mmput+0x10e/0x270
  do_exit+0x59b/0xf40
  do_group_exit+0x8b/0x180

 read to 0xffffbc370c29a64c of 1 bytes by task 6855 on cpu 20:
  _swap_info_get+0x81/0xa0
  _swap_info_get at mm/swapfile.c:1140
  free_swap_and_cache+0x40/0xa0
  unmap_page_range+0x7f8/0x1d70
  unmap_single_vma+0xcd/0x170
  unmap_vmas+0x18b/0x220
  exit_mmap+0xee/0x220
  mmput+0x10e/0x270
  do_exit+0x59b/0xf40
  do_group_exit+0x8b/0x180

=== si.flags ===

 write to 0xffff956c8fc6c400 of 8 bytes by task 6087 on cpu 23:
  scan_swap_map_slots+0x6fe/0xb50
  scan_swap_map_slots at mm/swapfile.c:887
  get_swap_pages+0x39d/0x5c0
  get_swap_page+0x377/0x524
  add_to_swap+0xe4/0x1c0
  shrink_page_list+0x1795/0x2870
  shrink_inactive_list+0x316/0x880
  shrink_lruvec+0x8dc/0x1380
  shrink_node+0x317/0xd80
  do_try_to_free_pages+0x1f7/0xa10
  try_to_free_pages+0x26c/0x5e0
  __alloc_pages_slowpath+0x458/0x1290

 read to 0xffff956c8fc6c400 of 8 bytes by task 6207 on cpu 63:
  _swap_info_get+0x41/0xa0
  __swap_info_get at mm/swapfile.c:1114
  put_swap_page+0x84/0x490
  __remove_mapping+0x384/0x5f0
  shrink_page_list+0xff1/0x2870
  shrink_inactive_list+0x316/0x880
  shrink_lruvec+0x8dc/0x1380
  shrink_node+0x317/0xd80
  do_try_to_free_pages+0x1f7/0xa10
  try_to_free_pages+0x26c/0x5e0
  __alloc_pages_slowpath+0x458/0x1290

The writes are under si->lock but the reads are not. For si.highest_bit
and si.swap_map[offset], data race could trigger logic bugs, so fix them
by having WRITE_ONCE() for the writes and READ_ONCE() for the reads
except those isolated reads where they compare against zero which a data
race would cause no harm. Thus, annotate them as intentional data races
using the data_race() macro.

For si.flags, the readers are only interested in a single bit where a
data race there would cause no issue there.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/swapfile.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2c33ff456ed5..8178db2b9873 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -678,7 +678,7 @@ static void swap_range_alloc(struct swap_info_struct *si, unsigned long offset,
 	if (offset == si->lowest_bit)
 		si->lowest_bit += nr_entries;
 	if (end == si->highest_bit)
-		si->highest_bit -= nr_entries;
+		WRITE_ONCE(si->highest_bit, si->highest_bit - nr_entries);
 	si->inuse_pages += nr_entries;
 	if (si->inuse_pages == si->pages) {
 		si->lowest_bit = si->max;
@@ -710,7 +710,7 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	if (end > si->highest_bit) {
 		bool was_full = !si->highest_bit;
 
-		si->highest_bit = end;
+		WRITE_ONCE(si->highest_bit, end);
 		if (was_full && (si->flags & SWP_WRITEOK))
 			add_to_avail_list(si);
 	}
@@ -843,7 +843,7 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 		else
 			goto done;
 	}
-	si->swap_map[offset] = usage;
+	WRITE_ONCE(si->swap_map[offset], usage);
 	inc_cluster_info_page(si, si->cluster_info, offset);
 	unlock_cluster(ci);
 
@@ -889,12 +889,13 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 
 scan:
 	spin_unlock(&si->lock);
-	while (++offset <= si->highest_bit) {
-		if (!si->swap_map[offset]) {
+	while (++offset <= READ_ONCE(si->highest_bit)) {
+		if (data_race(!si->swap_map[offset])) {
 			spin_lock(&si->lock);
 			goto checks;
 		}
-		if (vm_swap_full() && si->swap_map[offset] == SWAP_HAS_CACHE) {
+		if (vm_swap_full() &&
+		    READ_ONCE(si->swap_map[offset]) == SWAP_HAS_CACHE) {
 			spin_lock(&si->lock);
 			goto checks;
 		}
@@ -905,11 +906,12 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 	}
 	offset = si->lowest_bit;
 	while (offset < scan_base) {
-		if (!si->swap_map[offset]) {
+		if (data_race(!si->swap_map[offset])) {
 			spin_lock(&si->lock);
 			goto checks;
 		}
-		if (vm_swap_full() && si->swap_map[offset] == SWAP_HAS_CACHE) {
+		if (vm_swap_full() &&
+		    READ_ONCE(si->swap_map[offset]) == SWAP_HAS_CACHE) {
 			spin_lock(&si->lock);
 			goto checks;
 		}
@@ -1111,7 +1113,7 @@ static struct swap_info_struct *__swap_info_get(swp_entry_t entry)
 	p = swp_swap_info(entry);
 	if (!p)
 		goto bad_nofile;
-	if (!(p->flags & SWP_USED))
+	if (data_race(!(p->flags & SWP_USED)))
 		goto bad_device;
 	offset = swp_offset(entry);
 	if (offset >= p->max)
@@ -1137,7 +1139,7 @@ static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
 	p = __swap_info_get(entry);
 	if (!p)
 		goto out;
-	if (!p->swap_map[swp_offset(entry)])
+	if (data_race(!p->swap_map[swp_offset(entry)]))
 		goto bad_free;
 	return p;
 
@@ -1206,7 +1208,10 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
 	}
 
 	usage = count | has_cache;
-	p->swap_map[offset] = usage ? : SWAP_HAS_CACHE;
+	if (usage)
+		WRITE_ONCE(p->swap_map[offset], usage);
+	else
+		WRITE_ONCE(p->swap_map[offset], SWAP_HAS_CACHE);
 
 	return usage;
 }
@@ -1258,7 +1263,7 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
 		goto bad_nofile;
 
 	rcu_read_lock();
-	if (!(si->flags & SWP_VALID))
+	if (data_race(!(si->flags & SWP_VALID)))
 		goto unlock_out;
 	offset = swp_offset(entry);
 	if (offset >= si->max)
@@ -3436,7 +3441,7 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
 	} else
 		err = -ENOENT;			/* unused swap entry */
 
-	p->swap_map[offset] = count | has_cache;
+	WRITE_ONCE(p->swap_map[offset], count | has_cache);
 
 unlock_out:
 	unlock_cluster_or_swap_info(p, ci);
-- 
1.8.3.1

