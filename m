Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003C3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C774D24688
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221013;
	bh=cThF3rr/+ZAbS8e0bLEwH3jyEmTyPhdsamIK09shfwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FS0mNp1ZEVPhhh+vtM6tJtlj82UGUfrj263kUWhLBZvLRRanHXgiVHJvwPGC2BFep
	 IxhWmT2XsG1z4RB0lnYD/9Ms+4wCH/bZ4WXfFeHOCoGdlszRicrXyhznIhICEwef6C
	 7mQ2i8CH9PGipJLiWoR4NNPEgARPx/PGEQIKRl98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbgA1OQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:16:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgA1OQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:16:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94A7A24681;
        Tue, 28 Jan 2020 14:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221010;
        bh=cThF3rr/+ZAbS8e0bLEwH3jyEmTyPhdsamIK09shfwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gpnrtohp0JwrankUiGyiKmNvi6KvrYvPLBGkjkJFuI9EDRqlFiVqbqny3By7L1OQ8
         489jkYpeYJS7gjbiSWdZH2lPY0syQhi3DlvM4yvJwqwlLpXd/o8wHaL9VPNLtb1nqw
         MkRDgPMXJISKrxXnG6ONmFxCBWPVwexEdt+baEnY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 052/271] ARM: dts: lpc32xx: add required clocks property to keypad device node
Date:   Tue, 28 Jan 2020 15:03:21 +0100
Message-Id: <20200128135856.513009692@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Zapolskiy <vz@mleia.com>

[ Upstream commit 3e88bc38b9f6fe4b69cecf81badd3c19fde97f97 ]

NXP LPC32xx keypad controller requires a clock property to be defined.

The change fixes the driver initialization problem:

  lpc32xx_keys 40050000.key: failed to get clock
  lpc32xx_keys: probe of 40050000.key failed with error -2

Fixes: 93898eb775e5 ("arm: dts: lpc32xx: add clock properties to device nodes")
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/lpc32xx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index 5fa3111731cb0..da375813afd04 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -462,6 +462,7 @@
 			key: key@40050000 {
 				compatible = "nxp,lpc3220-key";
 				reg = <0x40050000 0x1000>;
+				clocks = <&clk LPC32XX_CLK_KEY>;
 				interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
-- 
2.20.1



