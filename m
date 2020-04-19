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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90508C38A29
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 06:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CF802076A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 06:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRvu52Ag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDSGrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 02:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSGrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 02:47:15 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC9EC061A0C;
        Sat, 18 Apr 2020 23:47:14 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id a23so2721097plm.1;
        Sat, 18 Apr 2020 23:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HC8EzgDyXgY+Ahd0LWEHBYjj8NnTQwXiZWvYzIr89FA=;
        b=YRvu52AghzhI/BoIxJQT9pS0iYRnAZfDN4yfISSN6G7Y1/S9hMpl+e5jv+QI4C5NdO
         1PpDnil9SeqXK13yueVgpaqIbYTB2lsONhlm6/pS0HtdrsqXwXX9fjjOZ7bBGchmoDTE
         XqYZg7Ue9devgWIJX6tI4i0zj7voUhV5Sa9JrXlwtgeB3ZbbIeiH7wa6EYWCCjNQSWqY
         XklJ0kJQ8FvUC836yR2FMEWJnySL4c6Zb2I8mhjzUflJJ4jNnBwXvWL8NK1a5zapsuKP
         Rj9f0APBKBEoGJUoappNWfN2eLseLKi7apxNVm5/ZYNTC5zCt8LLdoVb5Khe5diw3WKR
         7l3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HC8EzgDyXgY+Ahd0LWEHBYjj8NnTQwXiZWvYzIr89FA=;
        b=fvbxt400/LvEvdBvNOiO4W+uu7chqsZ9hA+oTZVzG9Pfj+FDv4OqiEif+GrPQfS0c4
         vuCkUeW7Pu2L1Ob8AvE/p8lLH8QPwUy/hR24Gt9fUEBa/7W/i24PQgMyH8TI97yO7a4Q
         a0ighnZ0Sd2XKvQlTLfZwDM22+Ab2SjUo74GtuntdNTViL2erHgo8Al7A3AJCMv+0U5N
         WOLUQzO2Ur8I5vM3jpobAliyEYUPO26XG2qQkkXe7m5fTweGHh4NEiVHYz71ZoNqtK7o
         fW+ASrAMiwMudMSHiD/sVh7Ib7bqK6f/Ccc02RtLv6cNsd00OP12umARLv5C2QSeJDqt
         oFsg==
X-Gm-Message-State: AGi0Pub3wwanWrsxTQOFd5SFnfN/KRdHyOHxCNyePCvghkzW3RClWMNk
        ta3oN563MwK/maFF8Fo9oo8=
X-Google-Smtp-Source: APiQypIzlSUWxRzYEDXedUWj1Pe1NbxG2MRy5KjBGpXDhPr4lEsSTwZqUHoS2jm0voKHjbhs4L8pKw==
X-Received: by 2002:a17:90b:374f:: with SMTP id ne15mr5162521pjb.181.1587278834246;
        Sat, 18 Apr 2020 23:47:14 -0700 (PDT)
Received: from CentOS76.localdomain.localdomain ([27.59.158.48])
        by smtp.gmail.com with ESMTPSA id q97sm10689215pjb.7.2020.04.18.23.47.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Apr 2020 23:47:13 -0700 (PDT)
From:   jagdsh.linux@gmail.com
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        huah@kernel.org, mikey@neuling.org, gromero@linux.ibm.com,
        gregkh@linuxfoundation.org, alexios.zavras@intel.com,
        tglx@linutronix.de, swinslow@gmail.com, rfontana@redhat.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Subject: [PATCH] tools/testing/selftests/powerpc/tm: Remove duplicate headers
Date:   Sun, 19 Apr 2020 12:16:04 +0530
Message-Id: <1587278764-18640-1-git-send-email-jagdsh.linux@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Code cleanup: Remove duplicate headers which are included twice.

Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
---
 tools/testing/selftests/powerpc/tm/tm-poison.c      | 1 -
 tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-poison.c b/tools/testing/selftests/powerpc/tm/tm-poison.c
index 9775584..f0257c6 100644
--- a/tools/testing/selftests/powerpc/tm/tm-poison.c
+++ b/tools/testing/selftests/powerpc/tm/tm-poison.c
@@ -20,7 +20,6 @@
 #include <sched.h>
 #include <sys/types.h>
 #include <signal.h>
-#include <inttypes.h>
 
 #include "tm.h"
 
diff --git a/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c b/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
index e2a0c07..9ef37a9 100644
--- a/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
+++ b/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
@@ -17,7 +17,6 @@
 #include <pthread.h>
 #include <sys/mman.h>
 #include <unistd.h>
-#include <pthread.h>
 
 #include "tm.h"
 #include "utils.h"
-- 
1.8.3.1

