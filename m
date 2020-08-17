Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8380C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 930852072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597679506;
	bh=mdDePSu7eStr8QxZQkIFDAJN7NczDRXPX+oERb1uTbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lzsPuYuOVMISfZBsbTsmZ/Nm85wSNNGPQCXgh1CuZH5N/eH373vTDGNLZf796zYTE
	 FyhUvAJUrVQNtrSzopG8K92hbARUl1akW03n50rrjwLbFSVYbb2qiIKG5oy6plsFwJ
	 SgH/v4v9ZUow+bNzNw7nevQn0l2t7EnVqvjxwVBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387750AbgHQPvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730486AbgHQPjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:39:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 620DA208E4;
        Mon, 17 Aug 2020 15:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678774;
        bh=mdDePSu7eStr8QxZQkIFDAJN7NczDRXPX+oERb1uTbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zhSyKbVnIOc984eDtcCTZ524Txqjt+V8Z6iZXVUdyi/0M6iU0SFM1kZsaVMiTcJRf
         sok6HYoGACghfcmdFf7f7CLbDuUAmrk+Ix9hSomQX7AGxGuqCzUpdhQQvAFZSJoVqU
         MzQ7tmc4WHFOew86C4TxKv7cLwc3lCPBSZJK3NoE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5.8 448/464] ARM: dts: exynos: Extend all Exynos5800 A15s OPPs with max voltage data
Date:   Mon, 17 Aug 2020 17:16:41 +0200
Message-Id: <20200817143855.233813199@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit d644853ff8fcbb7a4e3757f9d8ccc39d930b7e3c upstream.

On Exynos5422/5800 the regulator supply for the A15 cores ("vdd_arm") is
coupled with the regulator supply for the SoC internal circuits
("vdd_int"), thus all operating points that modify one of those supplies
have to specify a triplet of the min/target/max values to properly work
with regulator coupling.

Fixes: eaffc4de16c6 ("ARM: dts: exynos: Add missing CPU frequencies for Exynos5422/5800")
Cc: <stable@vger.kernel.org>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/exynos5800.dtsi |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -23,17 +23,17 @@
 &cluster_a15_opp_table {
 	opp-2000000000 {
 		opp-hz = /bits/ 64 <2000000000>;
-		opp-microvolt = <1312500>;
+		opp-microvolt = <1312500 1312500 1500000>;
 		clock-latency-ns = <140000>;
 	};
 	opp-1900000000 {
 		opp-hz = /bits/ 64 <1900000000>;
-		opp-microvolt = <1262500>;
+		opp-microvolt = <1262500 1262500 1500000>;
 		clock-latency-ns = <140000>;
 	};
 	opp-1800000000 {
 		opp-hz = /bits/ 64 <1800000000>;
-		opp-microvolt = <1237500>;
+		opp-microvolt = <1237500 1237500 1500000>;
 		clock-latency-ns = <140000>;
 	};
 	opp-1700000000 {


