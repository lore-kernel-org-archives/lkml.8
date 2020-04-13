Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B667DC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:25:03 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B36F206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B36F206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgDMGYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 02:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbgDMGYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 02:24:51 -0400
Received: from mail.siol.net (mailoutvs18.siol.net [185.57.226.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8350C0A3BE0;
        Sun, 12 Apr 2020 23:24:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 2137A522E3E;
        Mon, 13 Apr 2020 08:24:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NvdWUDaGcZ_S; Mon, 13 Apr 2020 08:24:50 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id D3E42522E48;
        Mon, 13 Apr 2020 08:24:50 +0200 (CEST)
Received: from localhost.localdomain (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 4ECB5522E3E;
        Mon, 13 Apr 2020 08:24:48 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 1/3] arm64: dts: allwinner: h6: orangepi: Add gpio power supply
Date:   Mon, 13 Apr 2020 08:24:31 +0200
Message-Id: <20200413062433.1145043-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200413062433.1145043-1-jernej.skrabec@siol.net>
References: <20200413062433.1145043-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OrangePi Lite2 and One Plus have GPIO ports powered by same power
supplies. Add them in common DT.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch=
/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index 9287976c4a50..f1be3dd558ca 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -106,6 +106,12 @@ &ohci3 {
 	status =3D "okay";
 };
=20
+&pio {
+	vcc-pc-supply =3D <&reg_bldo2>;
+	vcc-pd-supply =3D <&reg_cldo1>;
+	vcc-pg-supply =3D <&reg_aldo1>;
+};
+
 &r_i2c {
 	status =3D "okay";
=20
@@ -230,6 +236,10 @@ &r_ir {
 	status =3D "okay";
 };
=20
+&r_pio {
+	vcc-pm-supply =3D <&reg_bldo3>;
+};
+
 &rtc {
 	clocks =3D <&ext_osc32k>;
 };
--=20
2.26.0

