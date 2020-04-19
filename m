Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453EEC3A5A9
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 10:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B39F21841
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 10:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PORkuIGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgDSKJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 06:09:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:34981 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgDSKJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 06:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587290989;
        bh=lIf5bgcA25Z1Aku6L9AbtpAcZaG4MIm+fbfvj0UG7eU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=PORkuIGReOtaAamnTTUluV7uXI/uC7W4H35LBpV8NEyl0c7pWZ9DkjKPUoncFw1ie
         wwQCzEOgBlMUKGSDMgOP93Ay9Zq8bw0xmxGI0FZXCRsAJJAz27aNKy63tUyWkuhGJ/
         kOWddRwIPRo0J1SI1X7trHKVEJK2pAQ1VZTRMPnM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MYvcA-1jm9z30C12-00Uo5s; Sun, 19 Apr 2020 12:09:49 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Oscar Carter <oscar.carter@gmx.com>,
        "John B . Wyatt IV" <jbwyatt4@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6656: Use fls instead of for loop in vnt_update_top_rates
Date:   Sun, 19 Apr 2020 12:09:21 +0200
Message-Id: <20200419100921.5421-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G2Hj3rgbNd/bm1y/xb0DINTgbsjen7+NgoFZPsV2AMlZuRhXJrC
 9nqILO99edjQUyQLL7VAATsI1Wj51OsBxJB5hcSJJ1Bb3WcNKW0G/U3zU0QNLFSiacNDZZQ
 BqWiV+69TMHiey3s/5UXhSFtg6BW82LFC7nbXhpc++4odyNDKEgA98tK2VQIrxx/Q0f8Plc
 uX8JLyQ919lnT5qiqPW/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ne/5xuAys5A=:B9H8KWUera+iw1Er6L/pFk
 HM5mE4cULZ93/3slC5qOH9HdULhDJ3NFL0pwPbz5L9e6fkjWZgs6NSXYo1Q+ucDKBVjaEfcgO
 AYYJZPJ8NHtq4DuRjWTgaR5byegBzRdJgVfdsMcJFRibgr/bEmA0xMOzb3vB5Ddp3LYCk+Bho
 H4cJW5fPJSvOkfjT8CoxCZTlezgriTmq4YkfaKs5R6ZzE38qYYbF6yanvI+nslH3KkC0j0dNO
 +TIgbEHUJtBC4+wLrYcW668FDQpdjcHGV5VTxhB2e0fB4v9NGWHZwz4lghrJkfqYtGgYxBIVL
 uXWscsApm3ayO1W2WmNFU1HROhVhXAZW1tUt6dDadPcaRb6wybJodCdGhw2WsuK8OLzHl53JN
 iETtLc9vJOoUxk0kGB7wgLVAB/x/79Tq2oTgnO9SE9JsJxiPCHLhDWQ5+PC3NSKd8tF8lqEs4
 Nfkq2TFEOM5/feZHtzAoyDhjdsu3U43VmCpdVRP0NjI9y5eps+p1WRiBFdbrmSAO5OVbd0hyx
 nGqXe0XmJj0uTf/0vCBepZI2VDFzf8NrYKhckmd34ej5CVbMiXjBcs8yYGIUYTIKMjol/mLBh
 J74dy9kKUzAXFvHImSoSy55wjLFFlOaD1A99s2Av3nh4MnPZl/oy8W3/4pO0vKtMPkF6khPIF
 Y7LBnIQ6x1C/RPBy5Wn/arbz6PAHxmHDtD1fKpyP1FkXCBiDUQqUqLyZcq97fOyh40ph8iM2z
 krVjBiqhzd+iWCiEeWmcvgACWhAboz9ew2CRfkzAtUfnlnds16D/JHZPKVVzfHnuc7kb5d1Ti
 yrMo9paEdskRoP4B2uZHBgOCM8/pbMhuO2mU574OM2k3S+iYlYDhOiok4yJjEpqK5wJZ3+BHI
 F82wQm3U4ukahLI7ln3qL/uL/as0vBLup6CpfmBCnhelM/Q+GTnVwGSEfdh6/at2fHxn1sW5k
 6PC3vfRtn4zIt5gZxxJ1m9rS/e631oqiAhmdSBTSSNLTvQV2Jx0/22EbFmzPDcMyiNrX/lwdN
 yxKOwpipF4Qf0FcoWtZR9AgEqM0DUek9dT8MbhnJB5Exw5H8zmFw3T/+w3Z3TvVrJE149axNG
 nw3sOLWaIfrAgWt1MNp8J90borPrsnNbRuFVrJRee/ByXdwX/9ZatbRpvWN4dq0WtLy1nwag3
 ZpX9efJ5vRnCA/UkTBiCAF4OZs0MblYqNWfb4ME7JTaHVYLTSux1uJDWBmzYsP2Hbl/t4Frga
 I8U0LvXiXKrspDEV8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the for loops of the vnt_update_top_rates function by the fls
function.

The purpose of the two for loops is to find the most significant bit set
in a range of bits. So, they can be replace by the fls function (find
last set) with a previous mask to define the range.

This way avoid the iteration over unnecessary for loops.

The header "linux/bits.h" can be remove as it is included in the header
"linux/bitops.h".

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/card.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
index 9bd37e57c727..952a7726fdd3 100644
=2D-- a/drivers/staging/vt6656/card.c
+++ b/drivers/staging/vt6656/card.c
@@ -26,7 +26,7 @@
  *
  */

-#include <linux/bits.h>
+#include <linux/bitops.h>
 #include "device.h"
 #include "card.h"
 #include "baseband.h"
@@ -223,29 +223,13 @@ void vnt_update_ifs(struct vnt_private *priv)

 void vnt_update_top_rates(struct vnt_private *priv)
 {
-	u8 top_ofdm =3D RATE_24M, top_cck =3D RATE_1M;
-	u8 i;
+	int pos;

-	/*Determines the highest basic rate.*/
-	for (i =3D RATE_54M; i >=3D RATE_6M; i--) {
-		if (priv->basic_rates & (u16)(1 << i)) {
-			top_ofdm =3D i;
-			break;
-		}
-	}
-
-	priv->top_ofdm_basic_rate =3D top_ofdm;
-
-	for (i =3D RATE_11M;; i--) {
-		if (priv->basic_rates & (u16)(1 << i)) {
-			top_cck =3D i;
-			break;
-		}
-		if (i =3D=3D RATE_1M)
-			break;
-	}
+	pos =3D fls(priv->basic_rates & GENMASK(RATE_54M, RATE_6M));
+	priv->top_ofdm_basic_rate =3D pos ? pos-- : RATE_24M;

-	priv->top_cck_basic_rate =3D top_cck;
+	pos =3D fls(priv->basic_rates & GENMASK(RATE_11M, RATE_1M));
+	priv->top_cck_basic_rate =3D pos ? pos-- : RATE_1M;
 }

 int vnt_ofdm_min_rate(struct vnt_private *priv)
=2D-
2.20.1

