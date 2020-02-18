Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A1BC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2136420801
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tlAxlN0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgBROpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:45:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38976 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgBROpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:45:41 -0500
Received: by mail-wm1-f67.google.com with SMTP id c84so3194604wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 06:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Dm++KgiZmzIoz3O/C9MxSRIxwKL4qLi+n4zUp5aZGPM=;
        b=tlAxlN0uE3ErB+aHj6HDUmSorZ6GTEcYOSTRfREJ9NPzN/JtBw3VrIuhIWcvn9aIc5
         rYTGyf5vaECjfXgPAwe/W/Z5SPM6HhQyL5iRxb2ZHrgFlB1ZKBqfNvfK7EcGqnsA56qh
         c2PRR+Duh7ToLWIJCVpZQ1kWb25v2Ej09txlDt1ScetF14xJWp27TafGJKZV7aX8cbZ0
         ONEquH+aYOn00n2Z30wzCNQKT+1jYf6PJQWSXJNxkrgzW0/eqTJZi3oP2qF1RSXPGK1J
         eqZC+swo0TJREb8U2eDr6daPLf+R+eh0WRPtO1USgY/Mb1RnmbZdjNMuO4xs+YMaNpLx
         N55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Dm++KgiZmzIoz3O/C9MxSRIxwKL4qLi+n4zUp5aZGPM=;
        b=p0wPTA+x0NlhnO7qRRALf4fSQqVXXcTsXRmILxTikM31jC95JOtvLfEuDhfa9mTamE
         kLZVbdiDOxyTfNEFGIDlutStjcv+uU5pzVgWHBtq77RZLNyfy7PVNrqV/YC2BjxSL1o+
         IYz154wv/ZoxPoeINjd9PPM1Ic/GLOW33I8D8wOgkTp2/k4pHp31PVngJAu/ScNDWT8m
         GJa1bGUsjhy3rY66Aou82W0RmDmxOpS1z1GAC5KdBsxkrNboG8PWuXyWQTxf89Rk8HWQ
         B183KyB2DDDfFhXpEZt3y5fjMG/kyGcECG6ldVqsFHhz3jJaGjMD9+3Fm84mK9geA7xo
         eIkQ==
X-Gm-Message-State: APjAAAXbNiJPIQX5Wuje0cXj5ermprcz/bQUIFEHlEdEkXRzI11AUcR2
        /WgJAEe9RzxiQAhNHO8GU1djbg==
X-Google-Smtp-Source: APXvYqxVcuws4XNX5QjelEIrPDX/Rf+PsiA49bwcLDSPaFaWv4tMW/RuBzCfCO5LFtCHH8DJJ+KCCw==
X-Received: by 2002:a05:600c:2c44:: with SMTP id r4mr3498992wmg.140.1582037138175;
        Tue, 18 Feb 2020 06:45:38 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:b988:85d8:294:141d])
        by smtp.gmail.com with ESMTPSA id o7sm3705403wmh.11.2020.02.18.06.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 06:45:36 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, valentin.schneider@arm.com,
        hdanton@sina.com, quentin.perret@arm.com,
        srikar@linux.vnet.ibm.com, riel@surriel.com,
        Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: fix statistics for find_idlest_group()
Date:   Tue, 18 Feb 2020 15:45:34 +0100
Message-Id: <20200218144534.4564-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sgs->group_weight is not set while gathering statistics in
update_sg_wakeup_stats(). This means that a group can be classified as
fully busy with 0 running tasks if utilization is high enough.

This path is mainly used for fork and exec.

Fixes: 57abff067a08 ("sched/fair: Rework find_idlest_group()")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a7e11b1bb64c..643ed6d8b8ff 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8354,6 +8354,8 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 
 	sgs->group_capacity = group->sgc->capacity;
 
+	sgs->group_weight = group->group_weight;
+
 	sgs->group_type = group_classify(sd->imbalance_pct, group, sgs);
 
 	/*
-- 
2.17.1

