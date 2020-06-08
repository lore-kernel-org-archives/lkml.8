Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BD4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B0F0204EF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591659938;
	bh=WlMZiVHm4EkowZDfAv/FXDl3g5KUViKZ6VTdwrywLfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kjxTZM9BuRVQXQHk+gIWltZ0r3S4K52ENBnTe9V3r89VrDGAkHQzfdFoRe/DWms/X
	 sI9+yhBydIGAoaIfVtIz3TP1+2Ed3PdpsY+blnsoSrF19LM7nKJ62HUXTHS6AQDL6Z
	 lar9g3XlTZNHevmEK3AM/wDbVERrAUudUEndh5zg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbgFHXpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:45:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732000AbgFHX0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:26:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C722820775;
        Mon,  8 Jun 2020 23:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658797;
        bh=WlMZiVHm4EkowZDfAv/FXDl3g5KUViKZ6VTdwrywLfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eQ7BnV5yEmD3UEP6J3Nmam2RuPZva13q7pTAaSjQxvChHGYp4V85GUu/anXHbYxLo
         uYIvFC3wjVunG8Q12VlTzlJz9RAZI6b+no52KdLYWHnps3l4KNBIwqvMMZgZP9pZt9
         KrnAmWqTtgi8WzoioQ/gexs97IQiZwEa2px6s6TQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ido Schimmel <idosch@mellanox.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 71/72] vxlan: Avoid infinite loop when suppressing NS messages with invalid options
Date:   Mon,  8 Jun 2020 19:24:59 -0400
Message-Id: <20200608232500.3369581-71-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232500.3369581-1-sashal@kernel.org>
References: <20200608232500.3369581-1-sashal@kernel.org>
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
index 9bca97d5f063..afdc2c290fd0 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -1610,6 +1610,10 @@ static struct sk_buff *vxlan_na_create(struct sk_buff *request,
 	ns_olen = request->len - skb_network_offset(request) -
 		sizeof(struct ipv6hdr) - sizeof(*ns);
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

