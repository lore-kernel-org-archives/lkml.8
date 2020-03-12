Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4018EC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B811206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xdfkgIKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgCLQym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 12:54:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39459 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgCLQyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 12:54:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id f7so7151880wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 09:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SArDM61DxsV/GfIWell/Cxt1WwRsKAiACjdjeXTddrQ=;
        b=xdfkgIKDq/iyo0jVzHfWYkFQBzAhD+amF2xVuFZiZuPFBLkNKlPqzVR/U4w6ISbDy1
         34r7Max0IjBk7BZbBcrlubWi4PBD4s2cJ54a9tHl+X9eb+SLAiKZFIApKq9q7Eh3PjeU
         dWmyrehxec3cI3q2IhUjBgTf0oQqxWr+jvgHI+XUM5rz104CVwxX363QqpEHhRRegATb
         37YRG45gRy5fMwn4BNhGSwEfocGasGpwFCfFsSe7sgs87+l1KUbeZgPzul+244z+5WOK
         oT3MnAXNwMSpwMRG1s4OJhRMGQY/HBEBvoWPzIP4TGJHbph/UU3CFy9c1YW/CJ3Rm/uo
         O8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SArDM61DxsV/GfIWell/Cxt1WwRsKAiACjdjeXTddrQ=;
        b=rmivPA+NwpoX/a09HaDVvh7q0iemocNG8UjwUbgjSkd2NkGHfQ1++557UVL00L/hHx
         O/S30dE7e4QJURYfQgwXYP7eFEATIZnPfd/yBUJEgxoFWkYTPPDCXH2HsFxbtQ2HhpzV
         pzIDJUN/cWgrA6tpdketUx5un6UzwMVaoa/TVlwJXTMGWqi/mY5YGpjKOeIrNLXZKs3t
         WwSnM/4bcsL2g6AysucWhmEwPa37t2MK6GGAY16YovrR7YnQ2Fud64H0I68x3Ap/h6We
         4rdsey8qvOEvVlC464CV/yb71AO2U2G/LkqESimm+pvKDWM/Ai7LwY/1VwpxeKZDk/x/
         bEqA==
X-Gm-Message-State: ANhLgQ1sxkfZfG6ZlL6OwKBXxDkVcvM5QwYMH64FgwLS8GKZFEWf6Z45
        3HnOasj8Fw7V9AC6s6Ah/CQx2w==
X-Google-Smtp-Source: ADFU+vvO/mQyWf1rzzDFXOfoL87wwi34LMOyqMTw2r+lLghq5vklIPIotAJ6X2CWp3yj5KpPIpUm0w==
X-Received: by 2002:a7b:c3d1:: with SMTP id t17mr5649753wmj.27.1584032077771;
        Thu, 12 Mar 2020 09:54:37 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:e531:1d0b:d2d6:94d6])
        by smtp.gmail.com with ESMTPSA id t81sm12818786wmb.15.2020.03.12.09.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 09:54:36 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: improve spreading of utilization
Date:   Thu, 12 Mar 2020 17:54:29 +0100
Message-Id: <20200312165429.990-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During load_balancing, a group with spare capacity will try to pull some
utilizations from an overloaded group. In such case, the load balance
looks for the runqueue with the highest utilization. Nevertheless, it
should also ensure that there are some pending tasks to pull otherwise
the load balance will fail to pull a task and the spread of the load will
be delayed.

This situation is quite transient but it's possible to highlight the
effect with a short run of sysbench test so the time to spread task impacts
the global result significantly.

Below are the average results for 15 iterations on an arm64 octo core:
sysbench --test=cpu --num-threads=8  --max-requests=1000 run

                           tip/sched/core  +patchset
total time:                172ms           158ms
per-request statistics:
         avg:                1.337ms         1.244ms
         max:               21.191ms        10.753ms

The average max doesn't fully reflect the wide spread of the value which
ranges from 1.350ms to more than 41ms for the tip/sched/core and from
1.350ms to 21ms with the patch.

Other factors like waiting for an idle load balance or cache hotness
can delay the spreading of the tasks which explains why we can still
have up to 21ms with the patch.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3c8a379c357e..97a0307312d9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9025,6 +9025,14 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		case migrate_util:
 			util = cpu_util(cpu_of(rq));
 
+			/*
+			 * Don't try to pull utilization from a CPU with one
+			 * running task. Whatever its utilization, we will fail
+			 * detach the task.
+			 */
+			if (nr_running <= 1)
+				continue;
+
 			if (busiest_util < util) {
 				busiest_util = util;
 				busiest = rq;
-- 
2.17.1

