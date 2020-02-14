Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E581EC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F3624681
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581695471;
	bh=oTLpgiW9WQhqeQEcfMPYRJ+8j1DDz0URrp8+7Fc5ivI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tte2B92st3DAuqKjf/+cIMXmmAHPpZjKNPegDT5mz0aotHwUvuMVwzIGyE8XI4/i6
	 K/a6SVYLChY7jQsMviYpJ382wTEcmmpRacBtOsWlEnK+RAYARNXLfKCFk3yglLvny0
	 CRowzw9psW8alPXbSuA830C9QgglwX2bbJm7SYc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbgBNPvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:51:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730655AbgBNPvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:51:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42C5022314;
        Fri, 14 Feb 2020 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695462;
        bh=oTLpgiW9WQhqeQEcfMPYRJ+8j1DDz0URrp8+7Fc5ivI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SxRCULKWAsoGN5rvxMk3DDOmKrhv+CoGi3trKGzcycXNvdQVJu2bajVojyn9BWl59
         4ZURgP+jzqcDWrRZZwIBS9vRpi5KvY44SIHYBh1O5yz2uLDy/GD5wOK3J06tp+SXiQ
         cw4KeflOQQSMVSaZ64vKDEu3yYzZr/dLl5rV99Do=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 099/542] mfd: max77650: Select REGMAP_IRQ in Kconfig
Date:   Fri, 14 Feb 2020 10:41:31 -0500
Message-Id: <20200214154854.6746-99-sashal@kernel.org>
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

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

[ Upstream commit cb7a374a5e7a5af3f8c839f74439193add6d0589 ]

MAX77650 MFD driver uses regmap_irq API but doesn't select the required
REGMAP_IRQ option in Kconfig. This can cause the following build error
if regmap irq is not enabled implicitly by someone else:

    ld: drivers/mfd/max77650.o: in function `max77650_i2c_probe':
    max77650.c:(.text+0xcb): undefined reference to `devm_regmap_add_irq_chip'
    ld: max77650.c:(.text+0xdb): undefined reference to `regmap_irq_get_domain'
    make: *** [Makefile:1079: vmlinux] Error 1

Fix it by adding the missing option.

Fixes: d0f60334500b ("mfd: Add new driver for MAX77650 PMIC")
Reported-by: Paul Gazzillo <paul@pgazz.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 4209008521660..c366503c466dd 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -758,6 +758,7 @@ config MFD_MAX77650
 	depends on OF || COMPILE_TEST
 	select MFD_CORE
 	select REGMAP_I2C
+	select REGMAP_IRQ
 	help
 	  Say Y here to add support for Maxim Semiconductor MAX77650 and
 	  MAX77651 Power Management ICs. This is the core multifunction
-- 
2.20.1

