Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181CAC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E54622078E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="ZnXBz/6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgDTHF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 03:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726055AbgDTHF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 03:05:27 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44135C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 00:05:26 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ms17so4035549pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 00:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F73XxE2CZAkSaOwPg4Nrru11KQB4w7SYV2z/uYSccF8=;
        b=ZnXBz/6exLkNDCi45tj//brSSbOIcNDxegDG2Gy7BHd7x+4kZZ01td6gwT5Td+oGVQ
         e/aLC+gsEP9BfXC6f/ktEaiDRFcxCINHpgB5q4bOug9/ozCbqknymQHK9DsJWvUOyczx
         Bn5aew5+b1GISFiklfFH1s5kbfdMRUrBJ85Q6wCHwdjWigpB1ecsgoZYkv+J8RLdz9fK
         B3+YWhKfEEbkXozp01TF4ZE6e+CoVFljx08iAgBCY5Ny8AGHuP+asZkd2SGJyW73QtJl
         NiGjAVIlXX8RftXB7a4rSXQYg9dyYMncyE+kYgqCENN/VpsxuWqZJk+RzzN3niAwa2Yl
         nhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F73XxE2CZAkSaOwPg4Nrru11KQB4w7SYV2z/uYSccF8=;
        b=abF32YJMe4ZbR7derPUfmC0TRrb7TNbgdBE+6NpbQq+LYlvuGU6ZHcTOO2F2wgqcDd
         sXW0GR0WoW+StXXo6NTFEdzUd6uVY45T9HQAcsweZfazHc007rZc+16JFlxyNP07/JFc
         sVpLSNhFalgleHJTtwMn5sDdJr7h8uPBvGs1T7bKqd5cFJH+u52Xx9r+aNjN1sNkOfNV
         0lbc9NFBEz+UagyE14thv5e1a8WsoUY2MWZNWV+CoKXgEx1wninFx0ocBgZh2XZ6SbhR
         +ww/GURGIrN7eHF6u+wxK3BZNPVDN/mKTYSvsnCrA7q2Q7zxttF8NtmDbYR9SXuO7IIX
         kM1g==
X-Gm-Message-State: AGi0PuYF7If3gM0Id4wdgJfLnk8DE1NSnJmKSl5jPcMfVGn3SrckunIa
        tN+4//OPPs0yN3sbUZKplkC6PCBKMculSQ==
X-Google-Smtp-Source: APiQypIzoxFpnQHTzskAHP8WW70snl6cIZyREUHHk9wcHvVSLsqWQmROMJHOq/is+DekVvlPEUPjNw==
X-Received: by 2002:a17:90a:5217:: with SMTP id v23mr19528322pjh.127.1587366325777;
        Mon, 20 Apr 2020 00:05:25 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.69])
        by smtp.gmail.com with ESMTPSA id b5sm161252pfb.190.2020.04.20.00.05.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 00:05:25 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] sched/cpuacct: Fix charge cpuacct.usage_sys incorrently.
Date:   Mon, 20 Apr 2020 15:04:53 +0800
Message-Id: <20200420070453.76815-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user_mode(task_pt_regs(tsk)) always return true for
user thread, and false for kernel thread. So it means that
the cpuacct.usage_sys is the time that kernel thread uses
not the time that thread uses in the kernel mode. We can
try get_irq_regs() first, if it is NULL, then we can fall
back to task_pt_regs().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
Changes in v2:
    1. we use get_irq_regs() first, if it's NULL, fall back to task_pt_regs()

 kernel/sched/cpuacct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 6448b0438ffb2..941c28cf97384 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -5,6 +5,7 @@
  * Based on the work by Paul Menage (menage@google.com) and Balbir Singh
  * (balbir@in.ibm.com).
  */
+#include <asm/irq_regs.h>
 #include "sched.h"
 
 /* Time spent by the tasks of the CPU accounting group executing in ... */
@@ -339,7 +340,7 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
 {
 	struct cpuacct *ca;
 	int index = CPUACCT_STAT_SYSTEM;
-	struct pt_regs *regs = task_pt_regs(tsk);
+	struct pt_regs *regs = get_irq_regs() ? : task_pt_regs(tsk);
 
 	if (regs && user_mode(regs))
 		index = CPUACCT_STAT_USER;
-- 
2.11.0

