Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BC4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 03:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1BCE206EB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 03:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPTSDknI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgGAD04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 23:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgGAD0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 23:26:55 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DFEC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 20:26:55 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x72so928667pfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 20:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=haItCdpVH6dP/fd+5hLpgld/wltsvifALp6/dCIKiUI=;
        b=SPTSDknIZgZlYH4/MMUk8/DWmB5sQwqLFNIvY0YQOzB+1NDSz9ue0XTtY3zJPJyGPh
         FqYx+8nz67YMzigCBFOubptd5wD+AGrzkNOC9mswhVQVpRpy1G4xqLOEj37d5fyVqEc7
         cd4OaUQh7JHIrwrFMQSkq6zd2XvhWmkPmzej1vmhBbPokqpEPg1JNPk92NYgev7Az2KE
         BWIqv/oL6SGFETlqDugkXCh9yW0FcNtICllVvQpdfuD4JdcqnxQOiDMQAAJQCYsKUQZ/
         dqD6xZf1AJ3zbmmQlfkMI7yEtZ3I6ZCag2iVjXKjIZigm8isfBJdDuvBvLcdx+dD8Iw+
         7mZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=haItCdpVH6dP/fd+5hLpgld/wltsvifALp6/dCIKiUI=;
        b=LdAODijHN2OEiF+FpP3cEY+OruaO7VvD2imHHJE3+HvqHDj6Popygpmo6hEB4tbnXa
         rUg6H4vefCjrpRkUNIwfkqusAyD2t2INF88KWBnH4ZdVrIvA5iSffGO8W/80nBxeI+Fu
         +RzWxSZAnW3aFMoyRALP1LTd/5DSSyaxiW427rHsaFxSoT5umZC30OSdF+UZEelCQTk1
         hjs7ixsblWq0hPQPa/dixStzcngv2Vi2+6LEzisg9s+2gBynJ0slAv/YOB9qPbIbpOks
         6Wfw/p2uTbCSkEEEA9zca03d7xdDRDbjNkj9Q0rrtfRpxKBmfFPOB28OvxU9qY9aKhfK
         EO/Q==
X-Gm-Message-State: AOAM532JCb7siMuyrMiaJEOxBOXH9eTpJy+XWycnu9v4GAf9DN/fEsv+
        8I2gUbCxDJOr0bRcRrrjpHA=
X-Google-Smtp-Source: ABdhPJxhMdBD2bTgiyIx0gqt4AIvw35kkmSWBBquJORLP6hBn08oAcBgjQkCQhESure4jATbG6y9Zw==
X-Received: by 2002:aa7:8b4b:: with SMTP id i11mr22292919pfd.123.1593574015112;
        Tue, 30 Jun 2020 20:26:55 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s36sm3942110pgl.35.2020.06.30.20.26.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jun 2020 20:26:54 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] imx: Provide correct number of resources when registering gpio devices
Date:   Tue, 30 Jun 2020 20:26:51 -0700
Message-Id: <20200701032651.12420-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit a85a6c86c25be ("driver core: platform: Clarify that IRQ 0 is
invalid"), the kernel is a bit touchy when it encounters interrupt 0.
As a result, there are lots of warnings such as the following when booting
systems such as 'kzm'.

WARNING: CPU: 0 PID: 1 at drivers/base/platform.c:224 platform_get_irq_optional+0x118/0x128
0 is an invalid IRQ number
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc3 #1
Hardware name: Kyoto Microcomputer Co., Ltd. KZM-ARM11-01
[<c01127d4>] (unwind_backtrace) from [<c010c620>] (show_stack+0x10/0x14)
[<c010c620>] (show_stack) from [<c06f5f54>] (dump_stack+0xe8/0x120)
[<c06f5f54>] (dump_stack) from [<c0128878>] (__warn+0xe4/0x108)
[<c0128878>] (__warn) from [<c0128910>] (warn_slowpath_fmt+0x74/0xbc)
[<c0128910>] (warn_slowpath_fmt) from [<c08b8e84>] (platform_get_irq_optional+0x118/0x128)
[<c08b8e84>] (platform_get_irq_optional) from [<c08b8eb4>] (platform_irq_count+0x20/0x3c)
[<c08b8eb4>] (platform_irq_count) from [<c0728660>] (mxc_gpio_probe+0x8c/0x494)
[<c0728660>] (mxc_gpio_probe) from [<c08b93cc>] (platform_drv_probe+0x48/0x98)
[<c08b93cc>] (platform_drv_probe) from [<c08b703c>] (really_probe+0x214/0x344)
[<c08b703c>] (really_probe) from [<c08b7274>] (driver_probe_device+0x58/0xb4)
[<c08b7274>] (driver_probe_device) from [<c08b7478>] (device_driver_attach+0x58/0x60)
[<c08b7478>] (device_driver_attach) from [<c08b7504>] (__driver_attach+0x84/0xc0)
[<c08b7504>] (__driver_attach) from [<c08b50f8>] (bus_for_each_dev+0x78/0xb8)
[<c08b50f8>] (bus_for_each_dev) from [<c08b62cc>] (bus_add_driver+0x154/0x1e0)
[<c08b62cc>] (bus_add_driver) from [<c08b82b8>] (driver_register+0x74/0x108)
[<c08b82b8>] (driver_register) from [<c0102320>] (do_one_initcall+0x80/0x3b4)
[<c0102320>] (do_one_initcall) from [<c1501008>] (kernel_init_freeable+0x170/0x208)
[<c1501008>] (kernel_init_freeable) from [<c0e178d4>] (kernel_init+0x8/0x11c)
[<c0e178d4>] (kernel_init) from [<c0100134>] (ret_from_fork+0x14/0x20)

As it turns out, mxc_register_gpio() is a bit lax when setting the
number of resources: it registers a resource with interrupt 0 when in
reality there is no such interrupt. Fix the problem by not declaring
the second interrupt resource if there is no second interrupt.

Fixes: a85a6c86c25be ("driver core: platform: Clarify that IRQ 0 is invalid")
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm/mach-imx/devices/platform-gpio-mxc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/devices/platform-gpio-mxc.c b/arch/arm/mach-imx/devices/platform-gpio-mxc.c
index 78628ef12672..355de845224c 100644
--- a/arch/arm/mach-imx/devices/platform-gpio-mxc.c
+++ b/arch/arm/mach-imx/devices/platform-gpio-mxc.c
@@ -24,7 +24,8 @@ struct platform_device *__init mxc_register_gpio(char *name, int id,
 			.flags = IORESOURCE_IRQ,
 		},
 	};
+	unsigned int nres;
 
-	return platform_device_register_resndata(&mxc_aips_bus,
-			name, id, res, ARRAY_SIZE(res), NULL, 0);
+	nres = irq_high ? ARRAY_SIZE(res) : ARRAY_SIZE(res) - 1;
+	return platform_device_register_resndata(&mxc_aips_bus, name, id, res, nres, NULL, 0);
 }
-- 
2.17.1

