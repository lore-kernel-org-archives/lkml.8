Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0A1C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D05A2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="acPUgjh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgDKMvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:51:48 -0400
Received: from mout.gmx.net ([212.227.15.15]:51291 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgDKMvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586609503;
        bh=nTa7HOtzBAyYvqCf5UKKR4MsPgngH6j/QGDhtC+XUJI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=acPUgjh22YDKWrgaAaaR7ytINdi8BGD9T0VWP/ctNa2B80Cu/av1QPrxceU1/pcdO
         Y9TSMdOnUGJqIgXJ+YKuPBqaz5jM0n2ZoaC8scJfjlFpwkjJZ2nY+zk06RkjaVGS3A
         K/+DUxcK9sp4p1QFhxv32pwPkRWpNEkWrMMbVdyI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MXp5a-1jmYMN21ZE-00Y83K; Sat, 11 Apr 2020 14:51:43 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: vt6656: Remove duplicate code in vnt_vt3184_init function
Date:   Sat, 11 Apr 2020 14:51:03 +0200
Message-Id: <20200411125104.9625-2-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411125104.9625-1-oscar.carter@gmx.com>
References: <20200411125104.9625-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uZExSfYV5udqcg6iGFAofrLuWYVWILFw9DwS3V2x5QdDJfb9GAm
 iaNORMSdwZTivGom5aF3GnudM/SpQj19UbX8pmpsrcbhUqYNc1J90n6ELdmglUMOh2qOl0B
 ZKwKyE8ckGRvi/WwUFX7Tx0gZglkba9F5JlixIv1j9Xt/XVkFXxfzsi545LJzDySebOSvjH
 NlROT6ly2jtTYI7SGIhqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w49Ddo/k2FQ=:laOUdd0v8usfgjg41SkhPF
 YEiWoL9+QV/PX/bPDE//smI9hWcYT4jZmySDqM+8CPhw+u/maTQY5JL3yDCv395fKRsENYwJH
 ktLjXZAuDxgEpY+W7qw23xcHYPQ7NPYp8YrwBwEtTScH+0ILw0ppwEOd5UDPAfvuh9VO89jTi
 EmKidwqHw0r+RpWrkQdAzST4oxcto5xdy1NchI1Rro6ckN/IGH6j6sfi4Mzacb7z6sSjdHSaM
 h6Juu59t81zlUbpZyQ9Mjvr58BDu8tlrRynTLTjKUR/ULn1MJ3HW9wS3YmQaBUfUavGgFj5vF
 6Vb6aJFBgqX25ITSD7cMRGCPST4pW3kbOhAKUwaDF82HQKIcBppwWoOIaAwlEb7rFe2FpoWb1
 q2YB209UQkqU6rRLyQZIyl/fHHiqdISIDIB/jYrW4yQlumAOnQxT8iQ5en3p9Fu+DocKIlo4H
 Vf5hSOoDllnxHIev4Jr377mVFwIRyRiIA07JNQFRULAsRuSgT86v1HYModWSFBoyE5zA79BBo
 I6p9/IH6ZsfxoWbT35UizGwAnfAVoLB/XfFxb3Uywbrf5zyDTw/G3yZHYKppLg3BYx5dMI+dz
 NdR5ZfHkIFDws1BclycacMfgqyTcl5HAL5FgnOicnUfWb7W7U/clAv32Swj7E2Z5cWKZtYZ/F
 t4bJfxaHhuBChMdzaWgHc1m0AE6DJXLCMMCx/hx6c/1fKKOopcKHNlrdZ8WFgyBuglMjJcH7Z
 tvvIvFJgkh+yJbZAWKVRDT53vEWFjBTAvX4Qel0z9mmP9zPHKq5zmX+AzpGC2D3IOjPtzqMWV
 9snFAQKBi+8Rn7UbSo/Qd5JRbCySKBwItqD6QEpqz6cSkDPDDs+L0vdBsYsxADSI6e7pKxGkk
 mCiu2Kr92xSmICL3VWnb6fLTFcCXbWSoX1MoGFIpiFBotTW51csF82/1iIa5cqiL+5rU4OgN4
 4l5mV3q7AevryigqwV5a5xrC94sggYaj96zkVkIsQCf3dlqajZ0utWNElaO/NMpX7Fjrk/SRY
 wsS7mfWG274lGXPqqPU0zJnTQITtDREiKzVGz7fWhOqxbE2Yuo2tEKc0CuQQAUr8fWp1dk05Z
 KcDjfdDt4Yb0wguE6LKhOPzqynea9HHb1cYBV+DBQSB3jzRGovgfIEjLaMpKSR3g07CWIRz0G
 bkn8OMqqJ29wXVZ+7AGZPxImz75De7fm2Vz6Y7PZxtyLXSK7yA0Y8srtSXiqpC89A3eV0bpZA
 LfYOmq6dk7ypdOeZ0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate code in "if" statements because different branches are
almost the same.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/baseband.c | 52 +++++++------------------------
 1 file changed, 12 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/ba=
seband.c
index a19a563d8bcc..276210a7284e 100644
=2D-- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -366,23 +366,15 @@ int vnt_vt3184_init(struct vnt_private *priv)

 	dev_dbg(&priv->usb->dev, "RF Type %d\n", priv->rf_type);

-	if (priv->rf_type =3D=3D RF_AL2230 ||
-	    priv->rf_type =3D=3D RF_AL2230S) {
+	if ((priv->rf_type =3D=3D RF_AL2230) ||
+	    (priv->rf_type =3D=3D RF_AL2230S) ||
+	    (priv->rf_type =3D=3D RF_AIROHA7230)) {
 		priv->bb_rx_conf =3D vnt_vt3184_al2230[10];
 		length =3D sizeof(vnt_vt3184_al2230);
 		addr =3D vnt_vt3184_al2230;

-		priv->bb_vga[0] =3D 0x1C;
-		priv->bb_vga[1] =3D 0x10;
-		priv->bb_vga[2] =3D 0x0;
-		priv->bb_vga[3] =3D 0x0;
-
-	} else if (priv->rf_type =3D=3D RF_AIROHA7230) {
-		priv->bb_rx_conf =3D vnt_vt3184_al2230[10];
-		length =3D sizeof(vnt_vt3184_al2230);
-		addr =3D vnt_vt3184_al2230;
-
-		addr[0xd7] =3D 0x06;
+		if (priv->rf_type =3D=3D RF_AIROHA7230)
+			addr[0xd7] =3D 0x06;

 		priv->bb_vga[0] =3D 0x1c;
 		priv->bb_vga[1] =3D 0x10;
@@ -390,22 +382,8 @@ int vnt_vt3184_init(struct vnt_private *priv)
 		priv->bb_vga[3] =3D 0x0;

 	} else if ((priv->rf_type =3D=3D RF_VT3226) ||
-			(priv->rf_type =3D=3D RF_VT3226D0)) {
-		priv->bb_rx_conf =3D vnt_vt3184_vt3226d0[10];
-		length =3D sizeof(vnt_vt3184_vt3226d0);
-		addr =3D vnt_vt3184_vt3226d0;
-
-		priv->bb_vga[0] =3D 0x20;
-		priv->bb_vga[1] =3D 0x10;
-		priv->bb_vga[2] =3D 0x0;
-		priv->bb_vga[3] =3D 0x0;
-
-		/* Fix VT3226 DFC system timing issue */
-		ret =3D vnt_mac_reg_bits_on(priv, MAC_REG_SOFTPWRCTL2,
-					  SOFTPWRCTL_RFLEOPT);
-		if (ret)
-			goto end;
-	} else if (priv->rf_type =3D=3D RF_VT3342A0) {
+		   (priv->rf_type =3D=3D RF_VT3226D0) ||
+		   (priv->rf_type =3D=3D RF_VT3342A0)) {
 		priv->bb_rx_conf =3D vnt_vt3184_vt3226d0[10];
 		length =3D sizeof(vnt_vt3184_vt3226d0);
 		addr =3D vnt_vt3184_vt3226d0;
@@ -435,19 +413,13 @@ int vnt_vt3184_init(struct vnt_private *priv)
 	if (ret)
 		goto end;

-	if (priv->rf_type =3D=3D RF_VT3226 ||
-	    priv->rf_type =3D=3D RF_VT3342A0) {
-		ret =3D vnt_control_out_u8(priv, MESSAGE_REQUEST_MACREG,
-					 MAC_REG_ITRTMSET, 0x23);
-		if (ret)
-			goto end;
+	if ((priv->rf_type =3D=3D RF_VT3226) ||
+	    (priv->rf_type =3D=3D RF_VT3342A0) ||
+	    (priv->rf_type =3D=3D RF_VT3226D0)) {
+		data =3D (priv->rf_type =3D=3D RF_VT3226D0) ? 0x11 : 0x23;

-		ret =3D vnt_mac_reg_bits_on(priv, MAC_REG_PAPEDELAY, BIT(0));
-		if (ret)
-			goto end;
-	} else if (priv->rf_type =3D=3D RF_VT3226D0) {
 		ret =3D vnt_control_out_u8(priv, MESSAGE_REQUEST_MACREG,
-					 MAC_REG_ITRTMSET, 0x11);
+					 MAC_REG_ITRTMSET, data);
 		if (ret)
 			goto end;

=2D-
2.20.1

