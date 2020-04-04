Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B82FC2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 09:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4261206CC
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 09:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mn1jmfAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgDDJiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 05:38:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33964 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgDDJiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 05:38:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id v23so2003982pfm.1;
        Sat, 04 Apr 2020 02:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cvSVov1F2OmeWlZ3ncvqWPGiyrktJe8a01P2xFXgELc=;
        b=mn1jmfAop92gziaawu2+RJJDJml9QCQO/QgnVcMU7tGlZ+FIbr/FH/CnPa3uejrJSI
         ovPJL+oKXUvuuV93NP/p2genIvRwsN8toFhBZbwGMlNzDfhnBgrOYkQFzaGuzPPdxrTs
         PmvE3r4TrsnOGfNdPlxrfsLWdspSNgTsE4lEKrirNvfUv+/DF5FhkW4/+k4peEgbGk2Q
         skHqAAl81D1NxP47jIuS0RrEIPZSDgKj9Vv9bPZkkgme/kCpARh6Xv3o4+HyQlS3glqz
         B8t7dXgtPZUrETd0dt0xeH5IDyoaIdacjM3YqjjjLD6G/CLo6IbKKCJ2n8LWqWqj96Xc
         jwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cvSVov1F2OmeWlZ3ncvqWPGiyrktJe8a01P2xFXgELc=;
        b=CBdo7/cFpxbjpMLhlAWtQHCswNxPR8Qyedds3F2id/QaCqqmMq1AgwgttFErCaI663
         ow0h3Hq+Ox1FiksTT8QsmvWPwcXQ6iGau2APJJlbMBODhEeKgmJcJ1e7rJ3lyH1xJzNM
         lHZ4u/GBHhhSlbjDt6mZfO0A1X/clGzn5N+6NYa6FmTjUAHu4N0XqY8rpyfBlEPcM41S
         vQE4VUYlYSWFm9CPCRHp+ufZDEz+HcvnOwXC4Ye3h92zyrMR4eNUi4k+ePfWtFSx7n4o
         ZmqMs196P41RtNh1uVLXjSXKrsldYFiemifkk5WBQqg+Ng9CN+dZwtgkh3cth5FznVGd
         rgmg==
X-Gm-Message-State: AGi0PuY+dF1KCgmaVUGvWs9u0M/6s0AGJd3RaZ/8v+gLiQvQ3nI066Jm
        g+lFHK5ByWxKFIgAzpPwJ+n4SCkR5KU=
X-Google-Smtp-Source: APiQypLrwsSTRMW/lGnKAohduF6pwvTs8Ffvrviy7IBg1Syk0rrHAuO3qzhvCYwOetINPaGtJ1qP7w==
X-Received: by 2002:aa7:96b2:: with SMTP id g18mr12941027pfk.221.1585993096026;
        Sat, 04 Apr 2020 02:38:16 -0700 (PDT)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id g30sm6668801pgn.40.2020.04.04.02.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Apr 2020 02:38:15 -0700 (PDT)
Date:   Sat, 4 Apr 2020 15:08:08 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: isp1760: Use the correct style for SPDX License
 Identifier
Message-ID: <20200404093803.GA4983@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header files related to ISP1760 USB host controller.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/usb/isp1760/isp1760-core.h | 2 +-
 drivers/usb/isp1760/isp1760-regs.h | 2 +-
 drivers/usb/isp1760/isp1760-udc.h  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/isp1760/isp1760-core.h b/drivers/usb/isp1760/isp1760-core.h
index 97cb4d7a3e1c..d9a0a4cc467c 100644
--- a/drivers/usb/isp1760/isp1760-core.h
+++ b/drivers/usb/isp1760/isp1760-core.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Driver for the NXP ISP1760 chip
  *
diff --git a/drivers/usb/isp1760/isp1760-regs.h b/drivers/usb/isp1760/isp1760-regs.h
index 1f00c3850cf7..fedc4f5cded0 100644
--- a/drivers/usb/isp1760/isp1760-regs.h
+++ b/drivers/usb/isp1760/isp1760-regs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Driver for the NXP ISP1760 chip
  *
diff --git a/drivers/usb/isp1760/isp1760-udc.h b/drivers/usb/isp1760/isp1760-udc.h
index 2d0b88747701..d2df650d54e9 100644
--- a/drivers/usb/isp1760/isp1760-udc.h
+++ b/drivers/usb/isp1760/isp1760-udc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Driver for the NXP ISP1761 device controller
  *
-- 
2.17.1

