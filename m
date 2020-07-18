Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF0CC433FC
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 20:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0077E22B4D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 20:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgGRUvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 16:51:21 -0400
Received: from v6.sk ([167.172.42.174]:37684 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727869AbgGRUvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 16:51:18 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 451C260D3A;
        Sat, 18 Jul 2020 20:51:17 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 13/13] ARM: dts: mmp3-dell-ariel: Enable the GPU
Date:   Sat, 18 Jul 2020 22:50:19 +0200
Message-Id: <20200718205019.184927-14-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200718205019.184927-1-lkundrak@v3.sk>
References: <20200718205019.184927-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the 2D (GC300) and the 3D (GC2000) GPUs cores.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- s/GC200/GC2000/ in patch description (pointed out by Pavel Machek)

 arch/arm/boot/dts/mmp3-dell-ariel.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/mmp3-dell-ariel.dts b/arch/arm/boot/dts/mmp3-dell-ariel.dts
index b0ec14c421641..fe3b1cd695eeb 100644
--- a/arch/arm/boot/dts/mmp3-dell-ariel.dts
+++ b/arch/arm/boot/dts/mmp3-dell-ariel.dts
@@ -114,3 +114,11 @@ &ssp2 {
 	cs-gpios = <&gpio 56 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
+
+&gpu_2d {
+	status = "okay";
+};
+
+&gpu_3d {
+	status = "okay";
+};
-- 
2.26.2

