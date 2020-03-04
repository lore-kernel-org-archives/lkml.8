Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CBCC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AD621741
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JT+yFrG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgCDPSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:18:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51817 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgCDPSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:18:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id a132so2531022wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 07:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sopjCc7otIA/K9Xwe3ZxbD5Bi8I07+57/M1L8O+OwaM=;
        b=JT+yFrG9MXK0CWi9wNlEWn38es/dbIpTyDQNxE7L50IBo+a0Z59Vr9PBmJWf2pQlYf
         Ld9jE2RPEnrzM6XhYpUVy7X2/Wt2lEQho9Hu9NuPoccEsIXXTtqhJVq6OHkHHuu19uVZ
         54/2Chhbmqs10mpJxx3YbDh/bibMCT/vnTKqbnBpwEEYlchraN3BAaNUoBnfM1vA0wl/
         pLnwvDQNK9m2PreNmN8E4I08FZodaSnMd6hv85O/Fl3UegYSDCB6Rw2XeXwhgZxAsok2
         tJTilP1QPcclONRmPaKnnF0yCIw8MhWffLDRCyZaueTGEOquP1gsepM/L0YVMT0KUjwi
         dlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sopjCc7otIA/K9Xwe3ZxbD5Bi8I07+57/M1L8O+OwaM=;
        b=HMHbaZwq6pJlZaMUL2OL6g/bUbmjsbS+ZI8MxxQ7IFk0bcytkwSW7ikLtZNcfb43ph
         6TupNGOhuBbpfaN+PJwtSwQXeyTZk9y/5fd7pAQqXDTAS1BvIJ8zY7k8GdVX/TnVG025
         UKHxbkoL9V0ePOFrLBL2L4VzE/onpJzN1hdZpf9mElo0+jnLN11Xc2m75DyDfSDxbLMA
         omAHxbHb+U/mmWeB428jORa35P3KQVVwfW2mKdkVHbGObx/0d6JFjI2wfoG1rXpQzc7a
         +dtkDZxhL/rDbOnOhUn6Io4efax90vCz+e3FB9cGt0zoTybMrK3fSprugiu0RUKELxdO
         Q2ng==
X-Gm-Message-State: ANhLgQ2J7p5Hmj0Q5j6FhyJGHmhxZoDAiUsb4KysEPifD0nOioSPp7vZ
        QUi+wreCNo2XN8/lcYtEZ0O1yLiG0J8=
X-Google-Smtp-Source: ADFU+vtW1FpBmeBT0MsPtvoankvYs+ReW52TULHQ9oETJvwPUjfWY0UiRhkGsfvXN/bjsbmXAkv2BA==
X-Received: by 2002:a1c:4681:: with SMTP id t123mr4246576wma.86.1583335079072;
        Wed, 04 Mar 2020 07:17:59 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:79d2:4161:5a2e:cf5c])
        by smtp.gmail.com with ESMTPSA id k126sm4425397wme.4.2020.03.04.07.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 07:17:58 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, valentin.schneider@arm.com,
        hdanton@sina.com, zhout@vivaldi.net,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair : fix reordering of enqueue_task_fair
Date:   Wed,  4 Mar 2020 16:17:48 +0100
Message-Id: <20200304151748.26135-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even when a cgroup is throttled, the group se of a child cgroup can still
be enqueued and its gse->on_rq stays true. When a task is enqueued on such
child, we still have to update the load_avg and increase h_nr_running of
the throttled cfs. Nevertheless, the 1st for_each_sched_entity loop is
skipped because of gse->on_rq == true and the 2nd loop because the cfs is
throttled whereas we have to update both load_avg with the old
h_nr_running and increment h_nr_running in such case.

Note that the update of load_avg will effectively happen only once in order
to sync with the throttled time. Next call for updating load_avg will stop
early because the clock stays unchanged.

Fixes: 6d4d22468dae ("sched/fair: Reorder enqueue/dequeue_task_fair path")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fcc968669aea..22d827fc46c3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5432,7 +5432,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		cfs_rq = cfs_rq_of(se);
 
 		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
+		if (!se->on_rq && cfs_rq_throttled(cfs_rq))
 			goto enqueue_throttle;
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
-- 
2.17.1

