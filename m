Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69C1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DE7422B4D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWVVXC2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbgHTMBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729324AbgHTMBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 08:01:05 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF10BC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 05:00:59 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j21so1017411pgi.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 05:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vxEczYTbXFfqWxIphzoJ3nc1l42+2omdhsQaCW411K8=;
        b=kWVVXC2yGYpQ1Vne6si7j49TqNTF19uAbWYHcP/ygjWdkdfHWHi3a/SK3nx6wx8oaR
         96vOgRs/Inhj3nPo3EAB5VTY4iZwxhMxlPmqZh63ZOZ/iBiY6y0IwuLRM4BFsEgtPCMI
         fk8CqipMP6BoNsUBFJCltXA1Thm8MfaIICvHE+0qERL41JINezkGttbIIa4jmli8QT08
         LZCPzl7yFwqAucFYxOSp/xMvcxe5FUJDu/It5xBib/l4A8//vLfnWhygz5MRVNGQhBdN
         JufsBK+7ButP83fLNuINtiyTxMHSOl/tY4NwqWApG4QbRi7J1BotRtS7PRQpY6AAdcX4
         GZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vxEczYTbXFfqWxIphzoJ3nc1l42+2omdhsQaCW411K8=;
        b=DPLqx2RgnRpK0fSQCVa85yGI6QpV8D3ukAkC+jh0HOq1PXKZm1Sb8I/Mxt13IGac/d
         4lPbXrN90v5S4rJ7NPUghUd3BQutZ7ANrFdKBa2AYqMY1zIciPZ51978xlIyyEy2yjAT
         DgmtnYzZ7AtQPakJME/tBOpJkPxXZSwWXLCRohCq4D2WYhWLRIaTDn/fUuIdeF9H7aB0
         mVX22N+5q8+xLZtynrJ2L60Th9F5cVmXqP887kjHKxQ01jqABhg3P1yWbxLYIXPI0+c8
         M9kv2Hgvh27lVtLdRsh1eJ7hEu91uuMvMyXkpqjtkpeVGLPX9pZ9vLkcueQbSaLRtKkl
         bGcA==
X-Gm-Message-State: AOAM531HSl7MIZDFwIntaRa2Ba+ZQmSD24fNoUt+AQeOOWrDQiP2pSmp
        7tsTCkbxV/tVx1YKUMLvRQ5h2UBYQMiVYw==
X-Google-Smtp-Source: ABdhPJynfWO6HyWpdKBktyFIyEqBe0LH9o6AleQb+0o+e4duCBv+3NoJu2Vdj5laNHgC8pucZWRIEg==
X-Received: by 2002:aa7:96c5:: with SMTP id h5mr1958444pfq.195.1597924859495;
        Thu, 20 Aug 2020 05:00:59 -0700 (PDT)
Received: from localhost.localdomain ([103.7.29.7])
        by smtp.gmail.com with ESMTPSA id h193sm2407517pgc.42.2020.08.20.05.00.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 05:00:59 -0700 (PDT)
From:   Jiang Biao <benbjiang@gmail.com>
X-Google-Original-From: Jiang Biao <benbjiang@tencent.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        Jiang Biao <benbjiang@tencent.com>
Subject: [PATCH] sched/fair: avoid vruntime compensation for SCHED_IDLE task
Date:   Thu, 20 Aug 2020 20:00:25 +0800
Message-Id: <20200820120025.74460-1-benbjiang@tencent.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiang Biao <benbjiang@tencent.com>

Vruntime compensation has been down in place_entity() to
boot the waking procedure for fair tasks. There is no need to
do that for SCHED_IDLE task actually.

Not compensating vruntime for SCHED_IDLE task could make
SCHED_IDLE task more harmless for normal tasks.

Signed-off-by: Jiang Biao <benbjiang@tencent.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1a68a0536add..adff77676a0a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4115,7 +4115,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 		vruntime += sched_vslice(cfs_rq, se);
 
 	/* sleeps up to a single latency don't count. */
-	if (!initial) {
+	if (!initial && likely(!task_has_idle_policy(task_of(se)))) {
 		unsigned long thresh = sysctl_sched_latency;
 
 		/*
-- 
2.21.0

