Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3D1C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 21:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25D42080C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 21:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YgzqnuhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389181AbgDBViD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 17:38:03 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46466 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389053AbgDBViC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 17:38:02 -0400
Received: by mail-qk1-f196.google.com with SMTP id u4so5825843qkj.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 14:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cXvGhQMH9Vx0ak5zGbNVG7SuHBMJvgZJzZWL2gwidSE=;
        b=YgzqnuhVS/9Pv0RDCjSmk23dnZpqYA+AyTuRejhv6/hM69BKW0V5OYzqFCjniF3duL
         ZYjiGyglbd2Ni1AsAYrBLJehkbAp3KFuocDi8omhJ7mvU/PblZsAPnWJMUmg1T2QjJUW
         XBaZeVR5sTk62UpwIQeoy4T6OwzXH1aXKLrbHIQ6Y9euomjTM0xhbPmmFuvAlwnsfWrt
         I19sSGRUlsBG8E6qvbuuKK8IMlTQK9AJMqHB3RV8hvSDCV05dh5Du2OPIJds3C89r+Qj
         btzDg01cuLxsIzY7q9jGkKnR54oklumdlNwTe7dqi2F7VXQiqSt9bf9SdSmAqb6I9LD2
         D3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cXvGhQMH9Vx0ak5zGbNVG7SuHBMJvgZJzZWL2gwidSE=;
        b=qGFqnbvkG2o07YvQLqneScBeELHHzXGkX7rEGL85yqEvw/F/0oXba3/KDlz4lgHQfL
         rR2BwZdnR6Uq1EznxijV5sIkyLbksJTWw73n3syRIeXTVh3InjgyVGqa6AxCNREViBe8
         MKnDhXIvq0i8Vxvs95V6rmjNGDBu1RTtAjnTQ9/WpzTJZKD3ETGzLCOL00RiMWEk3xYv
         HpH1iW93b0mF5L4zLMtjmBTv+dJq1zL1z17TED4dli+rUrPyPMZo+yZmAn8FDGZCY+6m
         x0H32+DB9TtAJDjGZG1Ni/hZE69Of38n5A01xmK1pED/nmMlcf3EtrWUmylNKQtLDVV9
         8o4w==
X-Gm-Message-State: AGi0PubhgMxYCTZ5jd79nsdzjDAj316FRgWNmi+INBZ1bcPSNd75tSVJ
        q2FIUMGphvBAsdtf4ys/78caq55Gi/6vrw==
X-Google-Smtp-Source: APiQypIescbweWxgN5CO2J7PzYNY6ucYDGV4Cet9EzI8GljZlGtZfCU3VFb/dajM8zPsH1KHJ4cbVg==
X-Received: by 2002:a05:620a:16cc:: with SMTP id a12mr3777819qkn.340.1585863481283;
        Thu, 02 Apr 2020 14:38:01 -0700 (PDT)
Received: from ovpn-66-203.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 4sm4559792qkl.51.2020.04.02.14.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 14:38:00 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     elver@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/swap_state: fix a data race in swapin_nr_pages
Date:   Thu,  2 Apr 2020 17:37:48 -0400
Message-Id: <20200402213748.2237-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"prev_offset" is a static variable in swapin_nr_pages() that can be
accessed concurrently with only mmap_sem held in read mode as noticed by
KCSAN,

 BUG: KCSAN: data-race in swap_cluster_readahead / swap_cluster_readahead

 write to 0xffffffff92763830 of 8 bytes by task 14795 on cpu 17:
  swap_cluster_readahead+0x2a6/0x5e0
  swapin_readahead+0x92/0x8dc
  do_swap_page+0x49b/0xf20
  __handle_mm_fault+0xcfb/0xd70
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x715
  page_fault+0x34/0x40

 1 lock held by (dnf)/14795:
  #0: ffff897bd2e98858 (&mm->mmap_sem#2){++++}-{3:3}, at: do_page_fault+0x143/0x715
  do_user_addr_fault at arch/x86/mm/fault.c:1405
  (inlined by) do_page_fault at arch/x86/mm/fault.c:1535
 irq event stamp: 83493
 count_memcg_event_mm+0x1a6/0x270
 count_memcg_event_mm+0x119/0x270
 __do_softirq+0x365/0x589
 irq_exit+0xa2/0xc0

 read to 0xffffffff92763830 of 8 bytes by task 1 on cpu 22:
  swap_cluster_readahead+0xfd/0x5e0
  swapin_readahead+0x92/0x8dc
  do_swap_page+0x49b/0xf20
  __handle_mm_fault+0xcfb/0xd70
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x715
  page_fault+0x34/0x40

 1 lock held by systemd/1:
  #0: ffff897c38f14858 (&mm->mmap_sem#2){++++}-{3:3}, at: do_page_fault+0x143/0x715
 irq event stamp: 43530289
 count_memcg_event_mm+0x1a6/0x270
 count_memcg_event_mm+0x119/0x270
 __do_softirq+0x365/0x589
 irq_exit+0xa2/0xc0

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/swap_state.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index ebed37bbf7a3..8238954ae781 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -509,10 +509,11 @@ static unsigned long swapin_nr_pages(unsigned long offset)
 		return 1;
 
 	hits = atomic_xchg(&swapin_readahead_hits, 0);
-	pages = __swapin_nr_pages(prev_offset, offset, hits, max_pages,
+	pages = __swapin_nr_pages(READ_ONCE(prev_offset), offset, hits,
+				  max_pages,
 				  atomic_read(&last_readahead_pages));
 	if (!hits)
-		prev_offset = offset;
+		WRITE_ONCE(prev_offset, offset);
 	atomic_set(&last_readahead_pages, pages);
 
 	return pages;
-- 
2.21.0 (Apple Git-122.2)

