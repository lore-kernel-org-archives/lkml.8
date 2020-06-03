Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385ACC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DF8920659
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbw38p2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgFCGpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 02:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgFCGpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 02:45:20 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8920EC05BD43
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 23:45:20 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a127so937622pfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 23:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uLhvVHc2quwQoGKg/SkeLM5Cyty3lJxhEEs1YioNG6g=;
        b=rbw38p2aa4lFLWcGblsb0QQU83Mo9aL1otVX4dMde4VR4fGp8r/yHaEeEf96uJXxkR
         DzRe9H3wpRKmSCTyk8yc5UYr8ZvJ1yHM824ALWTOA4pOUir6GaQTlu0mVnEfUKpN6Z0x
         2jBA/t6C+F43bIV0eMFB6E2deawjwdNz1oEcocQFZttqXgzfr0e5Cf5sXbjqAJMn7Zbr
         Hpsd5vMn3BviukoguU3ab7I9zr+t0JXBJouCBWxvbjd4WmrklSRTNeRmvZRJbHxYHt8C
         GCAU8xXG0EtT3uPoRaQgyokTZ47w9K4D9IH4TJhDbSQv9++W6gKHa6Bquz8ZGrWdn0bB
         b2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uLhvVHc2quwQoGKg/SkeLM5Cyty3lJxhEEs1YioNG6g=;
        b=E/+FoOd8UMYwO8gP1/qIwzbI+No8nuJpLb2a2aQEpZDW/mxGYpN11UjDKCGJ9AarUJ
         G6DX0cvwageSmGUz3nrZzsSAW98+LW5BVYYgdywoW3AdpKqxNB3gFEIBVdch8pcvGq1g
         tnmXKmLM5djAWZfgHKmiycD/8Zm5oqmfnGaWYM3iFZEqOSEKrDQE72POkPnkhQh4dRvJ
         +jIBTN2QOeva1b63u9EwdlIBavHyktLk6Ub1DdYhzpv2IGMfFFi4U+LfBr3J41L5h0Fr
         BdnWmCyzm/BTv7vfdpMDEPEcobI+5Yre5Q2r+dUN+YXWsVGMRSOdh1SuDij5+R0djeQO
         3YbQ==
X-Gm-Message-State: AOAM532txgoHEFp+4piezVfZ1usNffVJy0gfr+piNyd1RKsXFSx4chyY
        O0ADe8YIskGy4WBa0SVC91w=
X-Google-Smtp-Source: ABdhPJyfwd1s2KK/Xbds/vdRyuFHlajzEvfofWmv6yb6TaftFifRQWn+m7Iy2507WQvOT1Kpj4YkGg==
X-Received: by 2002:a65:4c8a:: with SMTP id m10mr26833343pgt.138.1591166719984;
        Tue, 02 Jun 2020 23:45:19 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id gm11sm1074720pjb.9.2020.06.02.23.45.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jun 2020 23:45:18 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     geert+renesas@glider.be, peter_hong@fintek.com.tw,
        linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH 1/1] driver core: Fix unbalance probe_count in really_probe()
Date:   Wed,  3 Jun 2020 14:45:09 +0800
Message-Id: <20200603064509.32736-1-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In previous patch, using return -EBUSY in really_probe() instead WARN_ON()
only. The following is the partial code.

	...
	atomic_inc(&probe_count);
	pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
		 drv->bus->name, __func__, drv->name, dev_name(dev));
	if (!list_empty(&dev->devres_head)) {
		dev_crit(dev, "Resources present before probing\n");
		return -EBUSY;
	}
	...

When the devres_head is not empty, this code will return -EBUSY to prevent
resource conflict, but it forgot to balance probe_count. We can move the
increasement code below the resource checking.

	...
	pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
		 drv->bus->name, __func__, drv->name, dev_name(dev));
	if (!list_empty(&dev->devres_head)) {
		dev_crit(dev, "Resources present before probing\n");
		return -EBUSY;
	}
	atomic_inc(&probe_count);
	...

The original code will cause lots motherboard freeze in reboot/shutdown
with systemd message "Reached target Reboot" or "Reached target Shutdown"
with serial8250 platform driver. e.g. AOPEN DE6200. The conflict boot
dmesg below:

	Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
	00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 921600) is a 16550A
	00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 921600) is a 16550A
	00:05: ttyS2 at I/O 0x3e8 (irq = 5, base_baud = 921600) is a 16550A
	serial8250: ttyS3 at I/O 0x2e8 (irq = 3, base_baud = 921600) is a 16550A

Reboot/Shutdown will freeze in wait_for_device_probe(), message as
following:
	INFQ: task systemd-shutdown: 1 blocked for more than 120 seconds.
	Not tainted 5.7.0-rc7-tty-next+ #241
	"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
	Call Trace:
	  __schedule+0x3d2/0x700
	  ? printk+0x52/0x6e
	  schedule+0x4f/0xc0
	  wait_for_device_probe+0xbb/0xl40
	  ? wait_woken+0x80/0x80
	  device_shutdown+0xl5/0xle0
	  kernel_power_off+0x35/0x70
	  __do_sys_reboot+0xla0/0x220
	  ? do_sigtimedwait+0xld0/0x210
	  ? do.writev+0x6a/0xll0
	  ? do.writev+0x6a/0xll0
	  ? sigprocmask+0x6f/Oxa0
	  __64_sys_reboot+0xle/0x20
	  do_syscall_64+0x57/0xlb0

Fixes: 7c35e699c88b ("driver core: Print device when resources present in really_probe()")
Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/base/dd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9a1d940342ac..5173b0766a26 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -487,7 +487,6 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	if (ret)
 		return ret;
 
-	atomic_inc(&probe_count);
 	pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
 		 drv->bus->name, __func__, drv->name, dev_name(dev));
 	if (!list_empty(&dev->devres_head)) {
@@ -495,6 +494,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 		return -EBUSY;
 	}
 
+	atomic_inc(&probe_count);
+
 re_probe:
 	dev->driver = drv;
 
-- 
2.17.1

