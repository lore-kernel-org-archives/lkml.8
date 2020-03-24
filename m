Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87B4C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9217C208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585056175;
	bh=ClFWbM6KRvO0jA0ltmJ0uDe7H7a6wSR5QyRk4Y8M8UY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y/ZP4LUy2/YSr1d406iAo3oFFAzdl0ktDIbQzs/EWzFQ1vPu4n1PwfgXaB8vco8Bw
	 ssQloBzDi4Nf8d3mjVL1R5kSiH7widAB6GY1/+v6nCjcMCb9ctD82hfVWdDvf+J9CN
	 f6OdNGcNyTJv+5zZCG8ADpiGMK1v1gPqDpS0v52c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgCXNWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:22:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729074AbgCXNWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:22:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F11AD206F6;
        Tue, 24 Mar 2020 13:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585056168;
        bh=ClFWbM6KRvO0jA0ltmJ0uDe7H7a6wSR5QyRk4Y8M8UY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BOAbrC1Osa/ZVMUTRcAZ2CXMjOJC+ot2Z6Tq+dMya7ZfM6h3DP1CY3iiSVPaX3yrY
         8UfwhqWQg7IzUz0e1RRQPLbN1CLL8hMb92UlWLWGm6bRRkt3JQDDfJaMJTSEKtGRgH
         WMpcEbb9A/mkd81sJObRZI4RDmeNAkGflU5tGY8A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 008/119] ARM: dts: dra7-l4: mark timer13-16 as pwm capable
Date:   Tue, 24 Mar 2020 14:09:53 +0100
Message-Id: <20200324130808.831489303@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130808.041360967@linuxfoundation.org>
References: <20200324130808.041360967@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

[ Upstream commit 00a39c92c8ab94727f021297d1748531af113fcd ]

DMTimers 13 - 16 are PWM capable and also can be used for CPTS input
signals generation. Hence, mark them as "ti,timer-pwm".

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/dra7-l4.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
index 7e7aa101d8a49..912ee8778830a 100644
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -3461,6 +3461,7 @@
 				clocks = <&l4per3_clkctrl DRA7_L4PER3_TIMER13_CLKCTRL 24>;
 				clock-names = "fck";
 				interrupts = <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>;
+				ti,timer-pwm;
 			};
 		};
 
@@ -3489,6 +3490,7 @@
 				clocks = <&l4per3_clkctrl DRA7_L4PER3_TIMER14_CLKCTRL 24>;
 				clock-names = "fck";
 				interrupts = <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>;
+				ti,timer-pwm;
 			};
 		};
 
@@ -3517,6 +3519,7 @@
 				clocks = <&l4per3_clkctrl DRA7_L4PER3_TIMER15_CLKCTRL 24>;
 				clock-names = "fck";
 				interrupts = <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>;
+				ti,timer-pwm;
 			};
 		};
 
@@ -3545,6 +3548,7 @@
 				clocks = <&l4per3_clkctrl DRA7_L4PER3_TIMER16_CLKCTRL 24>;
 				clock-names = "fck";
 				interrupts = <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>;
+				ti,timer-pwm;
 			};
 		};
 
-- 
2.20.1



