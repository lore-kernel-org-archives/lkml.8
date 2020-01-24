Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3445BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31AE22522
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579875689;
	bh=gbSUbp2Y+lwHdwPhmX4qakw92SmAT6LU7/lz0wpkvoE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=MjlLjhlY2dzcYf4UBuYPApB4WsF3NluyyO39OSePFL6w6vQ2PBufrC7D6MpBi6eta
	 naPrBTklMbVNwalxrfyeWS6q+X6CE4DHlcbVhO4WFoVH/mEENYElh27ZmHKAKVcnSo
	 YDcTuA6RBfUXeDnwLBHWOC1+Dtq0TgNyFVUAqtis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392204AbgAXOV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:21:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387438AbgAXOVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:21:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4390520661;
        Fri, 24 Jan 2020 14:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875681;
        bh=gbSUbp2Y+lwHdwPhmX4qakw92SmAT6LU7/lz0wpkvoE=;
        h=From:To:Cc:Subject:Date:From;
        b=iNvib8P4xgHXDvO+yujxMVfxOXxeeG/qNJFsdSieLaDIMYJRXksz0dhX/343yjZBk
         +982aIIQdqNqX/Oo8uRpyb2y6y7oJjh3g0Eexf7quNaHzSXVbTj64L/GRTMl2ZT8D4
         t19RrIj0tw/4beNmphD+VehdxQ2AH/aOsgaF4s5E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <sashal@kernel.org>,
        b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 01/32] batman-adv: Fix DAT candidate selection on little endian systems
Date:   Fri, 24 Jan 2020 09:20:48 -0500
Message-Id: <20200124142119.30484-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Eckelmann <sven@narfation.org>

[ Upstream commit 4cc4a1708903f404d2ca0dfde30e71e052c6cbc9 ]

The distributed arp table is using a DHT to store and retrieve MAC address
information for an IP address. This is done using unicast messages to
selected peers. The potential peers are looked up using the IP address and
the VID.

While the IP address is always stored in big endian byte order, this is not
the case of the VID. It can (depending on the host system) either be big
endian or little endian. The host must therefore always convert it to big
endian to ensure that all devices calculate the same peers for the same
lookup data.

Fixes: be1db4f6615b ("batman-adv: make the Distributed ARP Table vlan aware")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/distributed-arp-table.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 8d1d0fdb157e7..1519cbf70150b 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -243,6 +243,7 @@ static u32 batadv_hash_dat(const void *data, u32 size)
 	u32 hash = 0;
 	const struct batadv_dat_entry *dat = data;
 	const unsigned char *key;
+	__be16 vid;
 	u32 i;
 
 	key = (const unsigned char *)&dat->ip;
@@ -252,7 +253,8 @@ static u32 batadv_hash_dat(const void *data, u32 size)
 		hash ^= (hash >> 6);
 	}
 
-	key = (const unsigned char *)&dat->vid;
+	vid = htons(dat->vid);
+	key = (__force const unsigned char *)&vid;
 	for (i = 0; i < sizeof(dat->vid); i++) {
 		hash += key[i];
 		hash += (hash << 10);
-- 
2.20.1

