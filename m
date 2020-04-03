Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B43BC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 01:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9C6206F6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 01:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390298AbgDCBjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 21:39:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:9718 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390266AbgDCBjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 21:39:37 -0400
IronPort-SDR: lBbxNJch6Owijj4CPtSBa/BOYQUfMzzHqflgFzyEgybKdBZnqS0c7VrNcjQ17GUI7Ba9MJMv7X
 Hy2oaDy3s6AA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 18:39:37 -0700
IronPort-SDR: C4FkbxliIVSY0y4v0pRDgGfu4vgl9UkQx+GpiMofUmM/b6EaOEki8ulQ6nOwfT4zFgJ3IDuLuR
 MSpqWwBF3VbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,337,1580803200"; 
   d="scan'208";a="329015329"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga001.jf.intel.com with ESMTP; 02 Apr 2020 18:39:36 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        x86@kernel.org, "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Subject: [PATCH] x86/cpufeatures: Add enumeration for serialize instruction
Date:   Thu,  2 Apr 2020 18:40:26 -0700
Message-Id: <20200403014026.19137-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The serialize instruction ensures that before the next instruction is
fetched and executed, all the modifications to flags, registers, and memory
made by previous instructions are completed, draining all buffered writes
to memory.

Importantly, the serialize instruction does not modify registers,
arithmetic flags or memory.

Hence, the serialize instructions provides a better way for software
to serialize execution than using instructions such as cpuid, which does
modify registers and, in virtual machines, causes a VM exit.

This instruction is supported by the CPU if CPUID.7H.EDX[bit 14] is
set.

Cc: x86@kernel.org
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
This new instruction is documented in the latest version of the Intel
Architecture Instruction Set Extensions and Future Features Programming
Reference Chapter 2.1 located at
https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index db189945e9b0..cd9b1ec022ec 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -364,6 +364,7 @@
 #define X86_FEATURE_AVX512_VP2INTERSECT (18*32+ 8) /* AVX-512 Intersect for D/Q */
 #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
 #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
+#define X86_FEATURE_SERIALIZE		(18*32+14) /* SERIALIZE instruction */
 #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
-- 
2.17.1

