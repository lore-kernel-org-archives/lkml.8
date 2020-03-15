Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA844C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 10:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E6A206BE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 10:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ytc0lS9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgCOKzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 06:55:18 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55003 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbgCOKzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 06:55:18 -0400
Received: by mail-pj1-f66.google.com with SMTP id np16so6523100pjb.4;
        Sun, 15 Mar 2020 03:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qIYlGm4yxuJWPGZE9jBq7SClwzl5SsZAe4AqIxxnJxw=;
        b=Ytc0lS9YIYTtXj0J3ndnY9qI6fhM69eKrhKeJ5hWX7SeOO/4qrOucPykSm86CZNO8A
         s/cwNwQwBvzidl9CI6IhyG44/yBrU+4+zrHEI7pMeo8jauUmWDcdGSe8oPOqm60mngsh
         IjaJvwxItnBtcLy7FjbinFyXmDxPa0hsdOOMGBuGw1NXGBey3CvcBlOWREWvIDBlKFM4
         pmc3VmBp9GHVODEGzIibmrVO83GA4HTOczijkd1We60WzCZSB4ufS30e9uZ9elP2uPdy
         F/11X6sogex+WjgabQT3H+1L767Pk8EzB003F5exqaqQIOCLNWzjBfMZy/XjkwdJ9sfd
         KIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qIYlGm4yxuJWPGZE9jBq7SClwzl5SsZAe4AqIxxnJxw=;
        b=aVJp7gopYw+ZNNTGorRr3ekHBFNBKMyrvU+7uQK8bJRQUf2HpHdVf1RMh5QfqfW16y
         Jyd1oJwxBCuPhBtjF4STnoxqva4/TxZdyFRbTAJIyjhF2+Oe0QtblqFotd7JSm6zqr0f
         41RW/S/gzYoFk7M2+aH49r2zpZgfoFrWutXCq5OwwFnB7YYyXejxPOddzZd1Va852CYN
         GtTSFMh7UvEy9sUHx8JZn/79pTCAx2QZuDaNk2CjyoOvI9A4UEomYMVGbLgOL4l4KFvg
         k/RVQzp68ftnBZ+yFx1wJa/7wW6kjjYxhn5GEkESV8/EX6c1bEP07F7su5lezaJ8ddJE
         VsNg==
X-Gm-Message-State: ANhLgQ24HHYduFIMo4IsJpt4/fUFopeIKWL+C+xAkWPojB4YWGYdHFJT
        UOoqhwERVyRrjx3PiXddghY=
X-Google-Smtp-Source: ADFU+vvvi9/IwQKAHenUTXb90ToqvygF+HzJRijet4tByzTJotX9aoip3MjS9Alg2JwZYozZzCUysA==
X-Received: by 2002:a17:90a:9a90:: with SMTP id e16mr19401817pjp.164.1584269715129;
        Sun, 15 Mar 2020 03:55:15 -0700 (PDT)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id j17sm18311949pfr.176.2020.03.15.03.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Mar 2020 03:55:14 -0700 (PDT)
Date:   Sun, 15 Mar 2020 16:25:07 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] USB: chipidea: Use the correct style for SPDX License
 Identifier
Message-ID: <20200315105503.GA4440@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header files related to ChipIdea Highspeed Dual Role Controller.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/usb/chipidea/bits.h        | 2 +-
 drivers/usb/chipidea/ci.h          | 2 +-
 drivers/usb/chipidea/ci_hdrc_imx.h | 2 +-
 drivers/usb/chipidea/otg.h         | 2 +-
 drivers/usb/chipidea/otg_fsm.h     | 2 +-
 drivers/usb/chipidea/udc.h         | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/chipidea/bits.h b/drivers/usb/chipidea/bits.h
index 98da99510be7..b1540ce93264 100644
--- a/drivers/usb/chipidea/bits.h
+++ b/drivers/usb/chipidea/bits.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * bits.h - register bits of the ChipIdea USB IP core
  *
diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index d49d5e1235d0..644ecaef17ee 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * ci.h - common structures, functions, and macros of the ChipIdea driver
  *
diff --git a/drivers/usb/chipidea/ci_hdrc_imx.h b/drivers/usb/chipidea/ci_hdrc_imx.h
index de2aac9a2868..c2051aeba13f 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.h
+++ b/drivers/usb/chipidea/ci_hdrc_imx.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright 2012 Freescale Semiconductor, Inc.
  */
diff --git a/drivers/usb/chipidea/otg.h b/drivers/usb/chipidea/otg.h
index 4f8b8179ec96..5e7a6e571dd2 100644
--- a/drivers/usb/chipidea/otg.h
+++ b/drivers/usb/chipidea/otg.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2013-2014 Freescale Semiconductor, Inc.
  *
diff --git a/drivers/usb/chipidea/otg_fsm.h b/drivers/usb/chipidea/otg_fsm.h
index 2b49d29bf2fb..1f5c5ae0e71e 100644
--- a/drivers/usb/chipidea/otg_fsm.h
+++ b/drivers/usb/chipidea/otg_fsm.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2014 Freescale Semiconductor, Inc.
  *
diff --git a/drivers/usb/chipidea/udc.h b/drivers/usb/chipidea/udc.h
index e023735d94b7..ebb11b625bb8 100644
--- a/drivers/usb/chipidea/udc.h
+++ b/drivers/usb/chipidea/udc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * udc.h - ChipIdea UDC structures
  *
-- 
2.17.1

