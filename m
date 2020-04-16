Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08837C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1F6222265
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgDPU55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:57:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:8859 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbgDPU54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 16:57:56 -0400
IronPort-SDR: EHP9/gDuqXOibTF4xZopEIGcmAPGhyK+M40nT/WJMtUxBwd5Ong12CqDLylQIaXFSsqnMOR/DV
 WO5m4ffnWUog==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 13:57:55 -0700
IronPort-SDR: wCOQn6nr9oq78cynH4idgQbMXL8xKA3507sX04Tn3unbkAkWY6Qi0DujBuhkH4R8X3xhwvPHC1
 t3yUu5nscgbg==
X-IronPort-AV: E=Sophos;i="5.72,392,1580803200"; 
   d="scan'208";a="427982526"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 13:57:55 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH 1/3] x86/split_lock: Update to use X86_MATCH_INTEL_FAM6_MODEL()
Date:   Thu, 16 Apr 2020 13:57:52 -0700
Message-Id: <20200416205754.21177-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200416205754.21177-1-tony.luck@intel.com>
References: <20200416205754.21177-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPLIT_LOCK_CPU() macro escaped the tree-wide sweep for old-style
initialization. Update to use X86_MATCH_INTEL_FAM6_MODEL().

Fixes: 6650cdd9a8cc ("x86/split_lock: Enable split lock detection by kernel")
Cc: <stable@vger.kernel.org>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index bf08d4508ecb..6119deb32660 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1119,8 +1119,6 @@ void switch_to_sld(unsigned long tifn)
 	sld_update_msr(!(tifn & _TIF_SLD));
 }
 
-#define SPLIT_LOCK_CPU(model) {X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY}
-
 /*
  * The following processors have the split lock detection feature. But
  * since they don't have the IA32_CORE_CAPABILITIES MSR, the feature cannot
@@ -1128,8 +1126,8 @@ void switch_to_sld(unsigned long tifn)
  * processors.
  */
 static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
-	SPLIT_LOCK_CPU(INTEL_FAM6_ICELAKE_X),
-	SPLIT_LOCK_CPU(INTEL_FAM6_ICELAKE_L),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,           0),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,           0),
 	{}
 };
 
-- 
2.21.1

