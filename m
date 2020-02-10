Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E80C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD7520715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="P71NqZwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgBJRAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:00:45 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:43386 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJRAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:00:45 -0500
Received: by mail-qv1-f65.google.com with SMTP id p2so3482934qvo.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 09:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tDzjX5yb/FnpEzDqhJGtzVk0lEjmLNCz+7d6psCMd5o=;
        b=P71NqZwmSzuCdzx2tb34ueZZ/UqgiDtVWNB9ymBVjnvu0WwfyP99JP8UEOhnrJQ6Uq
         AOdQA1v5UyaVgjwPWJNL7cA07ZglpPk201Zci7I6Cjxqf140+sMOSEMAqy9pyhtUM8ch
         rzlhO1ty/E8koJ79hoEN/wlRQgHlDyCHwQpvpY4sySfZe7I5V4kY6iTFmhpNrhyA1Z/6
         Cd4qWBDDtcY+VfHybe8XbOwRNn2aFNwXS+I2E3PmbrqhTTDUIJyRqfsVMy60XtATzt5o
         2s3Fe5EIAxZ9k6Qq/IFyQO/UhkqAoHGeybQ9cdKgPGSP3edtrYQ3MUWJAP2RnyGjdlGI
         05Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tDzjX5yb/FnpEzDqhJGtzVk0lEjmLNCz+7d6psCMd5o=;
        b=NMf8h15/zOrO1JQzQFLiwOesSRTjpeN/6iYJMuZZLcpV8P+Xui0jwfvXClRMl1q6Qh
         O3tvM8ZjrtTLRGKnX+ZGqoc3rODhFUzlpj3nQWvVFLQ4rjp6uYYOgcOMYBEb6YbWzgcR
         3CJ6xmaZQ/tMG5FH6z7x+0fnYzkBhHYfVxOlfALiCBqFwLuBCa8I/G4YDKvSBY2sa0A+
         yyu7gDkEUFrVC/My4FpMOa5u51KrFLw1ouSONSj16Zu8d2EIUcqGZqx2sSkQ+sRLK0/3
         wrKiFUQOsssBXtn6aZXDP/57KSFmyhA8cZ+KilH1qDsbaGi/0mLEo6UuSlZasGdJ5v5v
         t8BA==
X-Gm-Message-State: APjAAAUZkMNZ8ZT1Y4JHTGKDpW/vZG7UiWF2mxJKWFaVv5bYGSrLszWk
        oO+bUX5nsxGCrV2FeiLMaKqzHg==
X-Google-Smtp-Source: APXvYqzSX3FsN7O6e1AgBOQKWgbQ+6aGfCZV35s07hH/ofSVdWBOXPQ9wgQk8v33u160/lAvyaqwpw==
X-Received: by 2002:a05:6214:1267:: with SMTP id r7mr10932258qvv.160.1581354044600;
        Mon, 10 Feb 2020 09:00:44 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id r1sm442348qtu.83.2020.02.10.09.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Feb 2020 09:00:43 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     elver@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/filemap: fix a data race in filemap_fault()
Date:   Mon, 10 Feb 2020 12:00:29 -0500
Message-Id: <1581354029-20154-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct file_ra_state ra.mmap_miss could be accessed concurrently during
page faults as noticed by KCSAN,

 BUG: KCSAN: data-race in filemap_fault / filemap_map_pages

 write to 0xffff9b1700a2c1b4 of 4 bytes by task 3292 on cpu 30:
  filemap_fault+0x920/0xfc0
  do_sync_mmap_readahead at mm/filemap.c:2384
  (inlined by) filemap_fault at mm/filemap.c:2486
  __xfs_filemap_fault+0x112/0x3e0 [xfs]
  xfs_filemap_fault+0x74/0x90 [xfs]
  __do_fault+0x9e/0x220
  do_fault+0x4a0/0x920
  __handle_mm_fault+0xc69/0xd00
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

 read to 0xffff9b1700a2c1b4 of 4 bytes by task 3313 on cpu 32:
  filemap_map_pages+0xc2e/0xd80
  filemap_map_pages at mm/filemap.c:2625
  do_fault+0x3da/0x920
  __handle_mm_fault+0xc69/0xd00
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

 Reported by Kernel Concurrency Sanitizer on:
 CPU: 32 PID: 3313 Comm: systemd-udevd Tainted: G        W    L 5.5.0-next-20200210+ #1
 Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019

ra.mmap_miss is used to contribute the readahead decisions, a data race
could be undesirable. Since the stores are aligned and less than
word-size, assume they are safe. Thus, fixing it by adding READ_ONCE()
for the loads except those places comparing to zero where they are safe.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/filemap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 1784478270e1..b6c1d37f7ea3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2380,14 +2380,14 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	}
 
 	/* Avoid banging the cache line if not needed */
-	if (ra->mmap_miss < MMAP_LOTSAMISS * 10)
+	if (READ_ONCE(ra->mmap_miss) < MMAP_LOTSAMISS * 10)
 		ra->mmap_miss++;
 
 	/*
 	 * Do we miss much more than hit in this file? If so,
 	 * stop bothering with read-ahead. It will only hurt.
 	 */
-	if (ra->mmap_miss > MMAP_LOTSAMISS)
+	if (READ_ONCE(ra->mmap_miss) > MMAP_LOTSAMISS)
 		return fpin;
 
 	/*
@@ -2418,7 +2418,7 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	/* If we don't want any read-ahead, don't bother */
 	if (vmf->vma->vm_flags & VM_RAND_READ)
 		return fpin;
-	if (ra->mmap_miss > 0)
+	if (data_race(ra->mmap_miss > 0))
 		ra->mmap_miss--;
 	if (PageReadahead(page)) {
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
@@ -2622,7 +2622,7 @@ void filemap_map_pages(struct vm_fault *vmf,
 		if (page->index >= max_idx)
 			goto unlock;
 
-		if (file->f_ra.mmap_miss > 0)
+		if (data_race(file->f_ra.mmap_miss > 0))
 			file->f_ra.mmap_miss--;
 
 		vmf->address += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
-- 
1.8.3.1

