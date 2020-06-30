Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE80C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C77D2081A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0nhWvvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388474AbgF3RsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388388AbgF3RsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:48:24 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AC9C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 10:48:24 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o22so4732620pjw.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 10:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GVyu4MkDCd3TIFlywfkImC8tPFKpiToQftsagCmrcyk=;
        b=r0nhWvvR4ZEsZyGSBSYNZjS9fQWc2mt+iW5c7JX+9ptNSQmv95N2j+GXJ98c3/DRff
         akz3I90Ypz4aGS1FKLRH+kVK1hpeMcNd2CjAeTyjQF1EwlU/QGQyojp8GI5Nm2SwdvDw
         MpRMo+I9DVCCCjfKea8j4Tp48KXM3Xgh+1lp5KKb/2QMIv0JqY6Cv5U8oQH+aPNLnXrI
         /u7Jf4sxVITDIXDc5ZEEnd5CqBz0sKXMt/7ScN9EeIo+v06mDwRlKK3vN+XfOHmCC43r
         VE0X7xBqhzsb2oMDtQj0WEjtNrGfuSeowUK4+wWDh9uo52p5G+inviGYwDvGwiHW6Gvw
         ULCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=GVyu4MkDCd3TIFlywfkImC8tPFKpiToQftsagCmrcyk=;
        b=HMQGOGf5R2yFxYTvvwUOjT0XDRh0FqsxCzSGxeFbIAYuwvGzD3rWEOi2Vhj+ZZlzlm
         otkzOEpO+BnBnCKibINW/X5JXiGyYV2ZGmREn3WJIMdXD0g6rVPkevScFJRXJe7tfq5D
         oJWiPC5r/FKW7N7R82UAx9V2bZCP9/cjDldlMiV08Em71S//N0vscRTGUAk/wIhzdfds
         AdyqhOIHCoI9kpqan4kKFiCAbfki5PJf2/YdM9T0/tAqgkyWiyGPiK4oHaiK+EUvy4/w
         1jA12hnhGMWr1ucZ2ZPZI9mI7NOnSpSCh75vB15BZiOz+4jPKFxh6bLXckrzxw0aGi4C
         y51Q==
X-Gm-Message-State: AOAM532028j6421rBMkkZ278RVbU/SnlAX/E+a5fJVMKQ3OcH8JBkV4a
        ggJZPOXeLI0kzDn4/WAFVws=
X-Google-Smtp-Source: ABdhPJyUEKimrT6OQmmT7k2agUYP9qT1ov1wWmypDoKRrIYmejaqOT6asz9QGEdmx6ou3+uHT1rLYQ==
X-Received: by 2002:a17:90a:b295:: with SMTP id c21mr23491540pjr.120.1593539304254;
        Tue, 30 Jun 2020 10:48:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u74sm3296106pgc.58.2020.06.30.10.48.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jun 2020 10:48:23 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2] sched: Declare sched_rt_bandwidth_account() in include file
Date:   Tue, 30 Jun 2020 10:48:21 -0700
Message-Id: <20200630174821.5780-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc reports:

kernel/sched/rt.c:626:6: warning:
		no previous prototype for ‘sched_rt_bandwidth_account’

Let's declare it, and remove the declaration from the source file
where it is called.

Fixes: faa5993736d9 ("sched/deadline: Prevent rt_time growth to infinity")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: sched_rt_bandwidth_account() is declared and used unconditionally.

 kernel/sched/deadline.c | 2 --
 kernel/sched/sched.h    | 4 +++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f63f337c7147..68587e72182d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1131,8 +1131,6 @@ int dl_runtime_exceeded(struct sched_dl_entity *dl_se)
 	return (dl_se->runtime <= 0);
 }
 
-extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
-
 /*
  * This function implements the GRUB accounting rule:
  * according to the GRUB reclaiming algorithm, the runtime is
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 877fb08eb1b0..82d4754a0e0e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -317,6 +317,8 @@ bool __dl_overflow(struct dl_bw *dl_b, int cpus, u64 old_bw, u64 new_bw)
 	       dl_b->bw * cpus < dl_b->total_bw - old_bw + new_bw;
 }
 
+struct rt_rq;
+
 extern void init_dl_bw(struct dl_bw *dl_b);
 extern int  sched_dl_global_validate(void);
 extern void sched_dl_do_global(void);
@@ -328,6 +330,7 @@ extern bool dl_param_changed(struct task_struct *p, const struct sched_attr *att
 extern int  dl_task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_allowed);
 extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
 extern bool dl_cpu_busy(unsigned int cpu);
+extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
 
 #ifdef CONFIG_CGROUP_SCHED
 
@@ -335,7 +338,6 @@ extern bool dl_cpu_busy(unsigned int cpu);
 #include <linux/psi.h>
 
 struct cfs_rq;
-struct rt_rq;
 
 extern struct list_head task_groups;
 
-- 
2.17.1

