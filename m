Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD4DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EAAF2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591360187;
	bh=j9fuMJzFwntpV3mYqfu+qUswix+dSaLC/uawv7kL3uY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FqtI84/3i0noKCOUYkZVoMqERIOHkE/UdCdzUQGSemSbFkh9NEnkwmef+DBnw3lFm
	 +Zcsu9+UlnL89sBAbThtkqpl66qZqfdOyaUeDZSszCKR35eekhasN/sQQVv60qx6Wb
	 w99h/nnHXH7dipIDRvr1HqK9X/kAVjoWDpO1lNbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgFEM3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:29:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgFEMZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 08:25:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30A2720835;
        Fri,  5 Jun 2020 12:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591359946;
        bh=j9fuMJzFwntpV3mYqfu+qUswix+dSaLC/uawv7kL3uY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o/7cDnZ0P2pWgE151b6Rr4op8o57vFbpNz8wt8Ms6EgcHzzGBaINy9bw7lzxRAnEA
         tvmCln3RKQqIEHSdg/FFwAbT1smJj8F7/2csD9hddIDb+eooG6QrTQsInEi02OUCK9
         hQs5VHinJZGEJkbMybpr3pZSNVUjrHzDsoLtSg84=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Willem de Bruijn <willemb@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.4 05/14] net: check untrusted gso_size at kernel entry
Date:   Fri,  5 Jun 2020 08:25:31 -0400
Message-Id: <20200605122540.2882539-5-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605122540.2882539-1-sashal@kernel.org>
References: <20200605122540.2882539-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/virtio_net.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 6f6ade63b04c..88997022a4b5 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -31,6 +31,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 {
 	unsigned int gso_type = 0;
 	unsigned int thlen = 0;
+	unsigned int p_off = 0;
 	unsigned int ip_proto;
 
 	if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
@@ -68,7 +69,8 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 		if (!skb_partial_csum_set(skb, start, off))
 			return -EINVAL;
 
-		if (skb_transport_offset(skb) + thlen > skb_headlen(skb))
+		p_off = skb_transport_offset(skb) + thlen;
+		if (p_off > skb_headlen(skb))
 			return -EINVAL;
 	} else {
 		/* gso packets without NEEDS_CSUM do not set transport_offset.
@@ -92,17 +94,25 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
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
 
-- 
2.25.1

