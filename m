Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127E7C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3E62215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZhFfVBNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgEGSKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726860AbgEGSKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:10:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2468C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 11:10:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d206so7973856ybh.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 11:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=509wYnGQ2ll8bD7lPJSFtG4McPi0txJLxy0qvSv45Lo=;
        b=ZhFfVBNHUmUmHvR6RS1KKWKRBbqh0HTuUO7pHTeDUaozng1hAAZP9tIZ+8LZTZaau7
         Z9IyHFYhb7tm2qWuEnfRILjVtXmrBUI68g930iuEC9carHiDuqJM0Q8hbwRfrYJOnMHr
         Mgiip6Sbjhz8csT4cQrv1o7W+McWrcFK2dCkrjLjttEyhQx5tBY2nv25d94p8HinQY69
         bAq4kIJxs93uzLLprZ68fwclQpsOnpw9wzY5nEva6p8IaoAzV2FXlO1YO17homT1jj9v
         rUVm+1XOYjBQxScTdPenOUF48W1umyG+mIMEcfc8/IR/gUNAJXBdT9qI0TFZ+veEPlea
         yjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=509wYnGQ2ll8bD7lPJSFtG4McPi0txJLxy0qvSv45Lo=;
        b=Pr3DAk3QD1AFIofXCgP3qh7c0OpGOg/kYwV6dhokbu/jd26ossWCE9ccMUtfF2YkB1
         Jhb/1fNqlcJ4PGTpT8DEbOsoDunkAq2M2pAQZsNCgcFuaVYjSZeaXH4LqXiZQV1AYUvc
         PjU/YnQhSgNqEQCoOmMgdmU5giT7a9kEvV/2vt+pzwrbUmUfoeOskx7RSUCMGmksOUMT
         HXZik6btZgJM9dTiMP7G/oAjHBQ+lNYdpxAcBh/PCgY9BBy7+g7zCT/W4ANcy9tQ8MTu
         cUXMMdqrhuRW4JiGg+OKKMNkHOPWycs1lQ3Wcgm3UZ7hYrwoVLNjJklA1xEaP7rydi23
         vwEg==
X-Gm-Message-State: AGi0PuYgNFnG6US/0laMRo4qFkjm8FpriX78D5rgYowTw8zF5Gtw16wO
        SBSiOLgyOvcwnB2/tDza2as1yaxN/U5Sqn4AoU7LPKo4TF7xwwD+kOLoNsFsCQRnQn/TkMgm9w0
        nCBNoQ5GRSpEX/GN1t/C82jGZkDuS+eoKih152EyOE0WefpuBq7lu7/bwM/mp+bgdl8htJTTw
X-Google-Smtp-Source: APiQypJlZZ0Nv+hjKxeI5eVTKF6u8iZstKbYl+urYr+Vc4mwMoSpMjoTwgcq1KFh3BK9+P30QwuTBkg0l1kn
X-Received: by 2002:a25:bb49:: with SMTP id b9mr26834376ybk.172.1588875019348;
 Thu, 07 May 2020 11:10:19 -0700 (PDT)
Date:   Thu,  7 May 2020 19:10:00 +0100
In-Reply-To: <20200507181012.29791-1-qperret@google.com>
Message-Id: <20200507181012.29791-3-qperret@google.com>
Mime-Version: 1.0
References: <20200507181012.29791-1-qperret@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 02/14] sched: cpufreq: Use sched_set_deadline() from sugov
From:   Quentin Perret <qperret@google.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, fweisbec@gmail.com, tkjos@google.com,
        kernel-team@android.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sched_set_deadline() is an exported symbol, use it instead of
sched_setattr_nocheck() to elevate the sugov kthreads to DL.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 kernel/sched/cpufreq_schedutil.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 7fbaee24c824..ebd5d30f0861 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -654,20 +654,6 @@ static void sugov_policy_free(struct sugov_policy *sg_policy)
 static int sugov_kthread_create(struct sugov_policy *sg_policy)
 {
 	struct task_struct *thread;
-	struct sched_attr attr = {
-		.size		= sizeof(struct sched_attr),
-		.sched_policy	= SCHED_DEADLINE,
-		.sched_flags	= SCHED_FLAG_SUGOV,
-		.sched_nice	= 0,
-		.sched_priority	= 0,
-		/*
-		 * Fake (unused) bandwidth; workaround to "fix"
-		 * priority inheritance.
-		 */
-		.sched_runtime	=  1000000,
-		.sched_deadline = 10000000,
-		.sched_period	= 10000000,
-	};
 	struct cpufreq_policy *policy = sg_policy->policy;
 	int ret;
 
@@ -685,7 +671,9 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
 		return PTR_ERR(thread);
 	}
 
-	ret = sched_setattr_nocheck(thread, &attr);
+	/* Fake (unused) bandwidth; workaround to "fix" priority inheritance. */
+	ret = sched_set_deadline(thread, 1000000, 10000000, 10000000,
+				 SCHED_FLAG_SUGOV);
 	if (ret) {
 		kthread_stop(thread);
 		pr_warn("%s: failed to set SCHED_DEADLINE\n", __func__);
-- 
2.26.2.526.g744177e7f7-goog

