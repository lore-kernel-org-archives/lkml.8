Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AFAC38BE2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97EE3218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YGDYAR/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgBXVPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:15:17 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40083 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgBXVPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:15:17 -0500
Received: by mail-qk1-f194.google.com with SMTP id b7so10022425qkl.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 13:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DnXw4rV9XlLkkel27q1Q4AsygHSvBzv4JLeZBnmaX8c=;
        b=YGDYAR/HjFbF3I8nfpGekdnfwZPxTEoGZg3FEWErtSuUFk/9u01yID2D7wXWWdGi0B
         GBY9bEmIAjHqjkwj7vpI7yOPmbOmx+x0VkhEcMXudKGlZW+S9o3dnKz96jgvRg3fA6w0
         ez/5vw08KiQN2+w7hgFTDoR9Sp5+VKw/OToCx10FwX1vi8kdKhn3iuc+ToOY7lF7gGFp
         C3ekvNjpjdOrhzpgRG4MO2+aRmm08gsEnZJ5dqmbn1efPaHkVvv+IppnQPkLg8wdVJs1
         BGydfyjsUaSlcoC6zzU2xzOr1GYr+nUKhZ958di+ImaxrgzCQgLE7bktx9l26ru2JXek
         if7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DnXw4rV9XlLkkel27q1Q4AsygHSvBzv4JLeZBnmaX8c=;
        b=uNta8U0a4iF0G2AQUNrpoCIQwBC4B+N/EITr3K+winDdjHTm1K2TQu/v+em7Lpvq2z
         Xrefpy1BEbIcwBmYGchrtfPCw93mDWKsZzr9cuy2CQx4mAY3zZ9KmpntHNJ2K6zdq00B
         tgVZfAzG6jxTx9me1HKR2ivpLiCIJdfPXLgDjrhoGvBgPDfBOpVF4EtnDQhY+WCJBcNW
         EF1ap1BTQEwFAeCOrSTNODulmtmq+An0zcHMKsfI3pvV5Kl1mZ42POD9uxP7546Xr6ye
         erCp6oKbjHvRbHsHgBN10//Bxtwz15UL8IhDmFPpM0ZNE109h+nOqc9ND529aleIi2uy
         Cz2g==
X-Gm-Message-State: APjAAAWzvkUzWIrOjwu+JUUFJ5JqA4DMADRq0pEaeqyJSHYS2DdM7yxE
        xIj+1Z0e8gwU+RP148yxtkNMNQ==
X-Google-Smtp-Source: APXvYqwGyW40OLcE8bLxFgI2b5iHxJI9XJfUFtphi6qAxsNl5flzorvxiNMu7+OD9FljkUR5jnDZsg==
X-Received: by 2002:a37:de0b:: with SMTP id h11mr51158132qkj.274.1582578915936;
        Mon, 24 Feb 2020 13:15:15 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 132sm6388381qkn.109.2020.02.24.13.15.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 13:15:14 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     elver@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/swapfile: fix data races in try_to_unuse()
Date:   Mon, 24 Feb 2020 16:15:03 -0500
Message-Id: <1582578903-29294-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

si->inuse_pages could be accessed concurrently as noticed by KCSAN,

 write to 0xffff98b00ebd04dc of 4 bytes by task 82262 on cpu 92:
  swap_range_free+0xbe/0x230
  swap_range_free at mm/swapfile.c:719
  swapcache_free_entries+0x1be/0x250
  free_swap_slot+0x1c8/0x220
  __swap_entry_free.constprop.19+0xa3/0xb0
  free_swap_and_cache+0x53/0xa0
  unmap_page_range+0x7e0/0x1ce0
  unmap_single_vma+0xcd/0x170
  unmap_vmas+0x18b/0x220
  exit_mmap+0xee/0x220
  mmput+0xe7/0x240
  do_exit+0x598/0xfd0
  do_group_exit+0x8b/0x180
  get_signal+0x293/0x13d0
  do_signal+0x37/0x5d0
  prepare_exit_to_usermode+0x1b7/0x2c0
  ret_from_intr+0x32/0x42

 read to 0xffff98b00ebd04dc of 4 bytes by task 82499 on cpu 46:
  try_to_unuse+0x86b/0xc80
  try_to_unuse at mm/swapfile.c:2185
  __x64_sys_swapoff+0x372/0xd40
  do_syscall_64+0x91/0xb05
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The plain reads in try_to_unuse() are outside si->lock critical section
which result in data races that could be dangerous to be used in a loop.
Fix them by adding READ_ONCE().

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/swapfile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index a65622eec66f..36fd1536a83d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2137,7 +2137,7 @@ int try_to_unuse(unsigned int type, bool frontswap,
 	swp_entry_t entry;
 	unsigned int i;
 
-	if (!si->inuse_pages)
+	if (!READ_ONCE(si->inuse_pages))
 		return 0;
 
 	if (!frontswap)
@@ -2153,7 +2153,7 @@ int try_to_unuse(unsigned int type, bool frontswap,
 
 	spin_lock(&mmlist_lock);
 	p = &init_mm.mmlist;
-	while (si->inuse_pages &&
+	while (READ_ONCE(si->inuse_pages) &&
 	       !signal_pending(current) &&
 	       (p = p->next) != &init_mm.mmlist) {
 
@@ -2182,7 +2182,7 @@ int try_to_unuse(unsigned int type, bool frontswap,
 	mmput(prev_mm);
 
 	i = 0;
-	while (si->inuse_pages &&
+	while (READ_ONCE(si->inuse_pages) &&
 	       !signal_pending(current) &&
 	       (i = find_next_to_unuse(si, i, frontswap)) != 0) {
 
@@ -2224,7 +2224,7 @@ int try_to_unuse(unsigned int type, bool frontswap,
 	 * been preempted after get_swap_page(), temporarily hiding that swap.
 	 * It's easy and robust (though cpu-intensive) just to keep retrying.
 	 */
-	if (si->inuse_pages) {
+	if (READ_ONCE(si->inuse_pages)) {
 		if (!signal_pending(current))
 			goto retry;
 		retval = -EINTR;
-- 
1.8.3.1

