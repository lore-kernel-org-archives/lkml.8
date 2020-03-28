Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8975DC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 14:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC7E206DB
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 14:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="BKwwzc+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgC1OSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 10:18:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:44875 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbgC1OSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 10:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585405086;
        bh=SUx80C22dsCXi3ioaoBr0faA646Xc9AQsYzwECabVtM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=BKwwzc+EcfWo75t1wQlgAxvoqfVeraDs/2nXNh1pWHE+dw+/55qtUlNveIiDg4aQt
         6/iHjdbiYLCKTlhc9qEI8jYW+7fq8Q7pYEgXem/p3Lku/DsyXee47iAX0JTLeMID4z
         urbQnvxuJcTOE5j67/dPARSOA5TZnZojYpElLisA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MeU4s-1jqQZd3Wjs-00aXqG; Sat, 28 Mar 2020 15:18:06 +0100
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: vt6656: Use defines in preamble_type variables
Date:   Sat, 28 Mar 2020 15:17:38 +0100
Message-Id: <20200328141738.23810-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:taf/1qb6TVJpY5BRTC2GnU1NkcevxFOvDkNTlR0xv0nWwHz4mtA
 urZ5cTR8TMK+wlutjrF49EGAUcp2LkvUEs2EIR3vO/nkktDOvsVybtVncearcNl+4ax9Ti/
 chaXVjD4vdMXbo4C6X6nDx2Xbec50V501YW9YrFLmRVotwcme6hfUj3k5XIBcUxmPk3M23k
 eggQB2hqgJXabcglDi39g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h1F8Q0YvS4Y=:wWkmqCsp0Xg/95wLuyShEm
 JoUbR4W0dj9+/DWfTu5ozK+gCuTqOZVyk2GoJ2RO/L4aZ7xBmmSOnSVSkqXKxB1NiTkFCvXVy
 jRevW08UVhDpHfeM9H0hJjfMT+gHJQFNMdEMY5S+CfmpLdQwAOk7cRHYpXIZtU6az4L0n7fA3
 drPO1v6KK9oeUh00cuBR3ry58KLGLYK4JM7Yd4M0mLmmCOai5aNqQAt2RtPf6qNPBMKsV2py/
 w3MUdf5Rfhx1ja0vfFml7nmWyN/pOVoG2aH46q0NXSUD/NAqxu930a5y2iwlTawT3dOBh6quv
 gO/IOhrMFqgRL9y3ThwhlmHhHHV5KVJXwO/39RJ1fqqXCGmgiD57gfK4QmqYCd0xB+km0KQAy
 IcvyHcHJP5FfsQeFF8gYQ/AnfagC70ePIHT3N5Xt4lFU31tyW5EB2+Psw6EkgKdRXf3ip2r8N
 D+RSuYnU0WY0u1a+k9KbMb9eLJxUlid24cdqFyWfySX+H6L4T4l8/RDOS/wVT7n1A6bIQKi/R
 loNe2RODYuMEMBTJiSvvAmHYPsNZiT+cXjeK7rPlI4Q8m63nt5/B2Wz3951BPV2ia9gGHIJPZ
 4xjxfu4k66O9pBW8srOqb52UCJoaQawzWWckfxYArTK13QqJLxkyMaW9Q5z7FqcRGrUUDL7Xh
 aqRxNggmgkCxOY7yhBgZwvgN4d68hIG0GYcYM7rhsMWPfc3Qg4tyUJ5vmycYDtJtNo7yf6SfL
 zLUi8yRxrloLz3B6xZl+NtAPDtglSO/slzEj+WJd+8sV/LdGwHVOkjS57UyeF9F6zKrCFr+j/
 m7LUAEDP6H2uwdyikkjymeYOYLpuwNG7GIWjJ+xGKinAB6qZSD7e7ElJ+uyb/sGQ7vE+tgtDH
 lpGbfV7iOweaX9FBTWBX/lJUr3HIkKxEdDKA6XkuXhXYKEFw9+59DLfTzzTi4CUTB05UbXC1g
 WWNcwyAAzflEjhIMu2y4N7qBOngIaJcoJ2ji5bT15he/nkhZe8rakzoLXHCveoU3VYe0AJtHX
 IopucBoYniCDe0QdFtXJQZTzKfnLlo6DJj3cltqikVjzAwIjUUOhc8taZAE/Fa8yWV/Cg7mHE
 qbdYXP8APNEw82ywpGmbpnN/5ilJLAx9bwN4OGkWR/0poccBweejsushWNuvBYiiUTf3ZxlFW
 RIwfTrv2xq7eg91tBmPgPH3jxMZpa86HlihvSpIEF2HYKH8P/9BT/I66PltZ8CbASw+tAQsn7
 WnaQ7XGVkImEQs1O+
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the PREAMBLE_SHORT and PREAMBLE_LONG defines present in the file
"baseband.h" to assign values to preamble_type variables. Also, use the
same defines to make comparisons against these variables.

In this way, avoid the use of numerical literals or boolean values and
make the code more clear.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
Changelog v1 -> v2
- Spell checking correction in the changelog.

 drivers/staging/vt6656/baseband.c | 8 ++++----
 drivers/staging/vt6656/main_usb.c | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/ba=
seband.c
index a19a563d8bcc..9bbafa7fff61 100644
=2D-- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -142,7 +142,7 @@ unsigned int vnt_get_frame_time(u8 preamble_type, u8 p=
kt_type,
 	rate =3D (unsigned int)vnt_frame_time[tx_rate];

 	if (tx_rate <=3D 3) {
-		if (preamble_type =3D=3D 1)
+		if (preamble_type =3D=3D PREAMBLE_SHORT)
 			preamble =3D 96;
 		else
 			preamble =3D 192;
@@ -198,7 +198,7 @@ void vnt_get_phy_field(struct vnt_private *priv, u32 f=
rame_length,
 	case RATE_2M:
 		count =3D bit_count / 2;

-		if (preamble_type =3D=3D 1)
+		if (preamble_type =3D=3D PREAMBLE_SHORT)
 			phy->signal =3D 0x09;
 		else
 			phy->signal =3D 0x01;
@@ -207,7 +207,7 @@ void vnt_get_phy_field(struct vnt_private *priv, u32 f=
rame_length,
 	case RATE_5M:
 		count =3D DIV_ROUND_UP(bit_count * 10, 55);

-		if (preamble_type =3D=3D 1)
+		if (preamble_type =3D=3D PREAMBLE_SHORT)
 			phy->signal =3D 0x0a;
 		else
 			phy->signal =3D 0x02;
@@ -224,7 +224,7 @@ void vnt_get_phy_field(struct vnt_private *priv, u32 f=
rame_length,
 				ext_bit =3D true;
 		}

-		if (preamble_type =3D=3D 1)
+		if (preamble_type =3D=3D PREAMBLE_SHORT)
 			phy->signal =3D 0x0b;
 		else
 			phy->signal =3D 0x03;
diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/ma=
in_usb.c
index 8e7269c87ea9..dd89f98cc18c 100644
=2D-- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -99,7 +99,7 @@ static void vnt_set_options(struct vnt_private *priv)
 	priv->op_mode =3D NL80211_IFTYPE_UNSPECIFIED;
 	priv->bb_type =3D BBP_TYPE_DEF;
 	priv->packet_type =3D priv->bb_type;
-	priv->preamble_type =3D 0;
+	priv->preamble_type =3D PREAMBLE_LONG;
 	priv->exist_sw_net_addr =3D false;
 }

@@ -721,10 +721,10 @@ static void vnt_bss_info_changed(struct ieee80211_hw=
 *hw,
 	if (changed & BSS_CHANGED_ERP_PREAMBLE) {
 		if (conf->use_short_preamble) {
 			vnt_mac_enable_barker_preamble_mode(priv);
-			priv->preamble_type =3D true;
+			priv->preamble_type =3D PREAMBLE_SHORT;
 		} else {
 			vnt_mac_disable_barker_preamble_mode(priv);
-			priv->preamble_type =3D false;
+			priv->preamble_type =3D PREAMBLE_LONG;
 		}
 	}

=2D-
2.20.1

