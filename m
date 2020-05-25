Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BE4C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A923207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="hSCSmp5S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FcF/jux0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgEYEMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 00:12:55 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:38611 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726625AbgEYEMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 00:12:43 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 67AA358009D;
        Mon, 25 May 2020 00:12:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 25 May 2020 00:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=WnCKLIGDJB4zf
        8Jo5QFngI60qvtZyt+/INzJ07sVSxs=; b=hSCSmp5SeAiTfim8E39c7IwhYULzp
        WqljHofUDVR8DIll/ggXEc1z166vm3GaWPjgBLiGVXq2Dv4pv30nbaxrCX6gFjKA
        44vZFUTGFw/NsZPy9f5u6uo56rlYaJb9uHmf0MtCRlbJRwOEHWI/qBW0hPFUv4jh
        V8hrYARhAFpmiDTSN1LWZ9BEh15nKHw7is+QSrows1lYgP5rgUwK7Mz/L4nYUKQD
        5/hqe4Z5lefB/UZW0qz1P1LXnBOAya53Q5lTq2r5u/fS0as+PPORHRKLHBwzGWLZ
        Fqf2/wvPBUg+vKQ2Zvej1vOQwtqTgGttYBBMSLr5qRvhaATlRy/KALVag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=WnCKLIGDJB4zf8Jo5QFngI60qvtZyt+/INzJ07sVSxs=; b=FcF/jux0
        foaDt723wxyGj1wJXHYzCscuQEFjRD+qIa3XqIJ1pPQtZRgTyWT5GBgIn6SMiRUa
        dHtYckq3L++UiYt5h1urujLFArBv9Dof3U/evNyYkmqwfOG6lS5o06P5WGKUnxAe
        3AybAwqXFp+PkfdloqtTFyYVtULRC32mevzqMkcpz0n1ewrc4B2/Zt1FqA5hZnAy
        GTqHGNlHQYIzNI6AbN+CUyLbyJgsdgYFrhbd/n4rQtJAz8EpRwOr2qiZ9MCmn6wt
        UU0flNXS5g16MvyoTiG5ck5rg97KnkeE5Got+97doLtLy02/j5DEFHfz8UKL/Har
        gSBNq4epb5VLIw==
X-ME-Sender: <xms:ukXLXgqTbZnh3A5GJK4QHCjhKHAKWn1SmzrbNT7MDiS4ffcMnQnxZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudduledgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:ukXLXmqz8EaQw1eGrJR2VOdXf0g6LkZk8ETLGHnqmCQ_Peu46u0GwQ>
    <xmx:ukXLXlP4xb4wfLbck1JX2QvvFwl0tA6aQ-TDgcMviaUsVW-wmDTUFg>
    <xmx:ukXLXn65zELhO1A0iyG32vvojKTdvft2q4Nb2v8OARz2IcbcvmQoLA>
    <xmx:ukXLXsxAH1cRK1DYgS1iNmS_wb2yR53P1kBE1OfjRc8Qi_wZECI1aQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id B4578306653A;
        Mon, 25 May 2020 00:12:41 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 8/9] arm64: dts: allwinner: h6: Fix indentation of IR node
Date:   Sun, 24 May 2020 23:13:01 -0500
Message-Id: <20200525041302.51213-9-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200525041302.51213-1-samuel@sholland.org>
References: <20200525041302.51213-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This node was indented by two tabs when added instead of one.
Remove the extra tab.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 22 ++++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index b9ab7d8fa8af..d912188dc6ea 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -901,17 +901,17 @@ r_ir_rx_pin: r-ir-rx-pin {
 		};
 
 		r_ir: ir@7040000 {
-				compatible = "allwinner,sun50i-h6-ir",
-					     "allwinner,sun6i-a31-ir";
-				reg = <0x07040000 0x400>;
-				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&r_ccu CLK_R_APB1_IR>,
-					 <&r_ccu CLK_IR>;
-				clock-names = "apb", "ir";
-				resets = <&r_ccu RST_R_APB1_IR>;
-				pinctrl-names = "default";
-				pinctrl-0 = <&r_ir_rx_pin>;
-				status = "disabled";
+			compatible = "allwinner,sun50i-h6-ir",
+				     "allwinner,sun6i-a31-ir";
+			reg = <0x07040000 0x400>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&r_ccu CLK_R_APB1_IR>,
+				 <&r_ccu CLK_IR>;
+			clock-names = "apb", "ir";
+			resets = <&r_ccu RST_R_APB1_IR>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_ir_rx_pin>;
+			status = "disabled";
 		};
 
 		r_i2c: i2c@7081400 {
-- 
2.24.1

