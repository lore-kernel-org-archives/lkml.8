Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76855C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC3420838
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865168;
	bh=t0TkbMdPNGRv3x1UHEVHXyq9U3K/2LwmLJ1MDKfPh4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eUhUNFyhI+ojavM5l+UV4YA8GyqZdW9TK91Z28BFzg87hIT7cPhf1p2d5eY+FE0vf
	 er8G5axdHQKF4SZ2eh3Uqd5gpFOeLmGyISqCqvpprjAZAnItstFP8pujoRYGad5Uhb
	 LZTbZxiPbrv/0pAcRYv/cMe0c352RcdCaP9m6pjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403763AbgAXL0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:26:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391531AbgAXL0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:26:02 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC6342075D;
        Fri, 24 Jan 2020 11:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865161;
        bh=t0TkbMdPNGRv3x1UHEVHXyq9U3K/2LwmLJ1MDKfPh4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dxP9ANK6xvFekxFJx8yqsNYSaqAqKykX67VOP+tRVdZhV0fX1/swLYsRH3yuMXN6K
         lJztt1VjApAsO9nUnyn2oVoyr6qCcDXr4ZkU0q8CwVUrdbJ0Nvfv7O9wrFHevijhhw
         RCn161/54PdUufeiWJLnCZg0ScVUHsEd6GQizpYE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 444/639] arm64: dts: allwinner: h6: Pine H64: Add interrupt line for RTC
Date:   Fri, 24 Jan 2020 10:30:14 +0100
Message-Id: <20200124093142.658446909@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

[ Upstream commit 0bb9d1876c0605815ea0452f68cb819a775a75f9 ]

The external PCF8563 RTC chip's interrupt line is connected to the NMI
line on the SoC.

Add the interrupt line to the device tree.

Fixes: 17ebc33afc35 ("arm64: allwinner: h6: add PCF8563 RTC on Pine H64 board")
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index 48daec7f78ba7..6c3a47d90c793 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -176,6 +176,8 @@
 	pcf8563: rtc@51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
+		interrupt-parent = <&r_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 		#clock-cells = <0>;
 	};
 };
-- 
2.20.1



