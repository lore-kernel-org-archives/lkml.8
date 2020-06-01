Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A48C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8C63206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591037155;
	bh=tYmwVOSA6P8UA7Rl8tWN9Wd0c22hBbEuWZ33UxNLNhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ne2CmhoIo+RI4WNM0ITiBuxcEt9D8o2SjHTIcpDXUXuRTzQbLSIqsQebhB/uhE1gb
	 eIDCN44K71ba5cmV0oy4J4x077w9RGRGK4JteWb/gSolEoZA44VU3aFdbo5wTouu1Z
	 MiiIHQqtp2sWjDmGo/dy0x+D2OZ2Zbuads5BN2Xw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbgFASpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:45:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730087AbgFASJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:09:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B959C2077D;
        Mon,  1 Jun 2020 18:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034944;
        bh=tYmwVOSA6P8UA7Rl8tWN9Wd0c22hBbEuWZ33UxNLNhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ow8jBV8+UcJ4Er3fyM8dUMRQ2vz2/68upxWUk2SN8ur5uQAgxtLjxWnNtTrWnuo+e
         vtnhoGzjbPrvktQSUOEICof/KWoYBym7Ih2SPAOTAjc3+GzD1Ud/uPeIJ0VtFAuZ74
         dnsCBIGU9JheR9Q3ofM459bFjYV3S8y5qxjF9NiY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 082/142] ARM: dts: bcm: HR2: Fix PPI interrupt types
Date:   Mon,  1 Jun 2020 19:54:00 +0200
Message-Id: <20200601174046.451718773@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174037.904070960@linuxfoundation.org>
References: <20200601174037.904070960@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hamish Martin <hamish.martin@alliedtelesis.co.nz>

[ Upstream commit be0ec060b54f0481fb95d59086c1484a949c903c ]

These error messages are output when booting on a BCM HR2 system:
    GIC: PPI11 is secure or misconfigured
    GIC: PPI13 is secure or misconfigured

Per ARM documentation these interrupts are triggered on a rising edge.
See ARM Cortex A-9 MPCore Technical Reference Manual, Revision r4p1,
Section 3.3.8 Interrupt Configuration Registers.

The same issue was resolved for NSP systems in commit 5f1aa51c7a1e
("ARM: dts: NSP: Fix PPI interrupt types").

Fixes: b9099ec754b5 ("ARM: dts: Add Broadcom Hurricane 2 DTS include file")
Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm-hr2.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-hr2.dtsi b/arch/arm/boot/dts/bcm-hr2.dtsi
index e4d49731287f..e35398cc60a0 100644
--- a/arch/arm/boot/dts/bcm-hr2.dtsi
+++ b/arch/arm/boot/dts/bcm-hr2.dtsi
@@ -75,7 +75,7 @@
 		timer@20200 {
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0x20200 0x100>;
-			interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_PPI 11 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&periph_clk>;
 		};
 
@@ -83,7 +83,7 @@
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x20600 0x20>;
 			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) |
-						  IRQ_TYPE_LEVEL_HIGH)>;
+						  IRQ_TYPE_EDGE_RISING)>;
 			clocks = <&periph_clk>;
 		};
 
@@ -91,7 +91,7 @@
 			compatible = "arm,cortex-a9-twd-wdt";
 			reg = <0x20620 0x20>;
 			interrupts = <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) |
-						  IRQ_TYPE_LEVEL_HIGH)>;
+						  IRQ_TYPE_EDGE_RISING)>;
 			clocks = <&periph_clk>;
 		};
 
-- 
2.25.1



