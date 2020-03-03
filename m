Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C51C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C78E2073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258906;
	bh=RvQhxzX6sNPG//i4+vk6Vu4eK5JycpXVfhLLiIG7OWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iuGvMcm0c2kPPpUolM7sn+TwsT7OyTToprxGy9s3gVkqASlQNrHHBzA0Z8HwVcJgN
	 zbPPX/OXd/lEea0IQIaYjAlqbXAt0AvKm26+hBm40B+Sv1pceYVvktzLL6qefR9cmB
	 HrWoBVAro1IGYQKLez+li6xaqLWbcD2mH/+R62LM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387943AbgCCSIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:08:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729318AbgCCRxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:53:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD860206D5;
        Tue,  3 Mar 2020 17:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258018;
        bh=RvQhxzX6sNPG//i4+vk6Vu4eK5JycpXVfhLLiIG7OWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V93xFb259SAflWIsGKUC0X7Mamk+uxuD74LhwVAfDb+zMP4rrNyTFzEtCLQzys2b+
         oqBl4WEe3fKjY/7spBbzppwi06UT9L3yaw4UzlaSPEst8TM407eQ6UxdCwxaxKc3AI
         By1biQoJQ9ISx+D+lmspuiFrSODsvJ30jLCJ/ymI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 012/152] Revert "net: dev: introduce support for sch BYPASS for lockless qdisc"
Date:   Tue,  3 Mar 2020 18:41:50 +0100
Message-Id: <20200303174303.899277587@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174302.523080016@linuxfoundation.org>
References: <20200303174302.523080016@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 379349e9bc3b42b8b2f8f7a03f64a97623fff323 ]

This reverts commit ba27b4cdaaa66561aaedb2101876e563738d36fe

Ahmed reported ouf-of-order issues bisected to commit ba27b4cdaaa6
("net: dev: introduce support for sch BYPASS for lockless qdisc").
I can't find any working solution other than a plain revert.

This will introduce some minor performance regressions for
pfifo_fast qdisc. I plan to address them in net-next with more
indirect call wrapper boilerplate for qdiscs.

Reported-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Fixes: ba27b4cdaaa6 ("net: dev: introduce support for sch BYPASS for lockless qdisc")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/dev.c |   22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3386,26 +3386,8 @@ static inline int __dev_xmit_skb(struct
 	qdisc_calculate_pkt_len(skb, q);
 
 	if (q->flags & TCQ_F_NOLOCK) {
-		if ((q->flags & TCQ_F_CAN_BYPASS) && READ_ONCE(q->empty) &&
-		    qdisc_run_begin(q)) {
-			if (unlikely(test_bit(__QDISC_STATE_DEACTIVATED,
-					      &q->state))) {
-				__qdisc_drop(skb, &to_free);
-				rc = NET_XMIT_DROP;
-				goto end_run;
-			}
-			qdisc_bstats_cpu_update(q, skb);
-
-			rc = NET_XMIT_SUCCESS;
-			if (sch_direct_xmit(skb, q, dev, txq, NULL, true))
-				__qdisc_run(q);
-
-end_run:
-			qdisc_run_end(q);
-		} else {
-			rc = q->enqueue(skb, q, &to_free) & NET_XMIT_MASK;
-			qdisc_run(q);
-		}
+		rc = q->enqueue(skb, q, &to_free) & NET_XMIT_MASK;
+		qdisc_run(q);
 
 		if (unlikely(to_free))
 			kfree_skb_list(to_free);


