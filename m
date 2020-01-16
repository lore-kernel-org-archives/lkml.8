Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152CEC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DDA2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579198400;
	bh=okBlYRU+qK/rpan1trzG4zDf6FeAwhV0O9O+nav5m4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iwXEpQ6kX0edKe+TwaIAAZWJ6ecm0WE9t/oSblUligg8SPHNQQG2ZFdVKU6aq2o/S
	 koi47FECWRDlTz5olIuOsrH+krXivw8pxi1ffgjJ5tayRCWbMzhshcwWtt4JpYU/JV
	 k71BqlgomYPuYvPB+c2FRYhpcf6Il3udaYnlF/Sw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395248AbgAPSNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:13:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:51928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405244AbgAPRg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:36:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 708B4246CE;
        Thu, 16 Jan 2020 17:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196216;
        bh=okBlYRU+qK/rpan1trzG4zDf6FeAwhV0O9O+nav5m4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MjMOYnLSkSSNj1j5Zbjx+cbi1rDLpwuRU9XPLI7Ygzzxspk2UD5NWinP2wWu1poKw
         2c3CscIuWvFSqQeoT700TOAOBsMMJ2pm4xlTnuHxgfwQP98Nd8m60hB/53ACNyw2gZ
         BT63eAOo13p5hZG3FcU8v3bwQgvucTrmbO5H65BY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vladimir Zapolskiy <vz@mleia.com>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.9 051/251] ARM: dts: lpc32xx: reparent keypad controller to SIC1
Date:   Thu, 16 Jan 2020 12:33:20 -0500
Message-Id: <20200116173641.22137-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Zapolskiy <vz@mleia.com>

[ Upstream commit 489261c45f0ebbc1c2813f337bbdf858267f5033 ]

After switching to a new interrupt controller scheme by separating SIC1
and SIC2 from MIC interrupt controller just one SoC keypad controller
was not taken into account, fix it now:

  WARNING: CPU: 0 PID: 1 at kernel/irq/irqdomain.c:524 irq_domain_associate+0x50/0x1b0
  error: hwirq 0x36 is too large for interrupt-controller@40008000
  ...
  lpc32xx_keys 40050000.key: failed to get platform irq
  lpc32xx_keys: probe of 40050000.key failed with error -22

Fixes: 9b8ad3fb81ae ("ARM: dts: lpc32xx: reparent SIC1 and SIC2 interrupts from MIC")
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/lpc32xx.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index da375813afd0..6bd196457ccc 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -463,7 +463,8 @@
 				compatible = "nxp,lpc3220-key";
 				reg = <0x40050000 0x1000>;
 				clocks = <&clk LPC32XX_CLK_KEY>;
-				interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-parent = <&sic1>;
+				interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
-- 
2.20.1

