Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467B0C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F379222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581695808;
	bh=3wGW2BrunnOgr3U/ABE1pDq4qPc9Y4WepmDP45PXgNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ewSaxgLFiUgFjewY5FMOx5hEStypuaZqMEK96LBWiO7+HTvlOdCzPoXW212rjLmg5
	 vfItpDUIBbnuC4n9YfCLFRpMep6RucNatg4R378htZ0e9E7EWgX8FdgbU0hOn93pvs
	 yzlclbMI50+z8iU+PQwlS5CSf2GTcVxW4AyRryQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387978AbgBNP4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:56:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387858AbgBNP4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:56:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3147B24654;
        Fri, 14 Feb 2020 15:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695792;
        bh=3wGW2BrunnOgr3U/ABE1pDq4qPc9Y4WepmDP45PXgNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MNc/SvIhgdJ2jd1P2vPZh7PXLAPS+QejE4UNR8kaNkyGSPXqSTaHIuV06sgzEon9i
         8cnYtf+ylw//A/vwcDSeeEa4kdj3oHiXHJjSDw9Y4P/wMD+tL8T1Hul0KqRSYH4a91
         4q2FF1AsrU5IpnBpqiKPQMcpTOp5w8wgdMN2NYCg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Reto Schneider <reto.schneider@husqvarnagroup.com>,
        Stefan Roese <sr@denx.de>, Paul Burton <paul.burton@mips.com>,
        Paul Burton <paulburton@kernel.org>,
        linux-mips@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 5.5 354/542] MIPS: ralink: dts: gardena_smart_gateway_mt7688: Limit UART1
Date:   Fri, 14 Feb 2020 10:45:46 -0500
Message-Id: <20200214154854.6746-354-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reto Schneider <reto.schneider@husqvarnagroup.com>

[ Upstream commit e8c192011c920517e5578d51c7aff0ecadd25de3 ]

The radio module asserts CTS when its RX buffer has 10 bytes left.
Putting just 8 instead of 16 bytes into the UART1 TX buffer on the Linux
side ensures to not overflow the RX buffer on the radio module side.

Signed-off-by: Reto Schneider <reto.schneider@husqvarnagroup.com>
Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Paul Burton <paul.burton@mips.com>
Signed-off-by: Paul Burton <paulburton@kernel.org>
Cc: linux-mips@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/boot/dts/ralink/gardena_smart_gateway_mt7688.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/boot/dts/ralink/gardena_smart_gateway_mt7688.dts b/arch/mips/boot/dts/ralink/gardena_smart_gateway_mt7688.dts
index aa5caaa311047..aad9a8a8669b4 100644
--- a/arch/mips/boot/dts/ralink/gardena_smart_gateway_mt7688.dts
+++ b/arch/mips/boot/dts/ralink/gardena_smart_gateway_mt7688.dts
@@ -177,6 +177,9 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinmux_i2s_gpio>;		/* GPIO0..3 */
 
+	fifo-size = <8>;
+	tx-threshold = <8>;
+
 	rts-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
 	cts-gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
 };
-- 
2.20.1

