Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D604C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 14:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC7BE20661
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 14:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="IIVUyI9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgDYOQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 10:16:33 -0400
Received: from mout.gmx.net ([212.227.15.18]:57057 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgDYOQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 10:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587824136;
        bh=IWQTeuFzj3IxK0YDbZnpgKnVOiUTK+tBGaUm0YMS1Po=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=IIVUyI9TgCaWJ+Pa39x+2sBjdplJhLA0bZmfVWz9iarkCsb6CwA2R/DFN4GMOWI6g
         U9JOiwY8CJ4Kb2SMjvbpo62yN4/u8QJ2koIWt8iQS3FMsjL//ZeRr8HeKNX48xxzM1
         tM4UBrX3RVxYaR40GS+wc0sWdeICKEvAZPcBdrW0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MIx3I-1jmdMY1tIQ-00KOK1; Sat, 25 Apr 2020 16:15:36 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Oscar Carter <oscar.carter@gmx.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: vt6656: Add formula to the vnt_rf_addpower function
Date:   Sat, 25 Apr 2020 16:15:14 +0200
Message-Id: <20200425141514.5528-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zaJ9e5GSSCmq7FylQ3qk0AEDJdvYTo8X9vCSWiONP3IrKhH7cGH
 2z9NLhlyhqMIjKypZuU+ASCo9UhL9fdvklN+LTmKYbSEE6P4rhn61QfipfMQPIF6fYA2fw8
 6toaktOR039LC4AKhNTbGhv1vjSVJ3QQYSvaFVtAE5ZWYjAC+3aVV3eqlhIVBMtssDfYE/u
 RdP6xVLa9K/6TFOtJL7/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fYwMpEDHYMk=:fDA2L151AazJs6IPY6aL38
 2a2p8qy0axLJN3xhDEZwRV37XRu8IX5SUeByiwphE6wXieG6rJ5X4yZeQBdNSns/BDkwKhVTi
 XY6UVoyUihXeiYOO8FblzkEQPmEe1U2YFoXlU7Z1S3+knbt9dbOGvDHTZO1FQbnQ6fojSV5Rk
 x/OiJL5ekcC3EOwL0/qLfWGiA4K4b/iH+tPpKOMsC2Z2QUoavu+II7mUVUGIj7ZZYVmgVTw0X
 ohIpOgXJ9iAThg5pJrbWtnn8Fr0M3BbNhUb0XR1eacLwYgnoV/DRng3g4kbwG5IRFrrU8x7pP
 0tRcBlc5nE66Z09U/L5mrb4EtWlEUQdbyyQoDQ+Df/ghxE4BDAazOnXXqgqPRt6dPP+ewN3Zk
 xv6bz4K0IDEIjKcfvKAY/PG4z3qIowB6vsRnjHu8+59R1tp7pYmtnhviXH8kWWbrebx17gAEI
 1UOEiYSHecXX011Bxqcgw8qcxks5E5YcEQQULO0/LbGvDyJJMZC6RnrVo2DPN+JdiHWvYhOXI
 yPKiC/Jw4SIOXkvoj0jTvS/DfM1w/4+HoBS3wKAG+zR540yZkgCq+8r0G7piXra9q7GaKdF1x
 VI7XwXuVfXHGv97U6lIuH+MrfTv7IrAr8h/qzU7EVz8IoZ8OjzJCnyYpWsr9zbluDCZros/6E
 Q2+w1mhSypQmPMUNNXaCTI9Q8qQP8mxnIl59rVTsGIbVEsMD5Givf+te1/2iJcic+5t4yIg5p
 AEWspC5+C11d5LmGVQbS1hkTwQFDicyIoGVO7spYDmnY6qRkkWqiEbUapOtHa43eapgeXPZ9U
 IDwHbSauP7IkWWk2UEM1aKTqKOxa7256rY8DNs2C03GqE48Cyoe9tclM5feHqmxfRkcmo7hQm
 hybAonLQEGOvTasQhv3DLeZGxsPCwE17kOCpGiC01UcbGFCCVBQzZ1znpwNtzpphgfpT3SYGv
 qkihfYyZ/9oSUhqdHSzX5Ru3AGyhjf0Te7nhhHJzWfHB1L0Nodsfw37AZ2vkWTww+kHk7p+mC
 I1vp860Fgy0CmW+ERzG6sMsxGwZkZtYUeBOpigcPLpwWQCDPYdht/gdTL7DeKCy11aziTrt/i
 MsaGEO8lkOMCHCHRyhhhql4whAS5n3qunMNFIgD8YVWW4qSEhUDUbY7U0U11To/dKXzEIO4yp
 8u6xhBqDNZCcMNLfEV2ndXM2RmgQ/c/Sp9ZVSws+Myl+2AfeiZ88hdxXdaMEXx4UJe6TvwYqp
 XO9Kgqbr1TLE8zSwt
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a formula to calculate the return value of the vnt_rf_addpower
function instead of the "if" statement with literal values for every
case.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
Changelog v1 -> v2
- Change the type of "base" variable from s32 to int as Dan Carpenter
  suggested.
- Remove the "--" postoperator and replace with (base - 1) as Dan
  Carpenter suggested. Also, as this expression has a minus before the
  parenthesis, remove it an apply the minus operator changing the sign of
  "base" and literal "1".

Changelog v2 -> v3
- Replace ternary operators with the equivalents "if" statements as Greg
  Kroah-Hartman suggested.

 drivers/staging/vt6656/rf.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/vt6656/rf.c b/drivers/staging/vt6656/rf.c
index 06fa8867cfa3..05c9d06f84dd 100644
=2D-- a/drivers/staging/vt6656/rf.c
+++ b/drivers/staging/vt6656/rf.c
@@ -538,26 +538,19 @@ int vnt_rf_write_embedded(struct vnt_private *priv, =
u32 data)

 static u8 vnt_rf_addpower(struct vnt_private *priv)
 {
+	int base;
 	s32 rssi =3D -priv->current_rssi;

 	if (!rssi)
 		return 7;

-	if (priv->rf_type =3D=3D RF_VT3226D0) {
-		if (rssi < -70)
-			return 9;
-		else if (rssi < -65)
-			return 7;
-		else if (rssi < -60)
-			return 5;
-	} else {
-		if (rssi < -80)
-			return 9;
-		else if (rssi < -75)
-			return 7;
-		else if (rssi < -70)
-			return 5;
-	}
+	if (priv->rf_type =3D=3D RF_VT3226D0)
+		base =3D -60;
+	else
+		base =3D -70;
+
+	if (rssi < base)
+		return ((rssi - base + 1) / -5) * 2 + 5;

 	return 0;
 }
=2D-
2.20.1

