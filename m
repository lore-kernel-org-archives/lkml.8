Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E95C4BA1B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D5024670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgBZQma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:42:30 -0500
Received: from foss.arm.com ([217.140.110.172]:38934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgBZQm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:42:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5332031B;
        Wed, 26 Feb 2020 08:42:27 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BA2343F819;
        Wed, 26 Feb 2020 08:42:25 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        morten.rasmussen@arm.com, qperret@google.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/2] sched/topology: Don't enable EAS on SMT systems
Date:   Wed, 26 Feb 2020 16:41:17 +0000
Message-Id: <20200226164118.6405-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200226164118.6405-1-valentin.schneider@arm.com>
References: <20200226164118.6405-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EAS already requires asymmetric CPU capacities to be enabled, and mixing
this with SMT is an aberration, but better be safe than sorry.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/topology.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 00911884b7e7..76cd0a370b9a 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -360,6 +360,10 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
 		goto free;
 	}
 
+	/* EAS definitely does *not* handle SMT */
+	if (sched_smt_active())
+		goto free;
+
 	for_each_cpu(i, cpu_map) {
 		/* Skip already covered CPUs. */
 		if (find_pd(pd, i))
-- 
2.24.0

