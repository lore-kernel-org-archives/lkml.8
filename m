Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FC6C433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5339206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262168;
	bh=gIRhl9opOJU5+qKIqIvykBBfc5EZJL8zkNp35h42d90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vDAzdV6fmqCCMRE6e0Guuxrs1OAv7/KdXTwe4YTchA/RaBOGkucmkifE/2gFDIJ9F
	 b861AqvBpS6cpPV4X/YmxMckW8u4UcvDnYNRV52r/V1sMKGxQYiTCFD5/BNQYw86Zh
	 nYwOP2Ov7f6/98s4WZoC2fO7DeCDhLps/JcWSTGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388696AbgGTQWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:22:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732742AbgGTQGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:06:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE52A22CB1;
        Mon, 20 Jul 2020 16:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261168;
        bh=gIRhl9opOJU5+qKIqIvykBBfc5EZJL8zkNp35h42d90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WSOML9KP51unxyCzF8JTxlvdTJz5JuagWxT0LCh+14kMloT/7q6UfhBS/mkliBITq
         tE1MVtdw+ryjz/CsMN2o79o1B05NF3sGv1C8C2cPzpGebjI9jfmQrqjTLD34nHNTnu
         PWf5H9/0QN1GDY1+lIylaBtg6p15xuFAvC/z/UBA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Toshiaki Makita <toshiaki.makita1@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.7 018/244] vlan: consolidate VLAN parsing code and limit max parsing depth
Date:   Mon, 20 Jul 2020 17:34:49 +0200
Message-Id: <20200720152826.744203618@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Toke Høiland-Jørgensen" <toke@redhat.com>

[ Upstream commit 469aceddfa3ed16e17ee30533fae45e90f62efd8 ]

Toshiaki pointed out that we now have two very similar functions to extract
the L3 protocol number in the presence of VLAN tags. And Daniel pointed out
that the unbounded parsing loop makes it possible for maliciously crafted
packets to loop through potentially hundreds of tags.

Fix both of these issues by consolidating the two parsing functions and
limiting the VLAN tag parsing to a max depth of 8 tags. As part of this,
switch over __vlan_get_protocol() to use skb_header_pointer() instead of
pskb_may_pull(), to avoid the possible side effects of the latter and keep
the skb pointer 'const' through all the parsing functions.

v2:
- Use limit of 8 tags instead of 32 (matching XMIT_RECURSION_LIMIT)

Reported-by: Toshiaki Makita <toshiaki.makita1@gmail.com>
Reported-by: Daniel Borkmann <daniel@iogearbox.net>
Fixes: d7bf2ebebc2b ("sched: consistently handle layer3 header accesses in the presence of VLANs")
Signed-off-by: Toke HÃ¸iland-JÃ¸rgensen <toke@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/if_vlan.h |   57 ++++++++++++++++++------------------------------
 1 file changed, 22 insertions(+), 35 deletions(-)

--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -25,6 +25,8 @@
 #define VLAN_ETH_DATA_LEN	1500	/* Max. octets in payload	 */
 #define VLAN_ETH_FRAME_LEN	1518	/* Max. octets in frame sans FCS */
 
+#define VLAN_MAX_DEPTH	8		/* Max. number of nested VLAN tags parsed */
+
 /*
  * 	struct vlan_hdr - vlan header
  * 	@h_vlan_TCI: priority and VLAN ID
@@ -308,34 +310,6 @@ static inline bool eth_type_vlan(__be16
 	}
 }
 
-/* A getter for the SKB protocol field which will handle VLAN tags consistently
- * whether VLAN acceleration is enabled or not.
- */
-static inline __be16 skb_protocol(const struct sk_buff *skb, bool skip_vlan)
-{
-	unsigned int offset = skb_mac_offset(skb) + sizeof(struct ethhdr);
-	__be16 proto = skb->protocol;
-
-	if (!skip_vlan)
-		/* VLAN acceleration strips the VLAN header from the skb and
-		 * moves it to skb->vlan_proto
-		 */
-		return skb_vlan_tag_present(skb) ? skb->vlan_proto : proto;
-
-	while (eth_type_vlan(proto)) {
-		struct vlan_hdr vhdr, *vh;
-
-		vh = skb_header_pointer(skb, offset, sizeof(vhdr), &vhdr);
-		if (!vh)
-			break;
-
-		proto = vh->h_vlan_encapsulated_proto;
-		offset += sizeof(vhdr);
-	}
-
-	return proto;
-}
-
 static inline bool vlan_hw_offload_capable(netdev_features_t features,
 					   __be16 proto)
 {
@@ -605,10 +579,10 @@ static inline int vlan_get_tag(const str
  * Returns the EtherType of the packet, regardless of whether it is
  * vlan encapsulated (normal or hardware accelerated) or not.
  */
-static inline __be16 __vlan_get_protocol(struct sk_buff *skb, __be16 type,
+static inline __be16 __vlan_get_protocol(const struct sk_buff *skb, __be16 type,
 					 int *depth)
 {
-	unsigned int vlan_depth = skb->mac_len;
+	unsigned int vlan_depth = skb->mac_len, parse_depth = VLAN_MAX_DEPTH;
 
 	/* if type is 802.1Q/AD then the header should already be
 	 * present at mac_len - VLAN_HLEN (if mac_len > 0), or at
@@ -623,13 +597,12 @@ static inline __be16 __vlan_get_protocol
 			vlan_depth = ETH_HLEN;
 		}
 		do {
-			struct vlan_hdr *vh;
+			struct vlan_hdr vhdr, *vh;
 
-			if (unlikely(!pskb_may_pull(skb,
-						    vlan_depth + VLAN_HLEN)))
+			vh = skb_header_pointer(skb, vlan_depth, sizeof(vhdr), &vhdr);
+			if (unlikely(!vh || !--parse_depth))
 				return 0;
 
-			vh = (struct vlan_hdr *)(skb->data + vlan_depth);
 			type = vh->h_vlan_encapsulated_proto;
 			vlan_depth += VLAN_HLEN;
 		} while (eth_type_vlan(type));
@@ -648,11 +621,25 @@ static inline __be16 __vlan_get_protocol
  * Returns the EtherType of the packet, regardless of whether it is
  * vlan encapsulated (normal or hardware accelerated) or not.
  */
-static inline __be16 vlan_get_protocol(struct sk_buff *skb)
+static inline __be16 vlan_get_protocol(const struct sk_buff *skb)
 {
 	return __vlan_get_protocol(skb, skb->protocol, NULL);
 }
 
+/* A getter for the SKB protocol field which will handle VLAN tags consistently
+ * whether VLAN acceleration is enabled or not.
+ */
+static inline __be16 skb_protocol(const struct sk_buff *skb, bool skip_vlan)
+{
+	if (!skip_vlan)
+		/* VLAN acceleration strips the VLAN header from the skb and
+		 * moves it to skb->vlan_proto
+		 */
+		return skb_vlan_tag_present(skb) ? skb->vlan_proto : skb->protocol;
+
+	return vlan_get_protocol(skb);
+}
+
 static inline void vlan_set_encap_proto(struct sk_buff *skb,
 					struct vlan_hdr *vhdr)
 {


