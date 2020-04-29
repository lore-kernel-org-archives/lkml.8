Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E870C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5741020731
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iKZrTlsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgD2PXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:23:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:56041 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgD2PXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588173813;
        bh=hOY4BoONXQi6iRBbmV53XudQnJwUUCIRMOoc3pADbx8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iKZrTlsCKksR/hF4pEuP4DKVUAb8FyKH1d8W+kfE9tFaQ4I9eTEAE6910XeFnfTsk
         8HUKh4xYhepII8OuayptttrxIHj6JDAXo6sHhXeD/d8wX5ZjCbJN8+lQBvvW7VpPyJ
         /IyVYN7d0feLOPyYl2N1L8iOrWYHuFTNYC8RACwg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1M5wLT-1jWGCN2z51-007VGx; Wed, 29 Apr 2020 17:23:32 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: vt6656: Refactor the vnt_set_bss_mode function
Date:   Wed, 29 Apr 2020 17:23:07 +0200
Message-Id: <20200429152307.5871-3-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200429152307.5871-1-oscar.carter@gmx.com>
References: <20200429152307.5871-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yfjrYUI66eQI9hul3e+k2D/Em1cq0YdQebCVxoUmArry/rZNRUX
 VOdAtnNUKDUok28BKCThUy0s2TmYeROBEMBT3KkdQVk0fOqw1cdlJ65Y7So0JWl66bWqVVz
 llGmfC4ei03vZvF96leIpOBEaZ8Qsc/ux/NQWg1iYBiRCfB3DOGZgP3GTwaPzHBEsdyQj5E
 q2tEFKPSeZ0v0nE0dil8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+L8d4eslQi0=:PiD0zclHcpTFTCW6V3bEpn
 6ju7zE58O5sw+e5Pj5N6/V3Vgrc/KWSQ+Y4RRcsR62R15/nMaD5ChoD6BBMzTbLmZX4+BWz5K
 6PhE9Jc2onVyn4Xq3C8De8lRl73g8n62OYnuqFJ4htTtH69K08eLOBfpDqUKEMg37/15dg2Vl
 KyAw0oBO2umzRVaKlONl3K+zfEwVx4OlQ9r0VTLN7egb4prjXmAMdMEiWhXJOCp5Y3Rd1l6Pk
 lxH3UkZCcWP4hTYJYYZSVEX8FUy/mxoXXTu20wQZKmCe5zj5YCCRa6LnICs/o1VHzZR5Typ/M
 D1zubew1/pY8/XTrkNBCXtqbe4OspLMVcPhZNwS9QJb/Sf1+I0+lpEJrW6NHv3Yib4KPAmPzR
 ie5MFywLRk1IWhI1ni0cO1KfrknFPl0ZTG0b12trnogGBqVq8PlGaigE9g2jPLR8egHMlsj3q
 +1sS6TC9KscT//L2GZ4tSss2D5XxGMCdEowRP1ZJu4R2oUwnpgCpW53KqO2lqzHkc5QX24kiO
 mQDFZjBzZpVsM0VqxFLNgX+NahPUVQfTTcIg6qks7YMNuL0UGshDd+2+Orxy1XUFc8ts8GPwB
 2dI+Dg3EsWWzF0jTstSNfn8peYIoikm5eQVyoosndpsaKeIDsXc76ZXaO7i9UNlsDb3TyNpwy
 WPPV4gE4c7OUrBjKNUZbDL2e1Kv9vdH0yX5J8dqCFVB1cvIkcTUNL3RO2LFi7LAW2mQMRsScz
 p8KfgZcJndEqc/YF+Y4d0eM7OoMUYPANwwDwsYngZSuE/u4vrJRMCmUwjbyGlHI/lRuqx4jDF
 VZcHWPQ88OxfB0tKB93Rx5SD2sesFJwRaJO5PdB3xTo1fpe12RiLUO+l7aNMipjvh+m7It6ND
 J+l58h0XV/5c7hyp2hBgYtTxLCBALefCHkjy4XsR3mnwW9ldMqJTsYkn9jIa4jiTZgmMFy9/O
 zt9ikBw8sZD+U1Sv4N19UZ7Z5VVkw9w+azPyw1SDjEtLqLZEdtSUXso2Qc9zLJ7syeGlMgtbv
 R6j8dVz0lWo+siTMeijBQG4qRElf/PioHr42RhGlY5sQJiE8Cp9jWDkkabb7Jw2b/eKU1kydP
 bDX3d1xEFZE1TZvn2AaPSqe997RDBq/yU1Utr2EOVHEcqYYNZxHLhKH6nc9c0q7K7KgxR+kcW
 ajr4rMY9sixy228rYC4GesxF2yEUJdaWHWyA3u76ZwqnXYXgQBf9yFA9/IKhqOsaaNMdMrsjr
 NG3XSsacMcCns8wvA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all the duplicate code in the "if, else if, else" statements as
all the branches in every "if" are almost the same. The only difference
between branches is some value. So, use variables instead of repeat
code.

Also, remove the unnecessary casting to u8 type because the
"priv->bb_type" variable is already an u8 tpe.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/card.c | 68 ++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
index 0854b70cb89f..3cb97c4daeb8 100644
=2D-- a/drivers/staging/vt6656/card.c
+++ b/drivers/staging/vt6656/card.c
@@ -472,62 +472,56 @@ int vnt_radio_power_on(struct vnt_private *priv)
 int vnt_set_bss_mode(struct vnt_private *priv)
 {
 	int ret;
+	unsigned char type =3D priv->bb_type;
+	unsigned char data =3D 0;
+	unsigned char bb_vga_0 =3D 0x1c;
+	unsigned char bb_vga_2_3 =3D 0x00;

 	if (priv->rf_type =3D=3D RF_AIROHA7230 && priv->bb_type =3D=3D BB_TYPE_1=
1A)
-		ret =3D vnt_mac_set_bb_type(priv, BB_TYPE_11G);
-	else
-		ret =3D vnt_mac_set_bb_type(priv, priv->bb_type);
+		type =3D BB_TYPE_11G;

+	ret =3D vnt_mac_set_bb_type(priv, type);
 	if (ret)
 		return ret;

 	priv->packet_type =3D vnt_get_pkt_type(priv);

-	if (priv->bb_type =3D=3D BB_TYPE_11A)
-		ret =3D vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG,
-					 0x88, 0x03);
-	else if (priv->bb_type =3D=3D BB_TYPE_11B)
-		ret =3D vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG,
-					 0x88, 0x02);
-	else if (priv->bb_type =3D=3D BB_TYPE_11G)
+	if (priv->bb_type =3D=3D BB_TYPE_11A) {
+		data =3D 0x03;
+		bb_vga_0 =3D 0x20;
+		bb_vga_2_3 =3D 0x10;
+	} else if (priv->bb_type =3D=3D BB_TYPE_11B) {
+		data =3D 0x02;
+	} else if (priv->bb_type =3D=3D BB_TYPE_11G) {
+		data =3D 0x08;
+	}
+
+	if (data) {
 		ret =3D vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG,
-					 0x88, 0x08);
-	if (ret)
-		return ret;
+					 0x88, data);
+		if (ret)
+			return ret;
+	}

 	ret =3D vnt_update_ifs(priv);
 	if (ret)
 		return ret;

-	ret =3D vnt_set_rspinf(priv, (u8)priv->bb_type);
+	ret =3D vnt_set_rspinf(priv, priv->bb_type);
 	if (ret)
 		return ret;

-	if (priv->bb_type =3D=3D BB_TYPE_11A) {
-		if (priv->rf_type =3D=3D RF_AIROHA7230) {
-			priv->bb_vga[0] =3D 0x20;
+	if (priv->rf_type =3D=3D RF_AIROHA7230) {
+		priv->bb_vga[0] =3D bb_vga_0;

-			ret =3D vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG,
-						 0xe7, priv->bb_vga[0]);
-			if (ret)
-				return ret;
-		}
-
-		priv->bb_vga[2] =3D 0x10;
-		priv->bb_vga[3] =3D 0x10;
-	} else {
-		if (priv->rf_type =3D=3D RF_AIROHA7230) {
-			priv->bb_vga[0] =3D 0x1c;
-
-			ret =3D vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG,
-						 0xe7, priv->bb_vga[0]);
-			if (ret)
-				return ret;
-		}
-
-		priv->bb_vga[2] =3D 0x0;
-		priv->bb_vga[3] =3D 0x0;
+		ret =3D vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG,
+					 0xe7, priv->bb_vga[0]);
+		if (ret)
+			return ret;
 	}

+	priv->bb_vga[2] =3D bb_vga_2_3;
+	priv->bb_vga[3] =3D bb_vga_2_3;
+
 	return vnt_set_vga_gain_offset(priv, priv->bb_vga[0]);
 }
=2D-
2.20.1

