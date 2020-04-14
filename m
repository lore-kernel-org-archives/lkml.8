Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4783C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A81B8206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KgCGSbwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440685AbgDNPkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:40:42 -0400
Received: from mout.gmx.net ([212.227.15.19]:33139 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440635AbgDNPjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586878783;
        bh=xayl9wr1Zhh2APoyBF+n7OmgkJn/nVrgwCRIOOlv8F4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KgCGSbwazxWP0k9SZLSBRpeMxuMQgGamMe59LQ9Cq7uBTa1m6n8TApHFNqfwacXjQ
         ThakJSdh27Lks6CyHSUQyYrgEuYJU+Cn42qkW+OqIYwmdD7jX/jLRNszGpL9x2AY/j
         vCTVVujET1OnIYVH2kLkAP41ni7ftYYGpo2Ta5Gg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1ML9uK-1jgSmD17PW-00IBXi; Tue, 14 Apr 2020 17:39:43 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] staging: vt6656: Refactor the assignment of the phy->signal variable
Date:   Tue, 14 Apr 2020 17:38:48 +0200
Message-Id: <20200414153849.5785-5-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414153849.5785-1-oscar.carter@gmx.com>
References: <20200414153849.5785-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WULWfV857+3ReqK0uGTtSIhLihDvMVYh4pt9Ad6fOD2coxShS2t
 C+PJi895M1gzYq6KTz/9RhpFYJgy7ciVx/m6oQpYdHaxjDVh4H7J4c0gXaHXKkit3wggFWP
 zb43xmQ3gatPU1R4Z/101hbi3ZLck3pjeerQyGTqeiy5ZqxfiMrS+ErJcxeVPiEHORC8HXh
 tv0CwGAybbr+RJRmeGatQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VrWkre+vVO4=:qClOhRBU9c9lgvyvVQ8/sc
 CNcw6LL6jVIX5ly3kmInF7NvaNDGZHSl055KRAhZ8rJ1+NfUD+/w5vRfth1h6pepIRbhdJcCi
 HiS+fx2N7Z9jECftXE9nPhknJ0MWIrcVbQTt3Fe59fw9jD4pqvy3z2Sdlqz92TIpzhOgw7vCw
 +OQzHlJ8AflXcSGiwAnRgWirnRoDkbdUS2iUtsxf+6A8A8ADRhRDEWLvJYgQTa3u0iKLg7sVG
 HpBKMVHLBJiEPRFiO1Y6/DvzlHIgq8kG0gjq43eVbDYKTdfseH+b8zc8rsOFO2z9GXp1WRCk+
 HSVQ/Ud9hHTNQEasEioUWpInsvy/S9lgfnqy1Y0SWzGcZNNEFIU9W0QO6lzFQkHYMxhMsmqOG
 SiDrB9o3spWxQLZIjPCciE+T/UGO7zA7JovQWkKiOfRihEZASaBhOq/ctuukGL9+cQqvCBTlH
 YMdDnpC6nBTSMjEakKQvHc5kTmveQ87QwA6e4ma4XpY9XOs5GQYTLCqHJSxYoCfvy+mjtvyzI
 IQesgmnhlqR+NNr1WxpXNf9Uj4n61mNM3V4JrD2c7LvJz7n+P9tJb5/wda/V+2mKksDL08ii+
 Qv5QgxEeXgcDO8PBFp9tsG3tasbHGyWMKi+FrkStdwLVmsn6Z5LX8wAOT6iwiTxEMrakpPZv+
 ApGrPkUHkgHs5NNrAupG+J5LIZWim/Oa+Un8WKIFkjdBc/nYO/tOetN72ePRMdtTo+pNpyFVw
 5qPk9TMfVog1LVG9+2DdLPRMMW9phI/7I9Yt8PbHRLsVVuLPJ488eY/lE0tSxlvkBQA0qYZmv
 86CRwftsvH8CuEzB1CTZs3rfWIaT3l7q9gSqUHFah+MwoErj8pKyh+T31Eyqtc6Dw6k7OOzIl
 9W+GHKmCgVxBoy7JuHQcQ7YWJ2GTB6N8EP/mry3V5blv0xLIsCwYTJTRidGS8Gr+t/0gdFPAH
 JlEj1Wga3+FVnED5cPfiaTCFoKT3Vu33IcdewvFXqcnMdbHJ5ZobyAAot3VrL8sVYAt5O+A67
 igGZr5JqLdubSCR610c1XyEqNBCZ6k4e2dtcK4fBVupWZNW36kn62gA1Y/ALSKfYwQNRZzFQu
 aKr9TiAu/NV9hckfIAOW7KKeadYTCfFCCmPRPg7RJUNByKZsqlKJJepnqTVy2Q4SNS786isY7
 BHSvfm7Oz7LJsY/MEQ2a/awyzEyvWlI1UoufzX/CIycL/GDDHrevMVQTXyx+D7MxofPjgBiJj
 Nl3p/5UH/uTdjwF57
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a constant array with the values of the "phy->signal" for every
rate. Remove all "phy->signal" assignments inside the switch statement
and replace these with a single reading from the new vnt_phy_signal
array.

The constant array can be of one dimension because the OR mask with
BIT(3) or BIT(4) allow obtain a second value according to the rate,
the preamble_type and the pkt_type.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/baseband.c | 105 ++++++++----------------------
 1 file changed, 26 insertions(+), 79 deletions(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/ba=
seband.c
index 149c9bba7108..3b6f2bcf91a7 100644
=2D-- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -196,6 +196,21 @@ static const struct vnt_threshold vt3342_vnt_threshol=
d[] =3D {
 	{41, 0xff, 0x00}
 };

+static const u8 vnt_phy_signal[] =3D {
+	0x00,	/* RATE_1M  */
+	0x01,	/* RATE_2M  */
+	0x02,	/* RATE_5M  */
+	0x03,	/* RATE_11M */
+	0x8b,	/* RATE_6M  */
+	0x8f,	/* RATE_9M  */
+	0x8a,	/* RATE_12M */
+	0x8e,	/* RATE_18M */
+	0x89,	/* RATE_24M */
+	0x8d,	/* RATE_36M */
+	0x88,	/* RATE_48M */
+	0x8c	/* RATE_54M */
+};
+
 /*
  * Description: Calculate data frame transmitting time
  *
@@ -264,6 +279,8 @@ void vnt_get_phy_field(struct vnt_private *priv, u32 f=
rame_length,
 	u32 count =3D 0;
 	u32 tmp;
 	int ext_bit;
+	int i;
+	u8 mask =3D 0;
 	u8 preamble_type =3D priv->preamble_type;

 	bit_count =3D frame_length * 8;
@@ -272,27 +289,12 @@ void vnt_get_phy_field(struct vnt_private *priv, u32=
 frame_length,
 	switch (tx_rate) {
 	case RATE_1M:
 		count =3D bit_count;
-
-		phy->signal =3D 0x00;
-
 		break;
 	case RATE_2M:
 		count =3D bit_count / 2;
-
-		if (preamble_type =3D=3D PREAMBLE_SHORT)
-			phy->signal =3D 0x09;
-		else
-			phy->signal =3D 0x01;
-
 		break;
 	case RATE_5M:
 		count =3D DIV_ROUND_UP(bit_count * 10, 55);
-
-		if (preamble_type =3D=3D PREAMBLE_SHORT)
-			phy->signal =3D 0x0a;
-		else
-			phy->signal =3D 0x02;
-
 		break;
 	case RATE_11M:
 		count =3D bit_count / 11;
@@ -305,75 +307,20 @@ void vnt_get_phy_field(struct vnt_private *priv, u32=
 frame_length,
 				ext_bit =3D true;
 		}

-		if (preamble_type =3D=3D PREAMBLE_SHORT)
-			phy->signal =3D 0x0b;
-		else
-			phy->signal =3D 0x03;
-
-		break;
-	case RATE_6M:
-		if (pkt_type =3D=3D PK_TYPE_11A)
-			phy->signal =3D 0x9b;
-		else
-			phy->signal =3D 0x8b;
-
-		break;
-	case RATE_9M:
-		if (pkt_type =3D=3D PK_TYPE_11A)
-			phy->signal =3D 0x9f;
-		else
-			phy->signal =3D 0x8f;
-
-		break;
-	case RATE_12M:
-		if (pkt_type =3D=3D PK_TYPE_11A)
-			phy->signal =3D 0x9a;
-		else
-			phy->signal =3D 0x8a;
-
 		break;
-	case RATE_18M:
-		if (pkt_type =3D=3D PK_TYPE_11A)
-			phy->signal =3D 0x9e;
-		else
-			phy->signal =3D 0x8e;
-
-		break;
-	case RATE_24M:
-		if (pkt_type =3D=3D PK_TYPE_11A)
-			phy->signal =3D 0x99;
-		else
-			phy->signal =3D 0x89;
-
-		break;
-	case RATE_36M:
-		if (pkt_type =3D=3D PK_TYPE_11A)
-			phy->signal =3D 0x9d;
-		else
-			phy->signal =3D 0x8d;
-
-		break;
-	case RATE_48M:
-		if (pkt_type =3D=3D PK_TYPE_11A)
-			phy->signal =3D 0x98;
-		else
-			phy->signal =3D 0x88;
+	}

-		break;
-	case RATE_54M:
-		if (pkt_type =3D=3D PK_TYPE_11A)
-			phy->signal =3D 0x9c;
-		else
-			phy->signal =3D 0x8c;
-		break;
-	default:
+	if (tx_rate > RATE_11M) {
 		if (pkt_type =3D=3D PK_TYPE_11A)
-			phy->signal =3D 0x9c;
-		else
-			phy->signal =3D 0x8c;
-		break;
+			mask =3D BIT(4);
+	} else if (tx_rate > RATE_1M) {
+		if (preamble_type =3D=3D PREAMBLE_SHORT)
+			mask =3D BIT(3);
 	}

+	i =3D tx_rate > RATE_54M ? RATE_54M : tx_rate;
+	phy->signal =3D vnt_phy_signal[i] | mask;
+
 	if (pkt_type =3D=3D PK_TYPE_11B) {
 		phy->service =3D 0x00;
 		if (ext_bit)
=2D-
2.20.1

