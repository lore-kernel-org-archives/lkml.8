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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39E0C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 12:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE011206D9
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 12:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMejgg2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgDSM5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 08:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgDSM5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 08:57:17 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D19CC061A0C;
        Sun, 19 Apr 2020 05:57:17 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p8so3653530pgi.5;
        Sun, 19 Apr 2020 05:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=n1yXK12lhvDFnNxFvI8lgwTXKTQAmt128ajjq2nM9X0=;
        b=FMejgg2J7fOCuMnzlg+iYcYEr4/wB1xwUnD6Gb924kZlfB+BYb2UZ7eTcA0UEjVzS7
         gdFmx84xogK27xCy2+O1SyAg0kRwrtP7zVUz5gdSnz8pt96/+JKDTOoUwD5PI7yhKhOF
         57KEEJJLuD5aobm/5zhxdHXoJC4pBQsHrv5rVvrMmHBhcVgWp7iniyQljZFkU38/x3T1
         D26xc7Bqb/mDosXfYL7YQiJRR+qbTxXpD+OBQB1/DYP6SpJ6uEpX9oDO8Ygq/d7FjzCK
         vnE9K2tvMnEdr0S7TEyKKLDGQg4mtWwOllLdZC/3J1YP2nw58/ZMqtKtEh4NNX1d3Q1U
         j8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=n1yXK12lhvDFnNxFvI8lgwTXKTQAmt128ajjq2nM9X0=;
        b=AJRC7iuWPB19vVRvDGowlyCm5pLSVnK+PslqiZrtSZv02+j+m0Q3pZkZrNNbkQJAm5
         WmgXB3aCwDJCsrepgHL0bjV0WNA749JOB1uluJbCaqhceDNitQ+vHXqZRigxQU4ieoAj
         cBvKscbPcyVMAlT9wOYg9f7he8NK+A/EViawtXqN22ya6uiFf6+Y9wIQMCFkiMMeBVQu
         g9MSzzF6db1decN6LMilT/b6Bnr3e5Wtn86ju2t57qVs4JiN+IlKI/04DdBcUeF04ETZ
         iefG0EryU8tELdxAbXLePwQK1a4Hrj8WaAAQkQ4SjNIagspIzJo1i8VpKrm3FOKO4Ny0
         +mTw==
X-Gm-Message-State: AGi0PuZ0iOiwODpDZqEMTd/dcoQE05w9wIDNn7kGpHjIud4LKCjNKUSG
        wdVL2/2MZLF9Z6h7nREKq+9TgYBG
X-Google-Smtp-Source: APiQypI5KS8DKUjvrnEp4QOgFWjili31VtOupE7837PpNhQQFYqZIEUCczGmdhln2jqZcmBUeg7ZNA==
X-Received: by 2002:a63:d850:: with SMTP id k16mr6473150pgj.190.1587301036712;
        Sun, 19 Apr 2020 05:57:16 -0700 (PDT)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id x123sm1409714pfb.1.2020.04.19.05.57.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Apr 2020 05:57:16 -0700 (PDT)
Date:   Sun, 19 Apr 2020 18:27:10 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: renesas_usbhs: Use the correct style for SPDX License
 Identifier
Message-ID: <20200419125705.GA5172@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header files related to Renesas USBHS Controller Drivers.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/usb/renesas_usbhs/common.h | 2 +-
 drivers/usb/renesas_usbhs/fifo.h   | 2 +-
 drivers/usb/renesas_usbhs/mod.h    | 2 +-
 drivers/usb/renesas_usbhs/pipe.h   | 2 +-
 drivers/usb/renesas_usbhs/rcar2.h  | 2 +-
 drivers/usb/renesas_usbhs/rcar3.h  | 2 +-
 drivers/usb/renesas_usbhs/rza.h    | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/common.h b/drivers/usb/renesas_usbhs/common.h
index ef1735d014da..eb34d762a63d 100644
--- a/drivers/usb/renesas_usbhs/common.h
+++ b/drivers/usb/renesas_usbhs/common.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-1.0+
+/* SPDX-License-Identifier: GPL-1.0+ */
 /*
  * Renesas USB driver
  *
diff --git a/drivers/usb/renesas_usbhs/fifo.h b/drivers/usb/renesas_usbhs/fifo.h
index c3d3cc35cee0..7d3700bf41d9 100644
--- a/drivers/usb/renesas_usbhs/fifo.h
+++ b/drivers/usb/renesas_usbhs/fifo.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-1.0+
+/* SPDX-License-Identifier: GPL-1.0+ */
 /*
  * Renesas USB driver
  *
diff --git a/drivers/usb/renesas_usbhs/mod.h b/drivers/usb/renesas_usbhs/mod.h
index 65dc19ca528e..56b7106d254d 100644
--- a/drivers/usb/renesas_usbhs/mod.h
+++ b/drivers/usb/renesas_usbhs/mod.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-1.0+
+/* SPDX-License-Identifier: GPL-1.0+ */
 /*
  * Renesas USB driver
  *
diff --git a/drivers/usb/renesas_usbhs/pipe.h b/drivers/usb/renesas_usbhs/pipe.h
index 3b130529408b..a4ae9f97d9cd 100644
--- a/drivers/usb/renesas_usbhs/pipe.h
+++ b/drivers/usb/renesas_usbhs/pipe.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-1.0+
+/* SPDX-License-Identifier: GPL-1.0+ */
 /*
  * Renesas USB driver
  *
diff --git a/drivers/usb/renesas_usbhs/rcar2.h b/drivers/usb/renesas_usbhs/rcar2.h
index 7d88732c5bff..046d07edb36f 100644
--- a/drivers/usb/renesas_usbhs/rcar2.h
+++ b/drivers/usb/renesas_usbhs/rcar2.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #include "common.h"
 
 extern const struct renesas_usbhs_platform_info usbhs_rcar_gen2_plat_info;
diff --git a/drivers/usb/renesas_usbhs/rcar3.h b/drivers/usb/renesas_usbhs/rcar3.h
index c7c5ec1e3af2..d13db30bd21b 100644
--- a/drivers/usb/renesas_usbhs/rcar3.h
+++ b/drivers/usb/renesas_usbhs/rcar3.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #include "common.h"
 
 extern const struct renesas_usbhs_platform_info usbhs_rcar_gen3_plat_info;
diff --git a/drivers/usb/renesas_usbhs/rza.h b/drivers/usb/renesas_usbhs/rza.h
index 1ca42a6fd480..a29b75fef057 100644
--- a/drivers/usb/renesas_usbhs/rza.h
+++ b/drivers/usb/renesas_usbhs/rza.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #include "common.h"
 
 extern const struct renesas_usbhs_platform_info usbhs_rza1_plat_info;
-- 
2.17.1

