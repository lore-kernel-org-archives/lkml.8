Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1F2C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FE720718
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859396;
	bh=/gff8lZ1/DFpE1xovyfNik2lxgSwEPuYCYRyWdfbQJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YEOn1lk23ZWm2r/l0FaLPUMb+ay8FzQ96jmKPTas8LD+ppvlC1nChoLoA1m1Fodnw
	 pLu6bIZw86i+B3PP42bTcfW9mOzHqq4cB0eeTHvXQwdH3vdTFBdhT3cFga67tMx2iR
	 SK/ZZLvKYFiL9Tq92dhSLS8qN/CgzeU317QLM4GY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387891AbgAXJtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:49:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387646AbgAXJty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:49:54 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B31620718;
        Fri, 24 Jan 2020 09:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859394;
        bh=/gff8lZ1/DFpE1xovyfNik2lxgSwEPuYCYRyWdfbQJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OocqRRUtIQvr0ZZy/ReLwuupnB8YxLS5Dy9XbUOCUjtES/oy5zI18Df6y/htJcY68
         vvrFT4nhql/4nWUg9D5S7daUwAOPnRXKNKbr1tTh3dlLBmy7kxos0dMXDSl2PboTkt
         3/XcRFjB9ELM3EyPo1WiS30CzbnPVWIaxkXJgSPk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 084/343] ARM: dts: lpc32xx: fix ARM PrimeCell LCD controller variant
Date:   Fri, 24 Jan 2020 10:28:22 +0100
Message-Id: <20200124092931.133554087@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Zapolskiy <vz@mleia.com>

[ Upstream commit 7a0790a4121cbcd111cc537cdc801c46ccb789ee ]

ARM PrimeCell PL111 LCD controller is found on On NXP LPC3230
and LPC3250 SoCs variants, the original reference in compatible
property to an older one ARM PrimeCell PL110 is invalid.

Fixes: e04920d9efcb3 ("ARM: LPC32xx: DTS files for device tree conversion")
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/lpc32xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index 9f9386c926d1e..a08ebc9509234 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -139,7 +139,7 @@
 		};
 
 		clcd: clcd@31040000 {
-			compatible = "arm,pl110", "arm,primecell";
+			compatible = "arm,pl111", "arm,primecell";
 			reg = <0x31040000 0x1000>;
 			interrupts = <14 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk LPC32XX_CLK_LCD>;
-- 
2.20.1



