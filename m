Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0EAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83655206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865330;
	bh=KrhLFM8MGiTIzMk9HHEJ9lXYYrQyFai/D9d7puAg+Z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LS+4/xUNboFcK+7QzISF6M/Vl/N7VGnXhvAOLb458KYkbSxnS/Nw8BRK4131uP0OE
	 N3MFpHLdO2/X37aN+ym8uS2cShMuy7bL3sezTuGGInIJXqeGOTxAnIMjhh2heSpoL9
	 sN6F+RV9keTKqChdOaDOLP7h4G80X4uqBkZBpaCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391730AbgAXL2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:28:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:45086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391715AbgAXL2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:28:45 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11AE9206D4;
        Fri, 24 Jan 2020 11:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865324;
        bh=KrhLFM8MGiTIzMk9HHEJ9lXYYrQyFai/D9d7puAg+Z0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IoAY5g4cqH3Jg6YhYZ/rygwkMycXRjBthLN2RGoJ0fc/6JVu9TJQ9k2x0dPeZaMbK
         9zUXGupxcB1bsozAgDf6C7RhI3kA/Sypv+iBxF2kA9b446Z7S4PgFU+J/YBByt5Eoa
         lapBjTJu/Mndb9bELeJwplF75k67cVDoZOcFRj+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tung Nguyen <tung.q.nguyen@dektech.com.au>,
        Ying Xue <ying.xue@windriver.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 492/639] tipc: reduce risk of wakeup queue starvation
Date:   Fri, 24 Jan 2020 10:31:02 +0100
Message-Id: <20200124093150.392530959@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Maloy <jon.maloy@ericsson.com>

[ Upstream commit 7c5b42055964f587e55bd87ef334c3a27e95d144 ]

In commit 365ad353c256 ("tipc: reduce risk of user starvation during
link congestion") we allowed senders to add exactly one list of extra
buffers to the link backlog queues during link congestion (aka
"oversubscription"). However, the criteria for when to stop adding
wakeup messages to the input queue when the overload abates is
inaccurate, and may cause starvation problems during very high load.

Currently, we stop adding wakeup messages after 10 total failed attempts
where we find that there is no space left in the backlog queue for a
certain importance level. The counter for this is accumulated across all
levels, which may lead the algorithm to leave the loop prematurely,
although there may still be plenty of space available at some levels.
The result is sometimes that messages near the wakeup queue tail are not
added to the input queue as they should be.

We now introduce a more exact algorithm, where we keep adding wakeup
messages to a level as long as the backlog queue has free slots for
the corresponding level, and stop at the moment there are no more such
slots or when there are no more wakeup messages to dequeue.

Fixes: 365ad35 ("tipc: reduce risk of user starvation during link congestion")
Reported-by: Tung Nguyen <tung.q.nguyen@dektech.com.au>
Acked-by: Ying Xue <ying.xue@windriver.com>
Signed-off-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/link.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 0fbf8ea18ce04..cc9a0485536b3 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -830,18 +830,31 @@ static int link_schedule_user(struct tipc_link *l, struct tipc_msg *hdr)
  */
 static void link_prepare_wakeup(struct tipc_link *l)
 {
+	struct sk_buff_head *wakeupq = &l->wakeupq;
+	struct sk_buff_head *inputq = l->inputq;
 	struct sk_buff *skb, *tmp;
-	int imp, i = 0;
+	struct sk_buff_head tmpq;
+	int avail[5] = {0,};
+	int imp = 0;
+
+	__skb_queue_head_init(&tmpq);
 
-	skb_queue_walk_safe(&l->wakeupq, skb, tmp) {
+	for (; imp <= TIPC_SYSTEM_IMPORTANCE; imp++)
+		avail[imp] = l->backlog[imp].limit - l->backlog[imp].len;
+
+	skb_queue_walk_safe(wakeupq, skb, tmp) {
 		imp = TIPC_SKB_CB(skb)->chain_imp;
-		if (l->backlog[imp].len < l->backlog[imp].limit) {
-			skb_unlink(skb, &l->wakeupq);
-			skb_queue_tail(l->inputq, skb);
-		} else if (i++ > 10) {
-			break;
-		}
+		if (avail[imp] <= 0)
+			continue;
+		avail[imp]--;
+		__skb_unlink(skb, wakeupq);
+		__skb_queue_tail(&tmpq, skb);
 	}
+
+	spin_lock_bh(&inputq->lock);
+	skb_queue_splice_tail(&tmpq, inputq);
+	spin_unlock_bh(&inputq->lock);
+
 }
 
 void tipc_link_reset(struct tipc_link *l)
-- 
2.20.1



