Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B44CC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA05206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="leHI3ZAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgBMSAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:00:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52973 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbgBMSAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:00:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so7268785wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 10:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yW0jgXQz7fRClRh+H+UBu4xpGoCVJNVpLNtJDmiQHCo=;
        b=leHI3ZAnR0hc1CPEh523zBYIvdhDhGl+lUf9k+14RWWhuDXSIireK2PDjHb65FvML1
         ptuRaVvfpP0ukdogPOTE41+jwKEoZYKTOZ4l1VtM51bYmXT5Wd391SU2O1EeOphuTH1Q
         nOcM6yO5WGVyDFx3PCgW3l66xUwCfL6fygjLF/8umf903UcJi8wCfVvaQfBF3jcIlg/L
         08NbS6w4i+irgZeRQEN7jVh6rOWvTa+4NPcgeZ+NKYscwCWySrC2A6WuzL+WXkq4BQwk
         ho8wFD3GNgIJ4fVODC3SKHmMRFMpoT/Mk8+mql/ZP78rDo8XiadSzmKPJzDEaiE7kPff
         I5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yW0jgXQz7fRClRh+H+UBu4xpGoCVJNVpLNtJDmiQHCo=;
        b=PbRV6NpmOldqQmRHYupS83ZU30Y+ptJhn3UVe237hTJQXmpoOls2kfFIw7B3aIdsRE
         Qr5llquDDvRG3cQh6t6XQvWxPFIKE600NFy81A91Kx08Co5cTKS4e3T3gmuOtfQzvWTb
         XEYYFGtW1tfdql9TC3WmQREfrRGI/5aVKv8UHxlXCNFo1SI7sr4VJ8K5jo4mabwmILsB
         iUt6s6eLa5jMfwOh636UeRgx8YIdTgSqKbFePy5IGY3nqgcwcIAEzgcjZLprV+qPUCMJ
         +v1mn1KTCDVV/ZwAAZrUpZadIjgN73ff1OPIicQcSSU/1K1CfjRxZVA7vY30Z5+d+ecK
         ZeJg==
X-Gm-Message-State: APjAAAUJiSI3bKmJr+FGhAELFS+nHFu2DSMubSECZ/r+gzpoVOsej0NH
        XIqw+hUFAGFC513LHrse5QV8xr7oVjA=
X-Google-Smtp-Source: APXvYqyE3jb4mWwz79E0W8X+lrylXGFOk5ZjRVEQzAqMjPyr15hrfMPtVV5AqWvMPvY+9GQ49Fk3eA==
X-Received: by 2002:a05:600c:2187:: with SMTP id e7mr6898896wme.11.1581616805696;
        Thu, 13 Feb 2020 10:00:05 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z11sm3630089wrv.96.2020.02.13.10.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 10:00:05 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 1/2] watchdog: Check WDOG_STOP_ON_REBOOT in reboot notifier
Date:   Thu, 13 Feb 2020 17:59:57 +0000
Message-Id: <20200213175958.105914-2-dima@arista.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213175958.105914-1-dima@arista.com>
References: <20200213175958.105914-1-dima@arista.com>
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

As a preparation to move the watchdog's decision to stop on reboot or
not in userspace, allow WDOG_STOP_ON_REBOOT to be set during runtime,
not only on driver's probing. Always register reboot notifier and check
WDOG_STOP_ON_REBOOT inside it (on actual reboot).

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/watchdog/watchdog_core.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 861daf4f37b2..ebf80ff3e8ce 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -153,6 +153,10 @@ static int watchdog_reboot_notifier(struct notifier_block *nb,
 	struct watchdog_device *wdd;
 
 	wdd = container_of(nb, struct watchdog_device, reboot_nb);
+
+	if (!test_bit(WDOG_STOP_ON_REBOOT, &wdd->status))
+		return NOTIFY_DONE;
+
 	if (code == SYS_DOWN || code == SYS_HALT) {
 		if (watchdog_active(wdd)) {
 			int ret;
@@ -254,17 +258,14 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 		}
 	}
 
-	if (test_bit(WDOG_STOP_ON_REBOOT, &wdd->status)) {
-		wdd->reboot_nb.notifier_call = watchdog_reboot_notifier;
-
-		ret = register_reboot_notifier(&wdd->reboot_nb);
-		if (ret) {
-			pr_err("watchdog%d: Cannot register reboot notifier (%d)\n",
-			       wdd->id, ret);
-			watchdog_dev_unregister(wdd);
-			ida_simple_remove(&watchdog_ida, id);
-			return ret;
-		}
+	wdd->reboot_nb.notifier_call = watchdog_reboot_notifier;
+	ret = register_reboot_notifier(&wdd->reboot_nb);
+	if (ret) {
+		pr_err("watchdog%d: Cannot register reboot notifier (%d)\n",
+				wdd->id, ret);
+		watchdog_dev_unregister(wdd);
+		ida_simple_remove(&watchdog_ida, id);
+		return ret;
 	}
 
 	if (wdd->ops->restart) {
@@ -321,9 +322,7 @@ static void __watchdog_unregister_device(struct watchdog_device *wdd)
 	if (wdd->ops->restart)
 		unregister_restart_handler(&wdd->restart_nb);
 
-	if (test_bit(WDOG_STOP_ON_REBOOT, &wdd->status))
-		unregister_reboot_notifier(&wdd->reboot_nb);
-
+	unregister_reboot_notifier(&wdd->reboot_nb);
 	watchdog_dev_unregister(wdd);
 	ida_simple_remove(&watchdog_ida, wdd->id);
 }
-- 
2.25.0

