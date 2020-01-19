Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA547C33CB6
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 16:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13F62072B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 16:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="ESMVRuxN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="etS9mNPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgASQb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 11:31:26 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45851 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727111AbgASQbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 11:31:07 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id AAD3D21B6A;
        Sun, 19 Jan 2020 11:31:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 19 Jan 2020 11:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=GZvRpwCtvmTOQ
        s2hXP6ts5mlEVgyPC4n0SpzvQR202w=; b=ESMVRuxN0vXPPtuiT2zQr0EW65308
        EiIB3RT6slESVpejv8CzRCdvMtkb4vmK8O87E/lMv7kt6KN+awxXkMhtzqtU+XUC
        JHvfTvKv/8m/mMHeNEk1zBtwgyB4N+uRnaIGF0c9MGokwgovvpw53ZRIgkwEQ0Wo
        UdEsv1M7ZtDmTA11+XzuvIxm3dZyib30vbsm6n5wK8dl+69AtUGvqEyF04yVRD9d
        ri4BScGHOU+R5MzRtG5J4uNmzfaUJhIefqQ631Aer120KwFV9pb/7ETrg39V6LZ/
        DtjhpG8rLsCGt0Dno2OkWW9jQHmOEeqnpfpSDegveBwhyDlUz6XJOWYCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=GZvRpwCtvmTOQs2hXP6ts5mlEVgyPC4n0SpzvQR202w=; b=etS9mNPU
        4wBC5IyNV/ChxhJopF7CIFEqH2u+a6PzedxFyK5F5hSWekittrRaPhUJmLash2QJ
        EP1EWvhxXGNFa+sIWqFCiAaQsFcR8DwNCBFfw7upfVCOXIewrJoP8NgZvghCVZYP
        GgQ1BuHxCbzXSuD6xURNTUTNLtKzSAZxAhoKKjxG4tWsTvvGLwind0sz498f75vm
        UzXVsUHJ1c7EKM3XXmcRNjH0ejgEgYY+z2JiHLeU88L9g0qdnpV7V9mIv302FGb7
        CgWyepxQfNhgi/RDmXpTbSdG7z83her0Jy+1Zh/98CwhIskwMcPdvnuBQ6lirhni
        wBKpsJEXoiD4OA==
X-ME-Sender: <xms:SoQkXpwepIZ0A2VKsjizHeWjRlqMilLJQ4ZvvXmL6_MBfgCsbx8y3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudefgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:SoQkXtYD9daVwESsliif9LOLmAk0OvhP_uB4RzschFRjLIYJr9G-NA>
    <xmx:SoQkXu6lPQiVNdSYomxRveG-A3rLSCscsewozz8YflpEtIFgnSB-Og>
    <xmx:SoQkXtz9wcLw6PSZkQ_oo0kIrqV3nv0Opk_JFxef_P2kSQBypHTdqQ>
    <xmx:SoQkXj08oRFYLnhrLiRvCrbgtFfCNrc6wqwckdJuNMd8NVULEKRAqA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1C9A48005A;
        Sun, 19 Jan 2020 11:31:06 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 4/9] arm64: dts: allwinner: pinebook: Sort device tree nodes
Date:   Sun, 19 Jan 2020 10:30:59 -0600
Message-Id: <20200119163104.13274-4-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200119163104.13274-1-samuel@sholland.org>
References: <20200119163104.13274-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The r_i2c node should come before r_rsb, and in any case should not
separate the axp803 node from its subnodes.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../boot/dts/allwinner/sun50i-a64-pinebook.dts   | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 8e7ce6ad28dd..97e412fc4e4b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -172,6 +172,14 @@
 	status = "okay";
 };
 
+/* The ANX6345 eDP-bridge is on r_i2c */
+&r_i2c {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&r_i2c_pl89_pins>;
+	status = "okay";
+};
+
 &r_rsb {
 	status = "okay";
 
@@ -183,14 +191,6 @@
 	};
 };
 
-/* The ANX6345 eDP-bridge is on r_i2c */
-&r_i2c {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&r_i2c_pl89_pins>;
-	status = "okay";
-};
-
 #include "axp803.dtsi"
 
 &ac_power_supply {
-- 
2.23.0

