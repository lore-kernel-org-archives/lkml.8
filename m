Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B173C33CB0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 05:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F66A24676
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 05:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="YX/Zp8Uk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jQm0Xuo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgAMFS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 00:18:58 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:42777 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgAMFS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 00:18:58 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4F2825DBD;
        Mon, 13 Jan 2020 00:18:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 13 Jan 2020 00:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=MFjG2zqyZNPA/
        ontFOTVLnbZ3yC/TQY/D7CEVP8rFPs=; b=YX/Zp8UksbWaQP5t7jZas6m5cJjmA
        9QiMsTcSD42o2BY3GoM96HU1/idbkRNj7cwMKmW1tJsVnlh7g0uAN4RAPOVkqtOC
        w0+ZuAF0+cCjiBzSHWwnGOulePHyUOp29TY04SNhVqpfX4elU71fCnw0rKMBp/eT
        tXfM951zPty9faZuSKQMKk2vxdjFUChT+XOYSTeMpVo2s+zC0KzIu3fekaqS8zc5
        24yH43FszshuqEZVlFVOfFDUKM7ZhdnlCI4L7gBfSZJXHKaYIzRDjyGv4Jzb1k88
        DvcZKk4HBY4A8BjiadpqWOdaiyLSD3jQmwfIKdhHFVrv1FlZ1JltRj10Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=MFjG2zqyZNPA/ontFOTVLnbZ3yC/TQY/D7CEVP8rFPs=; b=jQm0Xuo6
        P8iDb35VesAMHng8mPKoYBCXIRy4fnbKDvWU8oehy6KkyMOcKCSabqrclJLeRgPF
        0YBN/qL4EMB4b+fCsl+qKmXmAyCYUnQ1ne/mDMyC3gibdqzia/uL5F6McRcN1PaB
        93Q9YqjEVWCWsPRuOPTaoojHohsZLIzjIxsnDAipRFfER2pBZ2ErVRqYf2LqWXCs
        EIpBQkm0WSbdz7edArfCo9uy8fh6QsnJQAltG2UkTjQpZMz5vCEYUsR6CAy1OC0N
        2IPCCOwrV7csk3YEH8aQf8o0MLdkb1W7yfSVP4GDJf16uUJ5WU5pJTz8XpjFY2Sk
        LKWVq2u6tszBKw==
X-ME-Sender: <xms:wP0bXuUt8SInIMKdtBQs3zr_HKD3tcx8XBzSSXsgHvP1QUTrUMStfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:wP0bXgnom00mvM2sqKvoVQgCZTcFRm0vksW6AlTibHc3ZuikR2EpfA>
    <xmx:wP0bXgDYbggA8LwcAoW9m_hvR01TE7ejo5naA8uXupO28p0Zrcgdug>
    <xmx:wP0bXgdBHHUAb8rBoqvPbjH5y8kUNMI1pfXdjhQ0yEjNAdLOcYPx2A>
    <xmx:wf0bXoZzyvSjwzBkF4jHgpUwYbfVIzG54Z9lnNM7vjIr_6D8hTsfMA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8BC773060783;
        Mon, 13 Jan 2020 00:18:55 -0500 (EST)
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
Subject: [PATCH v6 6/6] arm64: dts: allwinner: h6: Add msgbox node
Date:   Sun, 12 Jan 2020 23:18:52 -0600
Message-Id: <20200113051852.15996-7-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200113051852.15996-1-samuel@sholland.org>
References: <20200113051852.15996-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The H6 SoC contains a message box that can be used to send messages and
interrupts back and forth between the ARM application CPUs and the ARISC
coprocessor. Add a device tree node for it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 29824081b43b..8dc6ba71a901 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -230,6 +230,16 @@
 			#dma-cells = <1>;
 		};
 
+		msgbox: mailbox@3003000 {
+			compatible = "allwinner,sun50i-h6-msgbox",
+				     "allwinner,sun6i-a31-msgbox";
+			reg = <0x03003000 0x1000>;
+			clocks = <&ccu CLK_BUS_MSGBOX>;
+			resets = <&ccu RST_BUS_MSGBOX>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+		};
+
 		sid: efuse@3006000 {
 			compatible = "allwinner,sun50i-h6-sid";
 			reg = <0x03006000 0x400>;
-- 
2.23.0

