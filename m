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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21826C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 14:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC71321744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 14:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdBL6A6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDSOA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 10:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgDSOA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 10:00:28 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81236C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 07:00:28 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y22so2928648pll.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 07:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zul1UlU8/LOKKj0PI9LG0ti1QsdQkiWiKOknlEboVJY=;
        b=CdBL6A6Xp5iwifCOKP8Ree7zSIRJZnxjJU5iG2mEwhlKjnrV7odri3Mk5xYBeEYa4q
         EdqHad9l1TBJaVsEqju24/bcY9/ry/BiXL0L+s7APxAApUJ4Uj2OGGtZPiMz5uPkjM4m
         wUpA6f26glLIE4CqR+9kEzz5oPCBwDA+X1ZDPY+NDkK7EFY6dBmKEXCs+gfdZea4Gqj6
         OjhwBv3JphXmduzt+yqYcTQT/KTpvGVl3HOhqQiiUxcJFNpvg3hrOuFS/WRwzRJNogMz
         qOOKHt5nRAdaSAKb6125DeKejoKSYdMoZY+rE5SScsg2KhpvgK+FgweNp1g1rb0rcexX
         ARGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zul1UlU8/LOKKj0PI9LG0ti1QsdQkiWiKOknlEboVJY=;
        b=BhqQkDAKK9EaCtM1MjHRwqYbq4/kWyAmNcLEuvlAnXNxT7217PPPI3wkYTLcjc11pj
         QOsxnRSqH2QCZTfDVNYFvywDiSmJ1W6COh9vBIXXyTMGt7EgjGx4BuPuUCvd0gUaEf9+
         JSyFhBLXZAFhrBvFpRxvvL5bNgutqw7x/+RKrI6h7WZWzP0FPfueWgpnjRovNCMVqYjP
         iSlr42xoskJMNJR1e0m2ZyPtcZ2ml/zjS4jLwZZx+puqoYdTYLlGGQO+1Q0sNz136J3X
         Q4axu1i6+BQD1+TMCfQMLkhlbyV0E6YasWA5rmJf7w5/tWMigv4N44NyBuEcOk2nyeVP
         OcPg==
X-Gm-Message-State: AGi0PuY08ORXUBAuI1dF+qeYpa/l/yctImRGgQ004pqeHy0EbEKHogg7
        RNpx6R1oZGCnm04EAuKfUxSFgdkgw9Y=
X-Google-Smtp-Source: APiQypKifngc3bmfCia2G2OpWAAQNWQIuWJArWvuLcf1MFOegsUZ895fuWpFubZmkvXqW4JTUcMpkw==
X-Received: by 2002:a17:90a:2344:: with SMTP id f62mr15900767pje.152.1587304827968;
        Sun, 19 Apr 2020 07:00:27 -0700 (PDT)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id w75sm17041105pfc.156.2020.04.19.07.00.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Apr 2020 07:00:27 -0700 (PDT)
Date:   Sun, 19 Apr 2020 19:30:21 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     David Kershner <david.kershner@unisys.com>,
        sparmaintainer@unisys.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: visorbus: Use the correct style for SPDX License
 Identifier
Message-ID: <20200419140017.GA7875@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header file related to Unisys visorbus configuration.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/visorbus/controlvmchannel.h | 2 +-
 drivers/visorbus/vbuschannel.h      | 2 +-
 drivers/visorbus/visorbus_private.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/visorbus/controlvmchannel.h b/drivers/visorbus/controlvmchannel.h
index 8c57562a070a..c87213554427 100644
--- a/drivers/visorbus/controlvmchannel.h
+++ b/drivers/visorbus/controlvmchannel.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2010 - 2015 UNISYS CORPORATION
  * All rights reserved.
diff --git a/drivers/visorbus/vbuschannel.h b/drivers/visorbus/vbuschannel.h
index b1dce26166bf..4aaf6564eb9f 100644
--- a/drivers/visorbus/vbuschannel.h
+++ b/drivers/visorbus/vbuschannel.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2010 - 2015 UNISYS CORPORATION
  * All rights reserved.
diff --git a/drivers/visorbus/visorbus_private.h b/drivers/visorbus/visorbus_private.h
index 366380b7f8d9..6956de605827 100644
--- a/drivers/visorbus/visorbus_private.h
+++ b/drivers/visorbus/visorbus_private.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2010 - 2015 UNISYS CORPORATION
  * All rights reserved.
-- 
2.17.1

