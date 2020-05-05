Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C798C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A9D5206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgEEWgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 18:36:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:41849 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729388AbgEEWgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 18:36:46 -0400
IronPort-SDR: QlSsmB7rfGKazkHD/RNkmNyE6I/fexW09WE7tN7IUfpozREFbj2huUAzxD18/XVz9eUD9irl7e
 7nxp1GptR4SA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 15:36:46 -0700
IronPort-SDR: pPCIxxcq51Eki5YNNUFkcxD4KPLR2e7x2RGPsvQDt4fVnaX8xAp7p54a71R52JjArZYSE0e6xk
 YeyzE9Vj09ZA==
X-IronPort-AV: E=Sophos;i="5.73,357,1583222400"; 
   d="scan'208";a="284410842"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 15:36:45 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH V2 3/7] x86/resctrl: Remove unnecessary RMID checks
Date:   Tue,  5 May 2020 15:36:14 -0700
Message-Id: <c9a3b60d34091840c8b0bd1c6fab15e5ba92cb17.1588715690.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1588715690.git.reinette.chatre@intel.com>
References: <cover.1588715690.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cache and memory bandwidth monitoring properties are read using
CPUID on every CPU. After the information is read from the system a
sanity check is run to (1) ensure that the RMID data is initialized
for the boot CPU in case the information was not available on the boot
CPU and (2) the boot CPU's RMID is set to the minimum of RMID obtained
from all CPUs.

Every known platform that supports resctrl has the same maximum RMID on
all CPUs. Both sanity checks found in x86_init_cache_qos() can thus
safely be removed.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/common.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a8f0f22ee5c1..556a96d05a6c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1354,20 +1354,6 @@ static void generic_identify(struct cpuinfo_x86 *c)
 #endif
 }
 
-static void x86_init_cache_qos(struct cpuinfo_x86 *c)
-{
-	/*
-	 * The heavy lifting of max_rmid and cache_occ_scale are handled
-	 * in get_cpu_cap().  Here we just set the max_rmid for the boot_cpu
-	 * in case CQM bits really aren't there in this CPU.
-	 */
-	if (c != &boot_cpu_data) {
-		boot_cpu_data.x86_cache_max_rmid =
-			min(boot_cpu_data.x86_cache_max_rmid,
-			    c->x86_cache_max_rmid);
-	}
-}
-
 /*
  * Validate that ACPI/mptables have the same information about the
  * effective APIC id and update the package map.
@@ -1480,7 +1466,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 #endif
 
 	x86_init_rdrand(c);
-	x86_init_cache_qos(c);
 	setup_pku(c);
 
 	/*
-- 
2.21.0

