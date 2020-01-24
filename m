Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE40C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5C32077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864135;
	bh=LSb4G87UFvmUVq5sp94TjEu4VGAzc4Ow6BhK+WMD1Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=APb6ZvtHOt+fhABvkjP1Pful54lCLEDoR4t3c6w4qxTKnMLYcfwAVVw77tg/CLjlJ
	 cisspPRL0fCgYHdAIIo4ZI2XIprzbOOgBBdkB3r1OsuYuVQ5eRlkpjlqp+eLUUSa9h
	 WgYarPl+sxecdAha4raLD1jl5jlv6x3JRWWHtlhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389716AbgAXLIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:08:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:44310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389697AbgAXLIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:08:51 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ACEB20663;
        Fri, 24 Jan 2020 11:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864130;
        bh=LSb4G87UFvmUVq5sp94TjEu4VGAzc4Ow6BhK+WMD1Fs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=txjJFD7AdIQrcZAxlDf/qyNb51fgqPVZ8/bW1ZDdhohIIDWMUOYVl081FGWopal5P
         cwk5t/MkCRGZiq5MfEij+yX1j1eFRTxZCqKHj81G8aKV2W058NHeQMj/AB2b/0tK3K
         9++vHs/ACRdj08blGkOQcwi7Ej2xI0W+T4sTCDUI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 164/639] ARM: dts: lpc32xx: reparent keypad controller to SIC1
Date:   Fri, 24 Jan 2020 10:25:34 +0100
Message-Id: <20200124093107.728952276@linuxfoundation.org>
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
index d4368eeff1b9a..4f8f671c3343c 100644
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



