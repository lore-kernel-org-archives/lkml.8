Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAC2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11BCF20775
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591659270;
	bh=YOvx+5mj0Dgp9Ng7is8QTXRd5/0609AkYbrMTO5lq0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gvxZR1/uvYqnUIyTBJ9up80MeEkRCxpEHwUHMsM/YhEMFXXqnz9as4elsxm0NOcUm
	 G2zXGwYghMRZe3lM7pz9vHbouZmNFlFYtUVAkFZkJzTyJ89YIUc09mxq6oTQ34DsqX
	 c9m0C3LEMo7kMGJTopeD8IBI+kKX2Sk52l0WWba4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732626AbgFHXeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:34:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732171AbgFHX1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:27:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E0FA20801;
        Mon,  8 Jun 2020 23:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658869;
        bh=YOvx+5mj0Dgp9Ng7is8QTXRd5/0609AkYbrMTO5lq0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xQA6drIu2iTxyDeoHXgbVusq3oa+ht7aoknx7PHPIB22VYvXnw5ahbW1zogQjDVuU
         iiUWbCbJiNrPHNQoBQWoSHOBCkxmvB/uhTDqe4w2DPyANyzqv31mFKR/W5UhIBbCom
         PM3f+/IzHkJwPVXUbz+u3jUMM7hQNnFo754UXrfQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ido Schimmel <idosch@mellanox.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 50/50] vxlan: Avoid infinite loop when suppressing NS messages with invalid options
Date:   Mon,  8 Jun 2020 19:26:40 -0400
Message-Id: <20200608232640.3370262-50-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232640.3370262-1-sashal@kernel.org>
References: <20200608232640.3370262-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit 8066e6b449e050675df48e7c4b16c29f00507ff0 ]

When proxy mode is enabled the vxlan device might reply to Neighbor
Solicitation (NS) messages on behalf of remote hosts.

In case the NS message includes the "Source link-layer address" option
[1], the vxlan device will use the specified address as the link-layer
destination address in its reply.

To avoid an infinite loop, break out of the options parsing loop when
encountering an option with length zero and disregard the NS message.

This is consistent with the IPv6 ndisc code and RFC 4886 which states
that "Nodes MUST silently discard an ND packet that contains an option
with length zero" [2].

[1] https://tools.ietf.org/html/rfc4861#section-4.3
[2] https://tools.ietf.org/html/rfc4861#section-4.6

Fixes: 4b29dba9c085 ("vxlan: fix nonfunctional neigh_reduce()")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vxlan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 58ddb6c90418..b1470d30d079 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -1521,6 +1521,10 @@ static struct sk_buff *vxlan_na_create(struct sk_buff *request,
 	daddr = eth_hdr(request)->h_source;
 	ns_olen = request->len - skb_transport_offset(request) - sizeof(*ns);
 	for (i = 0; i < ns_olen-1; i += (ns->opt[i+1]<<3)) {
+		if (!ns->opt[i + 1]) {
+			kfree_skb(reply);
+			return NULL;
+		}
 		if (ns->opt[i] == ND_OPT_SOURCE_LL_ADDR) {
 			daddr = ns->opt + i + sizeof(struct nd_opt_hdr);
 			break;
-- 
2.25.1

