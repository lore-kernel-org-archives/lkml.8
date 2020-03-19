Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CCCC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD3B20772
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="hzQ9Ozgc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgCSWL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 18:11:58 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:39480 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbgCSWLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 18:11:52 -0400
Received: by mail-qv1-f68.google.com with SMTP id v38so1955567qvf.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 15:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pzfdJRx1oF6jiIvR2C9U9rEyO4S41Htu1IVIdua7ZaQ=;
        b=hzQ9Ozgc3eHqxFwistOuYhvE2qISqi2ldxN1oF5OZ+DuD8DfcdzWGvcgWGprkU23gj
         1UrAGG5mtmeu8Ny9Y37Kse9f8a4kCaBCz0aSoNkKdnYn3siLeFx6MLWELNnnuT8m1T9H
         PDJj+UvFUPet3RDP2CoyTlY3ZYUGpcvTeC61TfEbnIh2Pr5n8nI3L0GgHxDdbFjEDZUe
         6L/mb6aqKD/4IIAJYjdcc/8zO6J3TWS/51gmh7UKYsbEW8n69IZ6EuD6XRdsZqnXxXx5
         FpkAUkxjm3IpfzXpjj6LUJ20seDXd++BpAQga6H5Ma/swI7kxBSMCEbzGjwVD21aqi4o
         FEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pzfdJRx1oF6jiIvR2C9U9rEyO4S41Htu1IVIdua7ZaQ=;
        b=kPWAMqIuK6zXnxZuwPM/lBjcOHi4vUxWR+fpZzKm7aRflD0KiLYNnaWLimNjk/g7qc
         zsOJP7vvSu4RyrZHmHONq64x0d/viwMnfRVhqD/bccIThKFc2bs/EaglRvm8CAvL6vp8
         8oABwABkIZbxhhhnVkVduARuzNZQ4A94oBhtlHOx7I4iHrz2ekRHvKSRVie24Sp5VNQS
         p/MflpM94NEMMkLUd9IK3e2jQwsbU3Did9OrN3v7hOl9u+q1yLTTo45zMt1Vkn8gsEw0
         rTXhCDiEDksuBbJXiGO2w/xG4zwqwJFRrsGQkCQsdZJT4s8NZe1XvFg066UvZIsmtgM/
         ihEA==
X-Gm-Message-State: ANhLgQ2xyxlg1o5CuLnzDLV9z/k38Y2fBUWcme2zVXMOvGDl4lcWLOA5
        7XNkzMgobKU7eM+1X+vS9JetjGF4TkjbcA==
X-Google-Smtp-Source: ADFU+vtSKBdVdLUNbDulH29r3gYb5+UBaLtQ+hKG13rkQbY88mxT+6kICnVtmSCjJ3pRmBBejOm5fA==
X-Received: by 2002:a0c:db86:: with SMTP id m6mr5133668qvk.116.1584655908780;
        Thu, 19 Mar 2020 15:11:48 -0700 (PDT)
Received: from ovpn-66-200.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m10sm2635693qte.71.2020.03.19.15.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 15:11:48 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     davem@davemloft.net
Cc:     alexander.h.duyck@linux.intel.com, kuznet@ms2.inr.ac.ru,
        kuba@kernel.org, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] ipv4: fix a RCU-list bug in inet_dump_fib()
Date:   Thu, 19 Mar 2020 18:11:41 -0400
Message-Id: <20200319221141.8814-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a place,

inet_dump_fib()
  fib_table_dump
    fn_trie_dump_leaf()
      hlist_for_each_entry_rcu()

without rcu_read_lock() triggers a warning,

 WARNING: suspicious RCU usage
 -----------------------------
 net/ipv4/fib_trie.c:2216 RCU-list traversed in non-reader section!!

 other info that might help us debug this:

 rcu_scheduler_active = 2, debug_locks = 1
 1 lock held by ip/1923:
  #0: ffffffff8ce76e40 (rtnl_mutex){+.+.}, at: netlink_dump+0xd6/0x840

 Call Trace:
  dump_stack+0xa1/0xea
  lockdep_rcu_suspicious+0x103/0x10d
  fn_trie_dump_leaf+0x581/0x590
  fib_table_dump+0x15f/0x220
  inet_dump_fib+0x4ad/0x5d0
  netlink_dump+0x350/0x840
  __netlink_dump_start+0x315/0x3e0
  rtnetlink_rcv_msg+0x4d1/0x720
  netlink_rcv_skb+0xf0/0x220
  rtnetlink_rcv+0x15/0x20
  netlink_unicast+0x306/0x460
  netlink_sendmsg+0x44b/0x770
  __sys_sendto+0x259/0x270
  __x64_sys_sendto+0x80/0xa0
  do_syscall_64+0x69/0xf4
  entry_SYSCALL_64_after_hwframe+0x49/0xb3

Signed-off-by: Qian Cai <cai@lca.pw>
---
 net/ipv4/fib_frontend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 577db1d50a24..5e441282d647 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -987,6 +987,8 @@ static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 	if (filter.flags & RTM_F_PREFIX)
 		return skb->len;
 
+	rcu_read_lock();
+
 	if (filter.table_id) {
 		tb = fib_get_table(net, filter.table_id);
 		if (!tb) {
@@ -1004,8 +1006,6 @@ static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 	s_h = cb->args[0];
 	s_e = cb->args[1];
 
-	rcu_read_lock();
-
 	for (h = s_h; h < FIB_TABLE_HASHSZ; h++, s_e = 0) {
 		e = 0;
 		head = &net->ipv4.fib_table_hash[h];
-- 
2.21.0 (Apple Git-122.2)

