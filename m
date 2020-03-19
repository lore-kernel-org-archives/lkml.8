Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5121DC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291AB20724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623667;
	bh=H0c+KBhye+F6KWuwQztJzRxuFgUkCnhfodNDRVnC/Lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pCAj6OwO5moQn0I78KLbp0GwFKNRXk4p+8Pr7lyxJSBa90nT55ZJzJEmfGYzVM8Ms
	 Cufz2gilsO8+6+bGj5XvjSU/E6DHYTs3VJiPfKFNn7mpP73L/NKPLbseauAxvX575W
	 b6CtjlgycZT7eMl7ILIUfJ1COKLlFrWSeV7aUC3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbgCSNOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:14:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728405AbgCSNOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:14:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4974E206D7;
        Thu, 19 Mar 2020 13:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623660;
        bh=H0c+KBhye+F6KWuwQztJzRxuFgUkCnhfodNDRVnC/Lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pUc2AAUfrc3DfiQk2dmY1X6UgbSZTbvSslsnMpHVVIeLXtA6PGU0k5edViutVfVLL
         eGomiKU/G+kGXBSYv7KSIU1GJMpJRY39K30Ufgy+Ax4FROJkc5KcUnfYSTxbUlgWv/
         i9rMp21PnOhSB6JV0bF+xNNu4ASRd1XjAqDO/eds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 11/99] net/packet: tpacket_rcv: do not increment ring index on drop
Date:   Thu, 19 Mar 2020 14:02:49 +0100
Message-Id: <20200319123944.918826343@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123941.630731708@linuxfoundation.org>
References: <20200319123941.630731708@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 46e4c421a053c36bf7a33dda2272481bcaf3eed3 ]

In one error case, tpacket_rcv drops packets after incrementing the
ring producer index.

If this happens, it does not update tp_status to TP_STATUS_USER and
thus the reader is stalled for an iteration of the ring, causing out
of order arrival.

The only such error path is when virtio_net_hdr_from_skb fails due
to encountering an unknown GSO type.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/packet/af_packet.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2299,6 +2299,13 @@ static int tpacket_rcv(struct sk_buff *s
 					TP_STATUS_KERNEL, (macoff+snaplen));
 	if (!h.raw)
 		goto drop_n_account;
+
+	if (do_vnet &&
+	    virtio_net_hdr_from_skb(skb, h.raw + macoff -
+				    sizeof(struct virtio_net_hdr),
+				    vio_le(), true, 0))
+		goto drop_n_account;
+
 	if (po->tp_version <= TPACKET_V2) {
 		packet_increment_rx_head(po, &po->rx_ring);
 	/*
@@ -2311,12 +2318,6 @@ static int tpacket_rcv(struct sk_buff *s
 			status |= TP_STATUS_LOSING;
 	}
 
-	if (do_vnet &&
-	    virtio_net_hdr_from_skb(skb, h.raw + macoff -
-				    sizeof(struct virtio_net_hdr),
-				    vio_le(), true, 0))
-		goto drop_n_account;
-
 	po->stats.stats1.tp_packets++;
 	if (copy_skb) {
 		status |= TP_STATUS_COPY;


