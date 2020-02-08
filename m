Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF286C35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 14:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81EAC217BA
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 14:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xj7br3Cn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgBHOr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 09:47:28 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43390 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbgBHOr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 09:47:28 -0500
Received: by mail-pg1-f195.google.com with SMTP id u131so1371092pgc.10
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 06:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bnds2NHqFSNWETn/RSq50/pXatc/ztN0cLMrVRUxkUU=;
        b=Xj7br3CnVPxHIhw8uOFA5f70SvXfdioQ2O93Aadvt9BvpCZRic7FVB32guF5lnBMS+
         CU9rUvQovegjrRi98LW1H7ntRM9b9NUxVgpnqyBsv91UMxKzf5qClcasOAR/qYydN81+
         O/lUtc0pFPnlvzImTPqrbWtdO0DpgkxfODSvqSiirLvOSoiHwKWwpdO4NZaNq1DWU2lW
         KFT6Xgeg1LdtCoMbsl+AkDmGVmL75Yp9pnhyObj5jAQWVV3g9dIUCsjHTqAzONw7hjSE
         zl/zIEGfnGPftdx3B/iOSzNYtBl2/7dSfqmDaPkE5e0anLvgeLCNyJ2JdZcAa5L/+m8a
         oPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bnds2NHqFSNWETn/RSq50/pXatc/ztN0cLMrVRUxkUU=;
        b=VW8fC83ueCjv8xfKbT4Gn8nObpKhh5qnHPVFc+ltjoo7I8nAIZd6fB7MpRik65KNxY
         iB6DbafWeD2H+pl8tnzE9VzXXqO9CAA2WEU34vfeQl5PZc1dUNFeBkQxfAU5389DmOAD
         sL+dFf0irkERFDf7Brjb8B818+N3nnvwRdkLqMPGuNq/P5NIvjD6l8uETUyPOJUfAHXv
         KU2arpqqcodDtm9s+bV9snvyVOx0CTfaNtZZ8f4ewpUGVy+OTiABW2+0bObB75n6d8OA
         G9qcg65htVqCcNoAvFhXfNJ7eM9n8v5aFU1XsaatAMEdV6rIPJbRwlUYA7RsyoKVy1Kl
         FwJQ==
X-Gm-Message-State: APjAAAXcKQPdz1djqOWiz11Tr+DpLALaSD7pu7KjmuGZcuB6j03uGtzI
        bxJPGrfv6/TFYu5+uyhi8d6A1CcIGm8IsQ==
X-Google-Smtp-Source: APXvYqy5IbKxoaPJD/HvfsAxaGYzvw1KtJ98ESXByWVCM6KLuM/SppRuSoOuizLrX4gcUIY0z9/NbQ==
X-Received: by 2002:aa7:87c5:: with SMTP id i5mr4569744pfo.114.1581173247433;
        Sat, 08 Feb 2020 06:47:27 -0800 (PST)
Received: from localhost.localdomain ([146.196.37.145])
        by smtp.googlemail.com with ESMTPSA id k29sm7188817pfh.77.2020.02.08.06.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2020 06:47:27 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH] events: Annotate parent_ctx with __rcu
Date:   Sat,  8 Feb 2020 20:16:49 +0530
Message-Id: <20200208144648.18833-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

parent_ctx is used under RCU context in kernel/events/core.c,
tell sparse about it aswell.

Fixes the following instances of sparse error:
kernel/events/core.c:3221:18: error: incompatible types in comparison
kernel/events/core.c:3222:23: error: incompatible types in comparison

This introduces the following two sparse errors:
kernel/events/core.c:3117:18: error: incompatible types in comparison
kernel/events/core.c:3121:30: error: incompatible types in comparison

Hence, use rcu_dereference() to access parent_ctx and silence
the newly introduced errors.

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 include/linux/perf_event.h |  2 +-
 kernel/events/core.c       | 11 ++++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 6d4c22aee384..e18a7bdc6f98 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -810,7 +810,7 @@ struct perf_event_context {
 	 * These fields let us detect when two contexts have both
 	 * been cloned (inherited) from a common ancestor.
 	 */
-	struct perf_event_context	*parent_ctx;
+	struct perf_event_context __rcu	*parent_ctx;
 	u64				parent_gen;
 	u64				generation;
 	int				pin_count;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2173c23c25b4..2a8c5670b254 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3106,26 +3106,31 @@ static void ctx_sched_out(struct perf_event_context *ctx,
 static int context_equiv(struct perf_event_context *ctx1,
 			 struct perf_event_context *ctx2)
 {
+	struct perf_event_context *parent_ctx1, *parent_ctx2;
+
 	lockdep_assert_held(&ctx1->lock);
 	lockdep_assert_held(&ctx2->lock);
 
+	parent_ctx1 = rcu_dereference(ctx1->parent_ctx);
+	parent_ctx2 = rcu_dereference(ctx2->parent_ctx);
+
 	/* Pinning disables the swap optimization */
 	if (ctx1->pin_count || ctx2->pin_count)
 		return 0;
 
 	/* If ctx1 is the parent of ctx2 */
-	if (ctx1 == ctx2->parent_ctx && ctx1->generation == ctx2->parent_gen)
+	if (ctx1 == parent_ctx2 && ctx1->generation == ctx2->parent_gen)
 		return 1;
 
 	/* If ctx2 is the parent of ctx1 */
-	if (ctx1->parent_ctx == ctx2 && ctx1->parent_gen == ctx2->generation)
+	if (parent_ctx1 == ctx2 && ctx1->parent_gen == ctx2->generation)
 		return 1;
 
 	/*
 	 * If ctx1 and ctx2 have the same parent; we flatten the parent
 	 * hierarchy, see perf_event_init_context().
 	 */
-	if (ctx1->parent_ctx && ctx1->parent_ctx == ctx2->parent_ctx &&
+	if (ctx1->parent_ctx && parent_ctx1 == parent_ctx2 &&
 			ctx1->parent_gen == ctx2->parent_gen)
 		return 1;
 
-- 
2.24.1

