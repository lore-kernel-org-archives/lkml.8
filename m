Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6512C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B742C20737
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fLFFHluG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgDMKU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 06:20:57 -0400
Received: from mout.gmx.net ([212.227.17.20]:42361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728253AbgDMKUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 06:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586773200;
        bh=QiOr1DeVPm8b1WI0oWjMb4zAXSFo1UBAnReM7F1ktdM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=fLFFHluGxWstu0No/gZbOyDkPtMQ/+viCNDTbqlL06TXxyXHEZvCOg8gKPv5TAV9/
         a+3+myAJ9SZjBx44jfLOZHsrE2YWhloO053GnGVQyw22Awvk1cF6q61cKhpidVt/ct
         R0yS/z0E2hBlxDDI5FCDoPc+tsREEalDpRoyRWRQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MDhhX-1jWQWG3Gb9-00An7f; Mon, 13 Apr 2020 12:19:59 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Malcolm Priestley <tvboxspy@gmail.com>,
        Oscar Carter <oscar.carter@gmx.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6656: Return error code in vnt_rf_write_embedded function
Date:   Mon, 13 Apr 2020 12:19:31 +0200
Message-Id: <20200413101931.6334-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gKYAHCKsplbokEjqMBJ57pEksNP3lEOJ+XgziKN3JbeKRuYgO9e
 XfoTV3qN68FeLE1NYV04cgw9wWdNDMJm8imol2QfC0anzzCXIC5DLB24bgC2sZcgX259DM4
 Fv8L69cPcFBdFvzSNvqdtF0TxZX8WqZeArHm7DCaOWgQ+IB1RQJ4A7eE8ZOlQVHSAQ99SXV
 52gS/a9U3lKOYQMz+sVYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TRGExfgQuJw=:OWz++pYOkcTjIa1pR1SQ6g
 wVNMlzZ3JJsOhaCbSGfbnrMgTxCPXXyfi3Z448b9GqtrWWlE9nrVRKCxyasjsmDIytLYBJtys
 5HQ41j7ylHaK1bjOdVVAsMrbEUih3A7zde/+6s/GxdV31a4g8GX9+w+cM+UrSwJ9tvSMwStr/
 ujQEEE+u7/372PvqW34utaMO/za3pZ7Q8zCufyaFTFyk0CBCDXi80VrOLn39UVmogh2YiupBm
 rlJJ5LswXx5TFhTWemrTd+jacC7/1ihSH0/AsxqR1vdhbnneLO87vET/ZeKkxmU+nOh+ON/W/
 DbLe6llWKGIIzwn+KO1atks76md3Mp15qbovhthsjPelIHqNTRG9jMWEVeQI8IxRkYUbu8UZg
 FXEiRywGqWF7C4kBNQ/Uhbf5UtLjXfYnEj339DkaYWR90vLXD6cRdS4XjVT0KVslgsV+Uk/hD
 A+KVCeOy0uJF8n54z/HxICbupHLkYZq6hl+loMBZz0P+7u6cNhNU/zS3u0Jyes0ldaVah5LBR
 0/m3P4mUKTlHSAlWDyURJ8kxeBGwpznv1f4H0JDRm9b5A6xge0vXGhvX7fsnNGCG0AJ3HI8gC
 cwzaP1AtE9wmQZJCKnAYPG4BMo/djy9mEzP1JO3dLmW+xydfMcgj2c9R5NZPCcM5QDFDVOYXX
 S+4zvnlvthusjbxCAXjfZzf3OxqW9MQzUL/A7GjVSLnO0pi1kVohNT/DRM3gv9gdqgf5EMXPq
 80HwW1zt/ayt/QnnJG5ip/wBIzeM4zwF5Y13mOOMDXHlWL6848Oiri5T05LWWk7RQrPIjrVzq
 wtKHskkfJKtvG7rs6Ovr045XtHa/VM3p1HG3wsa3vynCUSucNf2dZ5U/wJ9W5REmp5mKfWD03
 RM6XNVeIhgEC25lICORLpeDbckgipCyfXYtvy2qKOA2tS13W1THxrpcT++KK4nZu4t9mMd+H6
 xnN4tmkdbkhbhr20yHkP1fVZF3GLSXt6E0BY6xbjMq+SwiHUDAcMLjtRQUvefLfQ7lUDsigmh
 IGNRI6iHJno7DXwna3wnwXYZb4mvWtw/rmQRH1KiYMUl7mPfPzK5mne1r1SqQCDXz+drdT9vM
 TW0kwSTZ5LCMO4SLBsH4jC/gY91uVCns+vIe9hdTyy2rd/tNTrpF1kDmiC3LJ6b8U1IIv9USC
 IPNI6h3VGskGh3jGn0Z6YSA2AGAmbM+bcsRt6+jpjjr5Mae8mUgdSPf1AGXC3FO92HQ1TQFsl
 dtqn81HYwDzdtgS2E
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the error code returned by the vnt_control_out function as the
returned value of the vnt_rf_write_embedded function instead of a
boolean value.

Then, fix all vnt_rf_write_embedded calls removing the "and" operations
and replace with a direct assignment to the ret variable and add a check
condition after every call.

Also replace the boolean values true or false in the vnt_rf_set_txpower
function to 0 or error code EINVAL to follow the coding style guide.

The vnt_rf_set_txpower function is called only in the vnt_rf_setpower
function that already returns error codes. The calls to this function
(vnt_rf_set_txpower) not use the returned values, so they not need to be
fixed.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/rf.c | 99 ++++++++++++++++++++++++-------------
 1 file changed, 64 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/vt6656/rf.c b/drivers/staging/vt6656/rf.c
index 4f9aba0f21b0..5270ef511af9 100644
=2D-- a/drivers/staging/vt6656/rf.c
+++ b/drivers/staging/vt6656/rf.c
@@ -21,6 +21,7 @@
  *
  */

+#include <linux/errno.h>
 #include "mac.h"
 #include "rf.h"
 #include "baseband.h"
@@ -531,10 +532,8 @@ int vnt_rf_write_embedded(struct vnt_private *priv, u=
32 data)
 	reg_data[2] =3D (u8)(data >> 16);
 	reg_data[3] =3D (u8)(data >> 24);

-	vnt_control_out(priv, MESSAGE_TYPE_WRITE_IFRF,
-			0, 0, ARRAY_SIZE(reg_data), reg_data);
-
-	return true;
+	return vnt_control_out(priv, MESSAGE_TYPE_WRITE_IFRF, 0, 0,
+			       ARRAY_SIZE(reg_data), reg_data);
 }

 /* Set Tx power by rate and channel number */
@@ -603,14 +602,14 @@ static u8 vnt_rf_addpower(struct vnt_private *priv)
 int vnt_rf_set_txpower(struct vnt_private *priv, u8 power, u32 rate)
 {
 	u32 power_setting =3D 0;
-	int ret =3D true;
+	int ret =3D 0;

 	power +=3D vnt_rf_addpower(priv);
 	if (power > VNT_RF_MAX_POWER)
 		power =3D VNT_RF_MAX_POWER;

 	if (priv->power =3D=3D power)
-		return true;
+		return 0;

 	priv->power =3D power;

@@ -618,35 +617,50 @@ int vnt_rf_set_txpower(struct vnt_private *priv, u8 =
power, u32 rate)
 	case RF_AL2230:
 		power_setting =3D 0x0404090 | (power << 12);

-		ret &=3D vnt_rf_write_embedded(priv, power_setting);
+		ret =3D vnt_rf_write_embedded(priv, power_setting);
+		if (ret)
+			return ret;

 		if (rate <=3D RATE_11M)
-			ret &=3D vnt_rf_write_embedded(priv, 0x0001b400);
+			ret =3D vnt_rf_write_embedded(priv, 0x0001b400);
 		else
-			ret &=3D vnt_rf_write_embedded(priv, 0x0005a400);
+			ret =3D vnt_rf_write_embedded(priv, 0x0005a400);
+
 		break;
 	case RF_AL2230S:
 		power_setting =3D 0x0404090 | (power << 12);

-		ret &=3D vnt_rf_write_embedded(priv, power_setting);
+		ret =3D vnt_rf_write_embedded(priv, power_setting);
+		if (ret)
+			return ret;

 		if (rate <=3D RATE_11M) {
-			ret &=3D vnt_rf_write_embedded(priv, 0x040c1400);
-			ret &=3D vnt_rf_write_embedded(priv, 0x00299b00);
+			ret =3D vnt_rf_write_embedded(priv, 0x040c1400);
+			if (ret)
+				return ret;
+
+			ret =3D vnt_rf_write_embedded(priv, 0x00299b00);
 		} else {
-			ret &=3D vnt_rf_write_embedded(priv, 0x0005a400);
-			ret &=3D vnt_rf_write_embedded(priv, 0x00099b00);
+			ret =3D vnt_rf_write_embedded(priv, 0x0005a400);
+			if (ret)
+				return ret;
+
+			ret =3D vnt_rf_write_embedded(priv, 0x00099b00);
 		}
+
 		break;

 	case RF_AIROHA7230:
 		if (rate <=3D RATE_11M)
-			ret &=3D vnt_rf_write_embedded(priv, 0x111bb900);
+			ret =3D vnt_rf_write_embedded(priv, 0x111bb900);
 		else
-			ret &=3D vnt_rf_write_embedded(priv, 0x221bb900);
+			ret =3D vnt_rf_write_embedded(priv, 0x221bb900);
+
+		if (ret)
+			return ret;

 		if (power >=3D AL7230_PWR_IDX_LEN)
-			return false;
+			return -EINVAL;

 		/*
 		 * 0x080F1B00 for 3 wire control TxGain(D10)
@@ -654,61 +668,76 @@ int vnt_rf_set_txpower(struct vnt_private *priv, u8 =
power, u32 rate)
 		 */
 		power_setting =3D 0x080c0b00 | (power << 12);

-		ret &=3D vnt_rf_write_embedded(priv, power_setting);
-
+		ret =3D vnt_rf_write_embedded(priv, power_setting);
 		break;

 	case RF_VT3226:
 		if (power >=3D VT3226_PWR_IDX_LEN)
-			return false;
+			return -EINVAL;
 		power_setting =3D ((0x3f - power) << 20) | (0x17 << 8);

-		ret &=3D vnt_rf_write_embedded(priv, power_setting);
-
+		ret =3D vnt_rf_write_embedded(priv, power_setting);
 		break;
 	case RF_VT3226D0:
 		if (power >=3D VT3226_PWR_IDX_LEN)
-			return false;
+			return -EINVAL;

 		if (rate <=3D RATE_11M) {
 			u16 hw_value =3D priv->hw->conf.chandef.chan->hw_value;

 			power_setting =3D ((0x3f - power) << 20) | (0xe07 << 8);

-			ret &=3D vnt_rf_write_embedded(priv, power_setting);
-			ret &=3D vnt_rf_write_embedded(priv, 0x03c6a200);
+			ret =3D vnt_rf_write_embedded(priv, power_setting);
+			if (ret)
+				return ret;
+
+			ret =3D vnt_rf_write_embedded(priv, 0x03c6a200);
+			if (ret)
+				return ret;

 			dev_dbg(&priv->usb->dev,
 				"%s 11b channel [%d]\n", __func__, hw_value);

 			hw_value--;

-			if (hw_value < ARRAY_SIZE(vt3226d0_lo_current_table))
-				ret &=3D vnt_rf_write_embedded(priv,
+			if (hw_value < ARRAY_SIZE(vt3226d0_lo_current_table)) {
+				ret =3D vnt_rf_write_embedded(priv,
 					vt3226d0_lo_current_table[hw_value]);
+				if (ret)
+					return ret;
+			}

-			ret &=3D vnt_rf_write_embedded(priv, 0x015C0800);
+			ret =3D vnt_rf_write_embedded(priv, 0x015C0800);
 		} else {
 			dev_dbg(&priv->usb->dev,
 				"@@@@ %s> 11G mode\n", __func__);

 			power_setting =3D ((0x3f - power) << 20) | (0x7 << 8);

-			ret &=3D vnt_rf_write_embedded(priv, power_setting);
-			ret &=3D vnt_rf_write_embedded(priv, 0x00C6A200);
-			ret &=3D vnt_rf_write_embedded(priv, 0x016BC600);
-			ret &=3D vnt_rf_write_embedded(priv, 0x00900800);
+			ret =3D vnt_rf_write_embedded(priv, power_setting);
+			if (ret)
+				return ret;
+
+			ret =3D vnt_rf_write_embedded(priv, 0x00C6A200);
+			if (ret)
+				return ret;
+
+			ret =3D vnt_rf_write_embedded(priv, 0x016BC600);
+			if (ret)
+				return ret;
+
+			ret =3D vnt_rf_write_embedded(priv, 0x00900800);
 		}
+
 		break;

 	case RF_VT3342A0:
 		if (power >=3D VT3342_PWR_IDX_LEN)
-			return false;
+			return -EINVAL;

 		power_setting =3D  ((0x3f - power) << 20) | (0x27 << 8);

-		ret &=3D vnt_rf_write_embedded(priv, power_setting);
-
+		ret =3D vnt_rf_write_embedded(priv, power_setting);
 		break;
 	default:
 		break;
=2D-
2.20.1

