Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39F7C33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DE222527
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="i0k4vXpt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rZavhl8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387682AbgAMEuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 23:50:06 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:36525 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733196AbgAMEtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 23:49:41 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 243A76212;
        Sun, 12 Jan 2020 23:49:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 12 Jan 2020 23:49:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=2ekAlpSljFfQr
        TZx7XNCd5b2by7K3DL7GlymedphPIM=; b=i0k4vXptqYZXL+Owi2N8+DPbkOYfd
        LzfYHKQBIihIX0X43VHBhwp/iERjwq/ZDAocL8X8a5RWlzAOA8JnQVlOjsXUtWu1
        iJCxof2lflZU6X8kfqVMB5UjDStLagt3AcStEY+1V/Sh4z2fuArjmMXYMlrtLqNe
        ORuTndsH221edDVXzrrcwBdcpC3cNMXdv+kdytq0I/+bp27XzUmQpGD2hVC3A5nS
        bKnyX6m2fXck2kBKWuIx28oYUh3m/D2EI/4QsfinnF3DB4ZLJSVOMzWzM9vMsINh
        2/GdwNTIKglQV4x8C2Q8veJvH5yBrmwH4be+0iPfKYmmgwiZvH+BNMVgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=2ekAlpSljFfQrTZx7XNCd5b2by7K3DL7GlymedphPIM=; b=rZavhl8Q
        l/iBfmpCHwiS6ZsDBOn6gKOYlLTy9Sv0ppaeVY5ronq39g9wYY3xQBM5N/zdzvf6
        3p2kEHbVm6kjCO9I/PSunFa3/ahWx9bpwShs6KD/8aPqLhSrdsqrX466R2Z2+yi0
        yjB/MKnfzDoczHKyM/A3EWForAzuwR2tXhIxnoHA/+qMc/2VhI6+n4fu4PFmTfAZ
        8qalBabrN5Am9ctB86J06kIQP6PUWuy6sAuySibk31wARF0hgnFfNZ3aZwNZlyxk
        W2pNJYaepG+ISmVXjk+UYReUOdrtoSKO3ESn1f7B/maKZSVNlQdtYDe63TvJY18e
        EpDUFaDda8L/CA==
X-ME-Sender: <xms:5PYbXlN9TM8Qwp6WG3awgpTX_Yk4y3QspECX8uPl4CbkWFumMFuxmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:5PYbXpjqtEdhyaSGA9mAH6hdCa8TzHSmyc7ifc7sUB3K220GwTVDZQ>
    <xmx:5PYbXqlZuJ70v8VyVDR_O6QJ7l1PtV16IGd3HTfeG_avxhs39w2bGQ>
    <xmx:5PYbXtg7ft5FpN2nsiow6mY8eAP3ffd5hgSJHk5H-lusARA4pJWiHQ>
    <xmx:5PYbXvStCPeXzycTBqgH2ajdimjR6NMVe5mCTHyd3hlHE-8DrEdOIg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 65CFA30607B0;
        Sun, 12 Jan 2020 23:49:39 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 4/9] ARM: dts: sunxi: h3/h5: Add r_intc node
Date:   Sun, 12 Jan 2020 22:49:31 -0600
Message-Id: <20200113044936.26038-5-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200113044936.26038-1-samuel@sholland.org>
References: <20200113044936.26038-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The H3 and H5 SoCs have an additional interrupt controller in the RTC
power domain that can be used to enable wakeup for certain IRQs.

Add a node for it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 107eeafad20a..62660108550a 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -814,6 +814,15 @@
 			#clock-cells = <1>;
 		};
 
+		r_intc: interrupt-controller@1f00c00 {
+			compatible = "allwinner,sun8i-h3-r-intc",
+				     "allwinner,sun6i-a31-r-intc";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x01f00c00 0x400>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		r_ccu: clock@1f01400 {
 			compatible = "allwinner,sun8i-h3-r-ccu";
 			reg = <0x01f01400 0x100>;
-- 
2.23.0

