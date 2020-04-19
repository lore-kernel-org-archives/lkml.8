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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48AEC38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 701FC214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kfd/ueLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgDSNGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 09:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgDSNGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 09:06:14 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C686EC061A0C;
        Sun, 19 Apr 2020 06:06:14 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id a23so2897085plm.1;
        Sun, 19 Apr 2020 06:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=x13e4Lph7vZljz7h41hetbzBebxZhYomhQTZqjiToJM=;
        b=Kfd/ueLhVimc5NWzgL2NIZGr7Af0OGXV/BA+4EegPbarQ1rZE1LNvB76k0ZW58RXoe
         wDR8uTNdtZSnqFMMy5+VHepshPvDQq4vcrZ/EtKo+BG9u+ZIKvGhWuK8zM7/tstXhX02
         mn3xPSTB71yDTh2sDH2TwkJ3i2ullBhy/xcMQfe++19fFs+bldlWFyXMDZziNg1HDrJH
         k2d+ISyDI0jefA5SCp5elV2ovTboI0yOllzae3LglXGb5Svmaql1oOCCNpTTiGVqwIGz
         BlvJ2jcCQXuRaZEyX2jW60ON4XKZ5AzBNmCOu9sRgDyG9C9MW5Z/Imu8eOvxWKwGcKU+
         Y0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=x13e4Lph7vZljz7h41hetbzBebxZhYomhQTZqjiToJM=;
        b=iPEYK0toljmFiZSMD/eOHlw5hSknHhjzq4g9XKlKAquaKRCVGCuD5pnDw0HpqcMu02
         +98X65BFWI7Z2ED2si0KEpolhp6jOqe7Gmt2aLvSdDWI8V1lMMVA+kxyritKTigQbNTg
         76OQRKCoYz3R7FZxnP+3t2b+P4NBGP/Q+U7iBhfW3aok1UT046qbKXv91wvTJM35VObQ
         KgGYhJ/XmQdxlp/GI8apiebHXk5kNA7huK36xb6hJLy1w3TJ3MwC3PB7wD4dq2PDiN1L
         eBe7RoglCn4BGQ2BfYFUMg0GyCvG3OrWoF7qaWcyhmumLIV8rUcDa/qgVmUOCCmTMVo/
         MFPw==
X-Gm-Message-State: AGi0PubrObJ+leuYXbnX38OZD/PuOsy59qdFZsfvvgal7zXBpMO2T7en
        4Cy6XO6GpseKFVjJdoUcZ9XKnRL8jOo=
X-Google-Smtp-Source: APiQypJLCyF5GnLMu26JVoMR7Zy0hcSMhA5dN4iU07s63O5w9Y3jsS+tl6RHA9pjlGtOVg59oTN6FQ==
X-Received: by 2002:a17:90b:3615:: with SMTP id ml21mr16095454pjb.145.1587301574120;
        Sun, 19 Apr 2020 06:06:14 -0700 (PDT)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id x16sm22084914pfm.146.2020.04.19.06.06.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Apr 2020 06:06:13 -0700 (PDT)
Date:   Sun, 19 Apr 2020 18:36:07 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: serial: Use the correct style for SPDX License
 Identifier
Message-ID: <20200419130603.GA5763@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header files related to USB Serial device configuration.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/usb/serial/belkin_sa.h   | 2 +-
 drivers/usb/serial/io_16654.h    | 2 +-
 drivers/usb/serial/io_edgeport.h | 2 +-
 drivers/usb/serial/io_ionsp.h    | 2 +-
 drivers/usb/serial/io_ti.h       | 2 +-
 drivers/usb/serial/io_usbvend.h  | 2 +-
 drivers/usb/serial/iuu_phoenix.h | 2 +-
 drivers/usb/serial/mct_u232.h    | 2 +-
 drivers/usb/serial/oti6858.h     | 2 +-
 drivers/usb/serial/pl2303.h      | 2 +-
 drivers/usb/serial/visor.h       | 2 +-
 drivers/usb/serial/whiteheat.h   | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/serial/belkin_sa.h b/drivers/usb/serial/belkin_sa.h
index a13a98d284f2..89ec30c63cc6 100644
--- a/drivers/usb/serial/belkin_sa.h
+++ b/drivers/usb/serial/belkin_sa.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Definitions for Belkin USB Serial Adapter Driver
  *
diff --git a/drivers/usb/serial/io_16654.h b/drivers/usb/serial/io_16654.h
index 4980f72dc56f..f18501f056cf 100644
--- a/drivers/usb/serial/io_16654.h
+++ b/drivers/usb/serial/io_16654.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /************************************************************************
  *
  *	16654.H		Definitions for 16C654 UART used on EdgePorts
diff --git a/drivers/usb/serial/io_edgeport.h b/drivers/usb/serial/io_edgeport.h
index 2e7fedbaf2ff..43ba53a3a6fa 100644
--- a/drivers/usb/serial/io_edgeport.h
+++ b/drivers/usb/serial/io_edgeport.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /************************************************************************
  *
  *	io_edgeport.h	Edgeport Linux Interface definitions
diff --git a/drivers/usb/serial/io_ionsp.h b/drivers/usb/serial/io_ionsp.h
index 4b8e4823bd45..db4fce815c97 100644
--- a/drivers/usb/serial/io_ionsp.h
+++ b/drivers/usb/serial/io_ionsp.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /************************************************************************
  *
  *	IONSP.H		Definitions for I/O Networks Serial Protocol
diff --git a/drivers/usb/serial/io_ti.h b/drivers/usb/serial/io_ti.h
index 9bbcee37524e..50b899d55ed0 100644
--- a/drivers/usb/serial/io_ti.h
+++ b/drivers/usb/serial/io_ti.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*****************************************************************************
  *
  *	Copyright (C) 1997-2002 Inside Out Networks, Inc.
diff --git a/drivers/usb/serial/io_usbvend.h b/drivers/usb/serial/io_usbvend.h
index 0d1a5bb4636e..52cbc353051f 100644
--- a/drivers/usb/serial/io_usbvend.h
+++ b/drivers/usb/serial/io_usbvend.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /************************************************************************
  *
  *	USBVEND.H		Vendor-specific USB definitions
diff --git a/drivers/usb/serial/iuu_phoenix.h b/drivers/usb/serial/iuu_phoenix.h
index b400b262f72e..87992b24d904 100644
--- a/drivers/usb/serial/iuu_phoenix.h
+++ b/drivers/usb/serial/iuu_phoenix.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Infinity Unlimited USB Phoenix driver
  *
diff --git a/drivers/usb/serial/mct_u232.h b/drivers/usb/serial/mct_u232.h
index 0084edf518e8..e3d09a83cab1 100644
--- a/drivers/usb/serial/mct_u232.h
+++ b/drivers/usb/serial/mct_u232.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Definitions for MCT (Magic Control Technology) USB-RS232 Converter Driver
  *
diff --git a/drivers/usb/serial/oti6858.h b/drivers/usb/serial/oti6858.h
index 1226bf2347eb..5c25836fdcd9 100644
--- a/drivers/usb/serial/oti6858.h
+++ b/drivers/usb/serial/oti6858.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Ours Technology Inc. OTi-6858 USB to serial adapter driver.
  */
diff --git a/drivers/usb/serial/pl2303.h b/drivers/usb/serial/pl2303.h
index 52db5519aaf0..7d3090ee7e0c 100644
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Prolific PL2303 USB to serial adaptor driver header file
  */
diff --git a/drivers/usb/serial/visor.h b/drivers/usb/serial/visor.h
index 4bd69d047036..622d639ce74e 100644
--- a/drivers/usb/serial/visor.h
+++ b/drivers/usb/serial/visor.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * USB HandSpring Visor driver
  *
diff --git a/drivers/usb/serial/whiteheat.h b/drivers/usb/serial/whiteheat.h
index 269e727a92f9..7e63074c9128 100644
--- a/drivers/usb/serial/whiteheat.h
+++ b/drivers/usb/serial/whiteheat.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * USB ConnectTech WhiteHEAT driver
  *
-- 
2.17.1

