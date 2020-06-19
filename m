Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F12C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D76E02073E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="HkhM+Nby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388563AbgFSSty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:49:54 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:61031 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733289AbgFSSty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:49:54 -0400
Date:   Fri, 19 Jun 2020 18:49:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1592592591; bh=xt9FcSDY9Nl6m6FCtdnFPbr4ruQnPLHweIaO3/bHk1k=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=HkhM+Nby1w/55hDva2vkgVpsPydhfO7hd/A5dktc9helG+5XziviKVkl/QXCuRIg6
         tCMLAeuAUD/EkLy25+bDdH1zrNUE5x7F7lqyeIEJnR79shG3VJjKMKFUm/cis7hKRe
         PhjO3KP3OuZ8vOMXveyTVPyDKvwujv7X+KkZtkmntw5s4u3KTQkuX/v7cQ68oEOIe6
         CnlOM/OJbG4Rp5oJBJ/WDxyPWx3Vt9N2hiqwMLEDLXSBzXTCeFkl4plPWV/6ekJL1E
         8LQsC2/lLqSqdmwT5T/tLYA9tQ7h2tu4C8FEhYS/3EOKBZjjzPJLZG2LYJrJbdRN8w
         PRLlaquhkYuVg==
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Michal Kubecek <mkubecek@suse.cz>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Jiri Pirko <jiri@mellanox.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Aya Levin <ayal@mellanox.com>,
        Tom Herbert <therbert@google.com>,
        Alexander Lobakin <alobakin@pm.me>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH net 1/3] net: ethtool: add missing string for NETIF_F_GSO_TUNNEL_REMCSUM
Message-ID: <zFTHRjNWlu4eUUW2ctoeitCl16HlqxNz83PXnzZU-JKukUxUlXl_jpYe8H8tWNgKP1cTbxEogXn3YHD9rmYj3v5h8vLvaQFYePM56sQrrzw=@pm.me>
In-Reply-To: <x6AQUs_HEHFh9N-5HYIEIDvv9krP6Fg6OgEuqUBC6jHmWwaeXSkyLVi05uelpCPAZXlXKlJqbJk8ox3xkIs33KVna41w5es0wJlc-cQhb8g=@pm.me>
References: <x6AQUs_HEHFh9N-5HYIEIDvv9krP6Fg6OgEuqUBC6jHmWwaeXSkyLVi05uelpCPAZXlXKlJqbJk8ox3xkIs33KVna41w5es0wJlc-cQhb8g=@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e585f2363637 ("udp: Changes to udp_offload to support remote
checksum offload") added new GSO type and a corresponding netdev
feature, but missed Ethtool's 'netdev_features_strings' table.
Give it a name so it will be exposed to userspace and become available
for manual configuration.

Fixes: e585f2363637 ("udp: Changes to udp_offload to support remote
checksum offload")
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
---
 net/ethtool/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 47f63526818e..aaecfc916a4d 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -40,6 +40,7 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][=
ETH_GSTRING_LEN] =3D {
 =09[NETIF_F_GSO_UDP_TUNNEL_BIT] =3D=09 "tx-udp_tnl-segmentation",
 =09[NETIF_F_GSO_UDP_TUNNEL_CSUM_BIT] =3D "tx-udp_tnl-csum-segmentation",
 =09[NETIF_F_GSO_PARTIAL_BIT] =3D=09 "tx-gso-partial",
+=09[NETIF_F_GSO_TUNNEL_REMCSUM_BIT] =3D "tx-tunnel-remcsum-segmentation",
 =09[NETIF_F_GSO_SCTP_BIT] =3D=09 "tx-sctp-segmentation",
 =09[NETIF_F_GSO_ESP_BIT] =3D=09=09 "tx-esp-segmentation",
 =09[NETIF_F_GSO_UDP_L4_BIT] =3D=09 "tx-udp-segmentation",
--=20
2.27.0


