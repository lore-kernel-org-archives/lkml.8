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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF5AC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 09:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AEA120716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 09:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uyFI8ztN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgC1Jsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 05:48:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39589 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgC1Jsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 05:48:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id b22so5916873pgb.6;
        Sat, 28 Mar 2020 02:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tOjJX6xRnffKPc3AqETnscSj7oMhWI6lRH93RVQJDlQ=;
        b=uyFI8ztNJVNwUQlPh4HA75vk9sdQBxm5rfANauCha0igSDcmjfOSNUz70Y5rqAGBKP
         OClqS+G272PsaxBWysW0wn6HNyBuADJqOgNRsxrwcyXznMNhfzfr1BUESoOduri6yJ0U
         EPuqcGSeG3a81GcVIT8/u/CC1n2lhhTuVmdJqyAfodp/TdoAnZIm9XZxaO+XUjqBOosb
         TO9G4yGtlNtCFweOiSG0UktrHDzLnMoCf2SwEia6yeU93b1i7EBoJrl29Rord2OEeA+J
         CGT1XkDBGeLl7zXh6aiqxu3jjGEngCB6Inxi3mLPbj2/YPCSUw99OdPL7uH09jf66Bl+
         ocoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tOjJX6xRnffKPc3AqETnscSj7oMhWI6lRH93RVQJDlQ=;
        b=hSjzOYO5S1hntAFuSBVWCb9PAkFjmGuT//k30/JzEGyJS1cxpsJnzLTQxRSBSzwn9/
         ScZ8/o+LPjI6qtzF+7gn7wq9uqaHyVAGWnPLDYgZYKcv8ckOfFIVMM6CoiuItlIDKnI7
         Z679I6CfKPIVa0eRfr6qWwGRX6gl7p37yEtnQB9z6zP0+JhtDXdgNkZw8PcKdaKSYEif
         +pBiKUszEkQCm7gI7qYujQ5I27KMdo6xe4TZ4aa68pIP4WEU91y/ivOUpC/t8Pj8Z9nx
         ADzLsm0tFS+roVzLIEwr7/9Xe/twhKOK4ONAG6bOzsleOyAWGoa6YXNtIgFA+wEoq33E
         uKPQ==
X-Gm-Message-State: AGi0Pub2Eka3Yfg8B/VFhgj1tOC47xsOxP68GNoIYlUVC7pXJlWrTdwb
        bWz3AyyvuVhBYpb488PebM8=
X-Google-Smtp-Source: APiQypJllSfWfd4/UNQBwV9uQZrsenXv5PSlErXgpKWR1rpectgzO4p5/brh2hpH5eAzA7o39/br0Q==
X-Received: by 2002:aa7:838e:: with SMTP id u14mr239769pfm.212.1585388918591;
        Sat, 28 Mar 2020 02:48:38 -0700 (PDT)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id i4sm5418198pjg.4.2020.03.28.02.48.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Mar 2020 02:48:38 -0700 (PDT)
Date:   Sat, 28 Mar 2020 15:18:32 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: dwc2: Use the correct style for SPDX License Identifier
Message-ID: <20200328094828.GA5016@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header files related to DesignWare USB2 DRD Core Support.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/usb/dwc2/core.h  | 2 +-
 drivers/usb/dwc2/debug.h | 2 +-
 drivers/usb/dwc2/hcd.h   | 2 +-
 drivers/usb/dwc2/hw.h    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 99b0bdfe0012..668d1ad646a4 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /*
  * core.h - DesignWare HS OTG Controller common declarations
  *
diff --git a/drivers/usb/dwc2/debug.h b/drivers/usb/dwc2/debug.h
index a8c565b6bc34..47252c56d410 100644
--- a/drivers/usb/dwc2/debug.h
+++ b/drivers/usb/dwc2/debug.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * debug.h - Designware USB2 DRD controller debug header
  *
diff --git a/drivers/usb/dwc2/hcd.h b/drivers/usb/dwc2/hcd.h
index 1224fa9df604..ea02ee63ac6d 100644
--- a/drivers/usb/dwc2/hcd.h
+++ b/drivers/usb/dwc2/hcd.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /*
  * hcd.h - DesignWare HS OTG Controller host-mode declarations
  *
diff --git a/drivers/usb/dwc2/hw.h b/drivers/usb/dwc2/hw.h
index c4027bbcedec..864b76a0b954 100644
--- a/drivers/usb/dwc2/hw.h
+++ b/drivers/usb/dwc2/hw.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /*
  * hw.h - DesignWare HS OTG Controller hardware definitions
  *
-- 
2.17.1

