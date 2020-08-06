Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F2BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C3B72311A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgHFRXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:23:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:16275 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730067AbgHFRXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:23:48 -0400
IronPort-SDR: NUN5F1RX9GtuzdrBYwbPdzfQua30nba7qIoguDWiq4RRq0FszVO639tW2s86kpETSI3ljowEHj
 KeqN9kZg6ypQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="140656246"
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="140656246"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 04:41:36 -0700
IronPort-SDR: +d4867QDCujq41rvKqrfx2h6Kf0Vidyy7RoD1048MOXYZmoVWbq0g1SrfBI7j4RbMrCurwgl2h
 ZiORzQGDQIgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="307007972"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.135])
  by orsmga002.jf.intel.com with ESMTP; 06 Aug 2020 04:41:33 -0700
From:   Shuo Liu <shuo.a.liu@intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuo Liu <shuo.a.liu@intel.com>
Subject: [PATCH] x86/acrn: Remove redundant chars from ACRN signature
Date:   Thu,  6 Aug 2020 19:41:11 +0800
Message-Id: <20200806114111.9448-1-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hypervisor_cpuid_base() only handles 12 chars of the hypervisor
signature string but is provided with 14 chars.

Remove the redundancy. Additionally, replace the user space uint32_t
with preferred kernel type u32.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/acrn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index 3b08cdfc6514..0b2c03943ac6 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -17,9 +17,9 @@
 #include <asm/idtentry.h>
 #include <asm/irq_regs.h>
 
-static uint32_t __init acrn_detect(void)
+static u32 __init acrn_detect(void)
 {
-	return hypervisor_cpuid_base("ACRNACRNACRN\0\0", 0);
+	return hypervisor_cpuid_base("ACRNACRNACRN", 0);
 }
 
 static void __init acrn_init_platform(void)

base-commit: 48778464bb7d346b47157d21ffde2af6b2d39110
-- 
2.28.0

