Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EF3C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03B82077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579876069;
	bh=3v/fM/ecCBvsIgWS4BzRSVHHVFOa8m8sqfvh1xJbbkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WVbuTFFfrsiZ7eEj8WY4eM48rhMQE2mI9PLR54Ka63H9LWqmJddGi9HG0z0bqH7Af
	 W+sKA+rQ+bImSwPj9LE68pAhwPHGXTg/BDpNR0XS0OU7QiIcIhjbfgWe93PO39/lpG
	 Z75qBNZXXyl9EJSJZolma44tmUIt7N7ewBexOMFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390546AbgAXO1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:27:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:42906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405265AbgAXOVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:21:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6298A21556;
        Fri, 24 Jan 2020 14:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875677;
        bh=3v/fM/ecCBvsIgWS4BzRSVHHVFOa8m8sqfvh1xJbbkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZJYrGnogD4tlnVXMNr+uLrtFxZn7XM1vg81Ns3D4sfzSdvw5ZTVX2BJvBzft4kk5r
         7cgGj/e2YAW3qwvQ3epB0jTJ70f1fDXSFwTz79L1giJknQRPL/40pqkUVRnHt9gwB9
         q9KrGmW0KQ8j/TgYH2OQIctRurUne+VOPii/W+d8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 55/56] bnxt_en: Fix ipv6 RFS filter matching logic.
Date:   Fri, 24 Jan 2020 09:20:11 -0500
Message-Id: <20200124142012.29752-55-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124142012.29752-1-sashal@kernel.org>
References: <20200124142012.29752-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 6fc7caa84e713f7627e171ab1e7c4b5be0dc9b3d ]

Fix bnxt_fltr_match() to match ipv6 source and destination addresses.
The function currently only checks ipv4 addresses and will not work
corrently on ipv6 filters.

Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2f61175f5655a..5cf85a89016e0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8215,11 +8215,23 @@ static bool bnxt_fltr_match(struct bnxt_ntuple_filter *f1,
 	struct flow_keys *keys1 = &f1->fkeys;
 	struct flow_keys *keys2 = &f2->fkeys;
 
-	if (keys1->addrs.v4addrs.src == keys2->addrs.v4addrs.src &&
-	    keys1->addrs.v4addrs.dst == keys2->addrs.v4addrs.dst &&
-	    keys1->ports.ports == keys2->ports.ports &&
-	    keys1->basic.ip_proto == keys2->basic.ip_proto &&
-	    keys1->basic.n_proto == keys2->basic.n_proto &&
+	if (keys1->basic.n_proto != keys2->basic.n_proto ||
+	    keys1->basic.ip_proto != keys2->basic.ip_proto)
+		return false;
+
+	if (keys1->basic.n_proto == htons(ETH_P_IP)) {
+		if (keys1->addrs.v4addrs.src != keys2->addrs.v4addrs.src ||
+		    keys1->addrs.v4addrs.dst != keys2->addrs.v4addrs.dst)
+			return false;
+	} else {
+		if (memcmp(&keys1->addrs.v6addrs.src, &keys2->addrs.v6addrs.src,
+			   sizeof(keys1->addrs.v6addrs.src)) ||
+		    memcmp(&keys1->addrs.v6addrs.dst, &keys2->addrs.v6addrs.dst,
+			   sizeof(keys1->addrs.v6addrs.dst)))
+			return false;
+	}
+
+	if (keys1->ports.ports == keys2->ports.ports &&
 	    keys1->control.flags == keys2->control.flags &&
 	    ether_addr_equal(f1->src_mac_addr, f2->src_mac_addr) &&
 	    ether_addr_equal(f1->dst_mac_addr, f2->dst_mac_addr))
-- 
2.20.1

