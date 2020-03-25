Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F205AC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 22:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64DC20719
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 22:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="WcbDqTsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbgCYWBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 18:01:10 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:45389 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbgCYWBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 18:01:10 -0400
Received: by mail-qv1-f65.google.com with SMTP id g4so1926499qvo.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 15:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2LRvU1MBkUR83Gqvgx7L+Y8Q4FBFbX8N5vp+5n4yg4Q=;
        b=WcbDqTsCMr/IAwnZN8MoX/dVXK1RBR6E9bZd8ICOvtz6cZoglcAGaTl705g0nhrOp8
         tZ6gQDXn0zF05An8BN6HQ6CjAGOnzk2EgErysPwvey8ehfgxQlcD9QVEmume+6aQ38pG
         wtyN32HhUV015KYPnNVRmQpJH2F6UwG7lP+YQMU/p+GGFshq9FWCXmHF/ZYCrvc+p2+R
         F7ta4az8XTEskx5SGmes2SL51S2CbFmlT8davsU7lIfct17FUr6Cpc9Q0tITcvlUswez
         ec2lE1gxRq2JkJ7xaTMy4Ub/tRRlIomDghBjRQWdRmn5hBPYYNFsSmeAKs52N055Ockb
         HGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2LRvU1MBkUR83Gqvgx7L+Y8Q4FBFbX8N5vp+5n4yg4Q=;
        b=QwkqIga4yrywzFL5ZiQUaarbCz//yZrwhO+YDHzAxSFTZc5I4puHYk421HSiIekTWq
         VSvNLPoBWzkEggvWquX4lGiHiXYjmQISGzmaU/lx9LNxEgECDSLZzUHhd9WBybhL19b9
         yTbp+LS6uDxblYB/QzhIEaJsyBnjLQYy7A3Wao4AGLGCTDLWlfTw/dbtYQ+9lBFvzmb8
         FYdg5DkOnQ3OXntQd5jbmfwbZ/+HDF+ncp82hTEAJgwXrIUOSQD7+o4PR7ONPYkDn7wb
         I2mTulG28NMyTgT2/IbBdfEKbL0G07rONZx+XaNbNcCZiXHPjC9uMHoC/9Nw2Ieq6quW
         PhIQ==
X-Gm-Message-State: ANhLgQ3AjvwaOlVfXxLYx7LdFCiOxidND70kxN/bJbFQRNYQb0KTbvpL
        Y1ElemiZZ6/dpZjnUiX1xmPnMQ==
X-Google-Smtp-Source: ADFU+vs7SuVQXXkdNRbBL1RUpn65JVCeZ4bdF/5nuV5w6WTVXfR1bgNyW6rTpZ9NHRfVC6aCgq347g==
X-Received: by 2002:a05:6214:11ec:: with SMTP id e12mr5359612qvu.89.1585173669264;
        Wed, 25 Mar 2020 15:01:09 -0700 (PDT)
Received: from ovpn-66-69.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l42sm205009qtf.51.2020.03.25.15.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 15:01:08 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     davem@davemloft.net
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, kuba@kernel.org,
        eric.dumazet@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v2] ipv4: fix a RCU-list lock in fib_triestat_seq_show
Date:   Wed, 25 Mar 2020 18:01:00 -0400
Message-Id: <20200325220100.7863-1-cai@lca.pw>
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

Fix it by adding a pair of rcu_read_lock/unlock() and use
cond_resched_rcu() to avoid the situation where walking of a large
number of items  may prevent scheduling for a long time.

Signed-off-by: Qian Cai <cai@lca.pw>
---

Use cond_resched_rcu() from Eric.

 net/ipv4/fib_trie.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index ff0c24371e33..3be0affbabd3 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -2577,6 +2577,7 @@ static int fib_triestat_seq_show(struct seq_file *seq, void *v)
 		   " %zd bytes, size of tnode: %zd bytes.\n",
 		   LEAF_SIZE, TNODE_SIZE(0));
 
+	rcu_read_lock();
 	for (h = 0; h < FIB_TABLE_HASHSZ; h++) {
 		struct hlist_head *head = &net->ipv4.fib_table_hash[h];
 		struct fib_table *tb;
@@ -2596,7 +2597,9 @@ static int fib_triestat_seq_show(struct seq_file *seq, void *v)
 			trie_show_usage(seq, t->stats);
 #endif
 		}
+		cond_resched_rcu();
 	}
+	rcu_read_unlock();
 
 	return 0;
 }
-- 
2.21.0 (Apple Git-122.2)

