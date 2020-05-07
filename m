Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D32C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1226F208CA
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgEGLhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 07:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgEGLhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:37:54 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDC0C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 04:37:54 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:6572:4a1f:d283:9ae8])
        by michel.telenet-ops.be with bizsmtp
        id bnds2200Z3ZRV0X06ndsE6; Thu, 07 May 2020 13:37:52 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jWeqe-0007Eu-B3; Thu, 07 May 2020 13:37:52 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jWeqe-0006JS-9i; Thu, 07 May 2020 13:37:52 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>, Ken Xue <Ken.Xue@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] pinctrl: amd: Add ACPI dependency
Date:   Thu,  7 May 2020 13:37:51 +0200
Message-Id: <20200507113751.24213-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the AMD pin controller driver supports ACPI platform only.
Make the PINCTRL_AMD config symbol depend on ACPI, to avoid asking the
user about it when configuring a kernel without ACPI support.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index f646f070d98fc2cb..f0ce4ce3e0f52456 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -95,6 +95,7 @@ config PINCTRL_AT91PIO4
 config PINCTRL_AMD
 	tristate "AMD GPIO pin control"
 	depends on HAS_IOMEM
+	depends on ACPI || COMPILE_TEST
 	select GPIOLIB
 	select GPIOLIB_IRQCHIP
 	select PINMUX
-- 
2.17.1

