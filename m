Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8BAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61135206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbgFVUUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:20:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:62019 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728873AbgFVUUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:20:38 -0400
IronPort-SDR: QP0icH5NLimKnRuzWPE+secECg6sQBbWONr8Ykxdy7PRNOyD3Zp6UUPyrOqw0TJ84GTM07UBnR
 9V8HDTqrft0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="209057480"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="209057480"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 13:20:37 -0700
IronPort-SDR: CFCRnBS8ZevUWM4CFXbpCpIhHc1N5xei/GmT6ngoO6YU1nh+yS9qqo5/lfyIHLOxizbEHUuqlt
 +RCVKu9gyLmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="478506330"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.152])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2020 13:20:37 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] KVM: x86/mmu: Add MMU-internal header
Date:   Mon, 22 Jun 2020 13:20:31 -0700
Message-Id: <20200622202034.15093-4-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200622202034.15093-1-sean.j.christopherson@intel.com>
References: <20200622202034.15093-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mmu/mmu_internal.h to hold declarations and definitions that need
to be shared between various mmu/ files, but should not be used by
anything outside of the MMU.

Begin populating mmu_internal.h with declarations of the helpers used by
page_track.c.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu.h              |  4 ----
 arch/x86/kvm/mmu/mmu.c          |  1 +
 arch/x86/kvm/mmu/mmu_internal.h | 10 ++++++++++
 arch/x86/kvm/mmu/page_track.c   |  2 +-
 4 files changed, 12 insertions(+), 5 deletions(-)
 create mode 100644 arch/x86/kvm/mmu/mmu_internal.h

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index d46944488e72..434acfcbf710 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -209,10 +209,6 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 
 void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
 
-void kvm_mmu_gfn_disallow_lpage(struct kvm_memory_slot *slot, gfn_t gfn);
-void kvm_mmu_gfn_allow_lpage(struct kvm_memory_slot *slot, gfn_t gfn);
-bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
-				    struct kvm_memory_slot *slot, u64 gfn);
 int kvm_arch_write_log_dirty(struct kvm_vcpu *vcpu);
 
 int kvm_mmu_post_init_vm(struct kvm *kvm);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 1b4d45b8f462..c1bf30e24bfc 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -18,6 +18,7 @@
 #include "irq.h"
 #include "ioapic.h"
 #include "mmu.h"
+#include "mmu_internal.h"
 #include "x86.h"
 #include "kvm_cache_regs.h"
 #include "kvm_emulate.h"
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
new file mode 100644
index 000000000000..d7938c37c7de
--- /dev/null
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __KVM_X86_MMU_INTERNAL_H
+#define __KVM_X86_MMU_INTERNAL_H
+
+void kvm_mmu_gfn_disallow_lpage(struct kvm_memory_slot *slot, gfn_t gfn);
+void kvm_mmu_gfn_allow_lpage(struct kvm_memory_slot *slot, gfn_t gfn);
+bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
+				    struct kvm_memory_slot *slot, u64 gfn);
+
+#endif /* __KVM_X86_MMU_INTERNAL_H */
diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index a7bcde34d1f2..a84a141a2ad2 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -16,7 +16,7 @@
 
 #include <asm/kvm_page_track.h>
 
-#include "mmu.h"
+#include "mmu_internal.h"
 
 void kvm_page_track_free_memslot(struct kvm_memory_slot *slot)
 {
-- 
2.26.0

