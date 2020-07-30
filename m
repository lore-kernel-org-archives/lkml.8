Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08077C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 10:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D34E82082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 10:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=goautomation-biz.20150623.gappssmtp.com header.i=@goautomation-biz.20150623.gappssmtp.com header.b="As0Dc3S5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgG3Kdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 06:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgG3Kds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 06:33:48 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF3DC061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 03:33:48 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v4so18648253ljd.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 03:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=goautomation-biz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=pF91T05aS4Co7+HLHbZn7338QFcQLHQl99MYpUZGb5E=;
        b=As0Dc3S5gvTCRaWF6eKPI6A1dpajxz82kjEkzSQflmklQn+qmMC0kvcWDDxH+Gh/JP
         0H7lRTa3PUDu3QFs0/rA45xS9mz18eINnJOKaGSCPOIbpyOujNYjg6Muv7cXuqeVmkLj
         mbOdil5aQc2kntzEi3HvX/3VL/1NdqUzR2mw0KCSonVaecv0KCuHVpzWGQdFklaMPBzf
         bE/hH1YXUUFab8NXCaadZlO+h2kOpzS4WSVJzW+pyDzON/1Y4WLMElmQ4RK/mRI5eADL
         yexFgP6VYoXRvcbnWLW78dUV9ixqwWn8mntv7xmlK7D3s6Ks789cB5TIjX5wgO3O7qoE
         OVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pF91T05aS4Co7+HLHbZn7338QFcQLHQl99MYpUZGb5E=;
        b=V3RITKSd6jgzmBZ6T/xS3ZThZ0ji/qcQ5frfdPpgBlHlVckfkctoqjJOZAxFP79BKm
         L3n0GsaPy1XJmIqlTdD5ov4muhc1Cce5kWFzOwCFmNEP0In5Gkw2tSOVfzUT96HW1sQ4
         uPE2kenyNX8VdlT8qaxP2JxFI4+9aag9ALRKkr3h7Xog0AKY+RC/13hcYsfJx8fShqVy
         5xu6kfK65IggnFuvzUhLqHUHd0ulImBeK/OFQPpYYZFsk88i4uDZYg5t9/4W/TBbIyrS
         yCGFgFY6gHI3mRd5VXIe/KDDPdRDObkWdCvRYHv6Pww/2vyvO8toTlwF4rIzeERVD1dz
         Ozug==
X-Gm-Message-State: AOAM532yZ95R9iyNC14ywjBdMkUcaXto+Uj8seYN7yzpl82NJI3spOHh
        PgWsN/+x+sLjLlhgqIPTwXmKTnx1SupohfPb1uLFdF1QNf0=
X-Google-Smtp-Source: ABdhPJy6v079zOS2DCJQ2xknR1dMoxF/g3DOTJdPguz1oyEyMXc+oLLTMTIVXX7RTRZBGzB++s6idGTA7mAhPgnvrRc=
X-Received: by 2002:a2e:958f:: with SMTP id w15mr1162225ljh.190.1596105226219;
 Thu, 30 Jul 2020 03:33:46 -0700 (PDT)
MIME-Version: 1.0
From:   Neil Whelchel <neil@goautomation.biz>
Date:   Thu, 30 Jul 2020 03:32:55 -0700
Message-ID: <CAPcyyENjNG1oF_VnUE0YOf6sXgeS5KvvKaRV-Dk6sZYpf2fzBw@mail.gmail.com>
Subject: [PATCH] CREDITS: Update contact information
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update my email address in driver, documentation, and add to credits.

diff --git a/CREDITS b/CREDITS
index 0787b5872906..65803e878c92 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3957,6 +3957,14 @@ S: 820 4th St. N.
 S: Fargo, North Dakota 58122
 S: USA

+N: Neil Whelchel
+E: neil@goautomation.biz
+W: http://goautomation.biz
+S: Go Automation, LLC
+S: P.O. Box 2082
+S: Joshua Tree, Ca 92252
+S: USA
+
 N: Steven Whitehouse
 E: steve@chygwyn.com
 W: http://www.chygwyn.com/~steve
diff --git a/Documentation/usb/usb-serial.rst b/Documentation/usb/usb-serial.rst
index 8fa7dbd3da9a..f9ebfb1a60a3 100644
--- a/Documentation/usb/usb-serial.rst
+++ b/Documentation/usb/usb-serial.rst
@@ -231,7 +231,7 @@ ZyXEL omni.net lcd plus ISDN TA
 Cypress M8 CY4601 Family Serial Driver
 --------------------------------------

-  This driver was in most part developed by Neil "koyama" Whelchel.  It
+  This driver was in most part developed by Neil Whelchel.  It
   has been improved since that previous form to support dynamic serial
   line settings and improved line handling.  The driver is for the most
   part stable and has been tested on an smp machine. (dual p2)
diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index ecda82198798..2b1d854645ed 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -5,7 +5,7 @@
  *     Copyright (C) 2004
  *         Lonnie Mendez (dignome@gmail.com)
  *     Copyright (C) 2003,2004
- *         Neil Whelchel (koyama@firstlight.net)
+ *         Neil Whelchel (neil@goautomation.biz)
  *
  * See Documentation/usb/usb-serial.rst for more information on using this
  * driver
@@ -45,7 +45,7 @@ static bool stats;
 static int interval;
 static bool unstable_bauds;

-#define DRIVER_AUTHOR "Lonnie Mendez <dignome@gmail.com>, Neil
Whelchel <koyama@firstlight.net>"
+#define DRIVER_AUTHOR "Lonnie Mendez <dignome@gmail.com>, Neil
Whelchel <neil@goautomation.biz>"
 #define DRIVER_DESC "Cypress USB to Serial Driver"

 /* write buffer size defines */
