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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA88C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24E73214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="subicgQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgDSN6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 09:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgDSN6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 09:58:13 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E941BC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 06:58:12 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a7so3041975pju.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 06:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lSaqW9KjQVYKEsedDl7cS0NR1ij1Mdkbrdhn2d6I2Lk=;
        b=subicgQ/QUi5UL0nz0RMLIUy+DwHFxXl4+qqY7f3Br6tCeUH+sLA0OtFCRH+4/5nNI
         pJpbglwW1mDz5GlUiDaEfUoS3ZGnZUd57OAf1OCHh3EKHDFwzVuPqtQ/svDb4dCq/p8P
         U/yWEud3ORN3+hx+I7fEnRs65PHibSdZQTgip7zQvXdtwaRjxqA50XYri+n9xJvlHZfx
         5BbBls2IkPkKQIYnvmQfB+PJ7n8L2kOfTq+u0g47vVFnbMHDB6JkEgrgqNL06Oas3XVK
         FpHWpPRjYZGWdfA3wG1A8VBNl/6ALW6FioT50fre3MVIYCMeHDM70VF9j2tLgePGGJjf
         ezbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lSaqW9KjQVYKEsedDl7cS0NR1ij1Mdkbrdhn2d6I2Lk=;
        b=Xbiu2xK0QUCeWTVR74SKR/my9D6gbDwAl6+kiBEfe9Rze7CXhxta5cA8T2Ko9up7fT
         Ox1nHl4MTFwTJ5mtvQCXFsDM8NDmfbY4oeF5iBObK5kzkYn5iT04/AvFQ5Px/NodvHY8
         o+V2W9R72wDJx7uVYiWtlarzFnvvQTwkuET3nbSWiEjZCAYQWQVAacH1FkA2FMopwZk6
         8KmZe3tXDB8Kpdm/8L1M6wIc+UTqcbiExd8Ws3zh00mtgdQ3C7XJ/VWT+oJT4RGa+AFt
         OU6YKfqY+R4/v4nAo8o8aQik7kwUfZghl9bGz9uSGKQL2QZm1Cq0HLbJGJnCUZl5kDcw
         JJOA==
X-Gm-Message-State: AGi0Pub4DWgKJ1ptlfx2xjwfo1XluOZHRL3zAcLIPHUFB7DKJFG32up3
        1ZYgJuhm4PwdLektOeAF0KlMIV8X
X-Google-Smtp-Source: APiQypIq/mcSI+krcIZLLOoEAljwMo3bELZXJm8xiHSD6XIuZxt4eZ5DfnEJq4S9d/N9d4k510mblg==
X-Received: by 2002:a17:902:8609:: with SMTP id f9mr11925544plo.203.1587304692236;
        Sun, 19 Apr 2020 06:58:12 -0700 (PDT)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id n9sm11450775pjt.29.2020.04.19.06.58.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Apr 2020 06:58:11 -0700 (PDT)
Date:   Sun, 19 Apr 2020 19:28:07 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: visorbus: Use the correct style for SPDX License
 Identifier
Message-ID: <20200419135803.GA7814@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header files related to Unisys visorbus configuration.
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

