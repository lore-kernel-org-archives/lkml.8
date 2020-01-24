Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAADAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8149920704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865245;
	bh=JAm/Jf5W6sSjzIVp1Z7IdkLIzsPgERFc2vz32UGVoJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OJRAsdsw+J45uyCv5+Vb/VcKEke0JqQfMbsGqOW/xbKpqTFchcX+Gth63Adn4qiip
	 HbEzbQai3Q9l5Wd9b0mkTa5UH8cfaPnZ0wPglN4PbxyQLOZVxj1VHUdAIX82egfzFX
	 Tma5a4MgQcdpWD9dx3rgA8SYcqrNjeFa1pTlrIT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391435AbgAXL1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:27:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:42658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403806AbgAXL1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:27:17 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CCDA2075D;
        Fri, 24 Jan 2020 11:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865237;
        bh=JAm/Jf5W6sSjzIVp1Z7IdkLIzsPgERFc2vz32UGVoJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sqxSNT9vr07zvGcYUfDbeeGpEI5Yg1in4PyfQRwJrc8X1TLjcT5IKHwwpGMWNSBwd
         XslLx7b/c2lTQ4mpf5ROvMjYZlc8KAbB6mskuZs+3TsAtQ+zyMB6jjaJMnupuNi7iV
         kAu52870PZCW0QOkFpSe2ufnLLhOB5KpjKpDVJiQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yoshihiro Kaneko <ykaneko0929@gmail.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 491/639] arm64: dts: renesas: r8a77995: Fix register range of display node
Date:   Fri, 24 Jan 2020 10:31:01 +0100
Message-Id: <20200124093150.278778386@linuxfoundation.org>
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

From: Yoshihiro Kaneko <ykaneko0929@gmail.com>

[ Upstream commit 56d651e890f3befd616b6962a862f5ffa1a514fa ]

Since the R8A77995 SoC uses DU{0,1}, the range from the base address to
the 0x4000 address is used.
This patch fixed it.

Fixes: 18f1a773e3f9e6d1 ("arm64: dts: renesas: r8a77995: add DU support")
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index fe77bc43c4474..fb3ecb2c385d1 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -938,7 +938,7 @@
 
 		du: display@feb00000 {
 			compatible = "renesas,du-r8a77995";
-			reg = <0 0xfeb00000 0 0x80000>;
+			reg = <0 0xfeb00000 0 0x40000>;
 			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 724>,
-- 
2.20.1



