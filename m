Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66001C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 18:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199C020714
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 18:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="RkKAzv7q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgC1SRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 14:17:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:43097 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgC1SRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 14:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585419453;
        bh=8ClDFE5jb+D6WSqrYcYwBB3UMbtyV3apdX6dVPxKzro=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=RkKAzv7q1RFhXp+JE7EQOC9SrlCodxCVizulEnOAVVk3IV6/QNhftUYCskrt32qFL
         SrkTa434F0Lf8PwamryZgwVEvchTks/FCLChl9FLJcM9ZNtLDd3b3NtjPAYWdHTTn7
         ZxwjHlQ6bLhV3x6991SjByjovGQd4KsQEVvA9Nsc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MvK4f-1jZVtN3fsX-00rHzd; Sat, 28 Mar 2020 19:17:33 +0100
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6656: Refactor the vnt_update_pre_ed_threshold function
Date:   Sat, 28 Mar 2020 19:17:06 +0100
Message-Id: <20200328181706.14276-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6wF4kJiH5B1RFFkaEFpYdT+DGqXNheQYuV0ArwKuD7MrY4UcAMb
 TKBhovAJ5S2QtIMKshVTdD7M/1XC92uKlBri7nzTNelsw6uUsuxlpQpBIOMBbBnTfnfM3mx
 uBzyuCxMEvFGJyhiY0d1XjjGdCT6XoGBhC3A8tC6bQ5+p4qUZsbwffpaCui/UlwYrhlJatR
 wAbaPvRC8z8EUiUpfXWLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O/yTV3qRnN0=:uL8r9Uu/ngFkqmCQAlkZBt
 C5M1+gmfMUulCSGsTwFf1MwNlC5JbaVobd9QcO+71gc9WjMArUT+W5bINfZ37GE2386blqkrM
 o4F0u86ReYr9O4IgCdjmmf5Z2nY2CE+jQ5aSo/yaU2J5Ouyb8Le9s57hG3tPZVhcxKKt3laMK
 o592g+ojZv0hPs9qZFIMH0KcNJAgbZjZCg28TMPuiZb0u1kAui8zJ7pm0FXP1n5FWTyg5oq2p
 rJmLLi6K4fB01PsfV1xgz9yg3O7S7CQQb//dq7iXuwnj3no74LqVqprjU4HP1/MIhOOH909et
 CLur2nsGD52PB4VR35DWKEdaYwYaSZOyqgJb/wYe0kBrmZ4cNrRBujwYLGAjCZtyDRRot7n52
 fAraMYeG1I9Gc88qpqNSzZQWKCubXGw0fMFHpBwx8cTN5ukIpN/CsYSDWcG2b6pb5vlw9MooK
 E3AzvWA8djnoIynGm/BFNv5DgkOIPNzZjKr6BtMh4FL/GnuNdMNZR3nhj4MKS4tZEkfqxTxiY
 a4uTg53sK8m7+GcMOgcb2EeZaqDCp669F07EY1zBbzdgt4ohYkXnGPRR4XaZuwCluZyjrQBvs
 BjDaQxQ79b9ApExqIz4dWaqqDsNjfySd2ZkJgZ3KWyvt4iDXuQHfzaQw0iOkAX+2/VZtbuLoi
 uNk+MJWT6Nrhu7Ac7wa6flAP5mLKtAaQLAXr377AzLdk6i7E0zpgTK/5KDPax4lYMtZYPii8I
 jgkEXw/X6vVthfZz4xeEr7he9/kh3r4hQ6NAFe1Xd3O0MxYyEatfhgSqvpRr1Z4mZ3UnYNsg9
 xEYCsm1qaTP9i7l4aCyU2F39rCluWQWP33yBhid0JEtnobSLb1rDVHE3ez5aFO+jTDkQxvnbG
 YnoQamyk1+1cZYYPrusPevcd+WGtvLcwK3gjgkW5grOqzuGA/LKc196NObXix9RfMwXyCJctR
 z8EPeeZAro3427sb2vg/MIy1MNxz1lFpxKz4f3Rs+LJrDfOM+paCe+CpcfV0G4thwDm27FxBJ
 dK80aLF55d4ndViUVwcli6rMjXIY0iShtfK/WBAvUSkElCDQWOPAdif2mp7PRDd4ZpD1RPyK8
 9L0KN/Qe1TRDQOmqvG3Mg+5kL99aVni27GMGsiPbuxfqJatickMAPKCP2h5u4vuGyZcLXwVWo
 eWEJJUMTQdiOpHXHdvhYP4QF2CUKyXtnYhk+CqX33PZV9pBKhS+DkuVOLRX4ETQifBGbUADBh
 Bocq7bNrZhx5NrZm6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create three arrays with the threshold data use in the switch statement
of the vnt_update_pre_ed_threshold function. These three arrays contains
elements of struct vnt_threshold new type.

Create a for loop in the vnt_update_pre_ed_threshold function to do
exactly the same that the if-elseif-else statements in the switch
statement.

Also, remove the if check against the !cr_201 && !cr_206 due to now it
is replace by the NULL check against the threshold pointer. When this
pointer is NULL means that the cr_201 and cr_206 variables have not been
assigned, that is the same that the old comparison against cr_201 and
cr_206 due to these variables were initialized with 0.

The statistics of the old baseband object file are:

section              size   addr
.text                3415      0
.data                 576      0
.bss                    0      0
.rodata               120      0
.comment               45      0
.note.GNU-stack         0      0
.note.gnu.property     28      0
Total                4184

The statistics of the new baseband object file are:

section              size   addr
.text                2209      0
.data                 576      0
.bss                    0      0
.rodata               344      0
.comment               45      0
.note.GNU-stack         0      0
.note.gnu.property     28      0
Total                3202

With this refactoring it increase a little the readonly data but it
decrease much more the .text section. This refactoring decrease the
footprint and makes the code more clear.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/baseband.c | 335 +++++++++---------------------
 1 file changed, 100 insertions(+), 235 deletions(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/ba=
seband.c
index a19a563d8bcc..e03f83e1c394 100644
=2D-- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -115,6 +115,86 @@ static const u16 vnt_frame_time[MAX_RATE] =3D {
 	10, 20, 55, 110, 24, 36, 48, 72, 96, 144, 192, 216
 };

+struct vnt_threshold {
+	u8 bb_pre_ed_rssi;
+	u8 cr_201;
+	u8 cr_206;
+};
+
+static const struct vnt_threshold al2230_vnt_threshold[] =3D {
+	{0, 0x00, 0x30},	/* Max sensitivity */
+	{68, 0x00, 0x36},
+	{67, 0x00, 0x43},
+	{66, 0x00, 0x51},
+	{65, 0x00, 0x62},
+	{64, 0x00, 0x79},
+	{63, 0x00, 0x93},
+	{62, 0x00, 0xb9},
+	{61, 0x00, 0xe3},
+	{60, 0x01, 0x18},
+	{59, 0x01, 0x54},
+	{58, 0x01, 0xa0},
+	{57, 0x02, 0x20},
+	{56, 0x02, 0xa0},
+	{55, 0x03, 0x00},
+	{53, 0x06, 0x00},
+	{51, 0x09, 0x00},
+	{49, 0x0e, 0x00},
+	{47, 0x15, 0x00},
+	{46, 0x1a, 0x00},
+	{45, 0xff, 0x00}
+};
+
+static const struct vnt_threshold vt3226_vnt_threshold[] =3D {
+	{0, 0x00, 0x24},	/* Max sensitivity */
+	{68, 0x00, 0x2d},
+	{67, 0x00, 0x36},
+	{66, 0x00, 0x43},
+	{65, 0x00, 0x52},
+	{64, 0x00, 0x68},
+	{63, 0x00, 0x80},
+	{62, 0x00, 0x9c},
+	{61, 0x00, 0xc0},
+	{60, 0x00, 0xea},
+	{59, 0x01, 0x30},
+	{58, 0x01, 0x70},
+	{57, 0x01, 0xb0},
+	{56, 0x02, 0x30},
+	{55, 0x02, 0xc0},
+	{53, 0x04, 0x00},
+	{51, 0x07, 0x00},
+	{49, 0x0a, 0x00},
+	{47, 0x11, 0x00},
+	{45, 0x18, 0x00},
+	{43, 0x26, 0x00},
+	{42, 0x36, 0x00},
+	{41, 0xff, 0x00}
+};
+
+static const struct vnt_threshold vt3342_vnt_threshold[] =3D {
+	{0, 0x00, 0x38},	/* Max sensitivity */
+	{66, 0x00, 0x43},
+	{65, 0x00, 0x52},
+	{64, 0x00, 0x68},
+	{63, 0x00, 0x80},
+	{62, 0x00, 0x9c},
+	{61, 0x00, 0xc0},
+	{60, 0x00, 0xea},
+	{59, 0x01, 0x30},
+	{58, 0x01, 0x70},
+	{57, 0x01, 0xb0},
+	{56, 0x02, 0x30},
+	{55, 0x02, 0xc0},
+	{53, 0x04, 0x00},
+	{51, 0x07, 0x00},
+	{49, 0x0a, 0x00},
+	{47, 0x11, 0x00},
+	{45, 0x18, 0x00},
+	{43, 0x26, 0x00},
+	{42, 0x36, 0x00},
+	{41, 0xff, 0x00}
+};
+
 /*
  * Description: Calculate data frame transmitting time
  *
@@ -572,254 +652,42 @@ int vnt_exit_deep_sleep(struct vnt_private *priv)

 void vnt_update_pre_ed_threshold(struct vnt_private *priv, int scanning)
 {
-	u8 cr_201 =3D 0x0, cr_206 =3D 0x0;
+	const struct vnt_threshold *threshold =3D NULL;
+	u8 length;
+	u8 cr_201, cr_206;
 	u8 ed_inx =3D priv->bb_pre_ed_index;

 	switch (priv->rf_type) {
 	case RF_AL2230:
 	case RF_AL2230S:
 	case RF_AIROHA7230:
-		if (scanning) { /* Max sensitivity */
-			ed_inx =3D 0;
-			cr_206 =3D 0x30;
-			break;
-		}
-
-		if (priv->bb_pre_ed_rssi <=3D 45) {
-			ed_inx =3D 20;
-			cr_201 =3D 0xff;
-		} else if (priv->bb_pre_ed_rssi <=3D 46) {
-			ed_inx =3D 19;
-			cr_201 =3D 0x1a;
-		} else if (priv->bb_pre_ed_rssi <=3D 47) {
-			ed_inx =3D 18;
-			cr_201 =3D 0x15;
-		} else if (priv->bb_pre_ed_rssi <=3D 49) {
-			ed_inx =3D 17;
-			cr_201 =3D 0xe;
-		} else if (priv->bb_pre_ed_rssi <=3D 51) {
-			ed_inx =3D 16;
-			cr_201 =3D 0x9;
-		} else if (priv->bb_pre_ed_rssi <=3D 53) {
-			ed_inx =3D 15;
-			cr_201 =3D 0x6;
-		} else if (priv->bb_pre_ed_rssi <=3D 55) {
-			ed_inx =3D 14;
-			cr_201 =3D 0x3;
-		} else if (priv->bb_pre_ed_rssi <=3D 56) {
-			ed_inx =3D 13;
-			cr_201 =3D 0x2;
-			cr_206 =3D 0xa0;
-		} else if (priv->bb_pre_ed_rssi <=3D 57) {
-			ed_inx =3D 12;
-			cr_201 =3D 0x2;
-			cr_206 =3D 0x20;
-		} else if (priv->bb_pre_ed_rssi <=3D 58) {
-			ed_inx =3D 11;
-			cr_201 =3D 0x1;
-			cr_206 =3D 0xa0;
-		} else if (priv->bb_pre_ed_rssi <=3D 59) {
-			ed_inx =3D 10;
-			cr_201 =3D 0x1;
-			cr_206 =3D 0x54;
-		} else if (priv->bb_pre_ed_rssi <=3D 60) {
-			ed_inx =3D 9;
-			cr_201 =3D 0x1;
-			cr_206 =3D 0x18;
-		} else if (priv->bb_pre_ed_rssi <=3D 61) {
-			ed_inx =3D 8;
-			cr_206 =3D 0xe3;
-		} else if (priv->bb_pre_ed_rssi <=3D 62) {
-			ed_inx =3D 7;
-			cr_206 =3D 0xb9;
-		} else if (priv->bb_pre_ed_rssi <=3D 63) {
-			ed_inx =3D 6;
-			cr_206 =3D 0x93;
-		} else if (priv->bb_pre_ed_rssi <=3D 64) {
-			ed_inx =3D 5;
-			cr_206 =3D 0x79;
-		} else if (priv->bb_pre_ed_rssi <=3D 65) {
-			ed_inx =3D 4;
-			cr_206 =3D 0x62;
-		} else if (priv->bb_pre_ed_rssi <=3D 66) {
-			ed_inx =3D 3;
-			cr_206 =3D 0x51;
-		} else if (priv->bb_pre_ed_rssi <=3D 67) {
-			ed_inx =3D 2;
-			cr_206 =3D 0x43;
-		} else if (priv->bb_pre_ed_rssi <=3D 68) {
-			ed_inx =3D 1;
-			cr_206 =3D 0x36;
-		} else {
-			ed_inx =3D 0;
-			cr_206 =3D 0x30;
-		}
+		threshold =3D al2230_vnt_threshold;
+		length =3D ARRAY_SIZE(al2230_vnt_threshold);
 		break;

 	case RF_VT3226:
 	case RF_VT3226D0:
-		if (scanning)	{ /* Max sensitivity */
-			ed_inx =3D 0;
-			cr_206 =3D 0x24;
-			break;
-		}
-
-		if (priv->bb_pre_ed_rssi <=3D 41) {
-			ed_inx =3D 22;
-			cr_201 =3D 0xff;
-		} else if (priv->bb_pre_ed_rssi <=3D 42) {
-			ed_inx =3D 21;
-			cr_201 =3D 0x36;
-		} else if (priv->bb_pre_ed_rssi <=3D 43) {
-			ed_inx =3D 20;
-			cr_201 =3D 0x26;
-		} else if (priv->bb_pre_ed_rssi <=3D 45) {
-			ed_inx =3D 19;
-			cr_201 =3D 0x18;
-		} else if (priv->bb_pre_ed_rssi <=3D 47) {
-			ed_inx =3D 18;
-			cr_201 =3D 0x11;
-		} else if (priv->bb_pre_ed_rssi <=3D 49) {
-			ed_inx =3D 17;
-			cr_201 =3D 0xa;
-		} else if (priv->bb_pre_ed_rssi <=3D 51) {
-			ed_inx =3D 16;
-			cr_201 =3D 0x7;
-		} else if (priv->bb_pre_ed_rssi <=3D 53) {
-			ed_inx =3D 15;
-			cr_201 =3D 0x4;
-		} else if (priv->bb_pre_ed_rssi <=3D 55) {
-			ed_inx =3D 14;
-			cr_201 =3D 0x2;
-			cr_206 =3D 0xc0;
-		} else if (priv->bb_pre_ed_rssi <=3D 56) {
-			ed_inx =3D 13;
-			cr_201 =3D 0x2;
-			cr_206 =3D 0x30;
-		} else if (priv->bb_pre_ed_rssi <=3D 57) {
-			ed_inx =3D 12;
-			cr_201 =3D 0x1;
-			cr_206 =3D 0xb0;
-		} else if (priv->bb_pre_ed_rssi <=3D 58) {
-			ed_inx =3D 11;
-			cr_201 =3D 0x1;
-			cr_206 =3D 0x70;
-		} else if (priv->bb_pre_ed_rssi <=3D 59) {
-			ed_inx =3D 10;
-			cr_201 =3D 0x1;
-			cr_206 =3D 0x30;
-		} else if (priv->bb_pre_ed_rssi <=3D 60) {
-			ed_inx =3D 9;
-			cr_206 =3D 0xea;
-		} else if (priv->bb_pre_ed_rssi <=3D 61) {
-			ed_inx =3D 8;
-			cr_206 =3D 0xc0;
-		} else if (priv->bb_pre_ed_rssi <=3D 62) {
-			ed_inx =3D 7;
-			cr_206 =3D 0x9c;
-		} else if (priv->bb_pre_ed_rssi <=3D 63) {
-			ed_inx =3D 6;
-			cr_206 =3D 0x80;
-		} else if (priv->bb_pre_ed_rssi <=3D 64) {
-			ed_inx =3D 5;
-			cr_206 =3D 0x68;
-		} else if (priv->bb_pre_ed_rssi <=3D 65) {
-			ed_inx =3D 4;
-			cr_206 =3D 0x52;
-		} else if (priv->bb_pre_ed_rssi <=3D 66) {
-			ed_inx =3D 3;
-			cr_206 =3D 0x43;
-		} else if (priv->bb_pre_ed_rssi <=3D 67) {
-			ed_inx =3D 2;
-			cr_206 =3D 0x36;
-		} else if (priv->bb_pre_ed_rssi <=3D 68) {
-			ed_inx =3D 1;
-			cr_206 =3D 0x2d;
-		} else {
-			ed_inx =3D 0;
-			cr_206 =3D 0x24;
-		}
+		threshold =3D vt3226_vnt_threshold;
+		length =3D ARRAY_SIZE(vt3226_vnt_threshold);
 		break;

 	case RF_VT3342A0:
-		if (scanning) { /* need Max sensitivity */
-			ed_inx =3D 0;
-			cr_206 =3D 0x38;
-			break;
-		}
-
-		if (priv->bb_pre_ed_rssi <=3D 41) {
-			ed_inx =3D 20;
-			cr_201 =3D 0xff;
-		} else if (priv->bb_pre_ed_rssi <=3D 42) {
-			ed_inx =3D 19;
-			cr_201 =3D 0x36;
-		} else if (priv->bb_pre_ed_rssi <=3D 43) {
-			ed_inx =3D 18;
-			cr_201 =3D 0x26;
-		} else if (priv->bb_pre_ed_rssi <=3D 45) {
-			ed_inx =3D 17;
-			cr_201 =3D 0x18;
-		} else if (priv->bb_pre_ed_rssi <=3D 47) {
-			ed_inx =3D 16;
-			cr_201 =3D 0x11;
-		} else if (priv->bb_pre_ed_rssi <=3D 49) {
-			ed_inx =3D 15;
-			cr_201 =3D 0xa;
-		} else if (priv->bb_pre_ed_rssi <=3D 51) {
-			ed_inx =3D 14;
-			cr_201 =3D 0x7;
-		} else if (priv->bb_pre_ed_rssi <=3D 53) {
-			ed_inx =3D 13;
-			cr_201 =3D 0x4;
-		} else if (priv->bb_pre_ed_rssi <=3D 55) {
-			ed_inx =3D 12;
-			cr_201 =3D 0x2;
-			cr_206 =3D 0xc0;
-		} else if (priv->bb_pre_ed_rssi <=3D 56) {
-			ed_inx =3D 11;
-			cr_201 =3D 0x2;
-			cr_206 =3D 0x30;
-		} else if (priv->bb_pre_ed_rssi <=3D 57) {
-			ed_inx =3D 10;
-			cr_201 =3D 0x1;
-			cr_206 =3D 0xb0;
-		} else if (priv->bb_pre_ed_rssi <=3D 58) {
-			ed_inx =3D 9;
-			cr_201 =3D 0x1;
-			cr_206 =3D 0x70;
-		} else if (priv->bb_pre_ed_rssi <=3D 59) {
-			ed_inx =3D 8;
-			cr_201 =3D 0x1;
-			cr_206 =3D 0x30;
-		} else if (priv->bb_pre_ed_rssi <=3D 60) {
-			ed_inx =3D 7;
-			cr_206 =3D 0xea;
-		} else if (priv->bb_pre_ed_rssi <=3D 61) {
-			ed_inx =3D 6;
-			cr_206 =3D 0xc0;
-		} else if (priv->bb_pre_ed_rssi <=3D 62) {
-			ed_inx =3D 5;
-			cr_206 =3D 0x9c;
-		} else if (priv->bb_pre_ed_rssi <=3D 63) {
-			ed_inx =3D 4;
-			cr_206 =3D 0x80;
-		} else if (priv->bb_pre_ed_rssi <=3D 64) {
-			ed_inx =3D 3;
-			cr_206 =3D 0x68;
-		} else if (priv->bb_pre_ed_rssi <=3D 65) {
-			ed_inx =3D 2;
-			cr_206 =3D 0x52;
-		} else if (priv->bb_pre_ed_rssi <=3D 66) {
-			ed_inx =3D 1;
-			cr_206 =3D 0x43;
-		} else {
-			ed_inx =3D 0;
-			cr_206 =3D 0x38;
-		}
+		threshold =3D vt3342_vnt_threshold;
+		length =3D ARRAY_SIZE(vt3342_vnt_threshold);
 		break;
 	}

+	if (!threshold)
+		return;
+
+	for (ed_inx =3D scanning ? 0 : length - 1; ed_inx > 0; ed_inx--) {
+		if (priv->bb_pre_ed_rssi <=3D threshold[ed_inx].bb_pre_ed_rssi)
+			break;
+	}
+
+	cr_201 =3D threshold[ed_inx].cr_201;
+	cr_206 =3D threshold[ed_inx].cr_206;
+
 	if (ed_inx =3D=3D priv->bb_pre_ed_index && !scanning)
 		return;

@@ -828,9 +696,6 @@ void vnt_update_pre_ed_threshold(struct vnt_private *p=
riv, int scanning)
 	dev_dbg(&priv->usb->dev, "%s bb_pre_ed_rssi %d\n",
 		__func__, priv->bb_pre_ed_rssi);

-	if (!cr_201 && !cr_206)
-		return;
-
 	vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG, 0xc9, cr_201);
 	vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG, 0xce, cr_206);
 }
=2D-
2.20.1

