Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CC7C33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 18:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C94207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 18:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgAMSHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 13:07:35 -0500
Received: from mailoutvs5.siol.net ([185.57.226.196]:36183 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbgAMSHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 13:07:35 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id B11C6522228;
        Mon, 13 Jan 2020 19:07:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gxcA4vRUheZN; Mon, 13 Jan 2020 19:07:31 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 628FF522223;
        Mon, 13 Jan 2020 19:07:31 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id E152A522212;
        Mon, 13 Jan 2020 19:07:27 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH] arm64: dts: allwinner: h6: tanix-tx6: Use internal oscillator
Date:   Mon, 13 Jan 2020 19:07:20 +0100
Message-Id: <20200113180720.77461-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tanix TX6 doesn't have external 32 kHz oscillator, so switch RTC clock
to internal one.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---

While this patch gives one possible solution, I mainly want to start
discussion why Allwinner SoC dtsi reference external 32 kHz crystal
although some boards don't have it. My proposal would be to make clock
property optional, based on the fact if external crystal is present or
not. However, I'm not sure if that is possible at this point or not.
Driver also considers missing clock property as deprecated (old DT) [1],
so this might complicate things even further.

What do you think?

Best regards,
Jernej

[1] https://elixir.bootlin.com/linux/latest/source/drivers/rtc/rtc-sun6i.=
c#L263

 arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch=
/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
index 83e6cb0e59ce..af3aebda47bb 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
@@ -91,6 +91,12 @@ &r_ir {
 	status =3D "okay";
 };
=20
+/* This board doesn't have external 32 kHz crystal. */
+&rtc {
+	assigned-clocks =3D <&rtc 0>;
+	assigned-clock-parents =3D <&rtc 2>;
+};
+
 &uart0 {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&uart0_ph_pins>;
--=20
2.24.1

