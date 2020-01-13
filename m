Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B230C33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 05:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C70D214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 05:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="Xm14WEZl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n6L+ER7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733310AbgAMFTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 00:19:09 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:51099 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726375AbgAMFS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 00:18:58 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 56ED65EEB;
        Mon, 13 Jan 2020 00:18:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 13 Jan 2020 00:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=8789/HvoJo8OL
        hH4D97+su6QiBZWTXGYa2xCWRaRHwI=; b=Xm14WEZlxtedSncCmBRW3W1yr3vuL
        DJpp5oTgFoxFtLCBzg10dRqONGfimSLuhMXww78K8FJFP7RZwUn2NSJ827CNmGdM
        sCanoXdQK7aq26wG7k93il4YgIvHCqNvL9GME4Kq8Qfs11RvFvtQX/njFlKI3WUZ
        L2yuIWKbvdyj5H/7NZkMiPXlX2BxcU+pcxLJfcmBBPQMp/N2N2lJvCcf0YwsbV0K
        6D0sIhfElNZwa9Rie5cjNUu8n2knBGNPj1+QSsQEx/u+nTT2hA1zVVlzNdGaNGD0
        HnywuOEjb74e5TdXkK2X+t4FMBXS2gAwNcHDZwk8xIwhmoJOtK0Mhbjtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=8789/HvoJo8OLhH4D97+su6QiBZWTXGYa2xCWRaRHwI=; b=n6L+ER7I
        7jzBxqPMp0rVlYjBfZiCmBnHiYsI67+D7bBNjWj2FeAukngCIZp37Vm8QjnX234z
        pSa1JRqLRwlicEhNUI8ewHiLtmjn3Aw5pfukIN3l+5r9XqsOG7TaWU4OWbv5Kcdk
        l4k/jVxWVjd8ddIeGNILRJjg5GPlT9yiAtY7frJtUiDahOnEm/4Q0hUQP/N3GG7i
        n1nsVcMbtqjhr8Nebh53Y2b9/k3G/BKwe8nAsu1kVsKzOZJhG6PwjpaNsD+P1XoS
        IdtLto+stNbW/XGHA/pkWW/aNfo8DKazHoizceV+JJIOkTwH9o3M82rNpdtJuvF4
        Ea+4v0hkrXAUAA==
X-ME-Sender: <xms:v_0bXgEx38KmBBW9nMwGd5TKdTT3Ksos3geBB_5vYWE16MZB65d1iA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:v_0bXrbJq7ZQfzQR8GEUNW_7zzo8FQUiXawGxVqcO8gp5Qdjr4IyRQ>
    <xmx:v_0bXkOukVl4R7GQdhW5O5qVqWTRTU6smoQYIlyytnf3u7H2_xjhxg>
    <xmx:v_0bXsxPBMsiofY9XhYAN7bzkgYEPMtsx_6KAdh7Y2heBwROwCV5Xg>
    <xmx:wf0bXgJMU9s3w1ESMj_U5i3JH1flcZQ0KIM-6KsgdoNfHv-Rhutmig>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 85BFB30607B0;
        Mon, 13 Jan 2020 00:18:54 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v6 4/6] ARM: dts: sunxi: h3/h5: Add msgbox node
Date:   Sun, 12 Jan 2020 23:18:50 -0600
Message-Id: <20200113051852.15996-5-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200113051852.15996-1-samuel@sholland.org>
References: <20200113051852.15996-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The H3 and H5 SoCs contain a message box that can be used to send
messages and interrupts back and forth between the ARM application CPUs
and the ARISC coprocessor. Add a device tree node for it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 0afea59486c2..6c5b283962a1 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -233,6 +233,16 @@
 			reg = <0x1c14000 0x400>;
 		};
 
+		msgbox: mailbox@1c17000 {
+			compatible = "allwinner,sun8i-h3-msgbox",
+				     "allwinner,sun6i-a31-msgbox";
+			reg = <0x01c17000 0x1000>;
+			clocks = <&ccu CLK_BUS_MSGBOX>;
+			resets = <&ccu RST_BUS_MSGBOX>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+		};
+
 		usb_otg: usb@1c19000 {
 			compatible = "allwinner,sun8i-h3-musb";
 			reg = <0x01c19000 0x400>;
-- 
2.23.0

