Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88785C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 00:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B989206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 00:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgHPAnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 20:43:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9738 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbgHPAnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 20:43:07 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A09C82E4AD79F8DA0C38;
        Sat, 15 Aug 2020 16:55:35 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Sat, 15 Aug 2020
 16:55:25 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>
CC:     <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] sched: Convert to use the preferred fallthrough macro
Date:   Sat, 15 Aug 2020 04:54:22 -0400
Message-ID: <20200815085422.39115-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the uses of fallthrough comments to fallthrough macro.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/sched/topology.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 007b0a6b0152..1bd7e3af904f 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1219,13 +1219,13 @@ static void __free_domain_allocs(struct s_data *d, enum s_alloc what,
 	case sa_rootdomain:
 		if (!atomic_read(&d->rd->refcount))
 			free_rootdomain(&d->rd->rcu);
-		/* Fall through */
+		fallthrough;
 	case sa_sd:
 		free_percpu(d->sd);
-		/* Fall through */
+		fallthrough;
 	case sa_sd_storage:
 		__sdt_free(cpu_map);
-		/* Fall through */
+		fallthrough;
 	case sa_none:
 		break;
 	}
-- 
2.19.1

