Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07DDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97430206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865491;
	bh=w7f5YIqGGhYph6l+OF2ij8uXnChwL2dDDbJ5/o/FHus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sWHELCVOrRkklJ3vJ9I4hV0/0BUShE8GEFkpfZr18wVdmIgQmdplJL5lv86jw38Lk
	 b6g13wibaFEQMZypbnYWkNU51WfENvdv0zg4ZZbQbSt/cBgXLRbGW52ST6Lh03mTfQ
	 xp2CdsApVzoEdhCUolvwTN5Dvw5bkMhfGi1kcd3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391891AbgAXLba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:31:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391877AbgAXLb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:31:28 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6DF2214DB;
        Fri, 24 Jan 2020 11:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865487;
        bh=w7f5YIqGGhYph6l+OF2ij8uXnChwL2dDDbJ5/o/FHus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FdbKtIoEtM/bc001Rddv5L9pdflxca807YcPKwEwLNNuxaeRq0dhb8T8tmM9rPkhJ
         CqxZlpxgyQFjVLEnhFo8iwGBSA/2479lwP8zXqEFZzr3qU9PUHoEcz1oJmssny8T6y
         8TNCq4JjwNcQYSZBY31+xjX/x0ESzFklSS4ehUi8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oscar A Perez <linux@neuralgames.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 542/639] ARM: dts: aspeed-g5: Fixe gpio-ranges upper limit
Date:   Fri, 24 Jan 2020 10:31:52 +0100
Message-Id: <20200124093156.938644769@linuxfoundation.org>
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
index d107459fc0f89..f2e1015d75ab4 100644
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



