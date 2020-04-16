Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154FBC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E383621927
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587052321;
	bh=SteS77gACO4sJ7lpztNtH3/D2R3O5SRCa8yV+ZMnFak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ihJGlZ3twYJB+H2P1LtGg0i8NV/xb8GYwrNzBME2DYfw/nzafLL5RQURQTZDIlqei
	 TvmwI8UBZKOaQ9Pm4y9kHKEPT9mPxlAKYDwQbOl5C4jm8XdU/hJMWTlqbdpdcJARqu
	 H1YMUwvmBwl5VHkhEDliqguCg4Zg3W4/QajzYmgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442794AbgDPPv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:51:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896586AbgDPNc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:32:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4AC322264;
        Thu, 16 Apr 2020 13:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043932;
        bh=SteS77gACO4sJ7lpztNtH3/D2R3O5SRCa8yV+ZMnFak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GQqKgJyr/DxQ7upXRQPMbBWU9EmSHrZNC+eC4GpTE5xCWheg70CnDM06oIQRI1jWY
         gaNwSBc02CFlrvpSvpXnhs6Ffki4ZCtKrxjxxJGwWTJ0hocyIqzEnkx+ZOC31/eThZ
         dwta2Y0TL2brCtw7fA36eG2RjI6XOjt2qGGUhSR8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, maemo-leste@lists.dyne.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 013/257] ARM: dts: omap4-droid4: Fix lost touchscreen interrupts
Date:   Thu, 16 Apr 2020 15:21:04 +0200
Message-Id: <20200416131327.495817535@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 4abd9930d189dedaa59097144c6d8f623342fa72 ]

Looks like we can have the maxtouch touchscreen stop producing interrupts
if an edge interrupt is lost. This can happen easily when the SoC idles as
the gpio controller may not see any state for an edge interrupt if it
is briefly triggered when the system is idle.

Also it looks like maxtouch stops sending any further interrupts if the
interrupt is not handled. And we do have several cases of maxtouch already
configured with a level interrupt, so let's do that.

With level interrupt the gpio controller has the interrupt state visible
after idle. Note that eventually we will probably also be using the
Linux generic wakeirq configured for the controller, but that cannot be
done until the maxtouch driver supports runtime PM.

Cc: maemo-leste@lists.dyne.org
Cc: Arthur Demchenkov <spinal.by@gmail.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/motorola-mapphone-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/motorola-mapphone-common.dtsi b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
index da6b107da84a4..aeb5a673c209e 100644
--- a/arch/arm/boot/dts/motorola-mapphone-common.dtsi
+++ b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
@@ -413,7 +413,7 @@
 		reset-gpios = <&gpio6 13 GPIO_ACTIVE_HIGH>; /* gpio173 */
 
 		/* gpio_183 with sys_nirq2 pad as wakeup */
-		interrupts-extended = <&gpio6 23 IRQ_TYPE_EDGE_FALLING>,
+		interrupts-extended = <&gpio6 23 IRQ_TYPE_LEVEL_LOW>,
 				      <&omap4_pmx_core 0x160>;
 		interrupt-names = "irq", "wakeup";
 		wakeup-source;
-- 
2.20.1



