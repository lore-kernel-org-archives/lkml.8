Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35A1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5E38207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="WYlsjNW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgGVRt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:49:27 -0400
Received: from rcdn-iport-6.cisco.com ([173.37.86.77]:64298 "EHLO
        rcdn-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgGVRt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:49:26 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jul 2020 13:49:25 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=11909; q=dns/txt;
  s=iport; t=1595440165; x=1596649765;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mid7n47+MCB9PbIntyVtiB9ks3B53n3wp+Kb0twtBzk=;
  b=WYlsjNW70PN4UdtRC15u6nRAyhHdosiJdCfw5DhDxq/q74MtCEb3+sdc
   473czvhgp9YDmymwdhs1WhyrpcgKi6UfcuO6XhdOo81Ux2/oFbk3sHoLh
   qfAY8ZhCEwwXasVl6vbT4b2Iee1WWx2AsjD5Ki3pg8b+tujcSjd/Lnz14
   s=;
X-IronPort-AV: E=Sophos;i="5.75,383,1589241600"; 
   d="scan'208";a="803087948"
Received: from rcdn-core-9.cisco.com ([173.37.93.145])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 22 Jul 2020 17:42:19 +0000
Received: from sjc-ads-7483.cisco.com (sjc-ads-7483.cisco.com [10.30.221.19])
        by rcdn-core-9.cisco.com (8.15.2/8.15.2) with ESMTP id 06MHgIcA004315;
        Wed, 22 Jul 2020 17:42:19 GMT
Received: by sjc-ads-7483.cisco.com (Postfix, from userid 838444)
        id AF68B1234; Wed, 22 Jul 2020 10:42:18 -0700 (PDT)
From:   Aviraj CJ <acj@cisco.com>
To:     jon.maloy@ericsson.com, ying.xue@windriver.com,
        davem@davemloft.net, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        xe-linux-external@cisco.com, acj@cisco.com
Cc:     Eric Dumazet <edumazet@google.com>
Subject: [PATCH stable v4.19] tipc: clean up skb list lock handling on send path
Date:   Wed, 22 Jul 2020 10:41:57 -0700
Message-Id: <20200722174157.34361-1-acj@cisco.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.30.221.19, sjc-ads-7483.cisco.com
X-Outbound-Node: rcdn-core-9.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Maloy <jon.maloy@ericsson.com>

upstream e654f9f53b45fde3fcc8051830b212c7a8f36148 commit

The policy for handling the skb list locks on the send and receive paths
is simple.

- On the send path we never need to grab the lock on the 'xmitq' list
  when the destination is an exernal node.

- On the receive path we always need to grab the lock on the 'inputq'
  list, irrespective of source node.

However, when transmitting node local messages those will eventually
end up on the receive path of a local socket, meaning that the argument
'xmitq' in tipc_node_xmit() will become the 'ínputq' argument in  the
function tipc_sk_rcv(). This has been handled by always initializing
the spinlock of the 'xmitq' list at message creation, just in case it
may end up on the receive path later, and despite knowing that the lock
in most cases never will be used.

This approach is inaccurate and confusing, and has also concealed the
fact that the stated 'no lock grabbing' policy for the send path is
violated in some cases.

We now clean up this by never initializing the lock at message creation,
instead doing this at the moment we find that the message actually will
enter the receive path. At the same time we fix the four locations
where we incorrectly access the spinlock on the send/error path.

This patch also reverts commit d12cffe9329f ("tipc: ensure head->lock
is initialised") which has now become redundant.

Additional comment:
Below crash was seen while accessing uninitialized spinlock in skb_dequeue.

[ 282.961198] general protection fault: 0000 1 SMP PTI
[ 282.961204] CPU: 0 PID: 9 Comm: ksoftirqd/0 Kdump: loaded : G O 4.19.106 #1
[ 282.961218] Hardware name: Insyde Grangeville/Type2 - Board Product Name1, BIOS 05.05.15.0026 06/23/2016
[ 282.961233] RIP: 0010:queued_spin_lock_slowpath+0x14c/0x190
[ 282.961239] Code: ff ff 83 e8 01 75 eb e9 14 ff ff ff c1 e9 12 83 e0 03 83 e9 01 48 c1 e0 04 48 63 c9 48 05 00 ed 01 00 48 03 04 cd 80 c4 83 87 <48> 89 10 8b 42 08 85 c0 75 09 f3 90 8b 42 08 85 c0 74 f7 48 8b 02
[ 282.961248] RSP: 0018:ffffa2510008b988 EFLAGS: 00010006
[ 282.961254] RAX: 0065646f6d615d9f RBX: 0000000000000202 RCX: 0000000000003ffe
[ 282.961259] RDX: ffff9a2b77c1ed00 RSI: 0000000000040000 RDI: ffffa2510008ba5c
[ 282.961264] RBP: ffffa2510008ba48 R08: 00000000ffffffff R09: 0000000000000550
[ 282.961271] R10: ffff9a2b54bb9050 R11: 0000000000000001 R12: ffffa2510008ba5c
[ 282.961277] R13: ffff9a2b5fc1e800 R14: ffff9a2b5fc1e808 R15: 000000000000058c
[ 282.961283] FS: 0000000000000000(0000) GS:ffff9a2b77c00000(0000) knlGS:0000000000000000
[ 282.961288] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 282.961292] CR2: 00007f3f1321d2ac CR3: 00000001f0c0a002 CR4: 00000000003606f0
[ 282.961297] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 282.961301] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 282.961307] Call Trace:
[ 282.961321] _raw_spin_lock_irqsave+0x24/0x30
[ 282.961331] skb_dequeue+0x18/0x60
[ 282.961339] skb_queue_purge+0x1b/0x30
[ 282.961359] tipc_node_xmit+0x155/0x170 [tipc]
[ 282.961376] ? tipc_msg_init+0x2c/0xa0 [tipc]
[ 282.961390] tipc_named_node_up+0x1d6/0x210 [tipc]
[ 282.961406] tipc_node_write_unlock+0xf0/0x100 [tipc]
[ 282.961421] tipc_rcv+0x54c/0xc90 [tipc]
[ 282.961431] ? br_handle_frame_finish+0x3e0/0x3e0
[ 282.961439] ? br_handle_frame_finish+0x3e0/0x3e0
[ 282.961450] tipc_l2_rcv_msg+0x4a/0x70 [tipc]
[ 282.961458] __netif_receive_skb_one_core+0x52/0x70
[ 282.961465] netif_receive_skb_internal+0x39/0xb0
[ 282.961472] br_pass_frame_up+0xe8/0xf0
[ 282.961478] ? fdb_find_rcu+0xcd/0x130
[ 282.961485] br_handle_frame_finish+0x27a/0x3e0
[ 282.961493] br_handle_frame+0x191/0x2e0
[ 282.961499] ? br_pass_frame_up+0xf0/0xf0
[ 282.961506] __netif_receive_skb_core+0x1da/0xa70

CC: Eric Dumazet <edumazet@google.com>
Reported-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Acked-by: Ying Xue <ying.xue@windriver.com>
Signed-off-by: Jon Maloy <jon.maloy@ericsson.com>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[acj: backport v4.19 -stable
- adjust context
- skipped the hunk modifying non-existent function tipc_mcast_send_sync
- additional comment ]
Signed-off-by: Aviraj CJ <acj@cisco.com>
---
 net/tipc/bcast.c  |  8 ++++----
 net/tipc/group.c  |  4 ++--
 net/tipc/link.c   | 12 ++++++------
 net/tipc/node.c   |  7 ++++---
 net/tipc/socket.c | 12 ++++++------
 5 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/net/tipc/bcast.c b/net/tipc/bcast.c
index d8026543bf4c..68107bf92c7e 100644
--- a/net/tipc/bcast.c
+++ b/net/tipc/bcast.c
@@ -181,7 +181,7 @@ static void tipc_bcbase_xmit(struct net *net, struct sk_buff_head *xmitq)
 	}
 
 	/* We have to transmit across all bearers */
-	skb_queue_head_init(&_xmitq);
+	__skb_queue_head_init(&_xmitq);
 	for (bearer_id = 0; bearer_id < MAX_BEARERS; bearer_id++) {
 		if (!bb->dests[bearer_id])
 			continue;
@@ -237,7 +237,7 @@ static int tipc_bcast_xmit(struct net *net, struct sk_buff_head *pkts,
 	struct sk_buff_head xmitq;
 	int rc = 0;
 
-	skb_queue_head_init(&xmitq);
+	__skb_queue_head_init(&xmitq);
 	tipc_bcast_lock(net);
 	if (tipc_link_bc_peers(l))
 		rc = tipc_link_xmit(l, pkts, &xmitq);
@@ -267,7 +267,7 @@ static int tipc_rcast_xmit(struct net *net, struct sk_buff_head *pkts,
 	u32 dnode, selector;
 
 	selector = msg_link_selector(buf_msg(skb_peek(pkts)));
-	skb_queue_head_init(&_pkts);
+	__skb_queue_head_init(&_pkts);
 
 	list_for_each_entry_safe(dst, tmp, &dests->list, list) {
 		dnode = dst->node;
@@ -299,7 +299,7 @@ int tipc_mcast_xmit(struct net *net, struct sk_buff_head *pkts,
 	int rc = 0;
 
 	skb_queue_head_init(&inputq);
-	skb_queue_head_init(&localq);
+	__skb_queue_head_init(&localq);
 
 	/* Clone packets before they are consumed by next call */
 	if (dests->local && !tipc_msg_reassemble(pkts, &localq)) {
diff --git a/net/tipc/group.c b/net/tipc/group.c
index 3ee93b5c19b6..9a9138de4eca 100644
--- a/net/tipc/group.c
+++ b/net/tipc/group.c
@@ -199,7 +199,7 @@ void tipc_group_join(struct net *net, struct tipc_group *grp, int *sk_rcvbuf)
 	struct tipc_member *m, *tmp;
 	struct sk_buff_head xmitq;
 
-	skb_queue_head_init(&xmitq);
+	__skb_queue_head_init(&xmitq);
 	rbtree_postorder_for_each_entry_safe(m, tmp, tree, tree_node) {
 		tipc_group_proto_xmit(grp, m, GRP_JOIN_MSG, &xmitq);
 		tipc_group_update_member(m, 0);
@@ -435,7 +435,7 @@ bool tipc_group_cong(struct tipc_group *grp, u32 dnode, u32 dport,
 		return true;
 	if (state == MBR_PENDING && adv == ADV_IDLE)
 		return true;
-	skb_queue_head_init(&xmitq);
+	__skb_queue_head_init(&xmitq);
 	tipc_group_proto_xmit(grp, m, GRP_ADV_MSG, &xmitq);
 	tipc_node_distr_xmit(grp->net, &xmitq);
 	return true;
diff --git a/net/tipc/link.c b/net/tipc/link.c
index cc9a0485536b..f756b721f93e 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -928,7 +928,7 @@ int tipc_link_xmit(struct tipc_link *l, struct sk_buff_head *list,
 	int rc = 0;
 
 	if (unlikely(msg_size(hdr) > mtu)) {
-		skb_queue_purge(list);
+		__skb_queue_purge(list);
 		return -EMSGSIZE;
 	}
 
@@ -957,7 +957,7 @@ int tipc_link_xmit(struct tipc_link *l, struct sk_buff_head *list,
 		if (likely(skb_queue_len(transmq) < maxwin)) {
 			_skb = skb_clone(skb, GFP_ATOMIC);
 			if (!_skb) {
-				skb_queue_purge(list);
+				__skb_queue_purge(list);
 				return -ENOBUFS;
 			}
 			__skb_dequeue(list);
@@ -1429,7 +1429,7 @@ void tipc_link_create_dummy_tnl_msg(struct tipc_link *l,
 	struct sk_buff *skb;
 	u32 dnode = l->addr;
 
-	skb_queue_head_init(&tnlq);
+	__skb_queue_head_init(&tnlq);
 	skb = tipc_msg_create(TUNNEL_PROTOCOL, FAILOVER_MSG,
 			      INT_H_SIZE, BASIC_H_SIZE,
 			      dnode, onode, 0, 0, 0);
@@ -1465,8 +1465,8 @@ void tipc_link_tnl_prepare(struct tipc_link *l, struct tipc_link *tnl,
 	if (!tnl)
 		return;
 
-	skb_queue_head_init(&tnlq);
-	skb_queue_head_init(&tmpxq);
+	__skb_queue_head_init(&tnlq);
+	__skb_queue_head_init(&tmpxq);
 
 	/* At least one packet required for safe algorithm => add dummy */
 	skb = tipc_msg_create(TIPC_LOW_IMPORTANCE, TIPC_DIRECT_MSG,
@@ -1476,7 +1476,7 @@ void tipc_link_tnl_prepare(struct tipc_link *l, struct tipc_link *tnl,
 		pr_warn("%sunable to create tunnel packet\n", link_co_err);
 		return;
 	}
-	skb_queue_tail(&tnlq, skb);
+	__skb_queue_tail(&tnlq, skb);
 	tipc_link_xmit(l, &tnlq, &tmpxq);
 	__skb_queue_purge(&tmpxq);
 
diff --git a/net/tipc/node.c b/net/tipc/node.c
index e67ffd194927..a188c2590137 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1368,13 +1368,14 @@ int tipc_node_xmit(struct net *net, struct sk_buff_head *list,
 	int rc;
 
 	if (in_own_node(net, dnode)) {
+		spin_lock_init(&list->lock);
 		tipc_sk_rcv(net, list);
 		return 0;
 	}
 
 	n = tipc_node_find(net, dnode);
 	if (unlikely(!n)) {
-		skb_queue_purge(list);
+		__skb_queue_purge(list);
 		return -EHOSTUNREACH;
 	}
 
@@ -1383,7 +1384,7 @@ int tipc_node_xmit(struct net *net, struct sk_buff_head *list,
 	if (unlikely(bearer_id == INVALID_BEARER_ID)) {
 		tipc_node_read_unlock(n);
 		tipc_node_put(n);
-		skb_queue_purge(list);
+		__skb_queue_purge(list);
 		return -EHOSTUNREACH;
 	}
 
@@ -1415,7 +1416,7 @@ int tipc_node_xmit_skb(struct net *net, struct sk_buff *skb, u32 dnode,
 {
 	struct sk_buff_head head;
 
-	skb_queue_head_init(&head);
+	__skb_queue_head_init(&head);
 	__skb_queue_tail(&head, skb);
 	tipc_node_xmit(net, &head, dnode, selector);
 	return 0;
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 40947ad90222..f0184a5e83aa 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -800,7 +800,7 @@ static int tipc_sendmcast(struct  socket *sock, struct tipc_name_seq *seq,
 	msg_set_nameupper(hdr, seq->upper);
 
 	/* Build message as chain of buffers */
-	skb_queue_head_init(&pkts);
+	__skb_queue_head_init(&pkts);
 	rc = tipc_msg_build(hdr, msg, 0, dlen, mtu, &pkts);
 
 	/* Send message if build was successful */
@@ -841,7 +841,7 @@ static int tipc_send_group_msg(struct net *net, struct tipc_sock *tsk,
 	msg_set_grp_bc_seqno(hdr, bc_snd_nxt);
 
 	/* Build message as chain of buffers */
-	skb_queue_head_init(&pkts);
+	__skb_queue_head_init(&pkts);
 	mtu = tipc_node_get_mtu(net, dnode, tsk->portid);
 	rc = tipc_msg_build(hdr, m, 0, dlen, mtu, &pkts);
 	if (unlikely(rc != dlen))
@@ -1046,7 +1046,7 @@ static int tipc_send_group_bcast(struct socket *sock, struct msghdr *m,
 	msg_set_grp_bc_ack_req(hdr, ack);
 
 	/* Build message as chain of buffers */
-	skb_queue_head_init(&pkts);
+	__skb_queue_head_init(&pkts);
 	rc = tipc_msg_build(hdr, m, 0, dlen, mtu, &pkts);
 	if (unlikely(rc != dlen))
 		return rc;
@@ -1372,7 +1372,7 @@ static int __tipc_sendmsg(struct socket *sock, struct msghdr *m, size_t dlen)
 	if (unlikely(rc))
 		return rc;
 
-	skb_queue_head_init(&pkts);
+	__skb_queue_head_init(&pkts);
 	mtu = tipc_node_get_mtu(net, dnode, tsk->portid);
 	rc = tipc_msg_build(hdr, m, 0, dlen, mtu, &pkts);
 	if (unlikely(rc != dlen))
@@ -1427,7 +1427,7 @@ static int __tipc_sendstream(struct socket *sock, struct msghdr *m, size_t dlen)
 	int send, sent = 0;
 	int rc = 0;
 
-	skb_queue_head_init(&pkts);
+	__skb_queue_head_init(&pkts);
 
 	if (unlikely(dlen > INT_MAX))
 		return -EMSGSIZE;
@@ -1782,7 +1782,7 @@ static int tipc_recvmsg(struct socket *sock, struct msghdr *m,
 
 	/* Send group flow control advertisement when applicable */
 	if (tsk->group && msg_in_group(hdr) && !grp_evt) {
-		skb_queue_head_init(&xmitq);
+		__skb_queue_head_init(&xmitq);
 		tipc_group_update_rcv_win(tsk->group, tsk_blocks(hlen + dlen),
 					  msg_orignode(hdr), msg_origport(hdr),
 					  &xmitq);
-- 
2.19.1

