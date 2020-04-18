Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA20AC352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B1C922240
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="hh+OSKj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgDRUVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728667AbgDRUU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:57 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C6CC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:57 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u127so5679073wmg.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KF0MMuYkdCmTEZ9fsBt+yX/B+7bF7Hk+VwWS4t65ZtQ=;
        b=hh+OSKj7plLPq3kthIK4rbfmlRUEPmO6a4PSIbwHAvqUpU9qxAOQiP/zsEaKSrcclw
         GNhEIG3iNuw3+v9RC4vvpiw9cuJ3BK/5RZuSrzO2ekCxTXJuK2RGYK+ZmtSvD6TxX8vh
         k1QGNOG9+ohnsegmR2NaF8/07ttxfmzMJ5Q3QyJoerwBgbOvYCOvhPubwdlAciLyAON4
         lVdAR7UlqIpDl/YR9tBlrFc2F4h/Df0CLVeFpexcEhVzw/rGXMJPl7xWmhqw9/pFYyHo
         aGeciuIyo9dEg+baUYBYCkjq5233bQcTSeBobXFuOqx26pi8km+bllqHGdUR9LWG+wZF
         +ORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KF0MMuYkdCmTEZ9fsBt+yX/B+7bF7Hk+VwWS4t65ZtQ=;
        b=FWQsxB9f1osyfuswVdS74z3iLbzmcxbmE/Bm5w8QoxYhk/OudihgY4h1+ycVtCUmt/
         houBJeSoGP7TQb8kT+EXTnN7ZkyUmmrtRug7QPUeEiNEgscmWIrA5z3nI3WoBnmn+N7S
         IuYs1CDzYY+gm7SIL7b7ROrGedF6UiewE47ApYr0JMp/lEG62eAL0HrMGgOzdzfMOBJT
         CuoJwUHlGcyXoaz0xHzg1w+5rhRLQqm5nl9Q5PlakE3PtYxTpn+MJknbaYX44BgkEDAJ
         Yj7+B4TqiavMqAAAECWg2cxiTVn8uDJ/IMOSmYeN24ZpJEA1K5r4FPh1Vwd1evmQQXr5
         ZQFg==
X-Gm-Message-State: AGi0PuZ5oiOVGhI1+B6bhn5VIo3zoi/WrvlzJNVWvo8EK4d+cBQqCo7h
        +/HbaCOsl9oi9xzBvnAGtnE8Eicv8do=
X-Google-Smtp-Source: APiQypIvKB2Kimmp9S7e0iAkl2GLLQ7kmXQCaPGZakmwrSu83TmhxIS2RGau85a2AJVXtbo+IiP5YQ==
X-Received: by 2002:a05:600c:295a:: with SMTP id n26mr10523082wmd.16.1587241255612;
        Sat, 18 Apr 2020 13:20:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:54 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCHv3 48/50] sched: Print stack trace with KERN_INFO
Date:   Sat, 18 Apr 2020 21:19:42 +0100
Message-Id: <20200418201944.482088-49-dima@arista.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200418201944.482088-1-dima@arista.com>
References: <20200418201944.482088-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aligning with other messages printed in sched_show_task() - use
KERN_INFO to print the backtrace.

Cc: Ben Segall <bsegall@google.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e6ea7c17a362..581a219ac062 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5957,7 +5957,7 @@ void sched_show_task(struct task_struct *p)
 		(unsigned long)task_thread_info(p)->flags);
 
 	print_worker_info(KERN_INFO, p);
-	show_stack(p, NULL);
+	show_stack_loglvl(p, NULL, KERN_INFO);
 	put_task_stack(p);
 }
 EXPORT_SYMBOL_GPL(sched_show_task);
-- 
2.26.0

