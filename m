Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF33C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F7C2467D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="joMsms6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387723AbgBNP14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:27:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46871 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387686AbgBNP1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:27:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so11333827wrl.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 07:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iYvYMYE05nTlj34sxQLRowXhHtQfF/A1SvlH01JVT4o=;
        b=joMsms6GuQIXYUOUpESrbYJQqEDRlvLa9rCEsf81UBaXMMW9RMnM/4w57Ux7Y+thcF
         w0/977BNPX73eHbfqqWBbguaKNtsWK5VqIkW6+p/JozNBExqpJ0g6G4yJ46xkY+le4SL
         rnRhE0VPo9CI0pnGQuhuwvmPRKpp/nf/zyNjop4rnowf78OSWkFSVHsiU7gR1cV+R3dt
         tat2tWRjv11ZizxbWHsLEQt9DlQ4KmE3g+dNl2Hh4TlUZgmdduVMFR3kIruuqDQjvh2K
         Pctdp1iElQNgdbQghu9QwbnrkfAz0bQ7RWJil0LUX4nTptZAM20RPqljc+kI6tJH0bmH
         BvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iYvYMYE05nTlj34sxQLRowXhHtQfF/A1SvlH01JVT4o=;
        b=L7z3BnW7xY8CrHPZ+ozcQNVc6ifBTosreyUyRyhlszCH6xM0Htb5fp2RtYTcEXbhn/
         Lql0aw5xTkbsdsotqNIH02NtSHzp3Epn6WqtqLcwmZb/XCghHRAiNGJC3lImgjgeg/U5
         Ck5U7WHNURm4vHLC6yqEqFXT8Fp/TG7JdTMEYJVVPm+K1xmXq+eHuA8OB0r7jg2mV3tr
         Wc3L6y8riwjXdjhDHL44DevjughY9jk2ayeLKJY+pSw37+rO19azJQKstL0rfoPB9uh0
         EoilQyi6nljNOIzsbRCVzmyCuyZk2aWu/JFM30J9GC2gVYtbbBvU8x9JdAWawyjtxpKf
         O1gg==
X-Gm-Message-State: APjAAAWtubkfjdPcHRermYEzLEA6O9Y9FIIrWdfE8WLwhFu8elnxaoHa
        Tgwib5MnL9JvtANyfv53laiBwg==
X-Google-Smtp-Source: APXvYqz7QGTkDdLoHNaZZvBbxuCuu0XiKHI/gKVitd+WyRt+wEjdpN4D2C1Xrkm5bWMfFZnXUD1Ojg==
X-Received: by 2002:adf:f44a:: with SMTP id f10mr4824396wrp.16.1581694068577;
        Fri, 14 Feb 2020 07:27:48 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:b5b3:5d19:723a:398f])
        by smtp.gmail.com with ESMTPSA id c13sm7442963wrn.46.2020.02.14.07.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 07:27:47 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, valentin.schneider@arm.com,
        hdanton@sina.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 5/5] sched/fair: Take into account runnable_avg to classify group
Date:   Fri, 14 Feb 2020 16:27:29 +0100
Message-Id: <20200214152729.6059-6-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200214152729.6059-1-vincent.guittot@linaro.org>
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take into account the new runnable_avg signal to classify a group and to
mitigate the volatility of util_avg in face of intensive migration.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3b6a90d6315c..99249a2484b4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7718,7 +7718,8 @@ struct sg_lb_stats {
 	unsigned long avg_load; /*Avg load across the CPUs of the group */
 	unsigned long group_load; /* Total load over the CPUs of the group */
 	unsigned long group_capacity;
-	unsigned long group_util; /* Total utilization of the group */
+	unsigned long group_util; /* Total utilization over the CPUs of the group */
+	unsigned long group_runnable; /* Total runnable time over the CPUs of the group */
 	unsigned int sum_nr_running; /* Nr of tasks running in the group */
 	unsigned int sum_h_nr_running; /* Nr of CFS tasks running in the group */
 	unsigned int idle_cpus;
@@ -7939,6 +7940,10 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
 	if (sgs->sum_nr_running < sgs->group_weight)
 		return true;
 
+	if ((sgs->group_capacity * imbalance_pct) <
+			(sgs->group_runnable * 100))
+		return false;
+
 	if ((sgs->group_capacity * 100) >
 			(sgs->group_util * imbalance_pct))
 		return true;
@@ -7964,6 +7969,10 @@ group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
 			(sgs->group_util * imbalance_pct))
 		return true;
 
+	if ((sgs->group_capacity * imbalance_pct) <
+			(sgs->group_runnable * 100))
+		return true;
+
 	return false;
 }
 
@@ -8058,6 +8067,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 		sgs->group_load += cpu_load(rq);
 		sgs->group_util += cpu_util(i);
+		sgs->group_runnable += cpu_runnable(rq);
 		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
 
 		nr_running = rq->nr_running;
-- 
2.17.1

