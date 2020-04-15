Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C694C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1689A20656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408101AbgDOIhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2894645AbgDOIgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:36:03 -0400
Received: from mo6-p04-ob.smtp.rzone.de (mo6-p04-ob.smtp.rzone.de [IPv6:2a01:238:20a:202:5304::7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B80EC061A0F;
        Wed, 15 Apr 2020 01:36:01 -0700 (PDT)
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M7O2CKN9ej"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 46.4.0 DYNA|AUTH)
        with ESMTPSA id 6028a2w3F8ZS0Iv
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 15 Apr 2020 10:35:28 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Philipp Rossak <embed3d@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        openpvrsgx-devgroup@letux.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        "H . Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v6 09/12] ARM: dts: sun6i: a31: add sgx gpu child node
Date:   Wed, 15 Apr 2020 10:35:16 +0200
Message-Id: <65bf7033dfedf303387d2e5882c6ce672832a9c8.1586939718.git.hns@goldelico.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1586939718.git.hns@goldelico.com>
References: <cover.1586939718.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Rossak <embed3d@gmail.com>

We are adding the devicetree binding for the PVR-SGX-544-115 gpu.

This driver is currently under development in the openpvrsgx-devgroup.
Right now the full binding is not figured out, so we provide here a
placeholder. It will be completed as soon as there is a demo available.

The currently used binding that is used during development is more
complete and was already verifyed by loading the kernelmodule successful.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index f3425a66fc0a..933a825bf460 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -1417,5 +1417,16 @@ p2wi: i2c@1f03400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
+		gpu: gpu@1c400000 {
+			compatible = "allwinner,sun8i-a31-sgx544-115",
+				     "img,sgx544-115", "img,sgx544";
+			reg = <0x01c40000 0x10000>;
+			/*
+			 * This node is currently a placeholder for the gpu.
+			 * This will be completed when a full demonstration
+			 * of the openpvrsgx driver is available for this board.
+			 */
+		};
 	};
 };
-- 
2.25.1

