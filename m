Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA73C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E15F2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgBJPYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:24:41 -0500
Received: from foss.arm.com ([217.140.110.172]:35174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727429AbgBJPYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:24:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 782AD1FB;
        Mon, 10 Feb 2020 07:24:40 -0800 (PST)
Received: from dell3630.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5E7983F68E;
        Mon, 10 Feb 2020 07:24:39 -0800 (PST)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH] drivers base/arch_topology: Remove 'struct sched_domain' forward declaration
Date:   Mon, 10 Feb 2020 16:24:20 +0100
Message-Id: <20200210152420.10608-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
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

W/o the sched domain pointer argument the storage class and inline
definition as well as the return type, function name and parameter list
fit all into one line.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
 include/linux/arch_topology.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 3015ecbb90b1..c507e9ddd909 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -16,9 +16,7 @@ bool topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
 
 DECLARE_PER_CPU(unsigned long, cpu_scale);
 
-struct sched_domain;
-static inline
-unsigned long topology_get_cpu_scale(int cpu)
+static inline unsigned long topology_get_cpu_scale(int cpu)
 {
 	return per_cpu(cpu_scale, cpu);
 }
@@ -27,8 +25,7 @@ void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
 
 DECLARE_PER_CPU(unsigned long, freq_scale);
 
-static inline
-unsigned long topology_get_freq_scale(int cpu)
+static inline unsigned long topology_get_freq_scale(int cpu)
 {
 	return per_cpu(freq_scale, cpu);
 }
-- 
2.17.1

