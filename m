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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A317C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 10:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6BA205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 10:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PT6LwBXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgCOKkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 06:40:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37022 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbgCOKke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 06:40:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id 3so283188pff.4;
        Sun, 15 Mar 2020 03:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=T7dEPiegWbPiC/e8VCxdOs7BMWZRGg4BajPSzkAJ79A=;
        b=PT6LwBXzBxTzYMzucRCwoGeBZk33sN+EHTmC1uk4Hg821fnJii6OIeoshvDJAQNknr
         95MrZdMIOnDEa1coNZH4+qIP10Xq+XkzMyFA8eMVRmgn42j72io+RHZVSv7B2dTO59QL
         E3OYpSlnZzUGkFnPsPoZmopW0fdOuTirZwIJZZOH4kha+DCYDh2KF58Ki7ussBouw+Lf
         pLWd3T+g39ihnN8xakwd44ipPUsZAqk+84FEdPjFAbDYS0JZWdVQ9/nc4ndkgdxr0JsZ
         LStBnmZ/+tpulQJH718WSJXDSgUVSs4k1g2BxwxFNBg8zq6OA2Df4dELbrHOXSpvECFI
         S8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=T7dEPiegWbPiC/e8VCxdOs7BMWZRGg4BajPSzkAJ79A=;
        b=ZPhkXJs3SRaPA9PpbXbnj2C4zPkLHJ/HvQWp1fo1nM7I7Bot4m7xwxPE6H4t04e7ge
         DQrc8yQ9/2faU1dKfkfTClRQQ3Oh3LbEh5kF+jIY/kfhzfp7YgByffmNwXDkj3hnXFpR
         LWyS2yEWIQ00mzejEVBSm5v7jFAxPhbBcg+HRtWF95cuL3mMW9lIvvjSTbpDqcPjRrp9
         ppsTmmvuCfB2V4RqJ04CJfb+bu4EEi0I+Jz7DXg+8x9bJh0mni7TIpSsmERzORpnhex6
         xo7/Umk9qbNjOGk8O/JyKiIKLVJmrI9BNxzC6N7DKwQIqmN7dOLp0Ms0ZsOwptcr1s1w
         JUSA==
X-Gm-Message-State: ANhLgQ0j2zygEpkPilZw8TigNn/8MfQuOfpqGFdGfneQZBQWlAheufZn
        LLkRbLPqks9+votWgldajJk=
X-Google-Smtp-Source: ADFU+vvVkfsWWx9bDF7jJ+1hCc1UmO7HGa/pA+p2CV8UhLred92GOVKH7FUAZxxXGAmYGBwOzomFnQ==
X-Received: by 2002:a05:6a00:41:: with SMTP id i1mr21751857pfk.275.1584268833632;
        Sun, 15 Mar 2020 03:40:33 -0700 (PDT)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id c15sm17022690pja.30.2020.03.15.03.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Mar 2020 03:40:33 -0700 (PDT)
Date:   Sun, 15 Mar 2020 16:10:26 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Peter Korsgaard <jacmet@sunsite.dk>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: c67x00: Use the correct style for SPDX License
 Identifier
Message-ID: <20200315104022.GA3998@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header files related to Cypress C67X00 USB Controller.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/usb/c67x00/c67x00-hcd.h | 2 +-
 drivers/usb/c67x00/c67x00.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/c67x00/c67x00-hcd.h b/drivers/usb/c67x00/c67x00-hcd.h
index 3b181d4c7a03..6b6b04a3fe0f 100644
--- a/drivers/usb/c67x00/c67x00-hcd.h
+++ b/drivers/usb/c67x00/c67x00-hcd.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * c67x00-hcd.h: Cypress C67X00 USB HCD
  *
diff --git a/drivers/usb/c67x00/c67x00.h b/drivers/usb/c67x00/c67x00.h
index 7ce10928b037..a4456d0fffa9 100644
--- a/drivers/usb/c67x00/c67x00.h
+++ b/drivers/usb/c67x00/c67x00.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * c67x00.h: Cypress C67X00 USB register and field definitions
  *
-- 
2.17.1

