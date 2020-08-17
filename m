Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1B4C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D7020738
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597691069;
	bh=32lIzJAnUv4Rf9+Zm6bqbTnb8HSvaEfJkalMsbS//Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RsM+w3P25ha0k1WL6OAGOiyCSwSAuM0fzDYjDQOVUhwr/rKICq56USWCQHliLOpUA
	 JdeuPtI/hYWQinxIGJ5kQfhqmuFQui3Z3u5F2SOdzOt80WkRnqkRiGLrlTWh5zeOkW
	 x0gJ8n7ri0HAY6hcHsvYkU/LoA1yFn1i9mUwiDwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbgHQPpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:45:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730588AbgHQPiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:38:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2FCF22C9F;
        Mon, 17 Aug 2020 15:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678698;
        bh=32lIzJAnUv4Rf9+Zm6bqbTnb8HSvaEfJkalMsbS//Z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GhY8NaD83Shv4SdeqOkyQbIIbah4IlNA43MPb98Zp3y56gZAqHI6tYNfYLOwR4XmM
         pdQAZ4jOBGObvCxE7NF5GwTYb1NJdyvRK3pdHP5tcJpzseO3Cut/vSZMceM1ilDIOY
         R0slVDjgdQkGFstAQZuWCZLVPvjq2kErO0mwFI3U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Ogness <john.ogness@linutronix.de>,
        kernel test robot <lkp@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.8 383/464] af_packet: TPACKET_V3: fix fill status rwlock imbalance
Date:   Mon, 17 Aug 2020 17:15:36 +0200
Message-Id: <20200817143852.123370743@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Ogness <john.ogness@linutronix.de>

[ Upstream commit 88fd1cb80daa20af063bce81e1fad14e945a8dc4 ]

After @blk_fill_in_prog_lock is acquired there is an early out vnet
situation that can occur. In that case, the rwlock needs to be
released.

Also, since @blk_fill_in_prog_lock is only acquired when @tp_version
is exactly TPACKET_V3, only release it on that exact condition as
well.

And finally, add sparse annotation so that it is clearer that
prb_fill_curr_block() and prb_clear_blk_fill_status() are acquiring
and releasing @blk_fill_in_prog_lock, respectively. sparse is still
unable to understand the balance, but the warnings are now on a
higher level that make more sense.

Fixes: 632ca50f2cbd ("af_packet: TPACKET_V3: replace busy-wait loop")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/packet/af_packet.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -942,6 +942,7 @@ static int prb_queue_frozen(struct tpack
 }
 
 static void prb_clear_blk_fill_status(struct packet_ring_buffer *rb)
+	__releases(&pkc->blk_fill_in_prog_lock)
 {
 	struct tpacket_kbdq_core *pkc  = GET_PBDQC_FROM_RB(rb);
 	atomic_dec(&pkc->blk_fill_in_prog);
@@ -989,6 +990,7 @@ static void prb_fill_curr_block(char *cu
 				struct tpacket_kbdq_core *pkc,
 				struct tpacket_block_desc *pbd,
 				unsigned int len)
+	__acquires(&pkc->blk_fill_in_prog_lock)
 {
 	struct tpacket3_hdr *ppd;
 
@@ -2286,8 +2288,11 @@ static int tpacket_rcv(struct sk_buff *s
 	if (do_vnet &&
 	    virtio_net_hdr_from_skb(skb, h.raw + macoff -
 				    sizeof(struct virtio_net_hdr),
-				    vio_le(), true, 0))
+				    vio_le(), true, 0)) {
+		if (po->tp_version == TPACKET_V3)
+			prb_clear_blk_fill_status(&po->rx_ring);
 		goto drop_n_account;
+	}
 
 	if (po->tp_version <= TPACKET_V2) {
 		packet_increment_rx_head(po, &po->rx_ring);
@@ -2393,7 +2398,7 @@ static int tpacket_rcv(struct sk_buff *s
 		__clear_bit(slot_id, po->rx_ring.rx_owner_map);
 		spin_unlock(&sk->sk_receive_queue.lock);
 		sk->sk_data_ready(sk);
-	} else {
+	} else if (po->tp_version == TPACKET_V3) {
 		prb_clear_blk_fill_status(&po->rx_ring);
 	}
 


