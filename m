Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F3BC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 22:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CFC214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 22:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Tv72J/MJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgBGWb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 17:31:28 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45799 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgBGWb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 17:31:28 -0500
Received: by mail-qt1-f194.google.com with SMTP id d9so605757qte.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 14:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=f6HrDmuf4aCREtfI6DUuWK8pfybhsb7D5BH5pspKyPk=;
        b=Tv72J/MJwujqp0CyIrTDNsoH+54HegKcOn+RHnsC5TlvgsLRf4jCsB5leiSZHJg7Cr
         VSDA8UkPPGh4zcciKum6uTLWtePioMS8S+rfazU0YCz2Lqbm14j2cse5sYkvzrcqhcex
         fbiW/C6Ww/JdxnpVMAKF5tNtdyWxPYj52irA52Sbq4Sn9u0MtAWOWx8BctuUAWaUoH0F
         zzr3Gu2/9i0H8cDaB4zFd82BFB/OvhfCE1BTi4F6L2Ov4BJ6y8PGSE/PZSonkJd2Cbqa
         qGg0RKOgw6G+/CEnjGYXRBkqU2iELJoXrS84zIgV9jeH18mb9i/vnwD5l7k9+UbOwa2J
         mtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f6HrDmuf4aCREtfI6DUuWK8pfybhsb7D5BH5pspKyPk=;
        b=GsIEFVIIQt+h0ygfy1TTobaJoe44suNai2ED+bZoH63MUfs7BbKPt0Jo02q2+YNgVh
         Co18R1ZnetrcrsEKqf5Z+vafbMh0xJuuH96LM5DQ6TTYa92zu24svtvP+nF/vZ8Wgtg7
         rr7gW/dYdvMwgh3rpO4qq8CkRdoZq7OWZFLyzVDBHGygmlIG9R3imZnrB8Aai0hYIfkm
         VdhCUaNhCMpNQcViwm2Nrju5QpmQ/Ias1em+KYl8rIUgxwq86CkGefRxyjK7torpP110
         xi8SSRJRlz1/QYjEYvlnWdxOprwg8F8xREBb4CFm0wy0j4hdr96YPZ72inAYHmJqWEbj
         PTSg==
X-Gm-Message-State: APjAAAUtKqJaahqFDyyQdLH5HF09E0VZcVP4xKQdnQVN96YQ++xSMsC9
        iE590CrVCx+pCofGl8UKxdT9rL1EiL89Qw==
X-Google-Smtp-Source: APXvYqxKnwnODtpetfHQiWE90sgaIt6GjS/EYYakURQKqcM+dQhiT3VbONwdjO2Lsj5yRqnLB1dE9w==
X-Received: by 2002:aed:2bc2:: with SMTP id e60mr564770qtd.115.1581114687351;
        Fri, 07 Feb 2020 14:31:27 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x4sm1994873qkx.33.2020.02.07.14.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Feb 2020 14:31:26 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     elver@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/list_lru: fix a data race in list_lru_count_one
Date:   Fri,  7 Feb 2020 17:31:19 -0500
Message-Id: <1581114679-5488-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct list_lru_one l.nr_items could be accessed concurrently as noticed
by KCSAN,

 BUG: KCSAN: data-race in list_lru_count_one / list_lru_isolate_move

 write to 0xffffa102789c4510 of 8 bytes by task 823 on cpu 39:
  list_lru_isolate_move+0xf9/0x130
  list_lru_isolate_move at mm/list_lru.c:180
  inode_lru_isolate+0x12b/0x2a0
  __list_lru_walk_one+0x122/0x3d0
  list_lru_walk_one+0x75/0xa0
  prune_icache_sb+0x8b/0xc0
  super_cache_scan+0x1b8/0x250
  do_shrink_slab+0x256/0x6d0
  shrink_slab+0x41b/0x4a0
  shrink_node+0x35c/0xd80
  balance_pgdat+0x652/0xd90
  kswapd+0x396/0x8d0
  kthread+0x1e0/0x200
  ret_from_fork+0x27/0x50

 read to 0xffffa102789c4510 of 8 bytes by task 6345 on cpu 56:
  list_lru_count_one+0x116/0x2f0
  list_lru_count_one at mm/list_lru.c:193
  super_cache_count+0xe8/0x170
  do_shrink_slab+0x95/0x6d0
  shrink_slab+0x41b/0x4a0
  shrink_node+0x35c/0xd80
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

 Reported by Kernel Concurrency Sanitizer on:
 CPU: 56 PID: 6345 Comm: oom01 Tainted: G        W    L 5.5.0-next-20200205+ #4
 Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019

A shattered l.nr_items could affect the shrinker behaviour due to a data
race. Fix it by adding READ_ONCE() for the read. Since the writes are
aligned and up to word-size, assume those are safe from data races to
avoid readability issues of writing WRITE_ONCE(var, var + val).

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/list_lru.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 0f1f6b06b7f3..249468d06b9c 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -190,7 +190,7 @@ unsigned long list_lru_count_one(struct list_lru *lru,
 
 	rcu_read_lock();
 	l = list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
-	count = l->nr_items;
+	count = READ_ONCE(l->nr_items);
 	rcu_read_unlock();
 
 	return count;
-- 
1.8.3.1

