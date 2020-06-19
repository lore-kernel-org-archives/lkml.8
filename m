Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C98AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02B86207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="pFmK8XsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392797AbgFSRfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:35:17 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:18144 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389388AbgFSRfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 13:35:16 -0400
Date:   Fri, 19 Jun 2020 17:35:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1592588112; bh=xt9FcSDY9Nl6m6FCtdnFPbr4ruQnPLHweIaO3/bHk1k=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=pFmK8XsU1mVJCZhek4tdw6HeYYIApc5F2XOqjfO4gclb/IVLX/mXnov8jppqk5MiZ
         Sbk4cGaqJSqhrTTMrMZFbsbAWd3ED8RDbx7zTbueVuEyUZ0ah2kdXJDAk1zjPRPbpK
         ayrT0oVmeM5g3ENuqIu9WLzYjRMjLSG7P6iaxz5szFy+makwHbUkdi3bhLlSLo9ZFu
         tfEcDsxjsoQcCIlr8oZ6uWaO7STPnokRXCDuMo99iVXW823/EMOFAsya0Rys8rrUh1
         M2/31zNktwSEh0tACX0nevon9pfoh+To+GFjKXXwet7ZrTXiutgYdkhjbrpFgYoxLO
         RnPdSetDnL8Lg==
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
Message-ID: <wuvYA00G85-nqZH7xAkdeYgG5fFJE1_Ti_tYpIfzCx_UieXNc4cqFZYSgZmoMeIVqwnsDeraex63OVQ_lM4ixemMVjQCyvdBWfPU4fmxr44=@pm.me>
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


