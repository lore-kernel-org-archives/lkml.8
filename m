Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26EFC34031
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A412524654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7/L3Mtq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgBTH3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 02:29:52 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34480 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgBTH3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:29:52 -0500
Received: by mail-pg1-f195.google.com with SMTP id j4so1497676pgi.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 23:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=V5a5nkaIf0HT8qJIpZePaPQkNs+UktEkTD5ZQItlrz0=;
        b=M7/L3MtqtACa5TM5P0XiTAXlWEFWkRJgJo4BLducH0mt/IBGh0+HGzjg0oVHViWoSl
         EAz+ZlcCaL9fKg92gphPJC05lYY97P9w62RIcJK/lCTuMInADU8mHIxVM//yzWPtnV0/
         L0fgVLwxWnefdVKcZvwrYHEFOQe+hy0D+3QMvSRjnhcn1lhFwQLYB77yDKMHKVLDPCoL
         v0MNi7oTMRFoJ11NMDVpz2ERgG9NzwC+jXqePiFmMMeMFN0+TgYzh08mzDkml5PO3PcY
         6d/wBie0mRVVrlmZoYuTwj83K7m9A/EKqpF5R0/xa3zahSm5TiVl/txTk7R7mYyVxOCR
         tiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V5a5nkaIf0HT8qJIpZePaPQkNs+UktEkTD5ZQItlrz0=;
        b=n7+jy5G7/r78bqMobkFv5IBRn1GFsJlYniYBuayzDs2DWNtNb3Itk86bYVu8agT57M
         kE5rg38xtHuu0NiPEdLOD2RJnAlBXaJ2zInNxlAJAgVA9FVEp+hqcttwx2SBWSuJzxG6
         QvzAnMmcNXJiWp1wuqmB0NGxK+KOMFFRNCGQHczKEwAFI6pA2bcf5s/QLzgNd9nv/4GO
         tQP5k+tB7bfabWOY08r96O029RZiz08c2/I6Hzj9VYEoDLbKR6dCYnVhPjgXKh8Sa6sU
         p8viFODlQ/sKX3fV1NwuVhV2FKY5xGZoV/zCX9iSxp902oGAIy6GZ2xC4YaVUkXPDt3h
         8w0g==
X-Gm-Message-State: APjAAAWuQPi3H0lii0eTDUfGgBhb+loSPwPerY2Z44EqGbCFFU0QyEMp
        qMTRu7mogEJa0w8B2Mnmpcs=
X-Google-Smtp-Source: APXvYqzjQ1d1OPQqPVFCXRsEvKPBWAOVZnkYeZzZYCZCla6Ueib0RLthtN5qv/3AzdwBDCfnYmMJ7A==
X-Received: by 2002:a63:5f4e:: with SMTP id t75mr31243981pgb.7.1582183791368;
        Wed, 19 Feb 2020 23:29:51 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id r11sm2262936pgi.9.2020.02.19.23.29.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 19 Feb 2020 23:29:50 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH] sched/fair: add !se->on_rq check before dequeue entity
Date:   Thu, 20 Feb 2020 15:29:44 +0800
Message-Id: <1582183784-13502-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

We igonre checking for !se->on_rq condition before dequeue one
entity from cfs rq. It must be required in case the entity has
been dequeued.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3c8a379..945dcaf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5341,6 +5341,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	bool was_sched_idle = sched_idle_rq(rq);
 
 	for_each_sched_entity(se) {
+		if (!se->on_rq)
+			break;
 		cfs_rq = cfs_rq_of(se);
 		dequeue_entity(cfs_rq, se, flags);
 
-- 
1.9.1

