Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A11C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB342468A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686414;
	bh=H1Lcg5rw+RgdPVHED2wBfHLTyKq6l7C8E9zOH9Hlf1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mNT5fIssfUC1MwU9Wwplfn2vgs7uxX4vo0UE9QJJ0sH935Rt6AsXF3xoBNR9Zcf7+
	 T8QS3MqUZ+/PfRaKO90FNI9I9uTm3NMOiaUd5X7K+jTUMTfpKlA+LkcyGUNuDjIV1b
	 gM9cRmbLecjSSaRFwODLZJwq3YdkpGahjTl8LfYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387808AbgAVJm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:42:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:35026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387795AbgAVJm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:42:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0EC624686;
        Wed, 22 Jan 2020 09:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686175;
        bh=H1Lcg5rw+RgdPVHED2wBfHLTyKq6l7C8E9zOH9Hlf1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=giCUcAIFGD6gg0oUYgxhj2FHSan9Un2l1fonJ6F2Cdhj47nxgkbWRsn9ADG3dJ+Rt
         lAXkH4OW9vdCRviBiQQABbGALYUHKVE8Wg9yLXrcBUV1scsHZXqP/vO+yHHq0hr25x
         U2eZTB8KT2tJ3MFwCbYaSWUNXlgso58DlYnBvu7w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pengcheng Yang <yangpc@wangsu.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 075/103] tcp: fix marked lost packets not being retransmitted
Date:   Wed, 22 Jan 2020 10:29:31 +0100
Message-Id: <20200122092814.391579511@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092803.587683021@linuxfoundation.org>
References: <20200122092803.587683021@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pengcheng Yang <yangpc@wangsu.com>

[ Upstream commit e176b1ba476cf36f723cfcc7a9e57f3cb47dec70 ]

When the packet pointed to by retransmit_skb_hint is unlinked by ACK,
retransmit_skb_hint will be set to NULL in tcp_clean_rtx_queue().
If packet loss is detected at this time, retransmit_skb_hint will be set
to point to the current packet loss in tcp_verify_retransmit_hint(),
then the packets that were previously marked lost but not retransmitted
due to the restriction of cwnd will be skipped and cannot be
retransmitted.

To fix this, when retransmit_skb_hint is NULL, retransmit_skb_hint can
be reset only after all marked lost packets are retransmitted
(retrans_out >= lost_out), otherwise we need to traverse from
tcp_rtx_queue_head in tcp_xmit_retransmit_queue().

Packetdrill to demonstrate:

// Disable RACK and set max_reordering to keep things simple
    0 `sysctl -q net.ipv4.tcp_recovery=0`
   +0 `sysctl -q net.ipv4.tcp_max_reordering=3`

// Establish a connection
   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
   +0 bind(3, ..., ...) = 0
   +0 listen(3, 1) = 0

  +.1 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
   +0 > S. 0:0(0) ack 1 <...>
 +.01 < . 1:1(0) ack 1 win 257
   +0 accept(3, ..., ...) = 4

// Send 8 data segments
   +0 write(4, ..., 8000) = 8000
   +0 > P. 1:8001(8000) ack 1

// Enter recovery and 1:3001 is marked lost
 +.01 < . 1:1(0) ack 1 win 257 <sack 3001:4001,nop,nop>
   +0 < . 1:1(0) ack 1 win 257 <sack 5001:6001 3001:4001,nop,nop>
   +0 < . 1:1(0) ack 1 win 257 <sack 5001:7001 3001:4001,nop,nop>

// Retransmit 1:1001, now retransmit_skb_hint points to 1001:2001
   +0 > . 1:1001(1000) ack 1

// 1001:2001 was ACKed causing retransmit_skb_hint to be set to NULL
 +.01 < . 1:1(0) ack 2001 win 257 <sack 5001:8001 3001:4001,nop,nop>
// Now retransmit_skb_hint points to 4001:5001 which is now marked lost

// BUG: 2001:3001 was not retransmitted
   +0 > . 2001:3001(1000) ack 1

Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Tested-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -901,9 +901,10 @@ static void tcp_check_sack_reordering(st
 /* This must be called before lost_out is incremented */
 static void tcp_verify_retransmit_hint(struct tcp_sock *tp, struct sk_buff *skb)
 {
-	if (!tp->retransmit_skb_hint ||
-	    before(TCP_SKB_CB(skb)->seq,
-		   TCP_SKB_CB(tp->retransmit_skb_hint)->seq))
+	if ((!tp->retransmit_skb_hint && tp->retrans_out >= tp->lost_out) ||
+	    (tp->retransmit_skb_hint &&
+	     before(TCP_SKB_CB(skb)->seq,
+		    TCP_SKB_CB(tp->retransmit_skb_hint)->seq)))
 		tp->retransmit_skb_hint = skb;
 }
 


