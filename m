Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52990C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C50020661
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgBAS4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 13:56:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:57278 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbgBASwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:52:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2020 10:52:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,390,1574150400"; 
   d="scan'208";a="248075568"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2020 10:52:26 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 46/61] KVM: x86: Remove the unnecessary loop on CPUID 0x7 sub-leafs
Date:   Sat,  1 Feb 2020 10:52:03 -0800
Message-Id: <20200201185218.24473-47-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200201185218.24473-1-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly handle CPUID 0x7 sub-leaf 1.  The kernel is currently aware
of exactly one feature in CPUID 0x7.1,  which means there is room for
another 127 features before CPUID 0x7.2 will see the light of day, i.e.
the looping is likely to be dead code for years to come.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/cpuid.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 7362e5238799..47f61f4497fb 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -533,11 +533,9 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		if (boot_cpu_has(X86_FEATURE_AMD_SSBD))
 			cpuid_entry_set(entry, X86_FEATURE_SPEC_CTRL_SSBD);
 
-		for (i = 1, max_idx = entry->eax; i <= max_idx; i++) {
-			if (WARN_ON_ONCE(i > 1))
-				break;
-
-			entry = do_host_cpuid(array, function, i);
+		/* KVM only supports 0x7.0 and 0x7.1, capped above via min(). */
+		if (entry->eax == 1) {
+			entry = do_host_cpuid(array, function, 1);
 			if (!entry)
 				goto out;
 
-- 
2.24.1

