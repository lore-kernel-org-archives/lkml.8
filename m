Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D179C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 14:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1573E206E6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 14:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Udp+Xn81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgC1OKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 10:10:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:34143 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgC1OKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 10:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585404627;
        bh=HIDEZKg7AykOfEpAZWMSjf5Y8O/Z/Xqtejc6v4E6QRk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Udp+Xn81bCboKS40mWYPzQ2oJ4IYByLyE+QhmLLciiOhKPvJSfn0mEVr74XCtQQ2i
         HPx9LVhXkrvEItXmjf0PdTinXJHeyPHasAPSUijqjD5cTZdCwLbxeN1pC/Tiarl+yV
         msueYBTIQL91q2f9aMa/cwJk/QjKx4olbeZAvWos=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MXp9Y-1ik2d43Vs4-00YEUC; Sat, 28 Mar 2020 15:10:27 +0100
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
Subject: [PATCH] staging: vt6656: Use defines in preamble_type variables
Date:   Sat, 28 Mar 2020 15:09:55 +0100
Message-Id: <20200328140955.23615-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4qwPggfEBu5MUFm8FNxfZQgZqQe9rPwUA/31M3C/IRxc8RItije
 I35xUMIAB4igdortDKOqCpuJGMeIj6ezqh5dKEES/EW+gFOKdHCtwSpXAVIktUSuouEPXCE
 uT/cwNHuGXJWwe3IAEg8JC8FD/n4ATHWEKkokY1n6QZWxV5h72CnvMHfNbJsl5yhc8AUxwk
 wJO/uWLFs+KDoB4ebdTeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t+ipRfVZVbg=:KfY+aNl4fjMrZpVugqNWVW
 8CsbQZoKPmTRR2udY+Pr9Y0xbIcYKu9e4N7nDuXsCoPqxmJzykzuVvek2UIHr/DgXIhzEHUr/
 D3lZbTF3w7zNzO5bXU7vz7Kki2erD23h7uU2UVvgnPdsK9BJP6NYXhmGBRgEs0ZaNJRquTVrO
 7EwbXMz9P3UxdoK9KKVMRi/d/qpyxjnpZDzzbiEkTSJhSSz12yDlMMDlBOOItRtvOBfm1hyn/
 bQTeeTKLaLEiQythWX9AAe6eMmvLFebdH25jVtbgc/eDRGW42bhJSb+Ww8CChQUMA3q0TYYjf
 NT5W5LtJTxbscHAXp6Zqvg+OJJ0Ru/Vn1GjPRVFhJdXNwDWSzp5FIz8CyihUReOhkyESxw+sy
 vSi0vFPraCAxUpE0SuZ/0khbQXcxNEkyxjRmcaCU0HXbaDZ5C+6D0f0YdIPI7RA70OMgdmtQB
 qO72B+gUT/7Wq9oVEha9edKSw8BcTI2rcQhdd5Q1LS3eP5aySLsL/i5SfaiEJ6ZaaW2IxSaMg
 YWfOw8Qy3xCu5J4iw53jlrOw+Rz5Fmais90bU0wMDMdG+Qbc4mlgjp+iSS4Jzys5wCbFG6OGx
 iTpKkWdyZD8W3xisOTQTIFz1vIMYVzNhWAHFosUByDmovWOCuVS56wfipzp6qbRp6U6KnJJSf
 jGL6RHAI7C/goreakKWuKmABM0Bm+20Yjy5VwLCyEhzl3j6BQV+IU7aq1U491jmGfk5UdM+WT
 zDyXH1D5wGMgOtaESnUezfvnlJ/755ey/p+ychjiSNsMcKmY/XNvmh0IAaXqohZClBBxl/+BT
 jcELFuTAngIOEMtie6owwp+dvBd4Hq4vY2gf2CrgusWGkRrfwZzX1cmQ54n4viVfMgFxjIu5d
 kUsx+Xg8aPG2783bAmib2buWc4xxUMnVIO64r4Wx/vret3FTRoU44xj6O1SWdHaEM7MJ2LHxM
 66aejWt2qvOvGUX3r7pWBmmqdTz18XEasmbjR6UY22/rMgYf/zBGdapAmyVDSH5aITMxf4DoB
 walEymN+udcVIBhygD/ssUdibAsx6REOqPAjvE3e73CLXw4nMK4LfgYNGf9+2pCgpivfsWSXf
 kVjHINxcwYUFM3YqFi5tSpBdel874hhIKurNeYJ+eIcTK3FosRmR707YZEbDH/SvrRhe6TpFb
 4lANa1PFKUzAPZ1McPI2190ko1QtHAXKokFvQd1rsajQRXZ9mfUKdUGF+sIThhgDChywtzTFk
 7uIyk2e/Tye6ki4So
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the PREAMBLE_SHORT and PREAMBLE_LONG defines present in the file
"baseband.h" to assign values to preamble_type variables. Also, use the
same defines to make comparisons against this variables.

In this way, avoid the use of numerical literals or boolean values and
make the code more clear.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
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

