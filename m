Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111B7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB5AD206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgGGHdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:33:43 -0400
Received: from mail.windriver.com ([147.11.1.11]:41411 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGHdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:33:43 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 0677X0fZ013531
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 7 Jul 2020 00:33:00 -0700 (PDT)
Received: from pek-lpg-core1-vm1.wrs.com (128.224.156.106) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Tue, 7 Jul 2020 00:32:59 -0700
From:   <qiang.zhang@windriver.com>
To:     <ben.dooks@codethink.co.uk>, <bfields@redhat.com>,
        <cl@rock-chips.com>, <peterz@infradead.org>, <pmladek@suse.com>,
        <tj@kernel.org>
CC:     <akpm@linux-foundation.org>, <naresh.kamboju@linaro.org>,
        <mm-commits@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] kthread: Work could not be queued when worker being destroyed
Date:   Mon, 6 Jul 2020 13:46:47 +0800
Message-ID: <20200706054647.5344-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Qiang <qiang.zhang@windriver.com>

Before the work is put into the queue of the worker thread,
the state of the worker thread needs to be detected,because
the worker thread may be in the destruction state at this time.

Signed-off-by: Zhang Qiang <qiang.zhang@windriver.com>
Suggested-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 v1->v2:
 Add warning information for condition "!worker->task".
 v2->v3:
 Modify submission information and add "Reviewed-by" tags.
 v3->v4:
 Fix spi controller register trigger Warning.
 when a spi controller register, a "kthread_worker_fn" worker is created
 through "kthread_run" instead of "kthread_create_worker" which in this
 func the "worker->task" will be initialized. and then the "spi_start_queue"
 func queue a work to worker queue, at this time, if the worker has not
 begin to running, the "!worker->task" will be true, so a warning is triggered.

 kernel/kthread.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index bfbfa481be3a..825bd4dcdb95 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -791,6 +791,11 @@ static inline bool queuing_blocked(struct kthread_worker *worker,
 {
 	lockdep_assert_held(&worker->lock);
 
+	if (kthread_should_stop()) {
+		WARN_ON(1);
+		return true;
+	}
+
 	return !list_empty(&work->node) || work->canceling;
 }
 
-- 
2.24.1

