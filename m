Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A84C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B5E206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591663176;
	bh=iyzJrfIKvVs3kATF4wFc59OozNGRsscsxjNvpz3D/PQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nNHpQNsdzP1/RG7DJzFnJ2R9pfX1MuFJuB6sFjEvS2gd/4F5Cepqdii9/e08IS150
	 zTZiDsHqldWVUiibxIj9LSlICJ+ONbq9E8mShoRZvqZ78yZo7WSSuZ/xPhE/5oWBEQ
	 WaOHKItPPD5DziAYRXsjrVecvz1Dxj/A7rCj8ECQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732969AbgFIAje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:39:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729286AbgFHXNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:13:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 559BD21532;
        Mon,  8 Jun 2020 23:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658000;
        bh=iyzJrfIKvVs3kATF4wFc59OozNGRsscsxjNvpz3D/PQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ifLpUV/BVtBhEIVpwWWxdX06rfnjPrWtv0Ae4kDdOtQ3hcRkGZYgw/akl4LcvfpI7
         Fv+I451y1R9fZxBNZdu+M9t0PkWxfiVuo6VjUeomu2klnTElqlqPCl4uswZJdguoU/
         5aEPKusiHQwAraeb69h7jk6GmEC2qpmpO5szFO98=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 5.6 057/606] arm64: dts: meson-g12b-khadas-vim3: add missing frddr_a status property
Date:   Mon,  8 Jun 2020 19:03:02 -0400
Message-Id: <20200608231211.3363633-57-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <narmstrong@baylibre.com>

commit 5ac0869fb39b1c1ba84d4d75c550f82e0bf44c96 upstream.

In the process of moving the VIM3 audio nodes to a G12B specific dtsi
for enabling the SM1 based VIM3L, the frddr_a status = "okay" property
got dropped.
This re-enables the frddr_a node to fix audio support.

Fixes: 4f26cc1c96c9 ("arm64: dts: khadas-vim3: move common nodes into meson-khadas-vim3.dtsi")
Reported-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Tested-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20191018140216.4257-1-narmstrong@baylibre.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
index 554863429aa6..e2094575f528 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
@@ -152,6 +152,10 @@ &cpu103 {
 	clock-latency = <50000>;
 };
 
+&frddr_a {
+	status = "okay";
+};
+
 &frddr_b {
 	status = "okay";
 };
-- 
2.25.1

