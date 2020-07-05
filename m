Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97599C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6623B2074F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=c0d3.blue header.i=@c0d3.blue header.b="KHY10xfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgGES2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 14:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgGES2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 14:28:01 -0400
X-Greylist: delayed 311 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Jul 2020 11:28:01 PDT
Received: from mail.aperture-lab.de (mail.aperture-lab.de [IPv6:2a01:4f8:171:314c::100:a1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72252C061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 11:28:01 -0700 (PDT)
From:   =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
        t=1593973363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BWLNZff+/2GVoco07cWEeMqx/qFYTKj66Lb7zdTUnbM=;
        b=KHY10xfprOr13lO/b9r4ocoUTapsaRf42ZvcqVJnC/K7ZurJWGaaxQb+V6GS61hcLlpAUz
        4CSdTNvRBZAwHl6fVA6ee3y89+1aLdeZInm7FdcO+OAN0GFet0+E1h9dRFObkd3KBdqRre
        VCiMGfA0cpf1c9qlY+jMNE7vbOd+01/nIYnDPEQ+1eXJfSdSvPQzsI7livM9y8FDdu2Es6
        TD+T3ZmXDm8Nugyaa5Sg6vMOucfRG17MqpLQPTIjOnZ1uKZ9hjE+PiPCDNBGETDL+AeIQs
        CaAL3HJZrdJVyxSC1TtAzHDdE7YH/lLGIFAG00GNUNJy5rIvs7Eb63xzwDH7xw==
To:     netdev@vger.kernel.org
Cc:     Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Martin Weinelt <martin@linuxlounge.net>,
        "David S . Miller" <davem@davemloft.net>,
        bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH net] bridge: mcast: Fix MLD2 Report IPv6 payload length check
Date:   Sun,  5 Jul 2020 20:22:34 +0200
Message-Id: <20200705182234.10257-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=linus.luessing@c0d3.blue smtp.mailfrom=linus.luessing@c0d3.blue
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e57f61858b7c ("net: bridge: mcast: fix stale nsrcs pointer in
igmp3/mld2 report handling") introduced a small bug which would potentially
lead to accepting an MLD2 Report with a broken IPv6 header payload length
field.

The check needs to take into account the 2 bytes for the "Number of
Sources" field in the "Multicast Address Record" before reading it.
And not the size of a pointer to this field.

Fixes: e57f61858b7c ("net: bridge: mcast: fix stale nsrcs pointer in igmp3/mld2 report handling")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_multicast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 83490bf73a13..4c4a93abde68 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1000,21 +1000,21 @@ static int br_ip6_multicast_mld2_report(struct net_bridge *br,
 	num = ntohs(icmp6h->icmp6_dataun.un_data16[1]);
 	len = skb_transport_offset(skb) + sizeof(*icmp6h);
 
 	for (i = 0; i < num; i++) {
 		__be16 *_nsrcs, __nsrcs;
 		u16 nsrcs;
 
 		nsrcs_offset = len + offsetof(struct mld2_grec, grec_nsrcs);
 
 		if (skb_transport_offset(skb) + ipv6_transport_len(skb) <
-		    nsrcs_offset + sizeof(_nsrcs))
+		    nsrcs_offset + sizeof(__nsrcs))
 			return -EINVAL;
 
 		_nsrcs = skb_header_pointer(skb, nsrcs_offset,
 					    sizeof(__nsrcs), &__nsrcs);
 		if (!_nsrcs)
 			return -EINVAL;
 
 		nsrcs = ntohs(*_nsrcs);
 		grec_len = struct_size(grec, grec_src, nsrcs);
 
-- 
2.27.0

