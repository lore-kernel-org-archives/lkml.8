Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59640C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34593207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iroqxxMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbgG2ALj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:11:39 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:34595 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730568AbgG2ALh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 20:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595981496; x=1627517496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=afOSpCcIkE9zWH372UUS4XxZhj2dLHR6YIsW46csYng=;
  b=iroqxxMoOZyWKXOUSTZfZZxsDHW1HnapXs7k3uj8ggjgKdXqCypTMnGx
   +EsP6ss6BKcPHOdYOLnzZwdJCVdUks6OS0xOaymCstZ2o+Se2+lRfCZih
   C5PpCJQVsqapkzakZxkGdJ/D0TAtAi6EJig4YN8+NU164vsmU0EEzhJTK
   k=;
IronPort-SDR: NhD4CF+q2Ar27nLK4skVboa7VqMcUHbJ9D2OkOm0p/l7gxaROjSTStX1efuCw2SV4ZzE1PGP+v
 XcQCcLsb5rGw==
X-IronPort-AV: E=Sophos;i="5.75,408,1589241600"; 
   d="scan'208";a="55578786"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 29 Jul 2020 00:11:29 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id 2AE60240D95;
        Wed, 29 Jul 2020 00:11:25 +0000 (UTC)
Received: from EX13D01UWA001.ant.amazon.com (10.43.160.60) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 29 Jul 2020 00:11:25 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13d01UWA001.ant.amazon.com (10.43.160.60) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 29 Jul 2020 00:11:24 +0000
Received: from localhost (10.143.192.232) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Jul 2020 00:11:23 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        <thomas.lendacky@amd.com>, <torvalds@linux-foundation.org>,
        <mingo@kernel.org>, Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v2 1/5] Add a per-cpu view of SMT state
Date:   Wed, 29 Jul 2020 10:10:59 +1000
Message-ID: <20200729001103.6450-2-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729001103.6450-1-sblbir@amazon.com>
References: <20200729001103.6450-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new field smt_active in cpuinfo_x86 identifies if the current core/cpu
is in SMT mode or not. This can be very helpful if the system has some
of its cores with threads offlined and can be used for cases where
action is taken based on the state of SMT. The follow up patches use
this feature.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 arch/x86/include/asm/processor.h |  2 ++
 arch/x86/kernel/smpboot.c        | 11 ++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 03b7c4ca425a..23ea45dd6f14 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -136,6 +136,8 @@ struct cpuinfo_x86 {
 	u16			logical_die_id;
 	/* Index into per_cpu list: */
 	u16			cpu_index;
+	/*  Is SMT active on this core? */
+	bool			smt_active;
 	u32			microcode;
 	/* Address space bits used by the cache internally */
 	u8			x86_cache_bits;
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ffbd9a3d78d8..0b12f24ebfbb 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -645,6 +645,9 @@ void set_cpu_sibling_map(int cpu)
 	threads = cpumask_weight(topology_sibling_cpumask(cpu));
 	if (threads > __max_smt_threads)
 		__max_smt_threads = threads;
+
+	for_each_cpu(i, topology_sibling_cpumask(cpu))
+		cpu_data(i).smt_active = threads > 1;
 }
 
 /* maps the cpu to the sched domain representing multi-core */
@@ -1557,10 +1560,16 @@ static void remove_siblinginfo(int cpu)
 
 	for_each_cpu(sibling, topology_die_cpumask(cpu))
 		cpumask_clear_cpu(cpu, topology_die_cpumask(sibling));
-	for_each_cpu(sibling, topology_sibling_cpumask(cpu))
+
+	for_each_cpu(sibling, topology_sibling_cpumask(cpu)) {
 		cpumask_clear_cpu(cpu, topology_sibling_cpumask(sibling));
+		if (cpumask_weight(topology_sibling_cpumask(sibling)) == 1)
+			cpu_data(sibling).smt_active = false;
+	}
+
 	for_each_cpu(sibling, cpu_llc_shared_mask(cpu))
 		cpumask_clear_cpu(cpu, cpu_llc_shared_mask(sibling));
+
 	cpumask_clear(cpu_llc_shared_mask(cpu));
 	cpumask_clear(topology_sibling_cpumask(cpu));
 	cpumask_clear(topology_core_cpumask(cpu));
-- 
2.17.1

