Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE00C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90EF20714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbgBKSP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:15:27 -0500
Received: from foss.arm.com ([217.140.110.172]:51710 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729017AbgBKSPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 13:15:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F92C30E;
        Tue, 11 Feb 2020 10:15:25 -0800 (PST)
Received: from dell3630.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F40013F68E;
        Tue, 11 Feb 2020 10:15:23 -0800 (PST)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 1/2] drivers base/arch_topology: Remove 'struct sched_domain' forward declaration
Date:   Tue, 11 Feb 2020 19:15:14 +0100
Message-Id: <20200211181515.32570-2-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211181515.32570-1-dietmar.eggemann@arm.com>
References: <20200211181515.32570-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sched domain pointer argument from topology_get_freq_scale() and
topology_get_cpu_scale() got removed by commit 7673c8a4c75d
("sched/cpufreq: Remove arch_scale_freq_capacity()'s 'sd' parameter")
and commit 8ec59c0f5f49 ("sched/topology: Remove unused 'sd' parameter
from arch_scale_cpu_capacity()").

So the 'struct sched_domain' forward declaration is no longer needed.
Remove it.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
 include/linux/arch_topology.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 3015ecbb90b1..f4b1d4fd7efb 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -16,7 +16,6 @@ bool topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
 
 DECLARE_PER_CPU(unsigned long, cpu_scale);
 
-struct sched_domain;
 static inline
 unsigned long topology_get_cpu_scale(int cpu)
 {
-- 
2.17.1

