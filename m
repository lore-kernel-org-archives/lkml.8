Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31C5C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974D421582
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747685;
	bh=57FOBy08qBEXlKgCxiaToUjk/k0ohn9GFat1iPhq1H0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eZOhIY59fDEEswtWH5sayfbARhzCinoloDvR001DxuFpFaTGTV3xepZUmftbh+1/+
	 3Q9BlOG18DN0DxI7TknPAIBjU2eeWKG2qO8Mu607VeOPfxGQaPuIpSsMEJSg6F5KvD
	 H2vhQ0VPImjRS7XI3SaX4CfnTnWgnvbzEIsdWmxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbgBCQeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:34:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:49088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730815AbgBCQek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:34:40 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2142F20CC7;
        Mon,  3 Feb 2020 16:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747679;
        bh=57FOBy08qBEXlKgCxiaToUjk/k0ohn9GFat1iPhq1H0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bPuSEoKFYbDuHrRmRZGVwxoGkvyRoyYI78CPa7lCS3KXBcMlpakPvoFSUTzaCULEW
         nj5iDy1dY0oXc030FQHl5LjgzCf9F1aBu3HeTDPWkAsnXEaNZtmP08MMUEA3zsbwx3
         i12q0BKHiOiaBQzBRjFKaZYgI1MtoksVr2stV14Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guillaume La Roque <glaroque@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 25/90] arm64: dts: meson-sm1-sei610: add gpio bluetooth interrupt
Date:   Mon,  3 Feb 2020 16:19:28 +0000
Message-Id: <20200203161920.928315872@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161917.612554987@linuxfoundation.org>
References: <20200203161917.612554987@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



