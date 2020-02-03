Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18991C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8532086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580748170;
	bh=AecKnrKC/Dm5pmNq8baFZPyx+g+kYbE6BtUDc3Tuugw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hu8NXiPGkJRsH+Ub2jZgJM2MLbdu5w5sg0HrkiHgY0PIFcgZaRwloxK4ND8dOA1hS
	 Y9ZUrlfY4KyDA9NLavlL+h5irTYHDYGv/CAg1NLTyfr4Mnwc68o4eMqOXj9ZlxWY/b
	 HRagqtHbW9LApLaTzCbQ+hayRuut0yW7oN0jQEkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbgBCQdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:33:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730629AbgBCQdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:33:41 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08DD721741;
        Mon,  3 Feb 2020 16:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747620;
        bh=AecKnrKC/Dm5pmNq8baFZPyx+g+kYbE6BtUDc3Tuugw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gtTA36opSYr5/DB3ReflYWENDf5YnT7tiVlyWaDcDCFSYNl3OgEQvKT29MksXh5bo
         jOoE9duYPDIojlEAh1NbcMPBnLSbDN+8jqQLqEpBJAV2KQvakqg7g9f2I95/Q5faiN
         aTDyjWiV/HGkG2TZua9pxrZDGLC36WfEXbeG78WU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Praveen Chaudhary <pchaudhary@linkedin.com>,
        Zhenggen Xu <zxu@linkedin.com>,
        Andy Stracner <astracner@linkedin.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 70/70] net: Fix skb->csum update in inet_proto_csum_replace16().
Date:   Mon,  3 Feb 2020 16:20:22 +0000
Message-Id: <20200203161922.147273020@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161912.158976871@linuxfoundation.org>
References: <20200203161912.158976871@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Praveen Chaudhary <praveen5582@gmail.com>

[ Upstream commit 189c9b1e94539b11c80636bc13e9cf47529e7bba ]

skb->csum is updated incorrectly, when manipulation for
NF_NAT_MANIP_SRC\DST is done on IPV6 packet.

Fix:
There is no need to update skb->csum in inet_proto_csum_replace16(),
because update in two fields a.) IPv6 src/dst address and b.) L4 header
checksum cancels each other for skb->csum calculation. Whereas
inet_proto_csum_replace4 function needs to update skb->csum, because
update in 3 fields a.) IPv4 src/dst address, b.) IPv4 Header checksum
and c.) L4 header checksum results in same diff as L4 Header checksum
for skb->csum calculation.

[ pablo@netfilter.org: a few comestic documentation edits ]
Signed-off-by: Praveen Chaudhary <pchaudhary@linkedin.com>
Signed-off-by: Zhenggen Xu <zxu@linkedin.com>
Signed-off-by: Andy Stracner <astracner@linkedin.com>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/utils.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/core/utils.c b/net/core/utils.c
index 2a597ac7808e2..60045e9fea05b 100644
--- a/net/core/utils.c
+++ b/net/core/utils.c
@@ -442,6 +442,23 @@ void inet_proto_csum_replace4(__sum16 *sum, struct sk_buff *skb,
 }
 EXPORT_SYMBOL(inet_proto_csum_replace4);
 
+/**
+ * inet_proto_csum_replace16 - update layer 4 header checksum field
+ * @sum: Layer 4 header checksum field
+ * @skb: sk_buff for the packet
+ * @from: old IPv6 address
+ * @to: new IPv6 address
+ * @pseudohdr: True if layer 4 header checksum includes pseudoheader
+ *
+ * Update layer 4 header as per the update in IPv6 src/dst address.
+ *
+ * There is no need to update skb->csum in this function, because update in two
+ * fields a.) IPv6 src/dst address and b.) L4 header checksum cancels each other
+ * for skb->csum calculation. Whereas inet_proto_csum_replace4 function needs to
+ * update skb->csum, because update in 3 fields a.) IPv4 src/dst address,
+ * b.) IPv4 Header checksum and c.) L4 header checksum results in same diff as
+ * L4 Header checksum for skb->csum calculation.
+ */
 void inet_proto_csum_replace16(__sum16 *sum, struct sk_buff *skb,
 			       const __be32 *from, const __be32 *to,
 			       bool pseudohdr)
@@ -453,9 +470,6 @@ void inet_proto_csum_replace16(__sum16 *sum, struct sk_buff *skb,
 	if (skb->ip_summed != CHECKSUM_PARTIAL) {
 		*sum = csum_fold(csum_partial(diff, sizeof(diff),
 				 ~csum_unfold(*sum)));
-		if (skb->ip_summed == CHECKSUM_COMPLETE && pseudohdr)
-			skb->csum = ~csum_partial(diff, sizeof(diff),
-						  ~skb->csum);
 	} else if (pseudohdr)
 		*sum = ~csum_fold(csum_partial(diff, sizeof(diff),
 				  csum_unfold(*sum)));
-- 
2.20.1



