Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1ACC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E85BC206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="re2AKKov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505070AbgDNTk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504935AbgDNTjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:39:51 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B334C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:04:17 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id cf1so772022qvb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=wEXhi2KDTL49/7/ZUX9XUdxIt6VXHRWvzpEoOczneLE=;
        b=re2AKKovrbQOdYfoefUhsXCD8Vblkx7RtBDuhCUz9JbcE2R29tLdtqLfNNYj1W+4p+
         NqmzPC7nMS9/AG0Fqf0ddPTW9pKqGgase2913Dn4nE95p/dlWLzjRnX+yKEfR6CkfTDs
         oHFN3/5LLwVr27dS7A3/30R/sD814WL7brDf1/QzrONVahRxKQnkk8VOCeEvu5h1pZfd
         RBeUDWSaWOK4RZrUONVvfEZNT6gRaZmlChQr0MvIYrvUX1loaKu9DJhtnwDoQGGu5W2X
         DLyzqpFKYxSVL65gzvAkCInfgxIBzeNNI+ybDDSd40m30oqTdlTDWlBhlSJF9gFYSX+9
         yZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=wEXhi2KDTL49/7/ZUX9XUdxIt6VXHRWvzpEoOczneLE=;
        b=QKk8t6WN9TT3iW8g/oxPqC/Z43lrQD+KVYndv9UuKFL65CMKdB0nq+4J2LHdjSaO5m
         +JTu2+FtkyWrZlWHBmgnhYHvUAV/p3sJn2h7vuD9uBJwrnQZO4TGppcbXx3Txoy4KA6p
         dX1F/ODsekLETuXmRjT3BNRuzfeyEcreEMnycUIw44HR4dOrOCk1qbptrEBMrPXZ1BIs
         lpA2QCgB9PIBFxVugFh+UNA2cXeTxcrbMcysV3e0ePOa2i4wuYhnVjh4xrZh34boLs6g
         JcY2GuEySUo9LywlGAsE7ppPTzopLjRyjPEyYBT+p2t6B4i8xpiMvbIpLPybPhtgyqTa
         uyGA==
X-Gm-Message-State: AGi0PuboxaE2iuU1K+myeBgrzWbQ5DE93WB2faZ82ZvHQhqd8MrPpgd6
        2Ow/HwpqdJJ9rk5heBbfSgB6X8O1
X-Google-Smtp-Source: APiQypIXDaXG+77AFk7cpEZJzSlcSgxXpeGbEIvqAkcaRkEBxOkMTVXGD0JE11O6mFyQ07uoH+Ued9Ts
X-Received: by 2002:ac8:31ac:: with SMTP id h41mr17598668qte.139.1586891056302;
 Tue, 14 Apr 2020 12:04:16 -0700 (PDT)
Date:   Tue, 14 Apr 2020 15:03:51 -0400
Message-Id: <20200414190351.16893-1-brho@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: perf: add cond_resched() to task_function_call()
From:   Barret Rhoden <brho@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        syzbot+bb4935a5c09b5ff79940@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under rare circumstances, task_function_call() can repeatedly fail and
cause a soft lockup.

There is a slight race where the process is no longer running on the cpu
we targeted by the time remote_function() runs.  The code will simply
try again.  If we are very unlucky, this will continue to fail, until a
watchdog fires.  This can happen in a heavily loaded, multi-core virtual
machine.

Reported-by: syzbot+bb4935a5c09b5ff79940@syzkaller.appspotmail.com
Signed-off-by: Barret Rhoden <brho@google.com>
---
 kernel/events/core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 55e44417f66d..65c2c05e24c2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -99,7 +99,7 @@ static void remote_function(void *data)
  *
  * returns: @func return value, or
  *	    -ESRCH  - when the process isn't running
- *	    -EAGAIN - when the process moved away
+ *	    -ENXIO  - when the cpu the process was on has gone offline
  */
 static int
 task_function_call(struct task_struct *p, remote_function_f func, void *info)
@@ -112,11 +112,15 @@ task_function_call(struct task_struct *p, remote_function_f func, void *info)
 	};
 	int ret;
 
-	do {
-		ret = smp_call_function_single(task_cpu(p), remote_function, &data, 1);
+	while (1) {
+		ret = smp_call_function_single(task_cpu(p), remote_function,
+					       &data, 1);
 		if (!ret)
 			ret = data.ret;
-	} while (ret == -EAGAIN);
+		if (ret != -EAGAIN)
+			break;
+		cond_resched();
+	}
 
 	return ret;
 }
-- 
2.26.0.110.g2183baf09c-goog

