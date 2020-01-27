Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468D1C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 00:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E25E2083E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 00:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgA0ANd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 19:13:33 -0500
Received: from mga05.intel.com ([192.55.52.43]:22801 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgA0ANc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 19:13:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jan 2020 16:13:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,367,1574150400"; 
   d="scan'208";a="231218374"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga006.jf.intel.com with ESMTP; 26 Jan 2020 16:13:32 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: x86: Unexport x86_fpu_cache and make it static
Date:   Sun, 26 Jan 2020 16:13:30 -0800
Message-Id: <20200127001330.27741-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make x86_fpu_cache static now that FPU allocation and destruction is
handled entirely by common x86 code.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---

Pretty sure I meant to include this in the vCPU creation cleanup, but
completely forgot about it.

 arch/x86/include/asm/kvm_host.h | 1 -
 arch/x86/kvm/x86.c              | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 77d206a93658..f300a250ab51 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1266,7 +1266,6 @@ struct kvm_arch_async_pf {
 };
 
 extern struct kvm_x86_ops *kvm_x86_ops;
-extern struct kmem_cache *x86_fpu_cache;
 
 #define __KVM_HAVE_ARCH_VM_ALLOC
 static inline struct kvm *kvm_arch_alloc_vm(void)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7e3f1d937224..78b7e1f08845 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -227,8 +227,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 
 u64 __read_mostly host_xcr0;
 
-struct kmem_cache *x86_fpu_cache;
-EXPORT_SYMBOL_GPL(x86_fpu_cache);
+static struct kmem_cache *x86_fpu_cache;
 
 static int emulator_fix_hypercall(struct x86_emulate_ctxt *ctxt);
 
-- 
2.24.1

