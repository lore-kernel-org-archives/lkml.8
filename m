Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB39C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 16:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A24A12065D
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 16:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ndmsystems-com.20150623.gappssmtp.com header.i=@ndmsystems-com.20150623.gappssmtp.com header.b="d43EQWhn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgHIQNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 12:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgHIQM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 12:12:58 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCD7C061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 09:12:56 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id i10so7087350ljn.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 09:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndmsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UEpCtsZEvZZgbvhsQBYBWkiCjgyox61Emg/c1y2ZN3I=;
        b=d43EQWhnMIUnO0ayF/xBZT66+CQu7CKKb9TlQuBYJY4hAWz5E8yZRWDTEdRQnG2kqu
         L61G1YrcApisjNwWDUvL4ubvfMXQrCIB5FxuoJU/2qtM5OuABh8ga92lCA7AoPtaKYcK
         5mt9H91rLaEnDHSTHv6nSqQ8iFr2UNaToaQckqZWfqkLttr+uy6icA5qVu2f62rE4kCf
         H9k6PJjAP4YHc0P7f3sXBiUv/8J4KEm5GfWiLGUpHDU45ePXR2jZ6S+UhLVhPHoHSJk5
         9oP0jZItKO3v8hjrcF4KROr+5jFbL6fRtl0TjGcufpp7Kh8mYSRsiXAbsUkMLu9p9VWU
         dXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UEpCtsZEvZZgbvhsQBYBWkiCjgyox61Emg/c1y2ZN3I=;
        b=fRF+vSZR0MpHzHQ3t37RsgdBVwcQlZKa51ujomIbKGjoaKabXHWSbGiQzBr4jqDt3K
         cwdIlcdQxqIFGDag79fWIjQomNGYLHOVcbNAN6KiyeHOSo+AdQEnpn8qU1nMDBNe+YhH
         KKHw0KL7hE9IQNpR65mU9BudhkCNrDcar50GSLlmjgGBOOFFWdq/ved6NHME8tAgjhPd
         qfvR4rMTP1Myj3OllyPpCXf0zP7UiISRflTFQhPyFaA+DXPtzqEbok3sqaIdKozEGmN1
         abUrWZdXsBoljGPzz/+E6r4J0sCPOyHbXmau8vb8ELW5M+gVXboZeiZsgR4B5efaRWsu
         nn5w==
X-Gm-Message-State: AOAM532lAqe51/4fcgP/CNEpcWWq3pszSEXRV6URoyCh6XuETKKUajhs
        miW+DuW9Cr51Ib1ZocYkrlZqGw==
X-Google-Smtp-Source: ABdhPJxXNK/GX8iSF0+tUBzVrcJpI1Es27dIWpe2bDfWKcMa57w6DbPTwf60cmVZckN83ZjxqYj20w==
X-Received: by 2002:a2e:9c0b:: with SMTP id s11mr9170576lji.117.1596989571429;
        Sun, 09 Aug 2020 09:12:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:4a:1645::2])
        by smtp.googlemail.com with ESMTPSA id r14sm9066069lfe.29.2020.08.09.09.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 09:12:50 -0700 (PDT)
From:   Sergey Korolev <s.korolev@ndmsystems.com>
Cc:     s.korolev@ndmsystems.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rob Gill <rrobgill@protonmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: core: remove polling for /sys/kernel/debug/usb/devices
Date:   Sun,  9 Aug 2020 19:12:30 +0300
Message-Id: <20200809161233.13135-1-s.korolev@ndmsystems.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest reference to usbfs_conn_disc_event() removed in
commit fb28d58b72aa ("USB: remove CONFIG_USB_DEVICEFS")
in 2012 and now a user poll() waits infinitely for content changes.

Signed-off-by: Sergey Korolev <s.korolev@ndmsystems.com>
---
 drivers/usb/core/devices.c | 41 --------------------------------------
 drivers/usb/core/usb.h     |  1 -
 2 files changed, 42 deletions(-)

diff --git a/drivers/usb/core/devices.c b/drivers/usb/core/devices.c
index 696b2b692b83..1ef2de6e375a 100644
--- a/drivers/usb/core/devices.c
+++ b/drivers/usb/core/devices.c
@@ -39,7 +39,6 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/gfp.h>
-#include <linux/poll.h>
 #include <linux/usb.h>
 #include <linux/usbdevice_fs.h>
 #include <linux/usb/hcd.h>
@@ -97,22 +96,6 @@ static const char format_endpt[] =
 /* E:  Ad=xx(s) Atr=xx(ssss) MxPS=dddd Ivl=D?s */
   "E:  Ad=%02x(%c) Atr=%02x(%-4s) MxPS=%4d Ivl=%d%cs\n";
 
-/*
- * Wait for an connect/disconnect event to happen. We initialize
- * the event counter with an odd number, and each event will increment
- * the event counter by two, so it will always _stay_ odd. That means
- * that it will never be zero, so "event 0" will never match a current
- * event, and thus 'poll' will always trigger as readable for the first
- * time it gets called.
- */
-static struct device_connect_event {
-	atomic_t count;
-	wait_queue_head_t wait;
-} device_event = {
-	.count = ATOMIC_INIT(1),
-	.wait = __WAIT_QUEUE_HEAD_INITIALIZER(device_event.wait)
-};
-
 struct class_info {
 	int class;
 	char *class_name;
@@ -146,12 +129,6 @@ static const struct class_info clas_info[] = {
 
 /*****************************************************************/
 
-void usbfs_conn_disc_event(void)
-{
-	atomic_add(2, &device_event.count);
-	wake_up(&device_event.wait);
-}
-
 static const char *class_decode(const int class)
 {
 	int ix;
@@ -623,25 +600,7 @@ static ssize_t usb_device_read(struct file *file, char __user *buf,
 	return total_written;
 }
 
-/* Kernel lock for "lastev" protection */
-static __poll_t usb_device_poll(struct file *file,
-				    struct poll_table_struct *wait)
-{
-	unsigned int event_count;
-
-	poll_wait(file, &device_event.wait, wait);
-
-	event_count = atomic_read(&device_event.count);
-	if (file->f_version != event_count) {
-		file->f_version = event_count;
-		return EPOLLIN | EPOLLRDNORM;
-	}
-
-	return 0;
-}
-
 const struct file_operations usbfs_devices_fops = {
 	.llseek =	no_seek_end_llseek,
 	.read =		usb_device_read,
-	.poll =		usb_device_poll,
 };
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index 98e7d1ee63dc..c893f54a3420 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -191,7 +191,6 @@ extern const struct attribute_group *usb_interface_groups[];
 extern struct usb_driver usbfs_driver;
 extern const struct file_operations usbfs_devices_fops;
 extern const struct file_operations usbdev_file_operations;
-extern void usbfs_conn_disc_event(void);
 
 extern int usb_devio_init(void);
 extern void usb_devio_cleanup(void);
-- 
2.20.1

