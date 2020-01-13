Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED792C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 00:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE68721556
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 00:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvpbKlBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387569AbgAMAuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 19:50:37 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46624 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387502AbgAMAuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 19:50:37 -0500
Received: by mail-pg1-f196.google.com with SMTP id z124so3853852pgb.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 16:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1d6gYwX2CdMLtlcwRbkHiQqjyQbyQkRRWcGMa9V4gMo=;
        b=FvpbKlBlI0y5bFj4dzSMmDjZWg9wuldaBATMFCcG4oZMaxpm6sXwOOBwSXdwUNKe5U
         Z6w+KEStZCPaspc8Gq+kaidZO/xx1+iapdd15Q79MNqAJQ1C7SUHoV5PyJP+sG0lS4Pv
         nGQ1asK/RF0+LfmMYmCKV17hwPylQ0snpsIJrTCy9jTtY0GMH4GrSqTXgax+r0jEuB1A
         QqGEd7ZXPMrwkGiQC9FHtsmxtVR49qslkqH9kSdoYMupxxkfXi5u1A8iJWrg41g34Did
         p6syfEaORSwxUHxxJQudn7h87V0CY8W9JIs5qGLBH5AqG/rH3yHY10RkSll2b0aIxwei
         e0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1d6gYwX2CdMLtlcwRbkHiQqjyQbyQkRRWcGMa9V4gMo=;
        b=sDG4GxzqFcFtw+5lAFCf9rXrttCUDqsSESPRlU9A3bKGNTo7hox5UIINnWptUp7Eip
         uA0Z7Crr5JaZdqrynYprrr/a1WEj8j9bZi8lEo3WjWGzX9afEd7KnrO2/bzRoN5FRNn8
         sVaK85KgMkqXE7i/v4kpZakyXwtncaJdcuCKS1iff3X855xnyu3DqnFQV/+gCRkEMQEv
         hGnKogwbgQRcTZgEtepWK9j1ehg8JL/EujF//TJmsCyme+YuQ0c60v7WK+bEaahMX4BA
         S0L/Y8RE3hVaGytJRBwd3chAUzhYlXkQ34DwreJbMY7pI0wvyOyKMIkaTWXdPzEi8+YV
         oHRg==
X-Gm-Message-State: APjAAAWlu57rk0n2hFkgqO58YvY7QnT5Co7c9xJKZt1JZn94fG07znBw
        TPd7X5/vw9qk4k9ethUb2Xeu6GjB
X-Google-Smtp-Source: APXvYqwHP1iB+VAqLX8nd1B2wzjjX5fXpMz7xuuM/XGMPkmhCiSMDP9/3xG5J9XrHO3jVc1D+euw+Q==
X-Received: by 2002:a62:7c58:: with SMTP id x85mr17098642pfc.76.1578876636707;
        Sun, 12 Jan 2020 16:50:36 -0800 (PST)
Received: from localhost.localdomain ([103.7.29.6])
        by smtp.googlemail.com with ESMTPSA id w11sm10575336pgs.60.2020.01.12.16.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Jan 2020 16:50:36 -0800 (PST)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH RESEND v2] sched/nohz: Optimize get_nohz_timer_target()
Date:   Mon, 13 Jan 2020 08:50:27 +0800
Message-Id: <1578876627-11938-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

On a machine, cpu 0 is used for housekeeping, the other 39 cpus in the 
same socket are in nohz_full mode. We can observe huge time burn in the 
loop for seaching nearest busy housekeeper cpu by ftrace.

  2)               |                        get_nohz_timer_target() {
  2)   0.240 us    |                          housekeeping_test_cpu();
  2)   0.458 us    |                          housekeeping_test_cpu();

  ...

  2)   0.292 us    |                          housekeeping_test_cpu();
  2)   0.240 us    |                          housekeeping_test_cpu();
  2)   0.227 us    |                          housekeeping_any_cpu();
  2) + 43.460 us   |                        }
  
This patch optimizes the searching logic by finding a nearest housekeeper
cpu in the housekeeping cpumask, it can minimize the worst searching time 
from ~44us to < 10us in my testing. In addition, the last iterated busy 
housekeeper can become a random candidate while current CPU is a better 
fallback if it is a housekeeper.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
v1 -> v2:
 * current CPU is a better fallback if it is a housekeeper

 kernel/sched/core.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 102dfcf..04a0f6a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -539,27 +539,32 @@ void resched_cpu(int cpu)
  */
 int get_nohz_timer_target(void)
 {
-	int i, cpu = smp_processor_id();
+	int i, cpu = smp_processor_id(), default_cpu = -1;
 	struct sched_domain *sd;
 
-	if (!idle_cpu(cpu) && housekeeping_cpu(cpu, HK_FLAG_TIMER))
-		return cpu;
+	if (housekeeping_cpu(cpu, HK_FLAG_TIMER)) {
+		if (!idle_cpu(cpu))
+			return cpu;
+		default_cpu = cpu;
+	}
 
 	rcu_read_lock();
 	for_each_domain(cpu, sd) {
-		for_each_cpu(i, sched_domain_span(sd)) {
+		for_each_cpu_and(i, sched_domain_span(sd),
+			housekeeping_cpumask(HK_FLAG_TIMER)) {
 			if (cpu == i)
 				continue;
 
-			if (!idle_cpu(i) && housekeeping_cpu(i, HK_FLAG_TIMER)) {
+			if (!idle_cpu(i)) {
 				cpu = i;
 				goto unlock;
 			}
 		}
 	}
 
-	if (!housekeeping_cpu(cpu, HK_FLAG_TIMER))
-		cpu = housekeeping_any_cpu(HK_FLAG_TIMER);
+	if (default_cpu == -1)
+		default_cpu = housekeeping_any_cpu(HK_FLAG_TIMER);
+	cpu = default_cpu;
 unlock:
 	rcu_read_unlock();
 	return cpu;
-- 
1.8.3.1

