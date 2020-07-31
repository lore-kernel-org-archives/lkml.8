Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A62C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A8D220663
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733129AbgGaMFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:05:37 -0400
Received: from foss.arm.com ([217.140.110.172]:56250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732909AbgGaMFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:05:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9356B1FB;
        Fri, 31 Jul 2020 05:05:14 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6EEA33F71F;
        Fri, 31 Jul 2020 05:05:13 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, Quentin Perret <qperret@google.com>
Subject: [PATCH v4 08/10] sched/topology: Remove SD_SERIALIZE degeneration special case
Date:   Fri, 31 Jul 2020 12:55:00 +0100
Message-Id: <20200731115502.12954-9-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200731115502.12954-1-valentin.schneider@arm.com>
References: <20200731115502.12954-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is only a single NUMA node in the system, the only NUMA topology
level that will be generated will be NODE (identity distance), which
doesn't have SD_SERIALIZE.

This means we don't need this special case in sd_parent_degenerate(), as
having the NODE level "naturally" covers it. Thus, remove it.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/topology.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 93a7ff52335b..c6ecc395c76c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -204,8 +204,6 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 			    SD_SHARE_PKG_RESOURCES |
 			    SD_OVERLAP |
 			    SD_PREFER_SIBLING);
-		if (nr_node_ids == 1)
-			pflags &= ~SD_SERIALIZE;
 	}
 	if (~cflags & pflags)
 		return 0;
-- 
2.27.0

