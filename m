Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EFAC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F652064C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="DKhRjstW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgA2Kwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:52:36 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:44424 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgA2Kwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 05:52:35 -0500
Received: by mail-qv1-f66.google.com with SMTP id n8so7751425qvg.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 02:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8HkYUIvWOezC0v9NUiQvjyLeLXue41vWGlRjf5Gh4Qc=;
        b=DKhRjstWsgyVPPC0+8k699sVyJG9i4rGYVSw2/cXxQwfOub9SBfGcpKLwELrH5GhcH
         p0/BbJmNkT5NrA95atCLbZXHNLLQHoa2OJAoiJD8aDBGPxoqgrghg4VqUIF1L1FJ4tCy
         CyZl0Z6KnQf0jhuXLf3P+VpZEzks+bJ7EOC5PcGE2WP+/LbgF0UGrdXQAMH+kGIePqJ8
         55nd9F3cC105PkigbKMngIDCyUGM14hkf+UH9OY7h/4NDCeCAPK3ErLj+IeyWEz/VH2G
         vOfcqtjKoCTi3dARGYowIV1XjCfOBs/1hzei9baoDkq7S6x77L901CSK2VeykDz4Jx10
         3Bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8HkYUIvWOezC0v9NUiQvjyLeLXue41vWGlRjf5Gh4Qc=;
        b=H1GprQAUIxqXjzkTEJoHKvjH/w/80EsJcJwkbsAZG2g1stWLR2iIj3bzkj+fdGZCLs
         wUr2kV8+CsfubHe8y3a/b4BITd6yVA5yhTUoBNmnx6RUDyemRHALP9FJYSjZhzBdq495
         KtHU0oA5I8+6m14jXiqELx+nAoZThI3u7H942C/CsYJGmqEqMTfsEelUMDeBkQL7bbV1
         BsQV9Ed8fJsPHyZ5Evj3bkqgrtyZtbhbghZSory+cnk0d+ddD+NLBFMaczQfEeEx/Nif
         ZRaXHPINc5yB/sXeE7aPYKcMysbwvxJaonlRzm/xg9BYx9+xk3xsRC0Vsv2f2SoZd0Ns
         Llhw==
X-Gm-Message-State: APjAAAX1JA6NkOpRifCrbiA/ZuBINtN7lWXm9zg+odIfJfIgx7VbjKPJ
        RdZ3nkSVCRCpzUz52tggNY8lRA==
X-Google-Smtp-Source: APXvYqy1woZdF7zW7v1V674PosCNrOoNkrQqAXmAtm63gS86urtUje052UtvMRAufBNIRcW0ngOhJg==
X-Received: by 2002:ad4:518b:: with SMTP id b11mr27603196qvp.195.1580295154750;
        Wed, 29 Jan 2020 02:52:34 -0800 (PST)
Received: from ovpn-120-127.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id f11sm744574qkh.96.2020.01.29.02.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 02:52:34 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/page_counter: fix various data races
Date:   Wed, 29 Jan 2020 05:52:24 -0500
Message-Id: <20200129105224.4016-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 3e32cb2e0a12 ("mm: memcontrol: lockless page counters") could
had memcg->memsw->watermark been accessed concurrently as reported by
KCSAN,

 Reported by Kernel Concurrency Sanitizer on:
 BUG: KCSAN: data-race in page_counter_try_charge / page_counter_try_charge

 read to 0xffff8fb18c4cd190 of 8 bytes by task 1081 on cpu 59:
  page_counter_try_charge+0x4d/0x150 mm/page_counter.c:138
  try_charge+0x131/0xd50 mm/memcontrol.c:2405
  __memcg_kmem_charge_memcg+0x58/0x140
  __memcg_kmem_charge+0xcc/0x280
  __alloc_pages_nodemask+0x1e1/0x450
  alloc_pages_current+0xa6/0x120
  pte_alloc_one+0x17/0xd0
  __pte_alloc+0x3a/0x1f0
  copy_p4d_range+0xc36/0x1990
  copy_page_range+0x21d/0x360
  dup_mmap+0x5f5/0x7a0
  dup_mm+0xa2/0x240
  copy_process+0x1b3f/0x3460
  _do_fork+0xaa/0xa20
  __x64_sys_clone+0x13b/0x170
  do_syscall_64+0x91/0xb47
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

 write to 0xffff8fb18c4cd190 of 8 bytes by task 1153 on cpu 120:
  page_counter_try_charge+0x5b/0x150 mm/page_counter.c:139
  try_charge+0x131/0xd50 mm/memcontrol.c:2405
  mem_cgroup_try_charge+0x159/0x460
  mem_cgroup_try_charge_delay+0x3d/0xa0
  wp_page_copy+0x14d/0x930
  do_wp_page+0x107/0x7b0
  __handle_mm_fault+0xce6/0xd40
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

Since watermark could be compared or set to garbage due to load or
store tearing which would change the code logic, fix it by adding a pair
of READ_ONCE() and WRITE_ONCE() in those places.

Fixes: 3e32cb2e0a12 ("mm: memcontrol: lockless page counters")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/page_counter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/page_counter.c b/mm/page_counter.c
index de31470655f6..a17841150906 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -82,8 +82,8 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
 		 * This is indeed racy, but we can live with some
 		 * inaccuracy in the watermark.
 		 */
-		if (new > c->watermark)
-			c->watermark = new;
+		if (new > READ_ONCE(c->watermark))
+			WRITE_ONCE(c->watermark, new);
 	}
 }
 
@@ -135,8 +135,8 @@ bool page_counter_try_charge(struct page_counter *counter,
 		 * Just like with failcnt, we can live with some
 		 * inaccuracy in the watermark.
 		 */
-		if (new > c->watermark)
-			c->watermark = new;
+		if (new > READ_ONCE(c->watermark))
+			WRITE_ONCE(c->watermark, new);
 	}
 	return true;
 
-- 
2.21.0 (Apple Git-122.2)

