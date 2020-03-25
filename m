Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBBDC54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C68C2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="hUPBtEbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgCYP4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:56:04 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35760 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgCYP4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:56:03 -0400
Received: by mail-qt1-f196.google.com with SMTP id e14so2587041qts.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 08:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5LjboPnDfMYr+D+3numlwyKRNovhORGQjxZDfSq6m9Y=;
        b=hUPBtEbERszA+YII5Yxm3jnhf4gWvrQeMIUx7nRUKWsaVY/hTEbkcVwZ824Se5rjur
         x16y9PSdBsh167UfAZB5rT8bdfE8B41JnUCsPalmpfBxfrdDF/j6w9juDr9y/qiY8f1h
         pNQfeGBclLRBzT/fGnw6z3HBUlqE3UAo1M36/bqz9zfViGSlGkvioTbJiS2pCU7VlNop
         OQdFs/PIbIFnGIxs+zlMC8scqnUkRuWE0TWt3fVrW/7JpC5dxhnn5niw6m4tH5ntSp8s
         qpps1r0bF2/oiW3GuFKkRAgQUlhbibiMzAZHDiUoxY2kjLYpzPOqOSgyvIRDqfhyupYy
         4Vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5LjboPnDfMYr+D+3numlwyKRNovhORGQjxZDfSq6m9Y=;
        b=SuH0sbLIYT1Zh6V9of6T1LiLf62EUAQKU2q9r8NcRWB+vm/osRDkZLyQ16+t8syjtJ
         f8INOGwEx6qDJjVnJFun5GSxgOgeHuOd9d64vBl+qU/MSmAOOwVwtTzjTjNGE+a2cdPJ
         CosjNJoXnA42KRbgZ4bJ5N1SiEHE0xM3cXu7U9/HyE/nXjjzunOOJj+ERlRrD9T+QDdR
         s/F8z0NpN8KTim8PxoZc5wfrUk0SFY9i770LGhRSPO5t3CqvGMt7nRUFjW9QwgjKlgPK
         MNxYJLUAC1arGvoDbAfkxpuTczR/bJU1/C6URLUzu9TyBLVj94UYU/19X+hrRhgpAF7o
         skFA==
X-Gm-Message-State: ANhLgQ14bnqHn4+meIQZExP6/fcaX9SrnJIarwc25harY6wVLhZIGzS/
        NZJjT+p0yTiiLcqSapdi8x3ItA==
X-Google-Smtp-Source: ADFU+vsnGtXHOB3Q1SbOrengVFBDEEpEz+h2e/kMJ6fU6G+kU2YhLUoG6gF8c+vYKIE7feOWLDUscQ==
X-Received: by 2002:ac8:346f:: with SMTP id v44mr3526427qtb.205.1585151761950;
        Wed, 25 Mar 2020 08:56:01 -0700 (PDT)
Received: from ovpn-66-69.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id t23sm17931750qtj.63.2020.03.25.08.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 08:55:47 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     davem@davemloft.net
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] ipv4: fix a RCU-list lock in fib_triestat_seq_show
Date:   Wed, 25 Mar 2020 11:55:32 -0400
Message-Id: <20200325155532.7238-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fib_triestat_seq_show() calls hlist_for_each_entry_rcu(tb, head,
tb_hlist) without rcu_read_lock() will trigger a warning,

 net/ipv4/fib_trie.c:2579 RCU-list traversed in non-reader section!!

 other info that might help us debug this:

 rcu_scheduler_active = 2, debug_locks = 1
 1 lock held by proc01/115277:
  #0: c0000014507acf00 (&p->lock){+.+.}-{3:3}, at: seq_read+0x58/0x670

 Call Trace:
  dump_stack+0xf4/0x164 (unreliable)
  lockdep_rcu_suspicious+0x140/0x164
  fib_triestat_seq_show+0x750/0x880
  seq_read+0x1a0/0x670
  proc_reg_read+0x10c/0x1b0
  __vfs_read+0x3c/0x70
  vfs_read+0xac/0x170
  ksys_read+0x7c/0x140
  system_call+0x5c/0x68

Signed-off-by: Qian Cai <cai@lca.pw>
---
 net/ipv4/fib_trie.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index ff0c24371e33..73fa37476f03 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -2577,6 +2577,7 @@ static int fib_triestat_seq_show(struct seq_file *seq, void *v)
 		   " %zd bytes, size of tnode: %zd bytes.\n",
 		   LEAF_SIZE, TNODE_SIZE(0));
 
+	rcu_read_lock();
 	for (h = 0; h < FIB_TABLE_HASHSZ; h++) {
 		struct hlist_head *head = &net->ipv4.fib_table_hash[h];
 		struct fib_table *tb;
@@ -2597,6 +2598,7 @@ static int fib_triestat_seq_show(struct seq_file *seq, void *v)
 #endif
 		}
 	}
+	rcu_read_unlock();
 
 	return 0;
 }
-- 
2.21.0 (Apple Git-122.2)

