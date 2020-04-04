Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C56DC2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 09:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E956D206E9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 09:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nprn8Ox4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgDDJTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 05:19:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44045 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgDDJTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 05:19:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id b72so4873998pfb.11;
        Sat, 04 Apr 2020 02:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=NGWjop58dXG4vxvIdRNaBQN9RGU+nV2F4sGHS4krjUo=;
        b=Nprn8Ox4v6ELxRx0uvCCnpujI8wwKNUsM+6HRs7+1Lye6LpbA17bgc65vM72VA6nIY
         2BpFPqOzXpFBEp2SUgiYnh9l4z/sERklNKhOb+sYqX30nbOkZ0sBnf7EVpFcRSUfvYq9
         iQqLEG0iI6YFiGJEBQxDMoOy0pN6VcoMPVKCU0lrhBPukCkHI+e2tDH1232xxaFNVenx
         XIRY48YU2a74hyzAGGz0lFULb8MYSfm+Df3kXdtMrd8t7LOQnYRrztDV8dZTkW/YfeRO
         G6A7SLbEJNC5lApPyQuV1RXGs80URygT0Bz3DMLbe7HEonbTpHKr97+4oEssnL2cB7Eq
         uYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NGWjop58dXG4vxvIdRNaBQN9RGU+nV2F4sGHS4krjUo=;
        b=g8hNf48gXaZSxR9tMhwap9Of7+SU7qKqUmotOUD9LDvdOYxQgSYjKjPMmaKb7p4A7e
         69x8V9RjB66VVa4o38XMkWS7TbNkKuOgK8NceB7XqsUU826DJ07hwuMKx9G0jcJ6Uv7W
         eVcoKkeVIifQlsM13/DWA8dSshtKyxq1Ye0V5kgQPnSAA2BDBJ5G4oU2cjtwNOD+gqtT
         o1eYzDV4RYkihRfa5ZOi5ZYyy1VyB5PoEEu08Z80nrHMqEWV8tUr0zMEJP1eWO+X49DG
         BVfI/HcvlcStItGB0Q6yzpnIZnJvHV3WCxsOvPQxegROYvQA1OFwolFQ+Y27o8mXcLKm
         YoEA==
X-Gm-Message-State: AGi0PubVFqxwarenVf4N2WpOFT6BOlJrnThUTmd5t7cOPd70RjWjFqb+
        yp5ONJFHGUGuf4SKcNzMglY=
X-Google-Smtp-Source: APiQypKCYCka40/AuhMUFmyg+se9cHrBZC6b2n6BbAgRxBMoLZzUIJhfIT34BWH+s+H9QjCcVF1Kxg==
X-Received: by 2002:a63:4b53:: with SMTP id k19mr11878880pgl.91.1585991975371;
        Sat, 04 Apr 2020 02:19:35 -0700 (PDT)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id y15sm7331482pfc.206.2020.04.04.02.19.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Apr 2020 02:19:34 -0700 (PDT)
Date:   Sat, 4 Apr 2020 14:49:25 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Joe Perches <joe@perches.com>
Cc:     inux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] USB: host: Use the correct style for SPDX License Identifier
Message-ID: <20200404091921.GA4485@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header files related to USB host controller drivers.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/usb/host/ehci-fsl.h      | 2 +-
 drivers/usb/host/ehci.h          | 2 +-
 drivers/usb/host/fhci.h          | 2 +-
 drivers/usb/host/imx21-hcd.h     | 2 +-
 drivers/usb/host/ohci.h          | 2 +-
 drivers/usb/host/r8a66597.h      | 2 +-
 drivers/usb/host/xhci-debugfs.h  | 2 +-
 drivers/usb/host/xhci-ext-caps.h | 2 +-
 drivers/usb/host/xhci-mtk.h      | 2 +-
 drivers/usb/host/xhci-mvebu.h    | 2 +-
 drivers/usb/host/xhci-plat.h     | 2 +-
 drivers/usb/host/xhci-rcar.h     | 2 +-
 drivers/usb/host/xhci-trace.h    | 2 +-
 drivers/usb/host/xhci.h          | 2 +-
 14 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.h b/drivers/usb/host/ehci-fsl.h
index 9d18c6e6ab27..c95341d472f4 100644
--- a/drivers/usb/host/ehci-fsl.h
+++ b/drivers/usb/host/ehci-fsl.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /* Copyright (C) 2005-2010,2012 Freescale Semiconductor, Inc.
  * Copyright (c) 2005 MontaVista Software
  */
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index 229b3de319e6..eabf22a78eae 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 2001-2002 by David Brownell
  */
diff --git a/drivers/usb/host/fhci.h b/drivers/usb/host/fhci.h
index 2ce5031d866d..81fbc019a9b3 100644
--- a/drivers/usb/host/fhci.h
+++ b/drivers/usb/host/fhci.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Freescale QUICC Engine USB Host Controller Driver
  *
diff --git a/drivers/usb/host/imx21-hcd.h b/drivers/usb/host/imx21-hcd.h
index 7b9cf0a38d6e..96d16752a73e 100644
--- a/drivers/usb/host/imx21-hcd.h
+++ b/drivers/usb/host/imx21-hcd.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Macros and prototypes for i.MX21
  *
diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
index 27c26ca10bfd..b85a39588f9d 100644
--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-1.0+
+/* SPDX-License-Identifier: GPL-1.0+ */
 /*
  * OHCI HCD (Host Controller Driver) for USB.
  *
diff --git a/drivers/usb/host/r8a66597.h b/drivers/usb/host/r8a66597.h
index 51973a923526..ab081475c113 100644
--- a/drivers/usb/host/r8a66597.h
+++ b/drivers/usb/host/r8a66597.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * R8A66597 HCD (Host Controller Driver)
  *
diff --git a/drivers/usb/host/xhci-debugfs.h b/drivers/usb/host/xhci-debugfs.h
index f7a4e2492b00..56db635fcd6e 100644
--- a/drivers/usb/host/xhci-debugfs.h
+++ b/drivers/usb/host/xhci-debugfs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * xhci-debugfs.h - xHCI debugfs interface
  *
diff --git a/drivers/usb/host/xhci-ext-caps.h b/drivers/usb/host/xhci-ext-caps.h
index 268328c20681..fa59b242cd51 100644
--- a/drivers/usb/host/xhci-ext-caps.h
+++ b/drivers/usb/host/xhci-ext-caps.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * xHCI host controller driver
  *
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index acd56517215a..a93cfe817904 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2015 MediaTek Inc.
  * Author:
diff --git a/drivers/usb/host/xhci-mvebu.h b/drivers/usb/host/xhci-mvebu.h
index ca0a3a5721dd..3be021793cc8 100644
--- a/drivers/usb/host/xhci-mvebu.h
+++ b/drivers/usb/host/xhci-mvebu.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2014 Marvell
  *
diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
index 5681723fc9cd..b49f6447bd3a 100644
--- a/drivers/usb/host/xhci-plat.h
+++ b/drivers/usb/host/xhci-plat.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * xhci-plat.h - xHCI host controller driver platform Bus Glue.
  *
diff --git a/drivers/usb/host/xhci-rcar.h b/drivers/usb/host/xhci-rcar.h
index 012744a63a49..048ad3b8a6c7 100644
--- a/drivers/usb/host/xhci-rcar.h
+++ b/drivers/usb/host/xhci-rcar.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * drivers/usb/host/xhci-rcar.h
  *
diff --git a/drivers/usb/host/xhci-trace.h b/drivers/usb/host/xhci-trace.h
index b19582b2a72c..627abd236dbe 100644
--- a/drivers/usb/host/xhci-trace.h
+++ b/drivers/usb/host/xhci-trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * xHCI host controller driver
  *
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 3289bb516201..fb50f0e82d08 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 
 /*
  * xHCI host controller driver
-- 
2.17.1

