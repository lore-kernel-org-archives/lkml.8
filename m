Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCB8C2D0EC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F288D206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ddbV1GfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgC3Nyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:54:37 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:50882 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgC3Nyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:54:33 -0400
IronPort-SDR: oGXIKI9EGh+fVJpyD9YJqx6xqBN/HkJd+f7H8MGqr/yMg66J4RJlUaWzREy5ukW2jHssjHSOH5
 KN/87vYXunlmHP9YSKOc+LafTYwLheRfAF+VfXx+gkRO975yZ9MO4sEhQ8llW5K3bB4R2am7TM
 pQp1spHPlzl985T9kSsCQnvLpV1+A8y1oUFA1gi4+9txd/dIQ9KJlezlUVSah0xbiVb6Q3Umkb
 dgTQQnq5hinHLJwucWR7NB9SoI4zGSt46vDr+mwYyE+ErqJaLDG0W4DqWNHzHHIpl6e2VU205I
 4kg=
X-IronPort-AV: E=Sophos;i="5.72,324,1580770800"; 
   d="scan'208";a="11606920"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 30 Mar 2020 15:54:28 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 30 Mar 2020 15:54:28 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 30 Mar 2020 15:54:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1585576468; x=1617112468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=RTtPPxYYq8t3b00GlV/IZO1O9+uF2d8Ca1m7XVY2DW8=;
  b=ddbV1GfRNFhkyoePnNIkP+HO9J9SPiPr7qDzp0GIL7e1I/VvDKRS0krh
   ExHbo3c7+lDhmrA5lyreeo4ZgBSRKFB7zPEcYBy+WqKdNc5o2qMfwMgXW
   ZpdfXTUxVjlxGvbrc18NQUU41TWqFVJ5Bn0Wbd4cfQIGyRh90eR6c30UQ
   +uC8gZ74kELRI43lxyGJJnex84fv2Pc99sa6LHUz6IMt1xHQej+f2r2PG
   YrUAgkApjVn3JTIMfGDTgWE56tX/v7RljAqDhG0IlZkczLN5xI0nrYmOW
   y0tkR35dN4YQH8PUk0GwlluAG3InlD4+9Q/S7gljawvNOqCjwdOW6Fapw
   Q==;
IronPort-SDR: flzfqq2x4NGX/BErTh3OgyX0pn0uX7s4Q9Hda0z7nZUTPqUV5qa7agyhmFK4aRPEIsMxM5J+tM
 QqEuetvKOjw8NG2Y1VDDxwQWMu/FRfM7xHRGpqFq1xM4d3YiiWH88VVUAAL/9dUmzBe42XiGDf
 b0ZTFwW0V/I6eVwFgd4vbgLoPjhY/4111MVRa77oBV/FYO94fy330moDmmzcsyGHjkcmaquCjx
 5PmPyR+nm/GTy8yRiEZcpebnR7mQisrhvw6k+a+Svo8qvbWzDPQje4Y714l8lWBXkNmGxmzrkY
 TwA=
X-IronPort-AV: E=Sophos;i="5.72,324,1580770800"; 
   d="scan'208";a="11606919"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 30 Mar 2020 15:54:28 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 1FCFE280065;
        Mon, 30 Mar 2020 15:54:33 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH net-next 3/4] net: dsa: mv88e6xxx: implement get_phy_address
Date:   Mon, 30 Mar 2020 15:53:44 +0200
Message-Id: <20200330135345.4361-3-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200330135345.4361-1-matthias.schiffer@ew.tq-group.com>
References: <20200330135345.4361-1-matthias.schiffer@ew.tq-group.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid the need to specify a PHY for each physical port in the device tree
when phy_base_addr is not 0 (6250 and 6341 families).

This change should be backwards-compatible with existing device trees,
as it only adds sensible defaults where explicit definitions were
required before.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 221593261e8f..228c1b085b66 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5379,6 +5379,13 @@ static enum dsa_tag_protocol mv88e6xxx_get_tag_protocol(struct dsa_switch *ds,
 	return chip->info->tag_protocol;
 }
 
+static int mv88e6xxx_get_phy_address(struct dsa_switch *ds, int port)
+{
+	struct mv88e6xxx_chip *chip = ds->priv;
+
+	return chip->phy_base_addr + port;
+}
+
 static int mv88e6xxx_port_mdb_prepare(struct dsa_switch *ds, int port,
 				      const struct switchdev_obj_port_mdb *mdb)
 {
@@ -5509,6 +5516,7 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.get_tag_protocol	= mv88e6xxx_get_tag_protocol,
 	.setup			= mv88e6xxx_setup,
 	.teardown		= mv88e6xxx_teardown,
+	.get_phy_address	= mv88e6xxx_get_phy_address,
 	.phylink_validate	= mv88e6xxx_validate,
 	.phylink_mac_link_state	= mv88e6xxx_serdes_pcs_get_state,
 	.phylink_mac_config	= mv88e6xxx_mac_config,
-- 
2.17.1

