Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFD9C352BE
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 06:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 845832076A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 06:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAHAuRv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgDSGum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 02:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSGum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 02:50:42 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A76C061A0C;
        Sat, 18 Apr 2020 23:50:42 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a22so3018701pjk.5;
        Sat, 18 Apr 2020 23:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=faCl+8ZdE3Gy4jCSPjdomHs/AyJheMf/bvgsQt1IIJs=;
        b=RAHAuRv6/BuQnAO2lg2sC/7E39P9HHXhLczNqLTyBWu3c5DeblViwTr7+PESUbW192
         mUuvzBRSlDLoFjQPRgfvKgqVn+z3l1p+iUi60OMBVVyImabQG/5QsiD+u3pffnY9YsSN
         vXIL379sJDRUDrjkYu6cagCunIrU1HK5fEap112EAGILsJ3GIVQy7nPiUBRNkXExgd3U
         Kn3J2Tj6T8Dqr3VE2Vs/aQ2loOkGpD9K9yqBb2x6X5tLsz9N+AWR19HuONzOYqyb8I7P
         AVBaRo+vNxC1Rv8wIbZ3I9VvhzYeoNPGIAtPQGbWc5OUwES/a5JVrKZq+7N33Am/wggX
         VTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=faCl+8ZdE3Gy4jCSPjdomHs/AyJheMf/bvgsQt1IIJs=;
        b=Z9AcFFezA8U7JMRa+E8WUFj672V2w3GjQIPlAUPoBeL9fgfWlYYSK1aziAXdJfCht3
         mkEKEaEI63MEICoqFgo8vF32qiHH+pBHbvwiVdLLt1oKPmJ570bzhAGhnGVGG7MyIAJ0
         7bxzsDV41B1O17yIh8ecJ0wuIjviZEJrhaKtzrX5XesfPveskVqyZvkIpMGsbBN8fcnZ
         Zi+fjK98M/j2KW5/j5kb8kKHjfWUXbJcX5sHyoQnK3P3B4GoaLAcsve+j9UfJKa/dHp6
         8IuVvcv5xKP0/j7KHJbX+mRp04RTjvFk7K9V87oJRwbCyOSjBrGSLAE88Xa4Chmicxj5
         U25g==
X-Gm-Message-State: AGi0PuYGAkEB0/iALstgBq/oTskst2HeckwqvMyWTo28CbuxzdxsVIvT
        XFzWFGvUV1BzDjBue/QCPzmPAzbg9HU=
X-Google-Smtp-Source: APiQypKIbqSbuU86TBmODhvzaCr46wfo1a/l91UDmnufP0sw6M7+ogneuwSR5aJ9EP7R0hdgk2GTww==
X-Received: by 2002:a17:90a:cb0b:: with SMTP id z11mr11610125pjt.62.1587279041802;
        Sat, 18 Apr 2020 23:50:41 -0700 (PDT)
Received: from CentOS76.localdomain.localdomain ([27.59.158.48])
        by smtp.gmail.com with ESMTPSA id l15sm22573953pgk.59.2020.04.18.23.50.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Apr 2020 23:50:41 -0700 (PDT)
From:   jagdsh.linux@gmail.com
To:     shuah@kernel.org, akpm@linux-foundation.org, bgeffon@google.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Subject: [PATCH] tools/testing/selftests/vm: Remove duplicate headers
Date:   Sun, 19 Apr 2020 12:19:44 +0530
Message-Id: <1587278984-18847-1-git-send-email-jagdsh.linux@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Code cleanup: Remove duplicate headers which are included twice.

Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
---
 tools/testing/selftests/vm/mremap_dontunmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/vm/mremap_dontunmap.c b/tools/testing/selftests/vm/mremap_dontunmap.c
index ee06cb0..3a7b5ef 100644
--- a/tools/testing/selftests/vm/mremap_dontunmap.c
+++ b/tools/testing/selftests/vm/mremap_dontunmap.c
@@ -11,7 +11,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <stdlib.h>
 #include <unistd.h>
 
 #include "../kselftest.h"
-- 
1.8.3.1

