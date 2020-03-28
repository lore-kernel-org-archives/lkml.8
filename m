Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420FBC2D0EC
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 10:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1363320717
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 10:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGqqX0Mr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgC1KEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 06:04:55 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55572 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgC1KEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 06:04:55 -0400
Received: by mail-pj1-f65.google.com with SMTP id mj6so4989267pjb.5;
        Sat, 28 Mar 2020 03:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=DOkxEDthBHCDOEOjMnAVrLIVxCq7kzad1xgt3/6TS2A=;
        b=QGqqX0MrlHBINE0veR+ZtDajkscgJYRIegZPekFJp+0TyNZA/ZJ9IxZpTGwLsyBzBp
         BsnbrfdCiSc6ddrXYUlgsaw+7QZs6vIO3dxT8sotxIdTwmDfobzNfLTFIrez2ODlNjqm
         S3pm5G3UEo7It6rMVSm32DKlTBfmy/FXA26Vb6dtxKO6kjkORcQ1yMXOW3DK6U9/VABl
         oY97/YkW9BqypPdyATV0RttjSgekIWCcz9Rqg8GMiBPLzH5djJHmizBfD2mNwFXhRBWS
         duoh/X6KPmjMP6j2kVpr/KXuFcfchdbIWS4jfO/BigLWSOhDkUJz+69mrB/ghtBIE9r6
         fp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DOkxEDthBHCDOEOjMnAVrLIVxCq7kzad1xgt3/6TS2A=;
        b=Cdjf7T9fdFjC88asbYLZZd+memBzMMI0SI46UqunS0JBzknb5taGbwrPnSpJ1Ys5bV
         Zh2MddrWpEm3pESIVd1VwEoJa4IwahmvTsEI9W1TxgZnZrInDTbQNyJRVMSTKYvtpyUD
         HusHtcSjfMFhCGtbcUoRbdI4AT3yAMVWkRfH6N5QY6id8A7XUNv6eGLNvDVSY4dPNYB2
         tm8YhVfPbuAh2n100ej37daygqKe2jq8hK1n8V/r9qZSWyCNHvz8b10FcmdH4rXvVsXq
         dns5+7LG1YBOqRbxXyfvSgtWLpTGiiuWwQcMjD02A7lf/x4AM44PybzFyDLCrsfMEVAT
         h4cg==
X-Gm-Message-State: ANhLgQ3bttp/qFAKdHvoMFgQHa/PQc630sq9M7JIlEM0z2eMYGfI7au2
        dYn71RRfq1WSeG5NKtEjKEA=
X-Google-Smtp-Source: ADFU+vvTN+Pr/HWcB7D9kgsa3Zyxk5dOYHnuQVU6Jzesd6nH05UOI+LSvx7AW2KkA9kFGBC8U/ZbyA==
X-Received: by 2002:a17:90a:d983:: with SMTP id d3mr4175094pjv.158.1585389893714;
        Sat, 28 Mar 2020 03:04:53 -0700 (PDT)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id f15sm5918796pfq.100.2020.03.28.03.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Mar 2020 03:04:53 -0700 (PDT)
Date:   Sat, 28 Mar 2020 15:34:46 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: dwc3: Use the correct style for SPDX License Identifier
Message-ID: <20200328100442.GA5517@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header files related to DesignWare USB3 DRD Core Support.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/usb/dwc3/core.h   | 2 +-
 drivers/usb/dwc3/debug.h  | 2 +-
 drivers/usb/dwc3/gadget.h | 2 +-
 drivers/usb/dwc3/io.h     | 2 +-
 drivers/usb/dwc3/trace.h  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 6846eb0cba13..bfc5c780a963 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * core.h - DesignWare USB3 DRD Core Header
  *
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 4a13ceaf4093..0f95656c9622 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /**
  * debug.h - DesignWare USB3 DRD Controller Debug Header
  *
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index fbc7d8013f0b..24dca3872022 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * gadget.h - DesignWare USB3 DRD Gadget Header
  *
diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
index 70acdf94a0bf..9bbe5d4bf076 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /**
  * io.h - DesignWare USB3 DRD IO Header
  *
diff --git a/drivers/usb/dwc3/trace.h b/drivers/usb/dwc3/trace.h
index 3054b89512ff..4c4fc6c41d9b 100644
--- a/drivers/usb/dwc3/trace.h
+++ b/drivers/usb/dwc3/trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /**
  * trace.h - DesignWare USB3 DRD Controller Trace Support
  *
-- 
2.17.1

