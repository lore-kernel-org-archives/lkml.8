Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE37C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A499F2078B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgCTM6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:58:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35597 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgCTM6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:58:09 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFHDu-0003hP-3S; Fri, 20 Mar 2020 13:58:02 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A88181C22BF;
        Fri, 20 Mar 2020 13:58:01 +0100 (CET)
Date:   Fri, 20 Mar 2020 12:58:01 -0000
From:   "tip-bot2 for Dan Carpenter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Fix reversed NULL check in
 perf_event_groups_less()
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200312105637.GA8960@mwanda>
References: <20200312105637.GA8960@mwanda>
MIME-Version: 1.0
Message-ID: <158470908138.28353.6741541578450083595.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a6763625ae6f8aa5ee82fcd8fa4e5e38db20dbc6
Gitweb:        https://git.kernel.org/tip/a6763625ae6f8aa5ee82fcd8fa4e5e38db20dbc6
Author:        Dan Carpenter <dan.carpenter@oracle.com>
AuthorDate:    Thu, 12 Mar 2020 13:56:37 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Mar 2020 13:06:22 +01:00

perf/core: Fix reversed NULL check in perf_event_groups_less()

This NULL check is reversed so it leads to a Smatch warning and
presumably a NULL dereference.

    kernel/events/core.c:1598 perf_event_groups_less()
    error: we previously assumed 'right->cgrp->css.cgroup' could be null
	(see line 1590)

Fixes: 95ed6c707f26 ("perf/cgroup: Order events in RB tree by cgroup id")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200312105637.GA8960@mwanda
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b5a68d2..d22e4ba 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1586,7 +1586,7 @@ perf_event_groups_less(struct perf_event *left, struct perf_event *right)
 			 */
 			return true;
 		}
-		if (!right->cgrp || right->cgrp->css.cgroup) {
+		if (!right->cgrp || !right->cgrp->css.cgroup) {
 			/*
 			 * Right has no cgroup but left does, no cgroups come
 			 * first.
