Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94699C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68F352067B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBaBacY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgFJOFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgFJOFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:05:49 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BB2C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 07:05:48 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q24so935532pjd.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 07:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hGRBzLYTvk6qctnbR0AAuYYEWEijsEhuh26BzXivYyE=;
        b=RBaBacY6WugYS0bLFx8FhVLK/lGQtqsLHxgcfIUe0i8Q5Q3FrsltScAgEGzcjTc9nO
         MrUJtZbVgEK+mpUhPL2EiVF6gMarst7npIi+boALCPpr6M2J3dHumHCbjPEq/XQ4lreX
         01frb//n2TU9S72m2DqUOKjveZw8Sshk5TkGCrWwQJFXlbTPG6WBbXfPzp9quQ3Fzeoo
         2Z1uhwqIX1+zBVX6vYBfN8YtBAHTng/INiVYLkQaesZw6r2jo8xMTniTUiT9TyCUijb6
         pIBAVhA7TFJzUkHy+AwF6quhYWWJaa3mMA1vdMiTQr+zlUVMx+nxSiU44Mcqx2Ms2r7A
         Oe2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hGRBzLYTvk6qctnbR0AAuYYEWEijsEhuh26BzXivYyE=;
        b=eFnlDzxple0/P4zGOPe/CxG3YUTYXHcknGxZMUNmQWOMY6csbw0L+7H9ARTIC0TnQo
         26/nbVDuQAudA1bXDrgfOWp8t1W0h1GOpYyjxJ9gdcycBSYDldD9BnlGWYNI3nqvKdSu
         6Wjhj5KbX2U581e67EFdbOH945o7YOdRPi7XQZVKnY6l0IIctDdPVTkuF53T5JpdJVne
         DZXAdC+dxDwIPDqfGPV6P2Ccizcnoz2zPVi3+gw0xz6S7k+BQip4UksinQcVuUWygaqK
         Rx291zOMb0bP7VAuYGtKvopDwMdJXGJ+b3ydMsDhmcBhnazYCn+7uOFj8od9rCN5yDXQ
         0c7Q==
X-Gm-Message-State: AOAM532RJGbc4cjpcnDr7Ehpd9vZS55m7kwxZkmSNTr5WV1UlhsQDN3b
        73Om1Ou+lpeRm4rMa17cI9g=
X-Google-Smtp-Source: ABdhPJyHFVWemzxpR7kGPJ3Pgjvye1z01A+7hv+M6xskPiz0QIZnvJcTkNvMnzMNRtdrI+hncgGMUw==
X-Received: by 2002:a17:90b:110f:: with SMTP id gi15mr3421975pjb.87.1591797947896;
        Wed, 10 Jun 2020 07:05:47 -0700 (PDT)
Received: from localhost.localdomain ([133.186.134.241])
        by smtp.gmail.com with ESMTPSA id h35sm5836374pje.29.2020.06.10.07.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 07:05:47 -0700 (PDT)
From:   Qi Zheng <arch0.zheng@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, Qi Zheng <arch0.zheng@gmail.com>
Subject: [PATCH] sched/fair: Fix comment in newidle_balance()
Date:   Wed, 10 Jun 2020 22:05:37 +0800
Message-Id: <20200610140537.208712-1-arch0.zheng@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code is using newidle_balance() rather than idle_balance().

Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0ed04d2a8959..7f9c3245c967 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10434,7 +10434,7 @@ static inline void nohz_newidle_balance(struct rq *this_rq) { }
 #endif /* CONFIG_NO_HZ_COMMON */
 
 /*
- * idle_balance is called by schedule() if this_cpu is about to become
+ * newidle_balance() is called by schedule() if this_cpu is about to become
  * idle. Attempts to pull tasks from other CPUs.
  *
  * Returns:
@@ -10452,8 +10452,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 	update_misfit_status(NULL, this_rq);
 	/*
-	 * We must set idle_stamp _before_ calling idle_balance(), such that we
-	 * measure the duration of idle_balance() as idle time.
+	 * We must set idle_stamp _before_ calling newidle_balance(), such that
+	 * we measure the duration of newidle_balance() as idle time.
 	 */
 	this_rq->idle_stamp = rq_clock(this_rq);
 
-- 
2.25.1

