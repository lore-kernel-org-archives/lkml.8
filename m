Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7A5C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 05:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0102073D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 05:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r7o4elA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgATF7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 00:59:15 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40323 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgATF7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 00:59:15 -0500
Received: by mail-pg1-f195.google.com with SMTP id k25so14979910pgt.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 21:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xFpx/BQ/UY8BuVpo3sx1HSzFguaOM0V83X80P9cw9EA=;
        b=r7o4elA7XHgbhUcd4CR2c/LXyqKn2GxiSXG5smCqCk62ayoUQjOkOXIaa6J/t1BFFj
         ZKra1Ixnlmx8AHI9tUjDwTdL3EE7jxg+RkIusdS/2e82a6Q/GRTTmbZiVK24ymQoBLSJ
         gmtwNFaGU2tmDJE1mREDDSqxxC+1dLHBtA+lCmb4SryNeEnZ/BYSG0w5G+509Pt2EMcB
         yDCK6VqQp/jFvGr6G61Pu8XJkYq/1ZE5gfMkaONLf1zer3jt11Kz7SmAFEtc2d9kiAY6
         E//Ax0sllosb5gsBvPcJ/AGPeqislsSCVb9l/pBgneLYxd+/GhPiWxFDgBdaWVV3ss9I
         bSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xFpx/BQ/UY8BuVpo3sx1HSzFguaOM0V83X80P9cw9EA=;
        b=rm1nvGGxkHn+rY6GFFBgShN0enVfYaW67DwIL7aGXHhanNCCsyGAoubL8DOwXG3Z66
         w8HyvT9AN/1fRe7k82JWEYaVvATmRHn5Su2gvOZc3Pz7hmLIWDzX9RcSzUVoJ2m34rbh
         zRLXPTSsljaFw9KEgWPAdi3sOg+yem3wdMrgAjaxIiszpdt5SRKjqCDWJxF1KbdJwYKW
         HwVKrzSf9sG0JdlYrvPKsBfy+nE55YJJc0Uh40AKn9RZFS9lEOCkpUgWr2jwuVjoI6ai
         mID5EtwZDwxsLrROK6esXmo1IpxUU1+7b4qN3ZYjLnPV0OK8E2Fqd6gQ47D6VugQx4aF
         V9ww==
X-Gm-Message-State: APjAAAVcKCcxF3TyNl4EvP5NUdXd3hn3PjslSxXDjsRmtupPHseu+mkg
        Qi9TBGWsu3VhrQoGQRkS3lKfmw==
X-Google-Smtp-Source: APXvYqwN2Sbh/TY+PR3e++i6UK784lLXsUd8b9q/otl6SJknDvPv2KfH90W2462g/3O6dA7nD3JT2g==
X-Received: by 2002:a62:e80a:: with SMTP id c10mr9505125pfi.91.1579499954859;
        Sun, 19 Jan 2020 21:59:14 -0800 (PST)
Received: from localhost ([122.172.71.156])
        by smtp.gmail.com with ESMTPSA id g19sm37524302pfh.134.2020.01.19.21.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jan 2020 21:59:14 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Define sched_idle_cpu() only for SMP configurations
Date:   Mon, 20 Jan 2020 11:29:05 +0530
Message-Id: <f0554f590687478b33914a4aff9f0e6a62886d44.1579499907.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sched_idle_cpu() isn't used for non SMP configuration and with a recent
change, we have started getting following warning:

kernel/sched/fair.c:5221:12: warning: ‘sched_idle_cpu’ defined but not used [-Wunused-function]

Fix that by defining sched_idle_cpu() only for SMP configurations.

Fixes: 323af6deaf70 ("sched/fair: Load balance aggressively for SCHED_IDLE CPUs")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 88a1de82dec5..1ca6c14d21ed 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5217,10 +5217,12 @@ static int sched_idle_rq(struct rq *rq)
 			rq->nr_running);
 }
 
+#ifdef CONFIG_SMP
 static int sched_idle_cpu(int cpu)
 {
 	return sched_idle_rq(cpu_rq(cpu));
 }
+#endif
 
 /*
  * The enqueue_task method is called before nr_running is
-- 
2.21.0.rc0.269.g1a574e7a288b

