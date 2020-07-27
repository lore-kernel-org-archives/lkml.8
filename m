Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C52C43445
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6575020838
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595860162;
	bh=R9n7i2d/2LiyirSf3VoJw7eQXDiACzZfwZCeutMFhUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xYd4c/IvMDEXFQsyP1FKRRsBXDeAYO4vJal9x5WCnV2bONod+lNsbilUfnQVFwk4V
	 l13WHg/SUCtQG6Ni/TQ8dLW0CoW2oXseArbnn6HNsUjkftIF0nKGtWfHmbd5RANHZZ
	 8gytD1vz4h+QUDlKTfUpljxGHTnzXiu9A+w9hmzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732554AbgG0O3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:29:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732078AbgG0OX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:23:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39D7420775;
        Mon, 27 Jul 2020 14:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859805;
        bh=R9n7i2d/2LiyirSf3VoJw7eQXDiACzZfwZCeutMFhUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wI0LSRtCdJHI04U5nIxqe3QcE1U9H3lr8nM0qoQ9bDriQlwx1Tu+FjCuNAOEbi9DF
         x1/g2FmdkOnIFuu7PSWBcjDx3KOy1mxkXf9iVN/7ntPcV3+1qJYUuOzWwVhirs/ejs
         ymUoORc+qkSWdiFKbxiz2IBIlj4QMhiAGjjmvGV8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhouxudong <zhouxudong8@huawei.com>,
        guodeqing <geffrey.guo@huawei.com>, Julian Anastasov <ja@ssi.bg>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 085/179] ipvs: fix the connection sync failed in some cases
Date:   Mon, 27 Jul 2020 16:04:20 +0200
Message-Id: <20200727134936.828153247@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: guodeqing <geffrey.guo@huawei.com>

[ Upstream commit 8210e344ccb798c672ab237b1a4f241bda08909b ]

The sync_thread_backup only checks sk_receive_queue is empty or not,
there is a situation which cannot sync the connection entries when
sk_receive_queue is empty and sk_rmem_alloc is larger than sk_rcvbuf,
the sync packets are dropped in __udp_enqueue_schedule_skb, this is
because the packets in reader_queue is not read, so the rmem is
not reclaimed.

Here I add the check of whether the reader_queue of the udp sock is
empty or not to solve this problem.

Fixes: 2276f58ac589 ("udp: use a separate rx queue for packet reception")
Reported-by: zhouxudong <zhouxudong8@huawei.com>
Signed-off-by: guodeqing <geffrey.guo@huawei.com>
Acked-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipvs/ip_vs_sync.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 605e0f68f8bd3..2b8abbfe018cf 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1717,6 +1717,8 @@ static int sync_thread_backup(void *data)
 {
 	struct ip_vs_sync_thread_data *tinfo = data;
 	struct netns_ipvs *ipvs = tinfo->ipvs;
+	struct sock *sk = tinfo->sock->sk;
+	struct udp_sock *up = udp_sk(sk);
 	int len;
 
 	pr_info("sync thread started: state = BACKUP, mcast_ifn = %s, "
@@ -1724,12 +1726,14 @@ static int sync_thread_backup(void *data)
 		ipvs->bcfg.mcast_ifn, ipvs->bcfg.syncid, tinfo->id);
 
 	while (!kthread_should_stop()) {
-		wait_event_interruptible(*sk_sleep(tinfo->sock->sk),
-			 !skb_queue_empty(&tinfo->sock->sk->sk_receive_queue)
-			 || kthread_should_stop());
+		wait_event_interruptible(*sk_sleep(sk),
+					 !skb_queue_empty_lockless(&sk->sk_receive_queue) ||
+					 !skb_queue_empty_lockless(&up->reader_queue) ||
+					 kthread_should_stop());
 
 		/* do we have data now? */
-		while (!skb_queue_empty(&(tinfo->sock->sk->sk_receive_queue))) {
+		while (!skb_queue_empty_lockless(&sk->sk_receive_queue) ||
+		       !skb_queue_empty_lockless(&up->reader_queue)) {
 			len = ip_vs_receive(tinfo->sock, tinfo->buf,
 					ipvs->bcfg.sync_maxlen);
 			if (len <= 0) {
-- 
2.25.1



