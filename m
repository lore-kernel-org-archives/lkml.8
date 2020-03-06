Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B17C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC0520726
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="XfqrDDLT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgCFPmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 10:42:03 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39457 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgCFPmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 10:42:03 -0500
Received: by mail-qk1-f195.google.com with SMTP id e16so2678472qkl.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 07:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MXluHjiwZwq++M60EzdikuAJ7SQh4kY9FFj9/2rOI1E=;
        b=XfqrDDLTdsV942+ut6/YkgkZKGbvL/q9ZDKBZ0SvOE4NI4GMCnyseOZpyMcDOvPNGZ
         mTMdszu0nM0VoZ9KQVwhiv1MaoW9CiMGkkSDgwfpNo+rPszSxt5LFgvP/O/UElXlpaE5
         BfIuiyR3UHdZ8/O0mXSUnPq5cqK9esf6CxUNqemabp/DjlRZ2CeCXEtmbLhIIcEZapqG
         TPhQ3gttHvuK9qshLEbQhu4Qj9Pq+xPpZR05TVtTqCYr6pCGxbW+MMn9dFqJ2gvQRGNZ
         ZIbA1hZJUpf4ZLh3euFZfQex4glc1YCWqSdesgDun9OM/Wg1zgYXHz1KRwmMJL1wPVKP
         0WUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MXluHjiwZwq++M60EzdikuAJ7SQh4kY9FFj9/2rOI1E=;
        b=hHYEN0Hti0gGyJIewgK4dK4inhjPrAKR6Ae95qad06SL/qw1c51MyrqpUGjg6tNTFQ
         +2IL/HX0kiGH2yMZH99MI12hJ/WwbKYiW96vV0CkEJ2tcIaM1YUPoXxX3XTP6rXq7sPS
         teC8Hx8u0kRU2iMPCdeGJN4X1+nSnRIbMRqlvViUcTYRPJXOPpT8IJ0yrZH6pJavQsXu
         iX1OGNvsRIr9Bb2HkwSjh49tmbdOvmfpwUpMzWNvnwIc+4fbcMZQOL7c4pS4nS9uAY3Q
         9UdKGJpNvNNEewGZ2tBHL3hNXfXP8NOC35LXwe3QRA5AXyZOUAvvtPlji/5EYaCxHDyr
         p74A==
X-Gm-Message-State: ANhLgQ0fLJGJHExqYqwhZVO+JWC86yMZyOfo18u9ECYHovwjseKrUJ1C
        4ao2vdjOBmczTY5u5liksci1MQ==
X-Google-Smtp-Source: ADFU+vudqeDY9lcAQWfY5s1B6AUUBMEYsqIgJhx8yfdx9+6DLvVj/rg/9shdrdKWk7ZCMCTeOV2R8Q==
X-Received: by 2002:a37:ef04:: with SMTP id j4mr3491798qkk.68.1583509322259;
        Fri, 06 Mar 2020 07:42:02 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w11sm13942407qti.54.2020.03.06.07.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2020 07:42:01 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Qian Cai <cai@lca.pw>
Subject: [PATCH] sched/cputime: silence a -Wunused-function warning
Date:   Fri,  6 Mar 2020 10:41:44 -0500
Message-Id: <1583509304-28508-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

account_other_time() is only used when CONFIG_IRQ_TIME_ACCOUNTING=y (in
irqtime_account_process_tick()) or CONFIG_VIRT_CPU_ACCOUNTING_GEN=y (in
get_vtime_delta()). When both are off, it will generate a compilation
warning from Clang,

kernel/sched/cputime.c:255:19: warning: unused function
'account_other_time' [-Wunused-function]
static inline u64 account_other_time(u64 max)

Rather than wrapping around this function with a macro expression,

 if defined(CONFIG_IRQ_TIME_ACCOUNTING) || \
    defined(CONFIG_VIRT_CPU_ACCOUNTING_GEN)

just use __maybe_unused for this small function which seems like a good
trade-off.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/sched/cputime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index cff3e656566d..85da4d6dee24 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -252,7 +252,7 @@ static __always_inline u64 steal_account_process_time(u64 maxtime)
 /*
  * Account how much elapsed time was spent in steal, irq, or softirq time.
  */
-static inline u64 account_other_time(u64 max)
+static inline __maybe_unused u64 account_other_time(u64 max)
 {
 	u64 accounted;
 
-- 
1.8.3.1

