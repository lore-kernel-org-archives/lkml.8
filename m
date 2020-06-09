Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36489C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 140612068D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591726743;
	bh=VMfeFiVfnefWCA1tQkBq53HIAe43nKZj1VYQE+v3HNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TP2g/oMJUeFGUn4jfIyLmytiZ3B5DaO5FejpnoQW6xZMGKYR/abUmGa3L8MR7e+eQ
	 aI1p+YieWdRHTnf1KzQPtOyt3Wga4l4ghNgFpUANvWlanzOie2OK71Yxi4Iy9P/sqN
	 Ypr2Z/B39apB6XmCE+bFOpWD3/2aVlhEJaQffTh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388837AbgFISS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:18:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730963AbgFIRt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:49:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CAA820801;
        Tue,  9 Jun 2020 17:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591724998;
        bh=VMfeFiVfnefWCA1tQkBq53HIAe43nKZj1VYQE+v3HNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XmGzQD82FaBxG/Pi0T2kzXLDcL8mu1rJpdiP6bvsoWAOGwM5TXLKejdbdaaR8kLYh
         Ph2jEQSl1a+O2fKc90oWNi5aQomDGOHWkVURPiUWbJnPZYArkQ7ODWBfhTGg7cwEVS
         1WRes+y8Pnn7WXp5yUA8HNLbPonM7r/mo6R6Qujk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 28/46] net: check untrusted gso_size at kernel entry
Date:   Tue,  9 Jun 2020 19:44:44 +0200
Message-Id: <20200609174028.165000124@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174022.938987501@linuxfoundation.org>
References: <20200609174022.938987501@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 6dd912f82680761d8fb6b1bb274a69d4c7010988 ]

Syzkaller again found a path to a kernel crash through bad gso input:
a packet with gso size exceeding len.

These packets are dropped in tcp_gso_segment and udp[46]_ufo_fragment.
But they may affect gso size calculations earlier in the path.

Now that we have thlen as of commit 9274124f023b ("net: stricter
validation of untrusted gso packets"), check gso_size at entry too.

Fixes: bfd5f4a3d605 ("packet: Add GSO/csum offload support.")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/virtio_net.h |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -31,6 +31,7 @@ static inline int virtio_net_hdr_to_skb(
 {
 	unsigned int gso_type = 0;
 	unsigned int thlen = 0;
+	unsigned int p_off = 0;
 	unsigned int ip_proto;
 
 	if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
@@ -68,7 +69,8 @@ static inline int virtio_net_hdr_to_skb(
 		if (!skb_partial_csum_set(skb, start, off))
 			return -EINVAL;
 
-		if (skb_transport_offset(skb) + thlen > skb_headlen(skb))
+		p_off = skb_transport_offset(skb) + thlen;
+		if (p_off > skb_headlen(skb))
 			return -EINVAL;
 	} else {
 		/* gso packets without NEEDS_CSUM do not set transport_offset.
@@ -90,17 +92,25 @@ retry:
 				return -EINVAL;
 			}
 
-			if (keys.control.thoff + thlen > skb_headlen(skb) ||
+			p_off = keys.control.thoff + thlen;
+			if (p_off > skb_headlen(skb) ||
 			    keys.basic.ip_proto != ip_proto)
 				return -EINVAL;
 
 			skb_set_transport_header(skb, keys.control.thoff);
+		} else if (gso_type) {
+			p_off = thlen;
+			if (p_off > skb_headlen(skb))
+				return -EINVAL;
 		}
 	}
 
 	if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
 		u16 gso_size = __virtio16_to_cpu(little_endian, hdr->gso_size);
 
+		if (skb->len - p_off <= gso_size)
+			return -EINVAL;
+
 		skb_shinfo(skb)->gso_size = gso_size;
 		skb_shinfo(skb)->gso_type = gso_type;
 


