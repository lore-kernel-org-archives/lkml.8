Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F2CC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19EAD206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgAJWxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 17:53:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:7143 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbgAJWxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 17:53:48 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 14:53:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; 
   d="scan'208";a="239045135"
Received: from guptapadev.jf.intel.com (HELO guptapadev.amr) ([10.7.198.56])
  by orsmga002.jf.intel.com with ESMTP; 10 Jan 2020 14:53:48 -0800
Date:   Fri, 10 Jan 2020 14:50:54 -0800
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Neelima Krishnan <neelima.krishnan@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] x86/cpu: Update cached HLE state on write to
 TSX_CTRL_CPUID_CLEAR
Message-ID: <2529b99546294c893dfa1c89e2b3e46da3369a59.1578685425.git.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/cpuinfo currently reports Hardware Lock Elision (HLE) feature to
be present on boot cpu even if it was disabled during the bootup. This
is because cpuinfo_x86->x86_capability HLE bit is not updated after TSX
state is changed via a new MSR IA32_TSX_CTRL.

Update the cached HLE bit also since it is expected to change after an
update to CPUID_CLEAR bit in MSR IA32_TSX_CTRL.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Tested-by: Neelima Krishnan <neelima.krishnan@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/kernel/cpu/tsx.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
index 3e20d322bc98..032509adf9de 100644
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -115,11 +115,12 @@ void __init tsx_init(void)
 		tsx_disable();
 
 		/*
-		 * tsx_disable() will change the state of the
-		 * RTM CPUID bit.  Clear it here since it is now
-		 * expected to be not set.
+		 * tsx_disable() will change the state of the RTM and HLE CPUID
+		 * bits. Clear them here since they are now expected to be not
+		 * set.
 		 */
 		setup_clear_cpu_cap(X86_FEATURE_RTM);
+		setup_clear_cpu_cap(X86_FEATURE_HLE);
 	} else if (tsx_ctrl_state == TSX_CTRL_ENABLE) {
 
 		/*
@@ -131,10 +132,10 @@ void __init tsx_init(void)
 		tsx_enable();
 
 		/*
-		 * tsx_enable() will change the state of the
-		 * RTM CPUID bit.  Force it here since it is now
-		 * expected to be set.
+		 * tsx_enable() will change the state of the RTM and HLE CPUID
+		 * bits. Force them here since they are now expected to be set.
 		 */
 		setup_force_cpu_cap(X86_FEATURE_RTM);
+		setup_force_cpu_cap(X86_FEATURE_HLE);
 	}
 }
-- 
2.21.1

