Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C888C4BA2D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C3E222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgBZXQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 18:16:19 -0500
Received: from mga04.intel.com ([192.55.52.120]:3614 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbgBZXQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 18:16:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 15:16:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,489,1574150400"; 
   d="scan'208";a="410797453"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga005.jf.intel.com with ESMTP; 26 Feb 2020 15:16:18 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH] x86/pkeys: Manually set X86_FEATURE_OSPKE to preserve existing changes
Date:   Wed, 26 Feb 2020 15:16:15 -0800
Message-Id: <20200226231615.13664-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly set X86_FEATURE_OSPKE via set_cpu_cap() instead of calling
get_cpu_cap() to pull the feature bit from CPUID after enabling CR4.PKE.
Invoking get_cpu_cap() effectively wipes out any {set,clear}_cpu_cap()
changes that were made between this_cpu->c_init() and setup_pku(), as
all non-synthetic feature words are reinitialized from the CPU's CPUID
values.

Blasting away capability updates manifests most visibility when running
on a VMX capable CPU, but with VMX disabled by BIOS.  To indicate that
VMX is disabled, init_ia32_feat_ctl() clears X86_FEATURE_VMX, using
clear_cpu_cap() instead of setup_clear_cpu_cap() so that KVM can report
which CPU is misconfigured (KVM needs to probe every CPU anyways).
Restoring X86_FEATURE_VMX from CPUID causes KVM to think VMX is enabled,
ultimately leading to an unexpected #GP when KVM attempts to do VMXON.

Arguably, init_ia32_feat_ctl() should use setup_clear_cpu_cap() and let
KVM figure out a different way to report the misconfigured CPU, but VMX
is not the only feature bit that is affected, i.e. there is precedent
that tweaking feature bits via {set,clear}_cpu_cap() after ->c_init()
is expected to work.  Most notably, x86_init_rdrand()'s clearing of
X86_FEATURE_RDRAND when RDRAND malfunctions is also overwritten.

Fixes: 0697694564c8 ("x86/mm/pkeys: Actually enable Memory Protection Keys in the CPU")
Cc: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Reported-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---

I considered adding a WARN_ON check of cpuid_ecx(7) to ensure OSPKE is set
and bail if it's not, but that seemed like useless paranoia.

I don't love that using clear_cpu_cap() is a bit fragile, especially where
init_ia32_feat_ctl() is concerned, but the existing RDRAND usage, which
predates setup_pku(), makes a pretty strong argument that setup_pku() is
in the wrong.

The other potential issue is late microcode updates, which refreshes the
feature bits from CPUID, but at least in that case the kernel will print a
warning if something changed.

 arch/x86/kernel/cpu/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 52c9bfbbdb2a..4cdb123ff66a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -445,7 +445,7 @@ static __always_inline void setup_pku(struct cpuinfo_x86 *c)
 	 * cpuid bit to be set.  We need to ensure that we
 	 * update that bit in this CPU's "cpu_info".
 	 */
-	get_cpu_cap(c);
+	set_cpu_cap(c, X86_FEATURE_OSPKE);
 }
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
-- 
2.24.1

