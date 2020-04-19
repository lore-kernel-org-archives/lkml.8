Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A773C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 06:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E07420753
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 06:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtLjrTi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgDSGO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 02:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgDSGO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 02:14:57 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58890C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 23:14:56 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r4so3409972pgg.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 23:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=h4Kymai0tHPy4v24RW3/SFQROwJdZQGu5SVwP1QVDBk=;
        b=jtLjrTi+k64qPZ5oc7RmnDFdZb3FRqqksFQzWwfC1GKWJmf3YUgPM0lIoX5nOTttKy
         NbV3mMLOQy02gV5nk+O8c6dQhogEvoN2fIJY6ndaKWdKWL6ZffGx6UD3iFnrPWMIRmND
         TCnPdQQ9FMbbQgMh7dTtCy62dtiWt2gOLYo1BjklxeK1ny/klNxdi62GXs2nH9vdbR5n
         BuITglFBo2XKk3icSP187NpyITxHABbLGDf6/pQlWswMOoSl3tFv6bpWd06cjwRNg+gE
         ZF1AiE8sd5OuQzIhZi9Be0rH93hxId6JYxmhCMQOUjzlsKS0Rmyy03m+Y//6ksfygbPL
         sfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h4Kymai0tHPy4v24RW3/SFQROwJdZQGu5SVwP1QVDBk=;
        b=gyiccooYD3TOrKy2leD1FPiGtE2JHfpk8QVFfQewG/omlfi7WaqdFHklQvXmGuBxRB
         Q7X7UQ5OJohs6x0TyhMSz0PgcieO3SlzQHVQU0hueGto2kfvd+DBKOvyAKlu6SXgxAXz
         FcvE9Vq6COaC6t/MtMdmyrFsROUTVFRpQ1ZpmYFpmuhDOROZYVyH3JwY5zpjlIEOSAxX
         7eY/6VTMgWeCBNvhg1MEJNB1ohRcsK/CqGgdtuAUgnea2ZavPevepu8cQPqUUn9GSs4g
         +NfdNm3bBVsb5NPRMM66GYxgbvfvmHCHr7fTQ88EvhDmh2YkWFUE4egXWMUOaeXxI7+/
         2uaA==
X-Gm-Message-State: AGi0PuZvq5IKhJYpFx15xXrGwuwPgaNcDOYvYSQG8FAxyjx5uZv625xF
        PlOacuSRTmYUVcVhceWB654=
X-Google-Smtp-Source: APiQypLUzvDOyEEHsLKqhQ4+Q36lix/EwCAHkjPW1DD4ORP/OC3JwhPkdJcuIDIa7TCh1PnOtwieBw==
X-Received: by 2002:a05:6a00:d:: with SMTP id h13mr11188350pfk.254.1587276894728;
        Sat, 18 Apr 2020 23:14:54 -0700 (PDT)
Received: from CentOS76.localdomain.localdomain ([27.59.158.48])
        by smtp.gmail.com with ESMTPSA id q145sm9527932pfq.105.2020.04.18.23.14.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Apr 2020 23:14:54 -0700 (PDT)
From:   jagdsh.linux@gmail.com
To:     jolsa@kernel.org, acme@redhat.com, ak@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Subject: [PATCH 2/7] tools/lib/perf/: Remove duplicate headers
Date:   Sun, 19 Apr 2020 11:43:56 +0530
Message-Id: <1587276836-17088-1-git-send-email-jagdsh.linux@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Code cleanup: Remove duplicate headers which are included twice.

Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
---
 tools/lib/perf/evlist.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 5b9f2ca..def5505 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -11,10 +11,8 @@
 #include <internal/mmap.h>
 #include <internal/cpumap.h>
 #include <internal/threadmap.h>
-#include <internal/xyarray.h>
 #include <internal/lib.h>
 #include <linux/zalloc.h>
-#include <sys/ioctl.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <unistd.h>
-- 
1.8.3.1

