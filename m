Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1926CC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB7220870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbgBKOP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:15:59 -0500
Received: from foss.arm.com ([217.140.110.172]:46942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbgBKOP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:15:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76F3D30E;
        Tue, 11 Feb 2020 06:15:58 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9163E3F68F;
        Tue, 11 Feb 2020 06:15:57 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH] cgroup/cpuset: Fix a race condition when reading cpuset.*
Date:   Tue, 11 Feb 2020 14:15:54 +0000
Message-Id: <20200211141554.24181-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LTP cpuset_hotplug_test.sh was failing with the following error message

	cpuset_hotplug 1 TFAIL: root group's cpus isn't expected(Result: 0-5, Expect: 0,2-5).

Which is due to a race condition between cpu hotplug operation and
reading cpuset.cpus file.

When a cpu is onlined/offlined, cpuset schedules a workqueue to sync its
internal data structures with the new values. If a read happens during
this window, the user will read a stale value, hence triggering the
failure above.

To fix the issue make sure cpuset_wait_for_hotplug() is called before
allowing any value to be read, hence forcing the synchronization to
happen before the read.

I ran 500 iterations with this fix applied with no failure triggered.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---

I think it's okay to flush the workqueue from the read context? We do it on the
write, so I assumed it's okay on the read too. But it'd be good to confirm it
doesn't break any rule I'm not aware of.

 kernel/cgroup/cpuset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 58f5073acff7..593055522626 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2405,6 +2405,9 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
 	cpuset_filetype_t type = seq_cft(sf)->private;
 	int ret = 0;
 
+	/* Ensure all hotplug ops were done before reading any value */
+	cpuset_wait_for_hotplug();
+
 	spin_lock_irq(&callback_lock);
 
 	switch (type) {
-- 
2.17.1

