Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5151CC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E61B20644
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="E0L0gFMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502322AbgDPJOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502201AbgDPIbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:31:11 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D93C03C1AA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:30:49 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n10so1350237pff.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLKE5lsx5SwaWEyA9+AGeYv3YbiLM647KJWineLVY5w=;
        b=E0L0gFMenYipGpqMJTyjfrUSWFiOP83B8e3kPCSBf6dL1TJCYsTK8cDGDjOS3cMT8c
         5T2Gj0p2io9+akp03jF/IQpQyRLTmXOU9wK3o0UPXfixUJHBMr0n2dODuPdkxYf/oMza
         Iiq22NTBYNiIpKDopNL0RIZbyyWNcaWhjkjcTYMF8IIIl99lJyhCI1x07gYmVoeZAaw3
         Dxu9QT2uq9LwBIbfDQ86PG0HGD76QsHb/iPniqeu5e906dfIT9l6S+I2qYDHwYgvOR0O
         YE4Go3S/pKfK5MQ4uHPzfvCkgi3maMSNqCo/Uc9curCr5Oim8d5WeXpwBNESqPKdMg9x
         GUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLKE5lsx5SwaWEyA9+AGeYv3YbiLM647KJWineLVY5w=;
        b=QMsvdd9w2x+vkH7bcwOfjPe/qJE1VHZWLQNODlT96X4C+6TCgBLonC4xpLX3gvbTOw
         oITtlSwos7O3m7vvuPXSilXdPQG5QcmruMgLA+hTfA+uOnImqbh1i180jBaxu5fpPGz/
         s+lOUhvsy1C2G7HBs5+SwLwFJGBMFwd3ugsBN3B3oEMZe1p7I7zCCkke6WYLamhhV9cX
         ydzqSviokaEq86ExL9lPQf9zvggh9n1CSCbXUZPqPKujjQB9s4fClgpYv/8Ktet9xYv3
         Ehk3+ZdpaP2J2jyjwTGMqFykwlGg0OBFyqu+fSAezQ3oHENOM5mHOaUmYLAgqRTS01c6
         JSDw==
X-Gm-Message-State: AGi0PuaYYeZZe4Pml6kQyIni547G4TAekASedzONkqeRvu5eV5c5gRcw
        avtac8eSkzdr7zn8AYtH2j4fgQ==
X-Google-Smtp-Source: APiQypJEoAQxZEfi7kmL+uXpcDYh5L5u+UHKejPp3YAMKG7CMCn7qaBzYy4Bz3QYcqZTq1W52hetZQ==
X-Received: by 2002:aa7:80d5:: with SMTP id a21mr12529408pfn.49.1587025849344;
        Thu, 16 Apr 2020 01:30:49 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.220.69])
        by smtp.gmail.com with ESMTPSA id z12sm16723291pfj.144.2020.04.16.01.30.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 01:30:48 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] sched/cpuacct: Use __this_cpu_add() instead of this_cpu_ptr()
Date:   Thu, 16 Apr 2020 16:29:57 +0800
Message-Id: <20200416082957.40691-1-songmuchun@bytedance.com>
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

