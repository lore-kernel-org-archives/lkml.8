Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89EFC35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 08:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD22821775
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 08:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fU456ijM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgBHIgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 03:36:33 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40178 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgBHIgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 03:36:33 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so730597plp.7
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 00:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0drD/VYgyxbEPwlFZ/4hraIRVmOTV1BqlQFDN4+1nYI=;
        b=fU456ijMc4tAo0eogyAfCt0BxsHuaT4ZN7yyucvK9CUndZqjyu6l5iioNa6lQfZ2G2
         AhVAwXUkR3jDKMSHMJc9+rBYNUc1zsvrxXwCeCqH2/a9yfgds5hHFonuxkZNJywp7+wt
         Z51D1jK9N+tVM3l/bK2O/p/MwAffL7hJ471CbXzOc1Up+GVOhZLxmiQn36NtXNVBFQTz
         yKyhV305cqY7SH/az2MjCu9Pqtbqyc5/MMui6aziyw5in4p5+UnqpkyffR+XgYmWmfn1
         dYx6V86I8AMyTq3Z02CVXp0Ykz8WVr7gdDlMkTZVU/2mfl+nUn+23bwu9UpuGiPXdASX
         sU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0drD/VYgyxbEPwlFZ/4hraIRVmOTV1BqlQFDN4+1nYI=;
        b=IeE5PYw3MAeqQKBNKBrjNl4LAC2VCchyotML5t9NnjfNl1JhKeyiakX9cLKO3wOC5E
         5QLAws2c+9J7jVpJ4s8Z62Hcb3tRggWxrYwZp4vjEH5DHknEBPNiAhhzjeYRoy73d/lN
         2zESRnWmMY1L/U+InHpsUe3ruTDox1XhT4QcQHkcacVkNK+wGDfHOkF0AiTc4w78zSER
         +zQ18HP9zNIIW0d7a9rzOTo2wUcUfNIyKNOybLKXb+pG9NeWxRcQn1zGBeB1Nfm2wJhK
         cNj7MtDWEDPGrYA5tSIWL1HhRGlnwlXLib4+kMgJ0RHQreaLVqoqRaS7Mzm60/V/wr/u
         lrSw==
X-Gm-Message-State: APjAAAV7dWjH5vfkkh6AUOJQ7bTzOs+Y07s8uuFEe77nwTmqTzpf8Goe
        KBmBG99wy8Qd1WSfXwjdg08=
X-Google-Smtp-Source: APXvYqzD9cf+gdedofOd466S6KUlWEFLkOQi4jjdzt017+C5NMBY12oqrSyDxOcz2nKTMASov8IPpw==
X-Received: by 2002:a17:90a:7d07:: with SMTP id g7mr9197302pjl.17.1581150991504;
        Sat, 08 Feb 2020 00:36:31 -0800 (PST)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id q29sm5503450pgc.15.2020.02.08.00.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Feb 2020 00:36:31 -0800 (PST)
Date:   Sat, 8 Feb 2020 14:06:25 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: Use the correct style for SPDX License
 Identifier
Message-ID: <20200208083621.GA3797@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header files related to pi433 radio module drivers.
It assigns explicit block comment to the SPDX License Identifier.

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/pi433/pi433_if.h       | 4 ++--
 drivers/staging/pi433/rf69.h           | 4 ++--
 drivers/staging/pi433/rf69_enum.h      | 4 ++--
 drivers/staging/pi433/rf69_registers.h | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
index 9feb95c431cb..16c5b7fba249 100644
--- a/drivers/staging/pi433/pi433_if.h
+++ b/drivers/staging/pi433/pi433_if.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * include/linux/TODO
  *
  * userspace interface for pi433 radio module
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index d43a8d87d5d3..b648ba5fff89 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * hardware abstraction/register access for HopeRf rf69 radio module
  *
  * Copyright (C) 2016 Wolf-Entwicklungen
diff --git a/drivers/staging/pi433/rf69_enum.h b/drivers/staging/pi433/rf69_enum.h
index 3ee1952245c2..fbf56fcf5fe8 100644
--- a/drivers/staging/pi433/rf69_enum.h
+++ b/drivers/staging/pi433/rf69_enum.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * enumerations for HopeRf rf69 radio module
  *
  * Copyright (C) 2016 Wolf-Entwicklungen
diff --git a/drivers/staging/pi433/rf69_registers.h b/drivers/staging/pi433/rf69_registers.h
index be5497cdace0..a170c66c3d5b 100644
--- a/drivers/staging/pi433/rf69_registers.h
+++ b/drivers/staging/pi433/rf69_registers.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * register description for HopeRf rf69 radio module
  *
  * Copyright (C) 2016 Wolf-Entwicklungen
-- 
2.17.1

