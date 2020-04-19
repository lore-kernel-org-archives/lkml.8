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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3772FC38A29
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 06:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 165FB21473
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 06:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAi5FK5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgDSGmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 02:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSGmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 02:42:35 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31633C061A0C;
        Sat, 18 Apr 2020 23:42:34 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id r20so3331118pfh.9;
        Sat, 18 Apr 2020 23:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mamiKfjGVqNB2lfZ9Vc1boeJO9yD6maYEt+Wkruvbx0=;
        b=HAi5FK5+6tSpBWtktFE7tJjwjNJ/l7KTz84EfFiGsGZQu6umzwT2Ab2JtfW5vE5nIF
         ErpFUHivh2/8s2AmUrxGOQumvxsVGY9zmITc/cugTi5o4l6FWNww1/2JrPrEklJbIPJP
         EEnL3cYgNCZTTomIwZguIqasaFF+FqQL+y84zIIjOZ0G/XeyBoTmEXMD7v+z+62bvWLW
         QuUsOruD7/XNk5BhL+Q/xaCs5SokShC5IOkcR99Jf77ecyPPaITw4AjolaP5v87F5WkQ
         l4SruuywUJ3x2htgpXrWSOu0jQZYG7snUjU7YNrl5saHruSNDfhucB1yopvaP10tHOPV
         46Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mamiKfjGVqNB2lfZ9Vc1boeJO9yD6maYEt+Wkruvbx0=;
        b=Jy7U+WjWTlYkeuN1EafXJyfO/Y30kFE4myvI+Ht+Z9aHxYjNLQnC/YQlKFu/FOzEob
         9XnIyvXdtCFNg6DLPnvzRk21cZYvGJPSoiv7psfPNtpRd75RJqHLLChSgPqw79e+B/VA
         X2cMi2mUK6RkyL/xekRDv4J2tzSJEgcF0vDrwDb91chea6OxSlmaJnASsyb2UwA4vuLx
         5t5vJhCPRufXGjBinTgi/4yWdDhXAFE146JngupKVdooBKbI6xssYCvxokhAdbadyg60
         Y8q2r5qRnvsRGbzOY0ZFW+KqlEen44c0u3KNfs8fNlmD4t8LUqf8Ouhnz1X3h2arMgUb
         ZXjg==
X-Gm-Message-State: AGi0Puab++A1td1iX95u/bxwzaRSxKApmaPXskI7nJIbBwFm+EEze+j2
        00PlSVuKTUOirvWgw7O9JAo=
X-Google-Smtp-Source: APiQypJh+Xo3EBWavapqrON4K7tyi4De+eQBWskRiR9Gf+W43SbsEFYnBV4coJXmwOBZiVLFAXwFbw==
X-Received: by 2002:aa7:850f:: with SMTP id v15mr10747842pfn.204.1587278553656;
        Sat, 18 Apr 2020 23:42:33 -0700 (PDT)
Received: from CentOS76.localdomain.localdomain ([27.59.158.48])
        by smtp.gmail.com with ESMTPSA id o18sm3285399pjw.15.2020.04.18.23.42.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Apr 2020 23:42:33 -0700 (PDT)
From:   jagdsh.linux@gmail.com
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        shuah@kernel.org, aneesh.kumar@linux.ibm.com, desnesn@linux.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Subject: [PATCH] tools/testing/selftests/powerpc/mm: Remove duplicate headers
Date:   Sun, 19 Apr 2020 12:11:30 +0530
Message-Id: <1587278490-18426-1-git-send-email-jagdsh.linux@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Code cleanup: Remove duplicate headers which are included twice.

Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
---
 tools/testing/selftests/powerpc/mm/tlbie_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/mm/tlbie_test.c b/tools/testing/selftests/powerpc/mm/tlbie_test.c
index f85a093..48344a7 100644
--- a/tools/testing/selftests/powerpc/mm/tlbie_test.c
+++ b/tools/testing/selftests/powerpc/mm/tlbie_test.c
@@ -33,7 +33,6 @@
 #include <sched.h>
 #include <time.h>
 #include <stdarg.h>
-#include <sched.h>
 #include <pthread.h>
 #include <signal.h>
 #include <sys/prctl.h>
-- 
1.8.3.1

