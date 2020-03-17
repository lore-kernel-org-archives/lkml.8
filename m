Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64839C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A9A20658
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584442594;
	bh=rJ+z3ahfuuDl0OQAcFKHw+9DSfilGsO4gskP2uEUtt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2wCibJj5ipPYKKAFmO4XW7mb2IVKTlYBib8v9EjzlTm2lWVOtYD6HIDCGcnk2xc0a
	 78k2B0LQ4DmuWeLkRwBIEdAsc1cttH/KRT26pW2FiB/k7LjxM6j/D7+Y+TexUMBDbh
	 ZOYYcEsQBDXrEvVL1iMRnwesAUMIZfj5seVxPfhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgCQK4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:56:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgCQK4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:56:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 765FC20714;
        Tue, 17 Mar 2020 10:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442589;
        bh=rJ+z3ahfuuDl0OQAcFKHw+9DSfilGsO4gskP2uEUtt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=njQF2VDtZAz4c3ni/RmDdffeJLP6BYW2AOXXw8s72/mbmc8q7VfRC+gezNONJCAhJ
         FwwhaHenSYIQkA+5kdZHPKaldquSeIeDQpMRM33SiQnWzYePGmMNMVjauaMsbaB7X8
         bblmy6UdK2bfvgzr/n/3ijz8fEgr92o7Ldm/iZH8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 15/89] net/packet: tpacket_rcv: do not increment ring index on drop
Date:   Tue, 17 Mar 2020 11:54:24 +0100
Message-Id: <20200317103301.716183895@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103259.744774526@linuxfoundation.org>
References: <20200317103259.744774526@linuxfoundation.org>
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
@@ -2260,6 +2260,13 @@ static int tpacket_rcv(struct sk_buff *s
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
@@ -2272,12 +2279,6 @@ static int tpacket_rcv(struct sk_buff *s
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


