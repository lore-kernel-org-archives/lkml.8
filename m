Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DE2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF4542078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597922518;
	bh=usbbmOkATIl2Hrmxb3OBn0fI0myJajHVBxeCjLFcOTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ePOcEFpVdCEt5evJV1tXEv9nnqluegNrOVAaAxBrDcR0ZjfY0G880Z7+f8QUMJQxD
	 yyrTMIq12efiJpMRUDv62A7D9glLh/f9mDjNNfMwKAFf9L8RKbv6kVnKPKdRV4R2hY
	 yU6lLI/5GEmmpekRQSu3ScnDgW3RbX+U+/47DDQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgHTLVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:21:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727831AbgHTKHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:07:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6598A206DA;
        Thu, 20 Aug 2020 10:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918053;
        bh=usbbmOkATIl2Hrmxb3OBn0fI0myJajHVBxeCjLFcOTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0P3bEdkr9JcvuqXmcclevbrgDSF7HR7WHWayVgLBqrXw1SiGyFLaCydq8FWgbqEhv
         58TlGD7s74dcx1fhefcsurXN+sDoeCY7QW1XoFVSOHg6QVP9rz5ezuiB7bdWykzDOh
         52YdxE8ThxQepwxkq5Q1Hi9dRlH3UQzLExjdQX50=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 037/228] openvswitch: Prevent kernel-infoleak in ovs_ct_put_key()
Date:   Thu, 20 Aug 2020 11:20:12 +0200
Message-Id: <20200820091609.391882312@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peilin Ye <yepeilin.cs@gmail.com>

[ Upstream commit 9aba6c5b49254d5bee927d81593ed4429e91d4ae ]

ovs_ct_put_key() is potentially copying uninitialized kernel stack memory
into socket buffers, since the compiler may leave a 3-byte hole at the end
of `struct ovs_key_ct_tuple_ipv4` and `struct ovs_key_ct_tuple_ipv6`. Fix
it by initializing `orig` with memset().

Fixes: 9dd7f8907c37 ("openvswitch: Add original direction conntrack tuple to sw_flow_key.")
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/openvswitch/conntrack.c |   38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -255,10 +255,6 @@ void ovs_ct_fill_key(const struct sk_buf
 	ovs_ct_update_key(skb, NULL, key, false, false);
 }
 
-#define IN6_ADDR_INITIALIZER(ADDR) \
-	{ (ADDR).s6_addr32[0], (ADDR).s6_addr32[1], \
-	  (ADDR).s6_addr32[2], (ADDR).s6_addr32[3] }
-
 int ovs_ct_put_key(const struct sw_flow_key *swkey,
 		   const struct sw_flow_key *output, struct sk_buff *skb)
 {
@@ -280,24 +276,30 @@ int ovs_ct_put_key(const struct sw_flow_
 
 	if (swkey->ct_orig_proto) {
 		if (swkey->eth.type == htons(ETH_P_IP)) {
-			struct ovs_key_ct_tuple_ipv4 orig = {
-				output->ipv4.ct_orig.src,
-				output->ipv4.ct_orig.dst,
-				output->ct.orig_tp.src,
-				output->ct.orig_tp.dst,
-				output->ct_orig_proto,
-			};
+			struct ovs_key_ct_tuple_ipv4 orig;
+
+			memset(&orig, 0, sizeof(orig));
+			orig.ipv4_src = output->ipv4.ct_orig.src;
+			orig.ipv4_dst = output->ipv4.ct_orig.dst;
+			orig.src_port = output->ct.orig_tp.src;
+			orig.dst_port = output->ct.orig_tp.dst;
+			orig.ipv4_proto = output->ct_orig_proto;
+
 			if (nla_put(skb, OVS_KEY_ATTR_CT_ORIG_TUPLE_IPV4,
 				    sizeof(orig), &orig))
 				return -EMSGSIZE;
 		} else if (swkey->eth.type == htons(ETH_P_IPV6)) {
-			struct ovs_key_ct_tuple_ipv6 orig = {
-				IN6_ADDR_INITIALIZER(output->ipv6.ct_orig.src),
-				IN6_ADDR_INITIALIZER(output->ipv6.ct_orig.dst),
-				output->ct.orig_tp.src,
-				output->ct.orig_tp.dst,
-				output->ct_orig_proto,
-			};
+			struct ovs_key_ct_tuple_ipv6 orig;
+
+			memset(&orig, 0, sizeof(orig));
+			memcpy(orig.ipv6_src, output->ipv6.ct_orig.src.s6_addr32,
+			       sizeof(orig.ipv6_src));
+			memcpy(orig.ipv6_dst, output->ipv6.ct_orig.dst.s6_addr32,
+			       sizeof(orig.ipv6_dst));
+			orig.src_port = output->ct.orig_tp.src;
+			orig.dst_port = output->ct.orig_tp.dst;
+			orig.ipv6_proto = output->ct_orig_proto;
+
 			if (nla_put(skb, OVS_KEY_ATTR_CT_ORIG_TUPLE_IPV6,
 				    sizeof(orig), &orig))
 				return -EMSGSIZE;


