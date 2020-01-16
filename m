Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D2EC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89342073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579200168;
	bh=d7cXhq7vMyyCAAxT+hk59hpaupWElbvnm/AH3qUW6Ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nezvU3mYyyBJyQwFvi6/jNsT3oSMn+8zFbTRtLxpbjOfOMozFDjFDjDOEHwDIhVke
	 FkD197ieacmDtkX/JWK4w+Zq9OHboBcCTn8IuDCQB5KTkvxcDCJGKpzDMAlu24K2Kg
	 uMTg+gv1z0z09g3pcYulZiwFu5RokqYQs4KVHwy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436996AbgAPSmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:42:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:51960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390230AbgAPRLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:11:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4173D24684;
        Thu, 16 Jan 2020 17:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194684;
        bh=d7cXhq7vMyyCAAxT+hk59hpaupWElbvnm/AH3qUW6Ww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xVtVq4AWHj4KytdFdXivzbIo9YtovVFkcJoROAvLjn6RDuS0/Fimtz49Ol2/PgsmW
         Lq1ZLeUED+WFaDyOCPCbuWTYwthVdQ2LlKFZ5h/mHW9LRT0hMzkApBbMEt8s8ea08A
         sgqCpwfOfV0+tUcP4x3hALsZC7dHWq/9VEpWqTeA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oscar A Perez <linux@neuralgames.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 528/671] ARM: dts: aspeed-g5: Fixe gpio-ranges upper limit
Date:   Thu, 16 Jan 2020 12:02:46 -0500
Message-Id: <20200116170509.12787-265-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar A Perez <linux@neuralgames.com>

[ Upstream commit 89b97c429e2e77d695b5133572ca12ec256a4ea4 ]

According to the AST2500/AST2520 specs, these SoCs support up to 228 GPIO
pins. However, 'gpio-ranges' value in 'aspeed-g5.dtsi' file is currently
setting the upper limit to 220 which isn't allowing access to all their
GPIOs. The correct upper limit value is 232 (actual number is 228 plus a
4-GPIO hole in GPIOAB). Without this patch, GPIOs AC5 and AC6 do not work
correctly on a AST2500 BMC running Linux Kernel v4.19

Fixes: 2039f90d136c ("ARM: dts: aspeed-g5: Add gpio controller to devicetree")
Signed-off-by: Oscar A Perez <linux@neuralgames.com>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index d107459fc0f8..f2e1015d75ab 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -247,7 +247,7 @@
 				compatible = "aspeed,ast2500-gpio";
 				reg = <0x1e780000 0x1000>;
 				interrupts = <20>;
-				gpio-ranges = <&pinctrl 0 0 220>;
+				gpio-ranges = <&pinctrl 0 0 232>;
 				clocks = <&syscon ASPEED_CLK_APB>;
 				interrupt-controller;
 			};
-- 
2.20.1

