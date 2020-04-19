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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680A7C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 12:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4224421841
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 12:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oUEAkQZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgDSMgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 08:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgDSMgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 08:36:10 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ED8C061A0C;
        Sun, 19 Apr 2020 05:36:10 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id ay1so2883538plb.0;
        Sun, 19 Apr 2020 05:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=6Z8Bx3p5Q6hFwu69ifPJp1LQnSz76OWcYhpeH5bINug=;
        b=oUEAkQZ3c+kUp664ajW7tua9y22QWM1UQwoNemwQkNn7O4ftv+9ILTmYBfumkjL6C7
         DzlCKEl0kdlH1fhr1lQo3NJ4ElSghMwCIfEWxCoEy1kEiOzCEbX8PFMEY8x3DTv6Px0g
         r/oDNSkw+QdUJSpLBpZgtEpJm9QCE7Xooq9B1rsxla1/1z5UGU+Ma4JLdLpwkw28wfiw
         k7erM+ZVCrOtkojO0fYwzEau6MxxlHo4Zxu8Pkq7nNOalN0M2VQLFtGzkUlnSM/DQMLI
         gaRKd5hGR+m2eyZjqshJVBrIcnxwjFd4MVbMBYdwGQyifViHfCbwba2j4y48WwS9vRKJ
         hyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6Z8Bx3p5Q6hFwu69ifPJp1LQnSz76OWcYhpeH5bINug=;
        b=C4XBeqSYzYa0KkOgsN3E4LghosfGBuwvK4UHvksep8hf5Jg98mpBj7lAbxNEUq2l5m
         5btQ/y0+pF8qm6bQ8/PnsJNXgvKSbfdogKjiCgw0qIjBzO/fZCuunbrEJWYe3xA+FlX6
         zOzYr9HggBkltihZDStjXnjDIEV8hzwHUW4Iux7UnYrmX+hSzAunUBVLmLHZshZNKS8Z
         R8ZlE6zbRHaPnQqHcCgzUm6z7tqVJcfYrhrHcT0CRgRqIPC/jiI912Hi9Kjuvwtr21Ue
         AvOCC9Wiw0Xk+4aduIkRIXU4SmaDDoVxOPQVWJRfIJuV/SGcjDma4GKG5UvUDEJKdYDO
         pB2A==
X-Gm-Message-State: AGi0PuaB3zMXkWBX64WwCIK+dYGncu2TDiBt5PHqABKVBeMjmZJn+Yms
        FRzm/M8zrpknIHFlHenFfu0=
X-Google-Smtp-Source: APiQypJ+VkSTyYRWLg2So+2TQWn/W1FltMq7L6xpsC80J/PBszDEt98ugqvJ+Ht1z6Olk5+HTjC9zA==
X-Received: by 2002:a17:90a:2347:: with SMTP id f65mr14839339pje.165.1587299770106;
        Sun, 19 Apr 2020 05:36:10 -0700 (PDT)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id 132sm24797478pfc.183.2020.04.19.05.36.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Apr 2020 05:36:09 -0700 (PDT)
Date:   Sun, 19 Apr 2020 18:06:03 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: phy: Use the correct style for SPDX License Identifier
Message-ID: <20200419123559.GA4505@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header files related to Physical Layer USB driver configuration.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/usb/phy/phy-fsl-usb.h | 2 +-
 drivers/usb/phy/phy-mv-usb.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/phy/phy-fsl-usb.h b/drivers/usb/phy/phy-fsl-usb.h
index 43d410f6641b..fbcc28ad9964 100644
--- a/drivers/usb/phy/phy-fsl-usb.h
+++ b/drivers/usb/phy/phy-fsl-usb.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /* Copyright (C) 2007,2008 Freescale Semiconductor, Inc. */
 
 #include <linux/usb/otg-fsm.h>
diff --git a/drivers/usb/phy/phy-mv-usb.h b/drivers/usb/phy/phy-mv-usb.h
index 96701a1229ad..5d5c0abb0c3a 100644
--- a/drivers/usb/phy/phy-mv-usb.h
+++ b/drivers/usb/phy/phy-mv-usb.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2011 Marvell International Ltd. All rights reserved.
  */
-- 
2.17.1

