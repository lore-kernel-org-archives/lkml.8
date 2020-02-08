Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF74C35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 14:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129A121741
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 14:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u0Er+8CL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgBHOq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 09:46:26 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38463 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgBHOq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 09:46:26 -0500
Received: by mail-pj1-f65.google.com with SMTP id j17so2207784pjz.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 06:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=umKYkZ+n1hghb0Jr4hdnB/RVp/UqOXWLvmLyfjg6Ugw=;
        b=u0Er+8CLUzoLx1hW2cmiqFqvmrAiNsVQbwOI9477K3oZVp5LbUl3zEcES5biwTiRMt
         Cdig9edK6EUn2HOv18tQS1FslaP/XD/Xq1VlYLaOkoHzprGxCE2bJyIbrlcaLxxomzuC
         hkSJ51ehrfIMbrExu/ZasJ908ZuPnYGGOLE0A4B81PQ2ONXxl63+qEk5DoGrv/Lho9B0
         HAcYDmW6xSgKXrJ2UulT/JQKahpQGI+TGXkfj1QWg5zI5BxnNa5TZkqtgejRnpYFUYls
         r+m5Q0Q+EVweJplXvOJ3Kph/gxj7TF3ZMoX106lyFCo2zX660nPCifoSNw+JVMlcRqQL
         yQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=umKYkZ+n1hghb0Jr4hdnB/RVp/UqOXWLvmLyfjg6Ugw=;
        b=A/5N+eeAmRWbTsOsmpL95iLomlZzQBuAkpNfyngwzyJWHdFOwkMApkB5kzedkIxB0s
         ev2cpTr2AJQkEAzZBFmW2UhXK8kTMvtZ3ovUva6AK1DvZnUwsDzwjMdUNb7oT74kDpE2
         Ykw8koWNtJQgKmF7oe5pFTYNHvHZ2aCvEFEUFYvK9WlfZh6hWjs8hbhSGX92U/IvbyYS
         +A6A9nKihvk0ZsNZ8ZstC4ShI/VkKBBqKqdLeJ8nytTq1dG0C9peZBDeJx49lNwkMYy3
         Z+97U00n95q0D5/Yr8dey7B/9LaqSZOd5rGi2oc1pa0pMQJ/lk6QSYugW0Ck2TTzpzCk
         tkeg==
X-Gm-Message-State: APjAAAWQIL0Vbjuylp0MUGcYGZ8SNyTlA7gZ59K41XF6w2NcxrQd/eVx
        Nn7IQ3VVd9vuxRVaiqMq2Tw=
X-Google-Smtp-Source: APXvYqx/IS2payZIY8op7Vby44AcisLhlL44sRCs5E5PXAo5D+NnApmONveTPEDK1ROMBceD0aF7Lg==
X-Received: by 2002:a17:90a:c301:: with SMTP id g1mr10355574pjt.88.1581173185375;
        Sat, 08 Feb 2020 06:46:25 -0800 (PST)
Received: from localhost.localdomain ([146.196.37.145])
        by smtp.googlemail.com with ESMTPSA id p24sm6750353pff.69.2020.02.08.06.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2020 06:46:24 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH] sched: Annotate perf_event_ctxp with __rcu
Date:   Sat,  8 Feb 2020 20:15:51 +0530
Message-Id: <20200208144550.18486-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf_event_ctxp is used in RCU context in kernel/events/core.c,
tell sparse about it as well.

Fix the following instances of sparse error:
kernel/events/core.c:1384:15: error: incompatible types in comparison
kernel/events/core.c:1397:28: error: incompatible types in comparison
kernel/events/core.c:3264:25: error: incompatible types in comparison
kernel/events/core.c:3265:25: error: incompatible types in comparison
kernel/events/core.c:4340:25: error: incompatible types in comparison
kernel/events/core.c:7091:23: error: incompatible types in comparison
kernel/events/core.c:7870:23: error: incompatible types in comparison
kernel/events/core.c:8971:23: error: incompatible types in comparison
kernel/events/core.c:11865:9: error: incompatible types in comparison
kernel/events/core.c:11975:17: error: incompatible types in comparison

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 include/linux/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 716ad1d8d95e..5df1778cfdf4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1063,7 +1063,7 @@ struct task_struct {
 	unsigned int			futex_state;
 #endif
 #ifdef CONFIG_PERF_EVENTS
-	struct perf_event_context	*perf_event_ctxp[perf_nr_task_contexts];
+	struct perf_event_context __rcu	*perf_event_ctxp[perf_nr_task_contexts];
 	struct mutex			perf_event_mutex;
 	struct list_head		perf_event_list;
 #endif
-- 
2.24.1

