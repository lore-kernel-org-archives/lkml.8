Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1824C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FE52080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UszE7ICQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbgBJJB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 04:01:58 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42459 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgBJJB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:01:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id w21so3552257pgl.9;
        Mon, 10 Feb 2020 01:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=K/pRvxA36An+Rl1ZwAdNT+xdUuhMMDvr3Oav2x/KizU=;
        b=UszE7ICQpQdfWSHopva4WlhnC6fZuKAudkGJ4nWwZ+ffHqgeC46FOiLAjm+u0NkWwH
         El2ZnlxU6aN73wPFpI7dLvjFtMbhXpSFVWO0gC3+i5JFQQSsxsUlkKMav1uasAq5ZNWU
         b31dGaMVj6Ks72kIkmIvtQ85TgVFRXdHlODXfOgs+bPW2skrdIFUksPneON6xcjl6uco
         BXeEU7jzg+3tLAhGb/ayVw73RfVq8BgujarmUCdEUkmhbhP75yl9bohDKcCRDJ5Bv+jU
         CUSBfEzVEZUI6oELz94/xB2X0eeGKDmsMK8q5hWD6SvUm5DRxIVbSD+TWlqzbquAVXLX
         Oaxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K/pRvxA36An+Rl1ZwAdNT+xdUuhMMDvr3Oav2x/KizU=;
        b=rHtFbkGCT925DjdPTg08co+MfZfbkEL0HH/uWHUWSGQLuZlcImoKaaQpsuS/D/uVLg
         40Z44W/lmpeCwIuNCfM2gXwCNMNFYdbU11boby+I7t8qNHn+hRI3ZDCw830Ae0fBnSIp
         4BCyrjerVsZlRFZJYP5DTDi29GhesQZNaDao8Q1z8/rJvYH7E9wZQ6tPDlHgsahLXc4Q
         2/sJ/v8L3u8PNMXo28c6XLM4jFFVW+dOKv5HAbo+6lPCOhAk5fB8jU1QdyWP2ThUaQdj
         U1TTsu8O1spqLK/C5JD3qVzWu8YdpFJsCf5CbNDnktoHR6tvdFF2WQwCA8ybJQJr4L6O
         813Q==
X-Gm-Message-State: APjAAAU3O5BgclgQI2quXwC7YONHpkfz+5puOMfGSnTjz6fbEWcu/uW+
        z9nxAH3NiICklRNXKU+culQ=
X-Google-Smtp-Source: APXvYqy7dvivVB5cTr39/nXlMeb1apwvCx28InCMFND9wVG6borIFs5tJ8degoQ0THQyYJ+1yka0lg==
X-Received: by 2002:aa7:8191:: with SMTP id g17mr202075pfi.25.1581325317718;
        Mon, 10 Feb 2020 01:01:57 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id g2sm11963516pgn.59.2020.02.10.01.01.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Feb 2020 01:01:57 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        baolin.wang7@gmail.com
Subject: [RESEND PATCH] hwspinlock: Allow drivers to be built with COMPILE_TEST
Date:   Mon, 10 Feb 2020 17:01:07 +0800
Message-Id: <5a95c3de07ef020a4e2f2776fa5adb00637ee387.1581324976.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow drivers to be built with COMPILE_TEST.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/hwspinlock/Kconfig |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
index 37740e9..826a105 100644
--- a/drivers/hwspinlock/Kconfig
+++ b/drivers/hwspinlock/Kconfig
@@ -9,7 +9,7 @@ menuconfig HWSPINLOCK
 config HWSPINLOCK_OMAP
 	tristate "OMAP Hardware Spinlock device"
 	depends on HWSPINLOCK
-	depends on ARCH_OMAP4 || SOC_OMAP5 || SOC_DRA7XX || SOC_AM33XX || SOC_AM43XX || ARCH_K3
+	depends on ARCH_OMAP4 || SOC_OMAP5 || SOC_DRA7XX || SOC_AM33XX || SOC_AM43XX || ARCH_K3 || COMPILE_TEST
 	help
 	  Say y here to support the OMAP Hardware Spinlock device (firstly
 	  introduced in OMAP4).
@@ -19,7 +19,7 @@ config HWSPINLOCK_OMAP
 config HWSPINLOCK_QCOM
 	tristate "Qualcomm Hardware Spinlock device"
 	depends on HWSPINLOCK
-	depends on ARCH_QCOM
+	depends on ARCH_QCOM || COMPILE_TEST
 	select MFD_SYSCON
 	help
 	  Say y here to support the Qualcomm Hardware Mutex functionality, which
@@ -31,7 +31,7 @@ config HWSPINLOCK_QCOM
 config HWSPINLOCK_SIRF
 	tristate "SIRF Hardware Spinlock device"
 	depends on HWSPINLOCK
-	depends on ARCH_SIRF
+	depends on ARCH_SIRF || COMPILE_TEST
 	help
 	  Say y here to support the SIRF Hardware Spinlock device, which
 	  provides a synchronisation mechanism for the various processors
@@ -42,7 +42,7 @@ config HWSPINLOCK_SIRF
 
 config HWSPINLOCK_SPRD
 	tristate "SPRD Hardware Spinlock device"
-	depends on ARCH_SPRD
+	depends on ARCH_SPRD || COMPILE_TEST
 	depends on HWSPINLOCK
 	help
 	  Say y here to support the SPRD Hardware Spinlock device.
@@ -51,7 +51,7 @@ config HWSPINLOCK_SPRD
 
 config HWSPINLOCK_STM32
 	tristate "STM32 Hardware Spinlock device"
-	depends on MACH_STM32MP157
+	depends on MACH_STM32MP157 || COMPILE_TEST
 	depends on HWSPINLOCK
 	help
 	  Say y here to support the STM32 Hardware Spinlock device.
@@ -61,7 +61,7 @@ config HWSPINLOCK_STM32
 config HSEM_U8500
 	tristate "STE Hardware Semaphore functionality"
 	depends on HWSPINLOCK
-	depends on ARCH_U8500
+	depends on ARCH_U8500 || COMPILE_TEST
 	help
 	  Say y here to support the STE Hardware Semaphore functionality, which
 	  provides a synchronisation mechanism for the various processor on the
-- 
1.7.9.5

