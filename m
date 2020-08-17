Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8077C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 766542072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693840;
	bh=o1hp91tWbFC0JPymhREMXQpAYm591TzRF4KoNiOC+jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=syX2f0sGY3Tb1hlYppcWC6KNry+wjKG4+RRFp1EAGHCxF4oxvAWgVB7jWU+5Sd4t9
	 aOtCj1JD5Lmo+Uq300wWlvXlIB9siFMdPgGRf3eEY/KenOEQOAeYBq9d9AzUmHIciZ
	 HILgmRIsHJKARdOhQfy+10hVzFnqkx9qF7I895is=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404436AbgHQTua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:50:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729225AbgHQPT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:19:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 495352076E;
        Mon, 17 Aug 2020 15:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677567;
        bh=o1hp91tWbFC0JPymhREMXQpAYm591TzRF4KoNiOC+jo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w74iwkooCq1tABzvT4GiCcXlAV5KOrd80zLS2qiVvXCFhqhYQPToOqPXg4JTGf4u5
         DTpsAXdBOJ5FuZQWBM7W4buetsgFAkSyESKl6IcpXQp6tKcAu0Sf9P3AVH2OMvdatv
         6bw5YhrroDng9+dPu+IRlj9/1UU3BP405N1U+lJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 029/464] sched/uclamp: Fix initialization of struct uclamp_rq
Date:   Mon, 17 Aug 2020 17:09:42 +0200
Message-Id: <20200817143835.152292709@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qais Yousef <qais.yousef@arm.com>

[ Upstream commit d81ae8aac85ca2e307d273f6dc7863a721bf054e ]

struct uclamp_rq was zeroed out entirely in assumption that in the first
call to uclamp_rq_inc() they'd be initialized correctly in accordance to
default settings.

But when next patch introduces a static key to skip
uclamp_rq_{inc,dec}() until userspace opts in to use uclamp, schedutil
will fail to perform any frequency changes because the
rq->uclamp[UCLAMP_MAX].value is zeroed at init and stays as such. Which
means all rqs are capped to 0 by default.

Fix it by making sure we do proper initialization at init without
relying on uclamp_rq_inc() doing it later.

Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcounting")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lkml.kernel.org/r/20200630112123.12076-2-qais.yousef@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2142c67676826..c3cbdc436e2e4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1237,6 +1237,20 @@ static void uclamp_fork(struct task_struct *p)
 	}
 }
 
+static void __init init_uclamp_rq(struct rq *rq)
+{
+	enum uclamp_id clamp_id;
+	struct uclamp_rq *uc_rq = rq->uclamp;
+
+	for_each_clamp_id(clamp_id) {
+		uc_rq[clamp_id] = (struct uclamp_rq) {
+			.value = uclamp_none(clamp_id)
+		};
+	}
+
+	rq->uclamp_flags = 0;
+}
+
 static void __init init_uclamp(void)
 {
 	struct uclamp_se uc_max = {};
@@ -1245,11 +1259,8 @@ static void __init init_uclamp(void)
 
 	mutex_init(&uclamp_mutex);
 
-	for_each_possible_cpu(cpu) {
-		memset(&cpu_rq(cpu)->uclamp, 0,
-				sizeof(struct uclamp_rq)*UCLAMP_CNT);
-		cpu_rq(cpu)->uclamp_flags = 0;
-	}
+	for_each_possible_cpu(cpu)
+		init_uclamp_rq(cpu_rq(cpu));
 
 	for_each_clamp_id(clamp_id) {
 		uclamp_se_set(&init_task.uclamp_req[clamp_id],
-- 
2.25.1



