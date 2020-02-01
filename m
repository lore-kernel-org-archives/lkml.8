Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C8BC33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526FA20661
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgBASzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 13:55:02 -0500
Received: from mga02.intel.com ([134.134.136.20]:11279 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727199AbgBASwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:52:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2020 10:52:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,390,1574150400"; 
   d="scan'208";a="248075538"
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
Subject: [PATCH 36/61] KVM: x86: Handle GBPAGE CPUID adjustment for EPT in VMX code
Date:   Sat,  1 Feb 2020 10:51:53 -0800
Message-Id: <20200201185218.24473-37-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200201185218.24473-1-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the clearing of the GBPAGE CPUID bit into VMX to eliminate an
instance of the undesirable "unsigned f_* = *_supported ? F(*) : 0"
pattern in the common CPUID handling code, and to pave the way toward
eliminating ->get_lpage_level().

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/cpuid.c   | 3 +--
 arch/x86/kvm/vmx/vmx.c | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index f4a3655451dd..c74253202af8 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -416,8 +416,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 	int r, i, max_idx;
 	unsigned f_nx = is_efer_nx() ? F(NX) : 0;
 #ifdef CONFIG_X86_64
-	unsigned f_gbpages = (kvm_x86_ops->get_lpage_level() == PT_PDPE_LEVEL)
-				? F(GBPAGES) : 0;
+	unsigned f_gbpages = F(GBPAGES);
 	unsigned f_lm = F(LM);
 #else
 	unsigned f_gbpages = 0;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index fcec3d8a0176..11b9c1e7e520 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7125,6 +7125,8 @@ static void vmx_set_supported_cpuid(struct kvm_cpuid_entry2 *entry)
 	case 0x80000001:
 		if (!cpu_has_vmx_rdtscp())
 			cpuid_entry_clear(entry, X86_FEATURE_RDTSCP);
+		if (enable_ept && !cpu_has_vmx_ept_1g_page())
+			cpuid_entry_clear(entry, X86_FEATURE_GBPAGES);
 		break;
 	default:
 		break;
-- 
2.24.1

