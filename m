Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B38EC28CBC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B5C2075A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="AT1YnVi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgEGDLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 23:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728295AbgEGDLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 23:11:03 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5F6C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 20:11:01 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id b8so1353306plm.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 20:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLKE5lsx5SwaWEyA9+AGeYv3YbiLM647KJWineLVY5w=;
        b=AT1YnVi/QlGwrwZlMFXPJg0XP0Yg1/I7Q7vApg2pVTsoQTvFiq9XdZ+mnkigbplZP4
         2SkP8hZ2joK6cSgKD8Tz1BVy27oeh0Of51rV/WJIbhPpqbCIKEALMNcjGKLkRfC1/mx9
         kIZU63GJ1Gtyea2zrvhl9VngAQIcJbm0xlgrVqQTmlI7dIa73vNhjGhe+lYIvzhpuRXW
         Q5QwAPudz3DQunNQJKHfpwrVIoTe8DYYVO62dDmCiPd60j1JNNAJcnICcZdC3giLO25L
         l/4dYeuV3icEEWsIgf7t2GXOx1Ix+aJwj+1fgHGycibNEOmHVwN644yKF6IfVVQJqIJs
         tZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLKE5lsx5SwaWEyA9+AGeYv3YbiLM647KJWineLVY5w=;
        b=f4Wq0Oh/DoS4Fvav3RK1kB6+o2Uw2hE4JtrVsUCgyOUCNIO7tQa79Ls71009pL7Rlg
         4SK6tiLeoWwVLdiIKXwKAo6X1Eh0FjgbjOm2Ob9PViEpJrCSYyxTuN99kcjFaehw6hnz
         9DLHBzPLHt61xzmJEgVFO6XuUlq2ny92RDZ1CDaNorL4h+CLvez2iM6m1b3hVG0/SEwN
         xNQWvJkumKKx1FOJbrOWiDjT9lh0I6027MDZIw0QF+rUy/UhNN348SEVQuRUaguuuo79
         0lCVStH4HRf9I2WaD1oHpH6Yudbg69R1uP0OleTAgIeSeacgwJk/LkOvQCh84P9W52+j
         e6Lw==
X-Gm-Message-State: AGi0PuYuCt93WBy9QbU4BLclnv4epqPL2lU+MUeTSTrJLI1ZBxBVoQAV
        gRHMiYhGqjrnuJ9XnnuDE12JHg==
X-Google-Smtp-Source: APiQypIt8HrpFKFTMpnxUNHbF3+yA9MDBPiQ1IFNYa1zqeTCpTAG2qNgifabo+tSNtUh1Xl9YsjXzw==
X-Received: by 2002:a17:902:108:: with SMTP id 8mr11668340plb.200.1588821061137;
        Wed, 06 May 2020 20:11:01 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id a17sm3321109pfr.24.2020.05.06.20.10.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2020 20:11:00 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 RESEND] sched/cpuacct: Use __this_cpu_add() instead of this_cpu_ptr()
Date:   Thu,  7 May 2020 11:10:39 +0800
Message-Id: <20200507031039.32615-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpuacct_charge() and cpuacct_account_field() are called with
rq->lock held, and this means preemption(and IRQs) are indeed
disabled, so it is safe to use __this_cpu_*() to allow for better
code-generation.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
Chane in v2:
    1. Update changelog.

 kernel/sched/cpuacct.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 9fbb103834345..6448b0438ffb2 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -347,7 +347,7 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
 	rcu_read_lock();
 
 	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
-		this_cpu_ptr(ca->cpuusage)->usages[index] += cputime;
+		__this_cpu_add(ca->cpuusage->usages[index], cputime);
 
 	rcu_read_unlock();
 }
@@ -363,7 +363,7 @@ void cpuacct_account_field(struct task_struct *tsk, int index, u64 val)
 
 	rcu_read_lock();
 	for (ca = task_ca(tsk); ca != &root_cpuacct; ca = parent_ca(ca))
-		this_cpu_ptr(ca->cpustat)->cpustat[index] += val;
+		__this_cpu_add(ca->cpustat->cpustat[index], val);
 	rcu_read_unlock();
 }
 
-- 
2.11.0

