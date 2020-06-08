Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8B1C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75DFD2074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591659579;
	bh=FnpfvCY1kK+oJUKHHBWMuFJE4lUNfe9+BmbcSoGl+oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uft50P/qUYBCAJGExzmEjRuInOa4UKzx9qbWwqUSh1LufiBjWw1+XcsmnQEs+gGZc
	 IPZCAj4dPEFkok9IZk0V/KvvfizJeNdxIAw9vNR0t1kWDMNHo2E482Z3/ZRPqNM0Ew
	 MY18cRYuPnSa6NBnyZA3Nw6gPYVHVq/I/AqRlcY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387719AbgFHX2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:28:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387407AbgFHXW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:22:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33212208A7;
        Mon,  8 Jun 2020 23:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658545;
        bh=FnpfvCY1kK+oJUKHHBWMuFJE4lUNfe9+BmbcSoGl+oM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xuMPGiqo+vf7nLRpPE2gMbOCkuVb/lNzxY3WJNmiHKYtpeCiFuxKMvYf2VYNkM0vT
         TUuOpra093uQDkROMIhYKdlhD9MswWwAn7/UT2ldOB6Cc0VI/80c2Q4aReOvGbXZ7D
         4LCI1mr0aMvS6oh2iCZaIOsNu4ZkwubJQVhnGGKs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ido Schimmel <idosch@mellanox.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 167/175] vxlan: Avoid infinite loop when suppressing NS messages with invalid options
Date:   Mon,  8 Jun 2020 19:18:40 -0400
Message-Id: <20200608231848.3366970-167-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231848.3366970-1-sashal@kernel.org>
References: <20200608231848.3366970-1-sashal@kernel.org>
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
index ae59fca96032..03434db36b5c 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -1924,6 +1924,10 @@ static struct sk_buff *vxlan_na_create(struct sk_buff *request,
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

