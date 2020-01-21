Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1451C33CB6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A734F206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="d8/NETrS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgAUQV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:21:59 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34072 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729273AbgAUQVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:21:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so3949788wrr.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 08:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AY7gzJpVgwoLzDrLzpZZrpTzP4MowdRWmtZvJqmyD6A=;
        b=d8/NETrSAl8IElP67e8VdOhFfToH/47rwfj11TCQiUFupkvJw7zfh6Fr+eqJQv2WU3
         OyZowoIedHdObkPaaJ/VQ6pXbAkosEJ2hSIxttQELNaDhoQegtkmSacq4P4KUpvFo+kh
         sX/3hxfAEMvhfvBfAh7lh8Hw0BH11E1kjDYKiTk+79ERFaf8ZTUq4lQT3wp6J+9JwWNE
         wKxJdmBr6wLSH5TgVhAe9tk6AduCuzVq41FTVqrRuJcGaIWMT093KDgO6RSZItx6bDuc
         HjAdyfgWuhYfRbMhUpAPacbh9jL8McO9mO4YiRNA/Halfn26MLR4f1EhSzjSgUSegs5X
         g8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AY7gzJpVgwoLzDrLzpZZrpTzP4MowdRWmtZvJqmyD6A=;
        b=BodefWPOx3bjseYQFectUWyPAZfscGHZ48YMgMIVUoC4+K6GgfyOkaZLE11V1eNguf
         RngN8L1ke98rmVPI6OuriXGjDdjBvBvHM0LbWzGomen9dALezw7DjiN0YYpUofHq9TJA
         hqy5VZxbKu5s1r9HSF5IzRZTZ+r2p54+WEnLOMUcok7nvYquUrKBLVVCydzRzlWo9osv
         GoI6u9hTYJtkPBsok26rd7nSeJoz+hHffIdyWxujiQUS97fXwRh6g0kaJ7i/8Lzc8g03
         vJMh6Bfs/J7pKDg6L+c4983RAbJyIhiQ4q50607lkIJIFbzmWQQeuMDPuLqxuMFXz4z6
         WLGw==
X-Gm-Message-State: APjAAAU/FnaGUqTlLT2AnvdVOmnl9PPnil2MhkDsGjvzt2EY0h5pT26+
        WxcubPXUm27XjiCcoeMCN0WgDqytlWY=
X-Google-Smtp-Source: APXvYqyIxrgxURVkWUvZnOLrzwB2hVAuiqTn2hI0/2V6DyeW3ukBp0NMPEMOxAu+iw/Xe39uAXwmRA==
X-Received: by 2002:adf:e683:: with SMTP id r3mr6360502wrm.38.1579623713609;
        Tue, 21 Jan 2020 08:21:53 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k8sm52454388wrl.3.2020.01.21.08.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 08:21:53 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
Subject: [RFC 2/2] watchdog/uapi: Add WDIOS_{RUN,STOP}_ON_REBOOT
Date:   Tue, 21 Jan 2020 16:21:45 +0000
Message-Id: <20200121162145.166334-3-dima@arista.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200121162145.166334-1-dima@arista.com>
References: <20200121162145.166334-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many watchdog drivers use watchdog_stop_on_reboot() helper in order
to stop the watchdog on system reboot. Unfortunately, this logic is
coded in driver's probe function and doesn't allows user to decide what
to do during shutdown/reboot.

On the other side, Xen and Qemu watchdog drivers (xen_wdt and i6300esb)
may be configured to either send NMI or turn off/reboot VM as
the watchdog action. As the kernel may stuck at any state, sending NMIs
can't reliably reboot the VM.

At Arista, we benefited from the following set-up: the emulated watchdogs
trigger VM reset and softdog is set to catch less severe conditions to
generate vmcore. Just before reboot watchdog's timeout is increased
to some good-enough value (3 mins). That keeps watchdog always running
and guarantees that VM doesn't stuck.

Provide new WDIOS_RUN_ON_REBOOT and WDIOS_STOP_ON_REBOOT ioctl options
to set up strategy on reboot.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/watchdog/watchdog_dev.c | 10 ++++++++++
 include/linux/watchdog.h        |  6 ++++++
 include/uapi/linux/watchdog.h   |  3 ++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 8766dd93028f..00135e698946 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -754,6 +754,16 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 		}
 		if (val & WDIOS_ENABLECARD)
 			err = watchdog_start(wdd);
+
+		if (val & WDIOS_RUN_ON_REBOOT) {
+			if (val & WDIOS_STOP_ON_REBOOT) {
+				err = -EINVAL;
+				break;
+			}
+			watchdog_run_on_reboot(wdd);
+		} else if (val & WDIOS_STOP_ON_REBOOT) {
+			watchdog_stop_on_reboot(wdd);
+		}
 		break;
 	case WDIOC_KEEPALIVE:
 		if (!(wdd->info->options & WDIOF_KEEPALIVEPING)) {
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 417d9f37077a..9e2ca7754631 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -150,6 +150,12 @@ static inline void watchdog_stop_on_reboot(struct watchdog_device *wdd)
 	set_bit(WDOG_STOP_ON_REBOOT, &wdd->status);
 }
 
+/* Use the following function to keep the watchdog running on reboot */
+static inline void watchdog_run_on_reboot(struct watchdog_device *wdd)
+{
+	clear_bit(WDOG_STOP_ON_REBOOT, &wdd->status);
+}
+
 /* Use the following function to stop the watchdog when unregistering it */
 static inline void watchdog_stop_on_unregister(struct watchdog_device *wdd)
 {
diff --git a/include/uapi/linux/watchdog.h b/include/uapi/linux/watchdog.h
index b15cde5c9054..bf19a5d3c987 100644
--- a/include/uapi/linux/watchdog.h
+++ b/include/uapi/linux/watchdog.h
@@ -53,6 +53,7 @@ struct watchdog_info {
 #define	WDIOS_DISABLECARD	0x0001	/* Turn off the watchdog timer */
 #define	WDIOS_ENABLECARD	0x0002	/* Turn on the watchdog timer */
 #define	WDIOS_TEMPPANIC		0x0004	/* Kernel panic on temperature trip */
-
+#define	WDIOS_RUN_ON_REBOOT	0x0008	/* Keep watchdog enabled on reboot */
+#define	WDIOS_STOP_ON_REBOOT	0x0010	/* Turn off the watchdog on reboot */
 
 #endif /* _UAPI_LINUX_WATCHDOG_H */
-- 
2.25.0

