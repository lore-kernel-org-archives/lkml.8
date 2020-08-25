Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB1EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11A9120782
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgHYRg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:36:28 -0400
Received: from mailoutvs17.siol.net ([185.57.226.208]:60562 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726551AbgHYRfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 13:35:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id CCD5C5247D2;
        Tue, 25 Aug 2020 19:35:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Cuc8QcMBidfA; Tue, 25 Aug 2020 19:35:40 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 85AE15247E0;
        Tue, 25 Aug 2020 19:35:40 +0200 (CEST)
Received: from localhost.localdomain (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 3E7C75247D2;
        Tue, 25 Aug 2020 19:35:38 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, robh+dt@kernel.org, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-sunxi@googlegroups.com
Subject: [PATCH 4/5] media: cedrus: Add support for R40
Date:   Tue, 25 Aug 2020 19:35:22 +0200
Message-Id: <20200825173523.1289379-5-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825173523.1289379-1-jernej.skrabec@siol.net>
References: <20200825173523.1289379-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Video engine in R40 is very similar to that in A33 but it runs on lower
speed, at least according to OS images released by board designer.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/stagin=
g/media/sunxi/cedrus/cedrus.c
index bc27f9430eeb..83a654a618be 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -496,6 +496,11 @@ static const struct cedrus_variant sun8i_h3_cedrus_v=
ariant =3D {
 	.mod_rate	=3D 402000000,
 };
=20
+static const struct cedrus_variant sun8i_r40_cedrus_variant =3D {
+	.capabilities	=3D CEDRUS_CAPABILITY_UNTILED,
+	.mod_rate	=3D 297000000,
+};
+
 static const struct cedrus_variant sun50i_a64_cedrus_variant =3D {
 	.capabilities	=3D CEDRUS_CAPABILITY_UNTILED |
 			  CEDRUS_CAPABILITY_H265_DEC,
@@ -536,6 +541,10 @@ static const struct of_device_id cedrus_dt_match[] =3D=
 {
 		.compatible =3D "allwinner,sun8i-h3-video-engine",
 		.data =3D &sun8i_h3_cedrus_variant,
 	},
+	{
+		.compatible =3D "allwinner,sun8i-r40-video-engine",
+		.data =3D &sun8i_r40_cedrus_variant,
+	},
 	{
 		.compatible =3D "allwinner,sun50i-a64-video-engine",
 		.data =3D &sun50i_a64_cedrus_variant,
--=20
2.28.0

