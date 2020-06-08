Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA10C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46267207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591662389;
	bh=OzO9K0KnNQjGQ//0XNCIDoj2357X829Yw3yx1jruEhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tMxq8GkWnpRh2moelEeiwNXiMmIBkAw3SfILS2ZZfWLGbphmayBPg4jyV32KYIXDl
	 8B1I3l0tBrMU8qe+9YctW4uw2GSBFmeotQqym/bs1bSSlS7cuLBfejIHuUJ96In592
	 QMwlzuNQ7wl8Ag4ZQkqNSmKoUE0oySkInJMXBTCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733046AbgFIA0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728597AbgFHXQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:16:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44C8120872;
        Mon,  8 Jun 2020 23:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658211;
        bh=OzO9K0KnNQjGQ//0XNCIDoj2357X829Yw3yx1jruEhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K3XELJOTtmj9uJ7stsp5d1LvUvZa4Fqi13dscS/NrnjQwOcH07Mok+WWVjWeobman
         Qp6NyR3j6amaU0M5nosI4jvWZatrVZ5ne8x+3wTxklBO7GOXtTAp5+OZZAOlxeZECc
         J4SQBFNdGYDCbC/RSlGB82eEzMBryl9EGCVZTPAw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Xin Long <lucien.xin@gmail.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.6 228/606] tipc: block BH before using dst_cache
Date:   Mon,  8 Jun 2020 19:05:53 -0400
Message-Id: <20200608231211.3363633-228-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 1378817486d6860f6a927f573491afe65287abf1 ]

dst_cache_get() documents it must be used with BH disabled.

sysbot reported :

BUG: using smp_processor_id() in preemptible [00000000] code: /21697
caller is dst_cache_get+0x3a/0xb0 net/core/dst_cache.c:68
CPU: 0 PID: 21697 Comm:  Not tainted 5.7.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 check_preemption_disabled lib/smp_processor_id.c:47 [inline]
 debug_smp_processor_id.cold+0x88/0x9b lib/smp_processor_id.c:57
 dst_cache_get+0x3a/0xb0 net/core/dst_cache.c:68
 tipc_udp_xmit.isra.0+0xb9/0xad0 net/tipc/udp_media.c:164
 tipc_udp_send_msg+0x3e6/0x490 net/tipc/udp_media.c:244
 tipc_bearer_xmit_skb+0x1de/0x3f0 net/tipc/bearer.c:526
 tipc_enable_bearer+0xb2f/0xd60 net/tipc/bearer.c:331
 __tipc_nl_bearer_enable+0x2bf/0x390 net/tipc/bearer.c:995
 tipc_nl_bearer_enable+0x1e/0x30 net/tipc/bearer.c:1003
 genl_family_rcv_msg_doit net/netlink/genetlink.c:673 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:718 [inline]
 genl_rcv_msg+0x627/0xdf0 net/netlink/genetlink.c:735
 netlink_rcv_skb+0x15a/0x410 net/netlink/af_netlink.c:2469
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:746
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0x537/0x740 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0x882/0xe10 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x6bf/0x7e0 net/socket.c:2362
 ___sys_sendmsg+0x100/0x170 net/socket.c:2416
 __sys_sendmsg+0xec/0x1b0 net/socket.c:2449
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45ca29

Fixes: e9c1a793210f ("tipc: add dst_cache support for udp media")
Cc: Xin Long <lucien.xin@gmail.com>
Cc: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/udp_media.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index d6620ad53546..28a283f26a8d 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -161,9 +161,11 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 			 struct udp_bearer *ub, struct udp_media_addr *src,
 			 struct udp_media_addr *dst, struct dst_cache *cache)
 {
-	struct dst_entry *ndst = dst_cache_get(cache);
+	struct dst_entry *ndst;
 	int ttl, err = 0;
 
+	local_bh_disable();
+	ndst = dst_cache_get(cache);
 	if (dst->proto == htons(ETH_P_IP)) {
 		struct rtable *rt = (struct rtable *)ndst;
 
@@ -210,9 +212,11 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 					   src->port, dst->port, false);
 #endif
 	}
+	local_bh_enable();
 	return err;
 
 tx_error:
+	local_bh_enable();
 	kfree_skb(skb);
 	return err;
 }
-- 
2.25.1

