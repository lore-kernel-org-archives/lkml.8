Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECF8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10DE220767
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbgFVWm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:42:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:27425 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730954AbgFVWm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:42:56 -0400
IronPort-SDR: TJuZitRUDRqKlpXBIq1I2yub3hgrzxnl6Iil8CyLio2gDBMmVemTmyOp6i3r///BZO0IG5Fjuz
 eoxbmm3Pu9/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="131303570"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="131303570"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 15:42:53 -0700
IronPort-SDR: MXXGxMAR/otzla/5xXCE68ySPELqwwKdvScoQZWPtwetPI2WHVCk4p77pCvRtqcsc/dxSOtCHM
 xCVPSYi1aHdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="264634921"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.152])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jun 2020 15:42:53 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/15] KVM: VMX: Rename vcpu_vmx's "guest_msrs_ready" to "guest_uret_msrs_loaded"
Date:   Mon, 22 Jun 2020 15:42:41 -0700
Message-Id: <20200622224249.29562-8-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200622224249.29562-1-sean.j.christopherson@intel.com>
References: <20200622224249.29562-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "uret" to "guest_msrs_ready" to explicitly associate it with the
"guest_uret_msrs" array, and replace "ready" with "loaded" to more
precisely reflect what it tracks, e.g. "ready" could be interpreted as
meaning ready for processing (setup_msrs() has run), which is wrong.
"loaded" also aligns with the similar "guest_state_loaded" field.

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 8 ++++----
 arch/x86/kvm/vmx/vmx.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index baf425fa7089..cebd68ea50ba 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1142,8 +1142,8 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 	 * when guest state is loaded. This happens when guest transitions
 	 * to/from long-mode by setting MSR_EFER.LMA.
 	 */
-	if (!vmx->guest_msrs_ready) {
-		vmx->guest_msrs_ready = true;
+	if (!vmx->guest_uret_msrs_loaded) {
+		vmx->guest_uret_msrs_loaded = true;
 		for (i = 0; i < vmx->nr_active_uret_msrs; ++i)
 			kvm_set_user_return_msr(vmx->guest_uret_msrs[i].index,
 						vmx->guest_uret_msrs[i].data,
@@ -1231,7 +1231,7 @@ static void vmx_prepare_switch_to_host(struct vcpu_vmx *vmx)
 #endif
 	load_fixmap_gdt(raw_smp_processor_id());
 	vmx->guest_state_loaded = false;
-	vmx->guest_msrs_ready = false;
+	vmx->guest_uret_msrs_loaded = false;
 }
 
 #ifdef CONFIG_X86_64
@@ -1759,7 +1759,7 @@ static void setup_msrs(struct vcpu_vmx *vmx)
 		move_msr_up(vmx, index, nr_active_uret_msrs++);
 
 	vmx->nr_active_uret_msrs = nr_active_uret_msrs;
-	vmx->guest_msrs_ready = false;
+	vmx->guest_uret_msrs_loaded = false;
 
 	if (cpu_has_vmx_msr_bitmap())
 		vmx_update_msr_bitmap(&vmx->vcpu);
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 55257195cb27..a0237ff6c4e0 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -220,7 +220,7 @@ struct vcpu_vmx {
 	struct vmx_uret_msr   guest_uret_msrs[MAX_NR_USER_RETURN_MSRS];
 	int                   nr_uret_msrs;
 	int                   nr_active_uret_msrs;
-	bool                  guest_msrs_ready;
+	bool                  guest_uret_msrs_loaded;
 #ifdef CONFIG_X86_64
 	u64		      msr_host_kernel_gs_base;
 	u64		      msr_guest_kernel_gs_base;
-- 
2.26.0

