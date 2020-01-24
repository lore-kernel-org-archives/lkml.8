Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F57C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8052077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579875508;
	bh=57FOBy08qBEXlKgCxiaToUjk/k0ohn9GFat1iPhq1H0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qNgGlyFhqKijoB0G4Ywrd7GUYr7ORvFwnPNuE3vOaLFpMG0R5YMyJG4BdrK0YRBl0
	 s9MuxLGYBRFHPfP4wR6xOmOYL379bGxAAfmMQv3tnU+LMUah3XqwEpnibLXwcFFV+v
	 w2eGG4/dCxmsSQQNhMs3y0W0tEVywByBIQV1xZAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390641AbgAXOS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:18:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:37710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390511AbgAXOSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:18:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 197D021556;
        Fri, 24 Jan 2020 14:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875503;
        bh=57FOBy08qBEXlKgCxiaToUjk/k0ohn9GFat1iPhq1H0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a1UmPzfAk4DFfv5pZgrb9tDHTQEOYPK9FVf9bvDDOLiH5AC7sSCXv2xIyNOMbv4Hm
         CjW9r6ndUYdwtDEsA+IJzOxvAT1ql1pGC7JuK5o5AewL/7gp0im7h6O6KkzTO93+7L
         bUj3PPl2A14cIAhcYwmun+jv0ln7BlVXIByLrPes=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 005/107] arm64: dts: meson-sm1-sei610: add gpio bluetooth interrupt
Date:   Fri, 24 Jan 2020 09:16:35 -0500
Message-Id: <20200124141817.28793-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124141817.28793-1-sashal@kernel.org>
References: <20200124141817.28793-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guillaume La Roque <glaroque@baylibre.com>

[ Upstream commit 30388cc075720aa0af4f2cb5933afa1f8f39d313 ]

add gpio irq to support interrupt trigger mode.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
index 3435aaa4e8db5..5d6a8dafe8dc0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
@@ -361,6 +361,8 @@
 
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
+		interrupt-parent = <&gpio_intc>;
+		interrupts = <95 IRQ_TYPE_LEVEL_HIGH>;
 		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
 		max-speed = <2000000>;
 		clocks = <&wifi32k>;
-- 
2.20.1

