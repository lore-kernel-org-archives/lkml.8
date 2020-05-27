Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9687C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B59C8207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XsUGywVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbgE0L0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730000AbgE0L0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:26:34 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92F0C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:26:33 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 82so14247676lfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7O70g2lJGWAJBSxv7+BPv+EgaUlJHCXJMM3QrFbfLoU=;
        b=XsUGywVbPPu2a5crGLJmxPTCsuzR0OuIQ+aBzOOBv++1v3NKjBLrrjSSZcDpiYN0qf
         Dqa0KgBDDL2GMXstARbs0S3GGlmSB6moGoADwt2Gf9llGEkgAQoEEbIxpiCeugl/wXdJ
         1Y7er1GA02R3sgkVvwl7nNkN/XKDaMMP9Wjvt0SWx7XmF54qZM7DmAzM4MJwI1dZ8eli
         ASI8yK3ag/j5xU4oDjT5/oP5EaLGYEpesbrFqrn6AVy/NiIea1s2hRKTrr2EHjKvVfgG
         4J+BYiAZgDrSD/C3CkWmD+A/yT8MjSYIMj7StC2bFYg9auoVk0KpMirlMocizL+A561/
         0/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7O70g2lJGWAJBSxv7+BPv+EgaUlJHCXJMM3QrFbfLoU=;
        b=DMXdkGyGQfTFXRrjRGUZ6TYIyUSW42D86ucYqUl3ZWHwLZslJ+WH1W8yf8vtGVf9SV
         3Ne+OS2P+PpeyphUsQgMeDu2wQVceX/OYCKC9hXYm5usFJW+6jF5RJ0UyIrzMBs84w9M
         PlpHp/swnfoLiC7u5slF6esdUdB+Tv95zDHgHJyU7jk3wYeJEUAwOqPFyXvYmatxjfKW
         CrlDMVOwJbOY9APSZzLfg4HJZbJyHJm4ymVTX99354SZneE+Yh2EnvMo7rtpuzufp3Uw
         pNrBeRZSeKtL9r2VSH1Zg4zaE3NmIpsb+wYq7GyTLKumal863lZ8sIRnzwNgL1Wb7/Wf
         PCVg==
X-Gm-Message-State: AOAM533RpC+1nqvXn6qHj48xRCPA2FNmShhUZvsPdHgSUJO3v6HKkZ53
        gF1LKKQB7MvnhmDbN83SnCPcZw==
X-Google-Smtp-Source: ABdhPJxqhuM7NA8BFMzydGM+AFjiGQCKOMTJMKG2dfNheWXSg5exJmnEkRYX48DfquyDmwLY2gQZtQ==
X-Received: by 2002:ac2:5604:: with SMTP id v4mr2364028lfd.124.1590578792196;
        Wed, 27 May 2020 04:26:32 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id n22sm627557ljj.138.2020.05.27.04.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 04:26:31 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, linus.walleij@linaro.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 5/5] power: vexpress: make the reset driver a module
Date:   Wed, 27 May 2020 13:26:08 +0200
Message-Id: <20200527112608.3886105-6-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527112608.3886105-1-anders.roxell@linaro.org>
References: <20200527112608.3886105-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today the vexpress power driver can only be builtin.  Rework so it's
possible for the vexpress power driver to be a module.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm/mach-vexpress/Kconfig          |  1 -
 drivers/power/reset/Kconfig             |  5 +++--
 drivers/power/reset/vexpress-poweroff.c | 12 +++++++++++-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 065e12991663..4b54d8cf897d 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -15,7 +15,6 @@ menuconfig ARCH_VEXPRESS
 	select NO_IOPORT_MAP
 	select PLAT_VERSATILE
 	select POWER_RESET
-	select POWER_RESET_VEXPRESS
 	select POWER_SUPPLY
 	select REGULATOR if MMC_ARMMMCI
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index f07b982c8dff..8468d42b0198 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -189,9 +189,10 @@ config POWER_RESET_VERSATILE
 	  reference boards.
 
 config POWER_RESET_VEXPRESS
-	bool "ARM Versatile Express power-off and reset driver"
+	tristate "ARM Versatile Express power-off and reset driver"
 	depends on ARM || ARM64
-	depends on VEXPRESS_CONFIG=y
+	depends on VEXPRESS_CONFIG
+	default VEXPRESS_CONFIG
 	help
 	  Power off and reset support for the ARM Ltd. Versatile
 	  Express boards.
diff --git a/drivers/power/reset/vexpress-poweroff.c b/drivers/power/reset/vexpress-poweroff.c
index 1fdbcbd95fc2..b1eef95132d9 100644
--- a/drivers/power/reset/vexpress-poweroff.c
+++ b/drivers/power/reset/vexpress-poweroff.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/module.h>
 #include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -146,4 +147,13 @@ static struct platform_driver vexpress_reset_driver = {
 		.suppress_bind_attrs = true,
 	},
 };
-builtin_platform_driver(vexpress_reset_driver);
+
+static int __init vexpress_reset_init(void)
+{
+	return platform_driver_register(&vexpress_reset_driver);
+}
+module_init(vexpress_reset_init);
+
+MODULE_AUTHOR("Pawel Moll <pawel.moll@arm.com>");
+MODULE_DESCRIPTION("Vexpress reset driver");
+MODULE_LICENSE("GPL v2");
-- 
2.26.2

