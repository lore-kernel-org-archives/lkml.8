Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86738C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B165206E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgGXXpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 19:45:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:33707 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbgGXXpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 19:45:40 -0400
IronPort-SDR: SedM4n2t4cOo7+J8U0DcJ5ebeP7+HuxRqqhKDPgP/tlwFTwpLXZQoNdstj809jh0ozhU2l06tt
 HCj8a5VmjRXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="152072866"
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="152072866"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 16:45:39 -0700
IronPort-SDR: FLNGcN6ENOTZggkRSX8xX4wTyJTl/SugkLYQJBS4RNpFo/KV8lRziFT6lGdEk8mQKv9QuqqFAP
 Cgc5/jgOmj7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="488900121"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jul 2020 16:45:37 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Tony Luck" <tony.luck@intel.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Xiaoyao Li " <xiaoyao.li@intel.com>
Cc:     "x86" <x86@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH] x86/split_lock: Enumerate split lock feature on Sapphire Rapids and Alder Lake
Date:   Fri, 24 Jul 2020 16:45:20 -0700
Message-Id: <1595634320-79689-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Sapphire Rapids and Alder Lake processors to CPU list to enumerate
split lock feature.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---

This patch supersedes 
https://lore.kernel.org/lkml/1593208534-33721-1-git-send-email-fenghua.yu@intel.com/
and is applied on top of Alder Lake Intel family patch:
https://lore.kernel.org/lkml/20200721043749.31567-1-tony.luck@intel.com/#iZ30arch:x86:include:asm:intel-family.h

 arch/x86/kernel/cpu/intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 0ab48f1cdf84..b6b7b38dff5f 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1156,6 +1156,8 @@ static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	1),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		1),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		1),
+	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	1),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		1),
 	{}
 };
 
-- 
2.19.1

