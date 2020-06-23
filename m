Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8C7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEDB52076A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SacbG/sM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732270AbgFWCwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732025AbgFWCvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:51:48 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8707C061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 19:51:47 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d10so6590016pls.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 19:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Bkqe8eP6qav0NO7h7H0YnVgLuAUP47V9yLKohTYScP4=;
        b=SacbG/sMALx094GrI3w7UgttPeQ0KM2G3AoODCvFQJGFJ5vln9En6Frb+o9dKibvSg
         Okny/UMLQJ0rhbLGQCyBu5QdK9UVQ6bkIbPfzInNDmXXD1VDvL4Fk5eQnAF6Sj3p2w2Y
         2+FdERPjM6wES4ug+qUdx3gg4X7vQHpHE8DiQ0xiITzjC2e4JMKiuenvvQityR3Vg9D9
         PxSZHeUFisHW6YGR24OuLF+Fkp6WcuDGEoDhwAhouEVR26WTM7LJ9rRq9VWGfpMusq71
         kp0t2+FGL7LqQPW3OOCbVJWMZ6bbxHBot6lBBdjtBD79Tw29zxpM1olGSTmWEhdi2TsC
         cQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Bkqe8eP6qav0NO7h7H0YnVgLuAUP47V9yLKohTYScP4=;
        b=FSR1XHP5GotjSbUqyUZaTi3niBJqBfnMWLEyCq8IZie6sBXT5W13tXO/aYa6fcvj8N
         fXiOCPyKMstWs3enQxn2Fc6IWHUYL7IYU1erLw6mqQB54jdFm39Hue8vcoQpDwqHjzTu
         Ja8j+X0tKKu09SYBRQnN72AcBPClXmPRCrlufg/nCbzlnNvFan2HWcTp5nEmnTWA6kUE
         Dnwr0SLgm1pLG0AgZYOHTrJJNVXnh5w560yqnAtDzB6Ofo5kxtTM2/vysN8pEwnuw2T1
         d2I/7jb7QAunRKH++z314YvabECTHj5dmsnkpuzsPyYQX/DFCfq/jcGjqbSV4EjHMd3m
         ZqKQ==
X-Gm-Message-State: AOAM532oTwNaIieZR+h/NZAsuEpUYqSpzAvg87Dgk6mB7gmnu4xBSXx3
        lylQPn84vi1OKxXbmsxbX7IoiT8C8S0=
X-Google-Smtp-Source: ABdhPJwQKgj2PeBSrZqxgChMqadOaXI5DuaCAkwJY1oO+kXbbPkv3BV7iGHMfNyJ7tZr2wPjeTAnMQ==
X-Received: by 2002:a17:902:ba83:: with SMTP id k3mr22973488pls.261.1592880707148;
        Mon, 22 Jun 2020 19:51:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y7sm15807629pfq.43.2020.06.22.19.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 19:51:46 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH] i2c: designware: Fix functionality in !CONFIG_ACPI case
Date:   Tue, 23 Jun 2020 02:51:44 +0000
Message-Id: <20200623025144.34246-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the HiKey board, where CONFIG_ACPI is not set, we started
to see a graphics regression where the adv7511 HDMI bridge driver
wasn't probing. This was due to the i2c bus failing to start up.

I bisected the problem down to commit f9288fcc5c615 ("i2c:
designware: Move ACPI parts into common module") and after
looking at it a bit, I realized that change moved some
initialization into i2c_dw_acpi_adjust_bus_speed(). However,
i2c_dw_acpi_adjust_bus_speed() is only functional if CONFIG_ACPI
is set.

This patch pulls i2c_dw_acpi_adjust_bus_speed() out of the
ifdef CONFIG_ACPI conditional, and gets the board working again.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Wolfram Sang <wsa@kernel.org>
Cc: linux-i2c@vger.kernel.org
Fixes: f9288fcc5c615 ("i2c: designware: Move ACPI parts into common module")
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/i2c/busses/i2c-designware-common.c | 4 ++--
 drivers/i2c/busses/i2c-designware-core.h   | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index e3a8640db7da..33de185e15f2 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -286,6 +286,8 @@ int i2c_dw_acpi_configure(struct device *device)
 }
 EXPORT_SYMBOL_GPL(i2c_dw_acpi_configure);
 
+#endif	/* CONFIG_ACPI */
+
 void i2c_dw_acpi_adjust_bus_speed(struct device *device)
 {
 	struct dw_i2c_dev *dev = dev_get_drvdata(device);
@@ -317,8 +319,6 @@ void i2c_dw_acpi_adjust_bus_speed(struct device *device)
 }
 EXPORT_SYMBOL_GPL(i2c_dw_acpi_adjust_bus_speed);
 
-#endif	/* CONFIG_ACPI */
-
 u32 i2c_dw_scl_hcnt(u32 ic_clk, u32 tSYMBOL, u32 tf, int cond, int offset)
 {
 	/*
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 556673a1f61b..ea2485872cab 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -364,8 +364,7 @@ int i2c_dw_validate_speed(struct dw_i2c_dev *dev);
 
 #if IS_ENABLED(CONFIG_ACPI)
 int i2c_dw_acpi_configure(struct device *device);
-void i2c_dw_acpi_adjust_bus_speed(struct device *device);
 #else
 static inline int i2c_dw_acpi_configure(struct device *device) { return -ENODEV; }
-static inline void i2c_dw_acpi_adjust_bus_speed(struct device *device) {}
 #endif
+void i2c_dw_acpi_adjust_bus_speed(struct device *device);
-- 
2.17.1

