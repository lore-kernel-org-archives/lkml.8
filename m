Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A330EC33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7566A24692
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220897;
	bh=t5GZ5N/LopTk45JDVCHyBPgByYjTUsskcBljJRjATUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G5k8uc2U+WZg1nBNHW75RSirlj/Wpwo2904JXZZ94EJGPAboWRyBe4YSJA0GlMoiN
	 IHGs8PasKEYpCSl1MT15HMmrExXUUsh7f0yFKWYI0lXbWkMO7aK2ZGcZsSKvnueEx+
	 9oCdexy0eIfdJDbX4k4HfkNAW7rnTrAdKOT92WdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbgA1OO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:14:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:37250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729612AbgA1OOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:14:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E33A624693;
        Tue, 28 Jan 2020 14:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220893;
        bh=t5GZ5N/LopTk45JDVCHyBPgByYjTUsskcBljJRjATUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k9M5gnTK4rm2el7vtZXn5x2kJLynUGr0/Qfe1M/xkOSxzkYJusraAL9hFYXVh6e/Y
         rgJyb6oaip3T4gO/0H3Lfg9J6F3DgadYOnK/lOw4tGYPJxDsYzLH0wMWEouowWeRki
         zZ406TDgtCj0SZdCLlvuEDk+Ootg2s08+XDZowNA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 158/183] arm64: dts: juno: Fix UART frequency
Date:   Tue, 28 Jan 2020 15:06:17 +0100
Message-Id: <20200128135845.503087743@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Przywara <andre.przywara@arm.com>

[ Upstream commit 39a1a8941b27c37f79508426e27a2ec29829d66c ]

Older versions of the Juno *SoC* TRM [1] recommended that the UART clock
source should be 7.2738 MHz, whereas the *system* TRM [2] stated a more
correct value of 7.3728 MHz. Somehow the wrong value managed to end up in
our DT.

Doing a prime factorisation, a modulo divide by 115200 and trying
to buy a 7.2738 MHz crystal at your favourite electronics dealer suggest
that the old value was actually a typo. The actual UART clock is driven
by a PLL, configured via a parameter in some board.txt file in the
firmware, which reads 7.37 MHz (sic!).

Fix this to correct the baud rate divisor calculation on the Juno board.

[1] http://infocenter.arm.com/help/topic/com.arm.doc.ddi0515b.b/DDI0515B_b_juno_arm_development_platform_soc_trm.pdf
[2] http://infocenter.arm.com/help/topic/com.arm.doc.100113_0000_07_en/arm_versatile_express_juno_development_platform_(v2m_juno)_technical_reference_manual_100113_0000_07_en.pdf

Fixes: 71f867ec130e ("arm64: Add Juno board device tree.")
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/arm/juno-clocks.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-clocks.dtsi b/arch/arm64/boot/dts/arm/juno-clocks.dtsi
index 25352ed943e6e..00bcbf7688c77 100644
--- a/arch/arm64/boot/dts/arm/juno-clocks.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-clocks.dtsi
@@ -8,10 +8,10 @@
  */
 
 	/* SoC fixed clocks */
-	soc_uartclk: refclk7273800hz {
+	soc_uartclk: refclk7372800hz {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency = <7273800>;
+		clock-frequency = <7372800>;
 		clock-output-names = "juno:uartclk";
 	};
 
-- 
2.20.1



