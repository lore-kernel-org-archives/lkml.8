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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9FDC2BA1A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 10:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9229D206C3
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 10:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMhho21o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgDDKhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 06:37:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41081 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgDDKhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 06:37:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id m13so920371pgd.8;
        Sat, 04 Apr 2020 03:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9e3YjywRlT9unLTEqN08LmJN3s3Ftr6vaLOvEkkDfWs=;
        b=cMhho21ovWgHDV3FaLA06KOpuRyaeGEebizvDrE2bktmRABorboNdJKEDiixgudSw/
         g7YVkmLsY6y7kr59iq2fzfv6HLmd9i5a4cA0SG9hhi4FYwcaxYg1qL3NqpAtGYZ2ucal
         aoXxn7KC7W34kwAW3+TJczxk6zzMyxWrMyK6Kg1fcpgSh9gVzJo+MnKn6hhMfMjK/1VJ
         jmNCATOSRVHESlkVtMh1mBQuoYcDhwBFgJuOAQFwR0aLlMWcWIsbjie6KBrIhtbHKOPH
         HLnhQyypFy8QvlYatlftg9bLuUHNUglCprJse5gk0+CZVkoEUrQKQI9FYfU4ho+7uAsY
         JOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9e3YjywRlT9unLTEqN08LmJN3s3Ftr6vaLOvEkkDfWs=;
        b=l3NtXi9fc+RNnRGU4oolacFwZYFS3t11hGFyN9tH2E/yovc3hsyIFDmH4nMNi1kZes
         XQSfshovMinlyLqFPf8PGFy2vKT34w7HeSQDqtWkv6o5H9XbGIuj9ElcASdovL/54wbI
         32I1herTd72auSWliPualHtPji4hgfezLUxdSHxvuPh211oCY0YK34i6ax9zxd93uz4L
         u20nGo57uhIwGAIZX00qVZ5OnMAXpRlfROf/dbZf3ayls+KVLMFwo+pLLi+fQ3q3s6rW
         JaHKuqV0eHX3H5/dH20OInbxZjMzY4tvgA7aQCCZtk7q1wyHfMKX6dGzfPWbwYq4Gy36
         fl9w==
X-Gm-Message-State: AGi0Pub/LscjNuUfKOP9y4UP6Mja8I4JswFvbeYOJk0R3WiUKMeFo2xX
        SEuK8C5qtb93T/jnF3iR5AuXJ76mM20=
X-Google-Smtp-Source: APiQypIdV/cxtmiWWQdClIs7ou/+T/O54jGMKfa4HBQfw3T/QzNaY+mxHIEu+x9ivWzjNyyH4GTSOA==
X-Received: by 2002:a63:b954:: with SMTP id v20mr11630510pgo.381.1585996659225;
        Sat, 04 Apr 2020 03:37:39 -0700 (PDT)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id x4sm7382302pfi.202.2020.04.04.03.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Apr 2020 03:37:38 -0700 (PDT)
Date:   Sat, 4 Apr 2020 16:07:31 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: mtu3: Use the correct style for SPDX License Identifier
Message-ID: <20200404103728.GA6011@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header files related to MediaTek USB3 Dual Role controller.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/usb/mtu3/mtu3.h         | 2 +-
 drivers/usb/mtu3/mtu3_debug.h   | 2 +-
 drivers/usb/mtu3/mtu3_dr.h      | 2 +-
 drivers/usb/mtu3/mtu3_hw_regs.h | 2 +-
 drivers/usb/mtu3/mtu3_qmu.h     | 2 +-
 drivers/usb/mtu3/mtu3_trace.h   | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index 6087be236a35..d49db92ab26c 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * mtu3.h - MediaTek USB3 DRD header
  *
diff --git a/drivers/usb/mtu3/mtu3_debug.h b/drivers/usb/mtu3/mtu3_debug.h
index e96a69234d05..fb6b28277c9b 100644
--- a/drivers/usb/mtu3/mtu3_debug.h
+++ b/drivers/usb/mtu3/mtu3_debug.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * mtu3_debug.h - debug header
  *
diff --git a/drivers/usb/mtu3/mtu3_dr.h b/drivers/usb/mtu3/mtu3_dr.h
index 5e58c4dbd54a..760fe7d69c6b 100644
--- a/drivers/usb/mtu3/mtu3_dr.h
+++ b/drivers/usb/mtu3/mtu3_dr.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * mtu3_dr.h - dual role switch and host glue layer header
  *
diff --git a/drivers/usb/mtu3/mtu3_hw_regs.h b/drivers/usb/mtu3/mtu3_hw_regs.h
index 8382d066749e..bf34f784f84b 100644
--- a/drivers/usb/mtu3/mtu3_hw_regs.h
+++ b/drivers/usb/mtu3/mtu3_hw_regs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * mtu3_hw_regs.h - MediaTek USB3 DRD register and field definitions
  *
diff --git a/drivers/usb/mtu3/mtu3_qmu.h b/drivers/usb/mtu3/mtu3_qmu.h
index 9cfde201db63..66e1c0ab5a99 100644
--- a/drivers/usb/mtu3/mtu3_qmu.h
+++ b/drivers/usb/mtu3/mtu3_qmu.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * mtu3_qmu.h - Queue Management Unit driver header
  *
diff --git a/drivers/usb/mtu3/mtu3_trace.h b/drivers/usb/mtu3/mtu3_trace.h
index 050e30f0fbd4..1b897636daf2 100644
--- a/drivers/usb/mtu3/mtu3_trace.h
+++ b/drivers/usb/mtu3/mtu3_trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /**
  * mtu3_trace.h - trace support
  *
-- 
2.17.1

