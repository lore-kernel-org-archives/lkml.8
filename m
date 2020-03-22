Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8970CC54EEB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 11:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC93206F8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 11:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dkMDcncr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgCVLYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 07:24:18 -0400
Received: from mout.gmx.net ([212.227.15.18]:57025 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbgCVLYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 07:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584876251;
        bh=2OfMz68fZcjyzYOJnTOBgsYuScztKPJ6ntaCVj5jt/0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=dkMDcncr31iy7F6+uSADPNxS3aP7BED9iOPjRmh3VB/wI+M/HsRN9ET4f2umlnbhB
         0T03qpvAl8gPnAKmcsQqxhgYrUJHwIlYQcV/wG/cWGDYqQytrcXhue/9UsMkEJHOQu
         fjzCdDJF5fZB+jCZ+h/QS4Kbi+UioA/0bNXlBgP8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1Mdeb5-1jp2Tq2X8T-00ZecY; Sun, 22 Mar 2020 12:24:11 +0100
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Oscar Carter <oscar.carter@gmx.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6656: Use DIV_ROUND_UP macro instead of specific code
Date:   Sun, 22 Mar 2020 12:23:42 +0100
Message-Id: <20200322112342.9040-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QcrRCzsISLPdRLV/rxdGZpgJj1BH2D/hXWF8r0pOjAM6J/ZAoVg
 ZRuRD7YzqJ4EqUkT9nC29B6GyZJWvrqD2ykxtFLF7C6NOrTi5+c9TJJqrmwi/BPLrf3YzcY
 FjvOygTPILYo5bibzBXptJQ60s/0acM9kFWT3K15mGp7cOdHBBw/ive8UxMENjAp4Wp4khb
 c+uOinyGlaG+vOwNzEwuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:spl5UPks56o=:c9soitPABpcjTQjStixt2M
 nseBB2ZCj2flGPJHz4Z1H2pOnkvjNDS8lsYKjIg6wrGYcLC96tmI1OdoonKM7PSVtNmMErZRX
 j04S+xgWxbxqSUmLTC//rKLGpiPbY4w+1ZD71bFi/s7IzxBADoVmzAWrxmXDPxs7u0UXBzAzY
 EZx1htdETYun/Hn7Nq6sU0yBrf9qNFmYCY1n8pVNjCjPb0D4eXMVBXgwoI0GFM5tWUGhfivCv
 GZRgvlNm9df2Atkf7t/tWmjYsTOvr3utOopu8Sr9dXCaPJ+2kz1w0bIQ4ne6jQDWrI1hPydf3
 OPFeD9o82s1y3FUFBNwTHJ5duVRB0U1+iEP8DKt65uE00b4Pe/adXkZRJdK4Om8L6lHl0Sg2Z
 X0e7zSEEhT/BWe1b8iSuTU8CqcwYDhEXqHdZBeCOQ/cZdfr1IFZhy4eMPC0yqWS5UluVVmOIp
 OalVQ+xGbvgSa1cAPExtOGkIBgMoXnhSsdrNb6LeBsc5zwKC6lAXgKyQpr3QaIUqE19g7GBb0
 UaQ9cy2sDzTOjpZBDuH/WgIEyyRdnvPQ0X9502fSfa5v7UYmm6eVrRK1C8cohLoRxBNzBQqp4
 2bQa+nSLHVpEfO0+woivzt4mzxsWW3rh9mGV8T8lcOTv7S8N4rgVGePt31z5HtFFVG/iWtuK7
 rNRQUvwDncbN2W9J4HUXxnnvx5+HyTv7xebRXrlEr7VUApkmV6OGf2ufKlCPLK/V52Ej67+yO
 oZ5OG/vtMcy2V3clgcZNuWsJLuGBqZ8PhkXMxaoEVWMqouCEwuvZ1FbaNjk1WA0ktMu+E4ZKl
 3yc6XtKUxTMXSaxIzgJ01FEmXtJIYd/WccQmwhmK109KkBRvvBmPYUVZk9nhllA+Pv4Cpgyeu
 1XTD1AjS/BgRctZi7bLOKjrQ23ha2livcoN0YqamP8dBCgIkn7A+Tlx7PTaPeEvs5MBkvR5OM
 Pn+t6dEsJ+YOa/MxdghAjrN4AByJCEs9472NjZ1qDB2JpiZAc7ENw2UNWB2/QN9MZCOCzf7Mp
 J6mG6XoalPJCuFEFDU6lHSACZNVKNnp1kua9vzh2+HCX5AWiDFj2YJtLSqQ0gPqDx+JL29gT+
 kPwXmhCeagtfryJUwHASqYwVUer/FWON8ry0ShbjB87gMBP2kpVL70l6oaMfhFfNr8XwhsypR
 CiFdSsYc+TlDMfGxxcM9UnUNdtlc4+2MjKnp3ZA59XXS+53hxiRcsC5SSQaXeEEVY9LpeeA8a
 m4GMWasGol01vN+JU
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DIV_ROUND_UP macro instead of specific code with the same purpose.
Also, remove the unused variables.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/baseband.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/ba=
seband.c
index f18e059ce66b..e2eb2b98a73d 100644
=2D-- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -22,6 +22,7 @@
  *
  */

+#include <linux/kernel.h>
 #include "mac.h"
 #include "baseband.h"
 #include "rf.h"
@@ -132,7 +133,6 @@ unsigned int vnt_get_frame_time(u8 preamble_type, u8 p=
kt_type,
 {
 	unsigned int frame_time;
 	unsigned int preamble;
-	unsigned int tmp;
 	unsigned int rate =3D 0;

 	if (tx_rate > RATE_54M)
@@ -146,20 +146,11 @@ unsigned int vnt_get_frame_time(u8 preamble_type, u8=
 pkt_type,
 		else
 			preamble =3D 192;

-		frame_time =3D (frame_length * 80) / rate;
-		tmp =3D (frame_time * rate) / 80;
-
-		if (frame_length !=3D tmp)
-			frame_time++;
-
+		frame_time =3D DIV_ROUND_UP(frame_length * 80, rate);
 		return preamble + frame_time;
 	}
-	frame_time =3D (frame_length * 8 + 22) / rate;
-	tmp =3D ((frame_time * rate) - 22) / 8;
-
-	if (frame_length !=3D tmp)
-		frame_time++;

+	frame_time =3D DIV_ROUND_UP(frame_length * 8 + 22, rate);
 	frame_time =3D frame_time * 4;

 	if (pkt_type !=3D PK_TYPE_11A)
@@ -213,11 +204,7 @@ void vnt_get_phy_field(struct vnt_private *priv, u32 =
frame_length,

 		break;
 	case RATE_5M:
-		count =3D (bit_count * 10) / 55;
-		tmp =3D (count * 55) / 10;
-
-		if (tmp !=3D bit_count)
-			count++;
+		count =3D DIV_ROUND_UP(bit_count * 10, 55);

 		if (preamble_type =3D=3D 1)
 			phy->signal =3D 0x0a;
=2D-
2.20.1

