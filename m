Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8CEC3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 13:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3741214DB
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 13:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DiBOvz4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgCANvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 08:51:04 -0500
Received: from mout.gmx.net ([212.227.15.18]:59403 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgCANvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 08:51:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583070657;
        bh=JKoFDKN1cLuoYPsFdgNGMtQg6A4zWvdbaIlDdMrb1gg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=DiBOvz4i1ZCeZlhA73DIs3cpTdi+vFM8wY69/u13XmYZOIoGLBv+IAP8bdAmMqFy+
         lAksbU5s3djzza+ThRbNHWt+hsW2CJyoJvAStNaYm9Sv9acwL5CSwggaOsvPpapaNi
         65UN6wD0ElPxgonAtARcfxXgyur0q3nhwU26Ht2M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1Mxm3Q-1jJr0p1pL4-00zHr0; Sun, 01 Mar 2020 14:50:57 +0100
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Oscar Carter <oscar.carter@gmx.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6656: Remove unnecessary local variables initialization
Date:   Sun,  1 Mar 2020 14:50:28 +0100
Message-Id: <20200301135028.11753-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wGQd9IDuC3R1icM00mwuqQJlfAU6ipGzkF95PmAtlfgTbfQo8pW
 fAHINJIcuPpOYoIj/a0Irb2lx+RX9caYn1yeBJE04wuhrT2MYsSyde+WegWkZMGEoGt9nxp
 5nnjl+zzRdvKMHO/0RIa5jlUU9ginKlmJ7ZOsTufXFMrOEeCZy3ltesNMvAlIKuytCeKlsP
 Urk6F0x4wDp2e+uPkCwAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VGhm5UI6I1o=:bA6E9xDaopggnVetEZ2GKc
 Fll/1WdgVTGHGtBajd4banvKH21lW/CcIt6t5n+T6nMiY18qwQxyItFf8ptRkSNHST8sUXe2/
 uZs6ksMSmfSMZNNsxgR5FvZdvnyCh8tx8os6sLxm7wuNpjhm8RYmdrhG6mD5ded4UZVgC6Ew0
 A8T+x6TWurjhw3QnQ/nhfA0iVE7kmZJiGFoLmrBwalB+bv/+c5G+04C4nX8YxZoWPIC25rNmf
 zCbbyU5zmlUqtHqNYg8NgvyGGe9mbszCeFJGnDsSqi/oxzxxXv+QB5s+BauE/8JLAu1YDioSo
 G9TqrxA1o+QSb0s932otsPX0YDrjywNs/0iHOnJ12uFBuHYuXObIU4PEYfU+vNQBgUJGyIiPC
 A4pQKdIoIdrQhDRC8vcpdrPcKPn+bCYq/wErdUt11iAX6fIfCEf89/gDfWdDSTX+BYOh9IBgo
 JLT6090RP5MmH8xd2p8gXnIuWfR+bg/gly5YWvr+cdDh5hEsQ/nn1hMrMlELUpRfXwg101ohv
 /xuApjPrkOCQzNRrNdDx9vshZtv57g+8caGOr/4I0NSEIpVUT8HOcIWGZ5oZ/s8ll5Lqcb88x
 nDXs40Lk3cF1AGr249BKYoWpQYVN/kRmV4V6e5tivuy/qaob84u638a/76ikXyec2qBek/hHT
 KjIHJT6fpoQz6U9GqTjx9ogqSU7WQXYVjwyzuiVj4DN9UqoUzoU5TLUlhNX0r5J36Pn/T15lA
 cuq0TRumbRReb4evYBqD+9Sp2ZaUHutqpFodsk4SSx5EctkYoUl6hQBtuSDaAG+Lobkw6Qacs
 KXZOG4cwLgQNo6qAgrn75u5UQtiosW8Q2RTQ3H2TszP3wqpw9Ci+c31svEjzFmGSjorLQqD1a
 gpkgnCUH0V4c4k6VNHbL4AEW2EOKIh5SVRHNRkURs/b1MkTVT7zQ8PH9Xtl7C/cjZuzdWiheG
 riptgM+qWlT3nnfBEHY5olaKMgXhiChZBhEYZhmohK+VXsIRgWlooF8xIi3RmKZXr1UUKy1i0
 C4nkozFllmnf8Q+duq1wAZw5u5rZFAIb4c07YezMeG9tetTYvLRiUM6G/wyKwjmI1ycaMBVbp
 UW3Q+7iCtziHFl87qExxPSIwhxj82AeI90a4DYX+mnrwjasfs5neo2cJ2Sw6sGOueb9dHzyI8
 qx3D6jOlqAwORCQdKrd2+JbsdFAhOsw5d10nq5uqfj46uqLa8LuwSnGvEYt/jpWtKhULeAy2k
 AgI1/Xf7zkOSfCL7w
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't initialize variables that are then set a few lines later.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/main_usb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/ma=
in_usb.c
index 701300202b21..bfeb5df896fe 100644
=2D-- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -109,7 +109,7 @@ static void vnt_set_options(struct vnt_private *priv)
  */
 static int vnt_init_registers(struct vnt_private *priv)
 {
-	int ret =3D 0;
+	int ret;
 	struct vnt_cmd_card_init *init_cmd =3D &priv->init_command;
 	struct vnt_rsp_card_init *init_rsp =3D &priv->init_response;
 	u8 antenna;
@@ -435,7 +435,7 @@ static void vnt_free_int_bufs(struct vnt_private *priv=
)

 static int vnt_alloc_bufs(struct vnt_private *priv)
 {
-	int ret =3D 0;
+	int ret;
 	struct vnt_usb_send_context *tx_context;
 	struct vnt_rcb *rcb;
 	int ii;
@@ -528,7 +528,7 @@ static void vnt_tx_80211(struct ieee80211_hw *hw,

 static int vnt_start(struct ieee80211_hw *hw)
 {
-	int ret =3D 0;
+	int ret;
 	struct vnt_private *priv =3D hw->priv;

 	priv->rx_buf_sz =3D MAX_TOTAL_SIZE_WITH_ALL_HEADERS;
@@ -798,7 +798,7 @@ static u64 vnt_prepare_multicast(struct ieee80211_hw *=
hw,
 	struct vnt_private *priv =3D hw->priv;
 	struct netdev_hw_addr *ha;
 	u64 mc_filter =3D 0;
-	u32 bit_nr =3D 0;
+	u32 bit_nr;

 	netdev_hw_addr_list_for_each(ha, mc_list) {
 		bit_nr =3D ether_crc(ETH_ALEN, ha->addr) >> 26;
@@ -973,7 +973,7 @@ vt6656_probe(struct usb_interface *intf, const struct =
usb_device_id *id)
 	struct vnt_private *priv;
 	struct ieee80211_hw *hw;
 	struct wiphy *wiphy;
-	int rc =3D 0;
+	int rc;

 	udev =3D usb_get_dev(interface_to_usbdev(intf));

=2D-
2.20.1

