Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151B0C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE9F420724
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uGpvQuce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgDSNRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 09:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgDSNRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 09:17:04 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEA0C061A0C;
        Sun, 19 Apr 2020 06:17:04 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id np9so3328088pjb.4;
        Sun, 19 Apr 2020 06:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pojq7IS2ZkV3Xkekvu/Qb2XJwPNKxLd59gsvyr7juZY=;
        b=uGpvQuceRHO5ZyprbL7HSKUS8eTodPE2iYjFoZT+E1KAI0Yz3aMLMhWWvopHyfbL6S
         RQ4EpuUlgrsP5EBz9+OdaDYgWIicIzeboGEeBF2XE5u7SrdGhe1Y8a/EXJoCSAfMCuPI
         iMOAXPj/lZsR7kYi06z/BNdIyze5lKyhWaPvdyB/RpfKKn1z9v08QFFmmpNXfYySVU9w
         ne/RVDB+t0lKZ7Tq/h7W/keRiHp0GveNYXm8wXHqTm79wBhVyJNJ/SocxU8jtO7JIupl
         LkArwyOlBK72wiuunkoJ9dTlIjjHlATNK6Q7JxXxJnCqwTSRCrIAcwIG8uFQYHantAsf
         vKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pojq7IS2ZkV3Xkekvu/Qb2XJwPNKxLd59gsvyr7juZY=;
        b=BrL+5yI3lnRr6jmGGa5SB32Iz880lxWRDeawNihq61Ymh7DV0Pq/M3bKD42KbRRBx3
         6Cy9VkJ5YpqOHHqRnEn1Aw++u2fht98yoMTzXZDfZVtFMbD4nwj+fcpr2WCwx6pU3uOt
         nC3RuwDkMTEnDvA4FIIcRAksbcxRExmuaN5bIU6x/BFpEw/T83/Bf6jlLLRrAAEMR538
         8e/Z74vWkjH/Pas4tgafPgccnCgQij86L6MpoWPvI5MgpX1ank/av6//s5k2V+zd8R4p
         fswb7rD2WQQcCC2JBDhfyzVebTVmbW26H8Td/vaO84QRSvA4pX8AUmn0ZCRrWfj2TrfL
         lQLg==
X-Gm-Message-State: AGi0PuZSwCFauF7TfVzdopcwm0I0VlBUk0kHQNuDyE3vX7A2h/ArK5mu
        wQQUg30csHEGsjTcqF9jB0pxtMt4028=
X-Google-Smtp-Source: APiQypI8L4YrWmkmIwvBdpZv7GuaXsPB0PFWN3G2DDDQbktirmF4jWv9JydHkEzmuOw+VpC+sjps+A==
X-Received: by 2002:a17:902:b111:: with SMTP id q17mr11895329plr.160.1587302224002;
        Sun, 19 Apr 2020 06:17:04 -0700 (PDT)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id mq6sm11535048pjb.38.2020.04.19.06.17.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Apr 2020 06:17:03 -0700 (PDT)
Date:   Sun, 19 Apr 2020 18:46:57 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
Cc:     linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] USB: Storage: Use the correct style for SPDX License
 Identifier
Message-ID: <20200419131653.GA6611@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header files related to USB Storage driver configuration.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/usb/storage/debug.h              | 2 +-
 drivers/usb/storage/initializers.h       | 2 +-
 drivers/usb/storage/protocol.h           | 2 +-
 drivers/usb/storage/scsiglue.h           | 2 +-
 drivers/usb/storage/transport.h          | 2 +-
 drivers/usb/storage/unusual_alauda.h     | 2 +-
 drivers/usb/storage/unusual_cypress.h    | 2 +-
 drivers/usb/storage/unusual_datafab.h    | 2 +-
 drivers/usb/storage/unusual_devs.h       | 2 +-
 drivers/usb/storage/unusual_ene_ub6250.h | 2 +-
 drivers/usb/storage/unusual_freecom.h    | 2 +-
 drivers/usb/storage/unusual_isd200.h     | 2 +-
 drivers/usb/storage/unusual_jumpshot.h   | 2 +-
 drivers/usb/storage/unusual_karma.h      | 2 +-
 drivers/usb/storage/unusual_onetouch.h   | 2 +-
 drivers/usb/storage/unusual_realtek.h    | 2 +-
 drivers/usb/storage/unusual_sddr09.h     | 2 +-
 drivers/usb/storage/unusual_sddr55.h     | 2 +-
 drivers/usb/storage/unusual_uas.h        | 2 +-
 drivers/usb/storage/unusual_usbat.h      | 2 +-
 drivers/usb/storage/usb.h                | 2 +-
 21 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/storage/debug.h b/drivers/usb/storage/debug.h
index 16ce06039a4d..a6505ceb6693 100644
--- a/drivers/usb/storage/debug.h
+++ b/drivers/usb/storage/debug.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Driver for USB Mass Storage compliant devices
  * Debugging Functions Header File
diff --git a/drivers/usb/storage/initializers.h b/drivers/usb/storage/initializers.h
index 2dbf9c7d9749..dcd7b7e5eda8 100644
--- a/drivers/usb/storage/initializers.h
+++ b/drivers/usb/storage/initializers.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Header file for Special Initializers for certain USB Mass Storage devices
  *
diff --git a/drivers/usb/storage/protocol.h b/drivers/usb/storage/protocol.h
index 072f1ffda2af..1d102463a66c 100644
--- a/drivers/usb/storage/protocol.h
+++ b/drivers/usb/storage/protocol.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Driver for USB Mass Storage compliant devices
  * Protocol Functions Header File
diff --git a/drivers/usb/storage/scsiglue.h b/drivers/usb/storage/scsiglue.h
index 2bc5ea045bf7..2a79c3ed4d86 100644
--- a/drivers/usb/storage/scsiglue.h
+++ b/drivers/usb/storage/scsiglue.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Driver for USB Mass Storage compliant devices
  * SCSI Connecting Glue Header File
diff --git a/drivers/usb/storage/transport.h b/drivers/usb/storage/transport.h
index fb3bb4ee4ccf..74ffd0d7e7b6 100644
--- a/drivers/usb/storage/transport.h
+++ b/drivers/usb/storage/transport.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Driver for USB Mass Storage compliant devices
  * Transport Functions Header File
diff --git a/drivers/usb/storage/unusual_alauda.h b/drivers/usb/storage/unusual_alauda.h
index 0ec8c99a4976..13f61ec88cde 100644
--- a/drivers/usb/storage/unusual_alauda.h
+++ b/drivers/usb/storage/unusual_alauda.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Unusual Devices File for the Alauda-based card readers
  */
diff --git a/drivers/usb/storage/unusual_cypress.h b/drivers/usb/storage/unusual_cypress.h
index fb99e526cd48..0547daf116a2 100644
--- a/drivers/usb/storage/unusual_cypress.h
+++ b/drivers/usb/storage/unusual_cypress.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Unusual Devices File for devices based on the Cypress USB/ATA bridge
  *	with support for ATACB
diff --git a/drivers/usb/storage/unusual_datafab.h b/drivers/usb/storage/unusual_datafab.h
index fdab5e7d68ca..5335b5d2bd79 100644
--- a/drivers/usb/storage/unusual_datafab.h
+++ b/drivers/usb/storage/unusual_datafab.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Unusual Devices File for the Datafab USB Compact Flash reader
  */
diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index 1880f3e13f57..325da547827a 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Driver for USB Mass Storage compliant devices
  * Unusual Devices File
diff --git a/drivers/usb/storage/unusual_ene_ub6250.h b/drivers/usb/storage/unusual_ene_ub6250.h
index 9134b91fbd73..a3b32abc2b2f 100644
--- a/drivers/usb/storage/unusual_ene_ub6250.h
+++ b/drivers/usb/storage/unusual_ene_ub6250.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 #if defined(CONFIG_USB_STORAGE_ENE_UB6250) || \
 		defined(CONFIG_USB_STORAGE_ENE_UB6250_MODULE)
 
diff --git a/drivers/usb/storage/unusual_freecom.h b/drivers/usb/storage/unusual_freecom.h
index 949231c7a36b..9ca686364a93 100644
--- a/drivers/usb/storage/unusual_freecom.h
+++ b/drivers/usb/storage/unusual_freecom.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Unusual Devices File for the Freecom USB/IDE adaptor
  */
diff --git a/drivers/usb/storage/unusual_isd200.h b/drivers/usb/storage/unusual_isd200.h
index d03a02cc904e..f248190bd666 100644
--- a/drivers/usb/storage/unusual_isd200.h
+++ b/drivers/usb/storage/unusual_isd200.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Unusual Devices File for In-System Design, Inc. ISD200 ASIC
  */
diff --git a/drivers/usb/storage/unusual_jumpshot.h b/drivers/usb/storage/unusual_jumpshot.h
index c323338881ef..44878f849c1c 100644
--- a/drivers/usb/storage/unusual_jumpshot.h
+++ b/drivers/usb/storage/unusual_jumpshot.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Unusual Devices File for the Lexar "Jumpshot" Compact Flash reader
  */
diff --git a/drivers/usb/storage/unusual_karma.h b/drivers/usb/storage/unusual_karma.h
index 8f1eebd71d2c..9fbed4cbc895 100644
--- a/drivers/usb/storage/unusual_karma.h
+++ b/drivers/usb/storage/unusual_karma.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Unusual Devices File for the Rio Karma
  */
diff --git a/drivers/usb/storage/unusual_onetouch.h b/drivers/usb/storage/unusual_onetouch.h
index c76d4e990f7b..cdfee8f6cf37 100644
--- a/drivers/usb/storage/unusual_onetouch.h
+++ b/drivers/usb/storage/unusual_onetouch.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Unusual Devices File for the Maxtor OneTouch USB hard drive's button
  */
diff --git a/drivers/usb/storage/unusual_realtek.h b/drivers/usb/storage/unusual_realtek.h
index 7e14c2d7cf73..945dcb19d31d 100644
--- a/drivers/usb/storage/unusual_realtek.h
+++ b/drivers/usb/storage/unusual_realtek.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Driver for Realtek RTS51xx USB card reader
  *
diff --git a/drivers/usb/storage/unusual_sddr09.h b/drivers/usb/storage/unusual_sddr09.h
index 650cf2862754..bfb650974129 100644
--- a/drivers/usb/storage/unusual_sddr09.h
+++ b/drivers/usb/storage/unusual_sddr09.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Unusual Devices File for SanDisk SDDR-09 SmartMedia reader
  */
diff --git a/drivers/usb/storage/unusual_sddr55.h b/drivers/usb/storage/unusual_sddr55.h
index e89df2cea7bd..6d6f76eb0630 100644
--- a/drivers/usb/storage/unusual_sddr55.h
+++ b/drivers/usb/storage/unusual_sddr55.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Unusual Devices File for SanDisk SDDR-55 SmartMedia reader
  */
diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
index 1b23741036ee..cfdec74e0f4a 100644
--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Driver for USB Attached SCSI devices - Unusual Devices File
  *
diff --git a/drivers/usb/storage/unusual_usbat.h b/drivers/usb/storage/unusual_usbat.h
index 05abf6870b8f..f9d3e5efc39d 100644
--- a/drivers/usb/storage/unusual_usbat.h
+++ b/drivers/usb/storage/unusual_usbat.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Unusual Devices File for SCM Microsystems (a.k.a. Shuttle) USB-ATAPI cable
  */
diff --git a/drivers/usb/storage/usb.h b/drivers/usb/storage/usb.h
index 5850d624cac7..0451fac1adce 100644
--- a/drivers/usb/storage/usb.h
+++ b/drivers/usb/storage/usb.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Driver for USB Mass Storage compliant devices
  * Main Header File
-- 
2.17.1

