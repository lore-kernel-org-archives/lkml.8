Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78A7C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DDF2072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217852;
	bh=hNUI5rCXY/JGwB+H+BOV4HGykXp69tf62roWzp9ofdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DAfVLr5CzvRbJwLLipCk65d1LlmyK1dUxMzC7KbNCjihT55nL2J/yOzuNd+BTSdGn
	 cYAl4FREjyJW7dyTOyokuNSgE0Kg31t1VpWaZ00YT5VLnTvX+4etjUXC6VEXdEefdn
	 ibeScLE/V86GVXgtBuxIl0byH2I4HaLyN6gycGZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391428AbgAPXay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:30:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403886AbgAPXaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:30:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71B9C2087E;
        Thu, 16 Jan 2020 23:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217424;
        bh=hNUI5rCXY/JGwB+H+BOV4HGykXp69tf62roWzp9ofdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qglhAIjR9xNwyxaClz1jfrSrb/uUhuR2bLuLvpGHuYBOMGBedCVtW/4RbZf/pAksQ
         l+3LCsFBexYjml+SxaYQDEl4Mfsj5h/NwbUl24tAFNdd3cf5CGd0PufLU8qAJ/ybp6
         MkIc8ZTtrQeOKvykmwQPvP3YLTGyAiY/KC+Behmg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 77/84] mips: cacheinfo: report shared CPU map
Date:   Fri, 17 Jan 2020 00:18:51 +0100
Message-Id: <20200116231722.592602605@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231713.087649517@linuxfoundation.org>
References: <20200116231713.087649517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>

[ Upstream commit 3b1313eb32c499d46dc4c3e896d19d9564c879c4 ]

Report L1 caches as shared per core; L2 - per cluster.

This fixes "perf" that went crazy if shared_cpu_map attribute not
reported on sysfs, in form of

/sys/devices/system/cpu/cpu*/cache/index*/shared_cpu_list
/sys/devices/system/cpu/cpu*/cache/index*/shared_cpu_map

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Signed-off-by: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/cacheinfo.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/cacheinfo.c b/arch/mips/kernel/cacheinfo.c
index 428ef2189203..3ea95568ece4 100644
--- a/arch/mips/kernel/cacheinfo.c
+++ b/arch/mips/kernel/cacheinfo.c
@@ -61,6 +61,25 @@ static int __init_cache_level(unsigned int cpu)
 	return 0;
 }
 
+static void fill_cpumask_siblings(int cpu, cpumask_t *cpu_map)
+{
+	int cpu1;
+
+	for_each_possible_cpu(cpu1)
+		if (cpus_are_siblings(cpu, cpu1))
+			cpumask_set_cpu(cpu1, cpu_map);
+}
+
+static void fill_cpumask_cluster(int cpu, cpumask_t *cpu_map)
+{
+	int cpu1;
+	int cluster = cpu_cluster(&cpu_data[cpu]);
+
+	for_each_possible_cpu(cpu1)
+		if (cpu_cluster(&cpu_data[cpu1]) == cluster)
+			cpumask_set_cpu(cpu1, cpu_map);
+}
+
 static int __populate_cache_leaves(unsigned int cpu)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
@@ -68,14 +87,20 @@ static int __populate_cache_leaves(unsigned int cpu)
 	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
 
 	if (c->icache.waysize) {
+		/* L1 caches are per core */
+		fill_cpumask_siblings(cpu, &this_leaf->shared_cpu_map);
 		populate_cache(dcache, this_leaf, 1, CACHE_TYPE_DATA);
+		fill_cpumask_siblings(cpu, &this_leaf->shared_cpu_map);
 		populate_cache(icache, this_leaf, 1, CACHE_TYPE_INST);
 	} else {
 		populate_cache(dcache, this_leaf, 1, CACHE_TYPE_UNIFIED);
 	}
 
-	if (c->scache.waysize)
+	if (c->scache.waysize) {
+		/* L2 cache is per cluster */
+		fill_cpumask_cluster(cpu, &this_leaf->shared_cpu_map);
 		populate_cache(scache, this_leaf, 2, CACHE_TYPE_UNIFIED);
+	}
 
 	if (c->tcache.waysize)
 		populate_cache(tcache, this_leaf, 3, CACHE_TYPE_UNIFIED);
-- 
2.20.1



