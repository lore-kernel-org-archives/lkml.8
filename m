Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3E3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B8E8206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgHXThI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:37:08 -0400
Received: from mailoutvs40.siol.net ([185.57.226.231]:37394 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726531AbgHXThH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:37:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 0CE77525556;
        Mon, 24 Aug 2020 21:37:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UnGh7B5-3ens; Mon, 24 Aug 2020 21:37:03 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id B258A525555;
        Mon, 24 Aug 2020 21:37:03 +0200 (CEST)
Received: from localhost.localdomain (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 4A26E525556;
        Mon, 24 Aug 2020 21:37:03 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, icenowy@aosc.io, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH] ARM: dts: sun8i: r40: bananapi-m2-ultra: Fix dcdc1 regulator
Date:   Mon, 24 Aug 2020 21:36:49 +0200
Message-Id: <20200824193649.978197-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DCDC1 regulator powers many different subsystems. While some of them can
work at 3.0 V, some of them can not. For example, VCC-HDMI can only work
between 3.24 V and 3.36 V. According to OS images provided by the board
manufacturer this regulator should be set to 3.3 V.

Set DCDC1 and DCDC1SW to 3.3 V in order to fix this.

Fixes: da7ac948fa93 ("ARM: dts: sun8i: Add board dts file for Banana Pi M=
2
		      Ultra")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm=
/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index 42d62d1ba1dc..ea15073f0c79 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -223,16 +223,16 @@ &reg_aldo3 {
 };
=20
 &reg_dc1sw {
-	regulator-min-microvolt =3D <3000000>;
-	regulator-max-microvolt =3D <3000000>;
+	regulator-min-microvolt =3D <3300000>;
+	regulator-max-microvolt =3D <3300000>;
 	regulator-name =3D "vcc-gmac-phy";
 };
=20
 &reg_dcdc1 {
 	regulator-always-on;
-	regulator-min-microvolt =3D <3000000>;
-	regulator-max-microvolt =3D <3000000>;
-	regulator-name =3D "vcc-3v0";
+	regulator-min-microvolt =3D <3300000>;
+	regulator-max-microvolt =3D <3300000>;
+	regulator-name =3D "vcc-3v3";
 };
=20
 &reg_dcdc2 {
--=20
2.28.0

