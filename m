Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D03C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 21:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB9B6206A2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 21:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XguNQg9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgDWVo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgDWVo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 17:44:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B14C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 14:44:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g13so8392841wrb.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 14:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jwBFGlISu+ZI6XDb9QeuV5Ui7R1Z+15tmGmCMSS0zGk=;
        b=XguNQg9JJtPS8hvqzI2G1Xm4c+PBj1/yeEH7i6KegSRtd+7M4T2zOW2a2f9XLS8XFG
         0UM/W4NW8LuACP/uC1j/Em6VD+khBcwacxoHt/6WqqWueHhXZ6bmJkukPYkfCiogESDD
         CXO8uuT/dH32fthuHJE70z853zoF+UgEDNaK8/Lfr1pmPNkHEKSTsYIdR+yepoV7dyQ7
         aY4YyNAetWvUTnef+jV6IZXJXnixwd4+luSpaPbMuqe1fzxFvf2kERibzfwO43R9czRr
         YheteCNxMU6k/3sxPaAskeCI7li//4+gE+69bQSiHvAWL+NKTKV8/+VTXM6Dv/xJYYNi
         JyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jwBFGlISu+ZI6XDb9QeuV5Ui7R1Z+15tmGmCMSS0zGk=;
        b=gHpWLxRm2Qior3vNdPFmIUaKzL8MpIwv/JD96D+Xbzyhc3pPQHmsyMaNXqduVN3Xhi
         b8b8AQPy2icOUPL0UEikIBPexljwk0fm1D20k51Y8ECkSjc2jbVckW0ts8a82Uy9Jf3a
         +q96PykEyyJ7kIOg5CQLsQl06pVK6ofc3cHEURD4QlorwTvp5qVL8HkPNrZBooBzFb28
         emtO91UBp6Tc2D4FXy9Y2ttNWlfsYg0P2QMbgJie/nX5N3kEzNsX141JrZwi65aZnHH1
         EihcgG9rrsokNKTAJ5o4RTG76KYBjF+BSvpVfLBbqIaEqk+wBDIJoBeFGP+wYWkqtYmX
         fUEA==
X-Gm-Message-State: AGi0PuacKrFtCOPisPPNKWfePC1rjFZPnJGJVD0hNPOdGhOiNvGGDf6+
        MJM23JSI+n7Gt0k+oqVINbDZ3PrJ
X-Google-Smtp-Source: APiQypIVAGS9RNUjvlnC1ewCJp3zn6pqACkaX3wlMXd72YepRmQ47CBfIWNgD8txasRip1c1eFuJwQ==
X-Received: by 2002:a5d:6b86:: with SMTP id n6mr7010213wrx.113.1587678297124;
        Thu, 23 Apr 2020 14:44:57 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id k9sm5652288wrd.17.2020.04.23.14.44.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Apr 2020 14:44:56 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] sched/core: not necessary to init root_task_group's common part for each cpu
Date:   Thu, 23 Apr 2020 21:44:43 +0000
Message-Id: <20200423214443.29994-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently root_task_group.shares and cfs_bandwidth are initialized for
each online cpu, which not necessary.

Let's take it out to do it only once.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5ca567adfcb9..613d6e892d80 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6642,6 +6642,8 @@ void __init sched_init(void)
 		root_task_group.cfs_rq = (struct cfs_rq **)ptr;
 		ptr += nr_cpu_ids * sizeof(void **);
 
+		root_task_group.shares = ROOT_TASK_GROUP_LOAD;
+		init_cfs_bandwidth(&root_task_group.cfs_bandwidth);
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 #ifdef CONFIG_RT_GROUP_SCHED
 		root_task_group.rt_se = (struct sched_rt_entity **)ptr;
@@ -6694,7 +6696,6 @@ void __init sched_init(void)
 		init_rt_rq(&rq->rt);
 		init_dl_rq(&rq->dl);
 #ifdef CONFIG_FAIR_GROUP_SCHED
-		root_task_group.shares = ROOT_TASK_GROUP_LOAD;
 		INIT_LIST_HEAD(&rq->leaf_cfs_rq_list);
 		rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
 		/*
@@ -6716,7 +6717,6 @@ void __init sched_init(void)
 		 * We achieve this by letting root_task_group's tasks sit
 		 * directly in rq->cfs (i.e root_task_group->se[] = NULL).
 		 */
-		init_cfs_bandwidth(&root_task_group.cfs_bandwidth);
 		init_tg_cfs_entry(&root_task_group, &rq->cfs, NULL, i, NULL);
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
-- 
2.23.0

