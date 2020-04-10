Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378F0C2BB86
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DE220753
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="CnTn4UWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgDJL3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 07:29:19 -0400
Received: from mout.gmx.net ([212.227.15.18]:36825 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgDJL3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 07:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586518154;
        bh=KtSi/VbBy7h2f5/PPhtzMU8agjhettQ5lYTN7Xt9ILg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CnTn4UWZFmtqmOQPprxvfziLGj0UNzSaWAMsHldOsEc2eijtqPMNDt5XFc7mY1lO0
         ERfla1e/sCiLcrXm+53FOrHVcF0OgVxvekkn5No8OCWWv1FtI1/t0u1DGhF6ye/Gjk
         Sl8a+by4nIIbl2CdM1gos0uZueTzQLtqeTVAbfgY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MXp9i-1jm6uT3Rbo-00Y6om; Fri, 10 Apr 2020 13:29:13 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: vt6656: Refactor the assignment of the phy->signal variable
Date:   Fri, 10 Apr 2020 13:28:33 +0200
Message-Id: <20200410112834.17490-2-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410112834.17490-1-oscar.carter@gmx.com>
References: <20200410112834.17490-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GwHkx9hixyR4J7tLmd1opGX8K7/qhqgCPuFQ/YcedJdrilOfwu+
 aU4l87PFkEMzp5Y6AvS6hiFvnUcR6reyHplEQKp9JypEER0PulQuDpWYGoemqdV07i7qO4T
 caKntc7XbJtAeWY+ox0XRXABBOSi7rwwOmpEkUmRSq0yEJ4VOV3Lyx1LTaGqyCYLB6Yc5FP
 Zzg9WT57t41Zx14VkHFmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DAq6SO9FoRQ=:Q8Ifa0KpW6o/8CEISXwc/Y
 LaDlaBgPZ66JQxFeeiGcxEsQRrENavN0Wcy8ijatwrGdCAL/tPXrhyjt9XfCgN+sbMtAc34b/
 NjB6IV1Uv8lsP4CNWeYl+uDyCWDVCDQgqSGrUmZdve+/TwHljScqekaNBJtvqsQdtmLnbXpc2
 ca3svRUZYRPFcxKgzKL3/o5cWqFBPskA6+9DE85QEQO1o+jwjzrEmioWkUnb3BakYQVQs7iel
 wZVSUoujaIBJCvs8VnFasIU7RGYbMAlLSXfpxfTLWJLzE11ra/r1994DMONK3kKr1tV+ZlGjh
 +EgxpihynHhOv0OGgO+B0xl5GZPMNkb8P7k0UurjDUF2868dzu1KFbfInXoTAe6zCTm7fENQw
 po0REyPWzHpXuUB97GDswM9Eo9xzLdNadYMZM0cYVXPkrv0RyLRQy0GCiWMhaqJ8fkaUGLjFq
 dBynEJUYt8wReJ3nbbVnqKgsCiUVuQUAn6dDwB2zjzYBAm6BUPFikcJwoJ7OUZ9zN8D70o+hk
 mXpscY3fYTS8JcoOhfTVqasAox5dLz7V0XL1s4lP4aWlE6ruRirm02c+nzqvn/sLI4O73eKbM
 yCfOYGDaXWqUN2GEHctjeZmU/Im61JywiMwEu8464HUkrP7M/eV16RQwnVXK09bV/rzZB9uA9
 kHoDGmGTU1G/3qn6Jm/cKW1OStX20MSjaIRgzSfJ3ezLq+KTaj3qxiCWUxnRzo/Mlm2DBZEyu
 BAfT6Snx3p/cwy9efx6X/jFdtHW/JJV3yDGhCctZKV2kzC4twaYF/pDBAxPbfEtIsPuUXn3V/
 bhatlWfFKeeTMOR1DhHsfqsvauCJGnAJNHv9QuhdsabHd422uFExv3CGr9+o95NGB1l/kZzuQ
 DAnFA2BoAm4ucHO45eflGaYUm0znSKp6yvtkAcA28xY7qYpoSZgO0bY04xMS4V+SoquM1YywK
 W6Q4F/ApVrmFMqd3AvK5Z3m5ATG+JTgQPLTG85l2gBSgei9FRF61e1vVqR4BCJIwLXYP5785X
 nmxZpn64BbuU8TKn5FJuUA4B6rDagxfkqLTRBQIVdC05RSorHIUCtnjhofOpPkNi/kr0Y46eE
 lZaIV3dzrCy6RL4nV54d+m3uE91ZVwGabOZ5GKzV8FdmxadcJH7tnoJs/3HFueXWN24a/fiR5
 kjLZDY9cyY2NO1yAl20TjKs5nkMyVBPB0fNn6Y3vrN1H9P7lwj8k2t/Dc+EjsrFeUBLQUEheI
 Szf5wbYc1hYGZix5M
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a constant array with the values of the "phy->signal" for every
rate. Remove all "phy->signal" assignments inside the switch statement
and replace these with a single reading from the new vnt_phy_signal
array.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/baseband.c | 101 +++++++-----------------------
 1 file changed, 21 insertions(+), 80 deletions(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/ba=
seband.c
index a19a563d8bcc..47f93bf6e07b 100644
=2D-- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -115,6 +115,21 @@ static const u16 vnt_frame_time[MAX_RATE] =3D {
 	10, 20, 55, 110, 24, 36, 48, 72, 96, 144, 192, 216
 };

+static const u8 vnt_phy_signal[][2] =3D {
+	{0x00, 0x00},	/* RATE_1M  */
+	{0x01, 0x09},	/* RATE_2M  */
+	{0x02, 0x0a},	/* RATE_5M  */
+	{0x03, 0x0b},	/* RATE_11M */
+	{0x8b, 0x9b},	/* RATE_6M  */
+	{0x8f, 0x9f},	/* RATE_9M  */
+	{0x8a, 0x9a},	/* RATE_12M */
+	{0x8e, 0x9e},	/* RATE_18M */
+	{0x89, 0x99},	/* RATE_24M */
+	{0x8d, 0x9d},	/* RATE_36M */
+	{0x88, 0x98},	/* RATE_48M */
+	{0x8c, 0x9c}	/* RATE_54M */
+};
+
 /*
  * Description: Calculate data frame transmitting time
  *
@@ -183,6 +198,7 @@ void vnt_get_phy_field(struct vnt_private *priv, u32 f=
rame_length,
 	u32 count =3D 0;
 	u32 tmp;
 	int ext_bit;
+	int i, j;
 	u8 preamble_type =3D priv->preamble_type;

 	bit_count =3D frame_length * 8;
@@ -191,27 +207,12 @@ void vnt_get_phy_field(struct vnt_private *priv, u32=
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
-		if (preamble_type =3D=3D 1)
-			phy->signal =3D 0x09;
-		else
-			phy->signal =3D 0x01;
-
 		break;
 	case RATE_5M:
 		count =3D DIV_ROUND_UP(bit_count * 10, 55);
-
-		if (preamble_type =3D=3D 1)
-			phy->signal =3D 0x0a;
-		else
-			phy->signal =3D 0x02;
-
 		break;
 	case RATE_11M:
 		count =3D bit_count / 11;
@@ -224,74 +225,14 @@ void vnt_get_phy_field(struct vnt_private *priv, u32=
 frame_length,
 				ext_bit =3D true;
 		}

-		if (preamble_type =3D=3D 1)
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
-		break;
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
 		break;
-	case RATE_36M:
-		if (pkt_type =3D=3D PK_TYPE_11A)
-			phy->signal =3D 0x9d;
-		else
-			phy->signal =3D 0x8d;
+	}

-		break;
-	case RATE_48M:
-		if (pkt_type =3D=3D PK_TYPE_11A)
-			phy->signal =3D 0x98;
-		else
-			phy->signal =3D 0x88;
+	i =3D tx_rate > RATE_54M ? RATE_54M : tx_rate;
+	j =3D tx_rate > RATE_11M ? pkt_type =3D=3D PK_TYPE_11A
+			       : preamble_type =3D=3D PREAMBLE_SHORT;

-		break;
-	case RATE_54M:
-		if (pkt_type =3D=3D PK_TYPE_11A)
-			phy->signal =3D 0x9c;
-		else
-			phy->signal =3D 0x8c;
-		break;
-	default:
-		if (pkt_type =3D=3D PK_TYPE_11A)
-			phy->signal =3D 0x9c;
-		else
-			phy->signal =3D 0x8c;
-		break;
-	}
+	phy->signal =3D vnt_phy_signal[i][j];

 	if (pkt_type =3D=3D PK_TYPE_11B) {
 		phy->service =3D 0x00;
=2D-
2.20.1

