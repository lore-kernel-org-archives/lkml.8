Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C04C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 606E320672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593460829;
	bh=8e3WqKkPIOzUMoX2gi82UQ6VHHt5uYAGlN6JtS1WMTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yBis49cpPI0LekaQHZKPn9ryO7FLYuIlCFmoBAGDzcvl3Pqj7sMD+i7w5ly7mhGOg
	 9tOrUwz54hvsGVpu/ztR+JtpnEnfxxEbalctYENimJaWDC4VgsAEH5gGaAAdRrzAOL
	 FZ9ZTZi1eBkeiSJRWIs5UgHs/1b8muCEmEoAkTLE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388596AbgF2UAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:00:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387569AbgF2TkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BDDC24826;
        Mon, 29 Jun 2020 15:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444343;
        bh=8e3WqKkPIOzUMoX2gi82UQ6VHHt5uYAGlN6JtS1WMTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o07IJMHpjijrxKNNOLYjYPTp6+wVanGDjOAXS//f1pm/cWgm842WdLuyYT37DJZx3
         mS4QrTovyTUsvenAMq0YYa99nwhwobrjwX4lf2MM7c2WUiW1GK2XF1M4zGZS+/mO/w
         iyLr0TV+u7xFMAClqPXEQEPmRYfUY1H0GU1IPcTY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Denis Kirjanov <kda@linux-powerpc.org>,
        Denis Kirjanov <denis.kirjanov@suse.com>,
        Neal Cardwell <ncardwell@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.4 018/178] tcp: don't ignore ECN CWR on pure ACK
Date:   Mon, 29 Jun 2020 11:22:43 -0400
Message-Id: <20200629152523.2494198-19-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629152523.2494198-1-sashal@kernel.org>
References: <20200629152523.2494198-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.50-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.50-rc1
X-KernelTest-Deadline: 2020-07-01T15:25+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Kirjanov <kda@linux-powerpc.org>

[ Upstream commit 2570284060b48f3f79d8f1a2698792f36c385e9a ]

there is a problem with the CWR flag set in an incoming ACK segment
and it leads to the situation when the ECE flag is latched forever

the following packetdrill script shows what happens:

// Stack receives incoming segments with CE set
+0.1 <[ect0]  . 11001:12001(1000) ack 1001 win 65535
+0.0 <[ce]    . 12001:13001(1000) ack 1001 win 65535
+0.0 <[ect0] P. 13001:14001(1000) ack 1001 win 65535

// Stack repsonds with ECN ECHO
+0.0 >[noecn]  . 1001:1001(0) ack 12001
+0.0 >[noecn] E. 1001:1001(0) ack 13001
+0.0 >[noecn] E. 1001:1001(0) ack 14001

// Write a packet
+0.1 write(3, ..., 1000) = 1000
+0.0 >[ect0] PE. 1001:2001(1000) ack 14001

// Pure ACK received
+0.01 <[noecn] W. 14001:14001(0) ack 2001 win 65535

// Since CWR was sent, this packet should NOT have ECE set

+0.1 write(3, ..., 1000) = 1000
+0.0 >[ect0]  P. 2001:3001(1000) ack 14001
// but Linux will still keep ECE latched here, with packetdrill
// flagging a missing ECE flag, expecting
// >[ect0] PE. 2001:3001(1000) ack 14001
// in the script

In the situation above we will continue to send ECN ECHO packets
and trigger the peer to reduce the congestion window. To avoid that
we can check CWR on pure ACKs received.

v3:
- Add a sequence check to avoid sending an ACK to an ACK

v2:
- Adjusted the comment
- move CWR check before checking for unacknowledged packets

Signed-off-by: Denis Kirjanov <denis.kirjanov@suse.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 677facbeed26a..cc8411c98f28a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -260,7 +260,8 @@ static void tcp_ecn_accept_cwr(struct sock *sk, const struct sk_buff *skb)
 		 * cwnd may be very low (even just 1 packet), so we should ACK
 		 * immediately.
 		 */
-		inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
+		if (TCP_SKB_CB(skb)->seq != TCP_SKB_CB(skb)->end_seq)
+			inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
 	}
 }
 
@@ -3682,6 +3683,15 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 		tcp_in_ack_event(sk, ack_ev_flags);
 	}
 
+	/* This is a deviation from RFC3168 since it states that:
+	 * "When the TCP data sender is ready to set the CWR bit after reducing
+	 * the congestion window, it SHOULD set the CWR bit only on the first
+	 * new data packet that it transmits."
+	 * We accept CWR on pure ACKs to be more robust
+	 * with widely-deployed TCP implementations that do this.
+	 */
+	tcp_ecn_accept_cwr(sk, skb);
+
 	/* We passed data and got it acked, remove any soft error
 	 * log. Something worked...
 	 */
@@ -4771,8 +4781,6 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 	skb_dst_drop(skb);
 	__skb_pull(skb, tcp_hdr(skb)->doff * 4);
 
-	tcp_ecn_accept_cwr(sk, skb);
-
 	tp->rx_opt.dsack = 0;
 
 	/*  Queue data for delivery to the user.
-- 
2.25.1

