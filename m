Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DA7C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FA021D7E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3DsoSSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgCIPwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:52:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35952 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727171AbgCIPwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583769152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IxoCj7ol2ys8Yu3qOzfjb+6i+I21gSxxhn+KMdZnqEM=;
        b=L3DsoSSR9G4jGj+a9ZQ8xk1bCZZo6A9idcXLYGpbudjpFreexs/PP+YsSJdzrHs2YXhUFT
        mNUrV6SoV/eh8ZKxz4OOcDZijXgt+GrV6ylbttzkOAynq5hQlvaKoTiiipBwVQ7P1LbcMg
        OR1g4wfawNSbpcCbRcmezNIw79YJQBQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-kfx9_tO0M-CRjmA1GWVsHA-1; Mon, 09 Mar 2020 11:52:29 -0400
X-MC-Unique: kfx9_tO0M-CRjmA1GWVsHA-1
Received: by mail-wr1-f71.google.com with SMTP id u18so5356884wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 08:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IxoCj7ol2ys8Yu3qOzfjb+6i+I21gSxxhn+KMdZnqEM=;
        b=oeWm+6fOjfsJWXs1wiXdWtvugeDRuNMeyGRRQq+Lk4KV4kpWLF9QGxQleNT3o4FVZZ
         dQvOTRNEoKE/hrstxUrdtxwBXuKH2sjkcXF+bsG83KLhovghhOSBUove0Oz+RwEFyqZu
         6UfZnX+yaQpOmYj4/fwkMdOLgBKaS/jKguci+T6WoYmBBl/t1UPzG5UsoZgW8yL7I5PD
         Y0yOdmGDeiGuKCq6xPVUQNWx9JnFOcASn238C3a9/vsWRNKu1Sbzcj5QWjQduifR56sv
         U0G1bWvneKrW4pVd/vJueWkLMenGJnTvZYDLZM7HfkY+t8P61jaEjkepUtL92CZAF6sg
         7DFg==
X-Gm-Message-State: ANhLgQ24fyazObHIbutevGE2XmMSCtU82Pq5hN9dI48qyu5IhDBVKh7p
        6jdsK4/P9ZpBQC32mUllnoJ3yieHMtpU1bssVEnPtDKE+tuxe86pSuOaktwjw8Wu0gqFOVd0SEX
        ehuj/K8tb+PQxp5S+8HdEg72V
X-Received: by 2002:a5d:69c7:: with SMTP id s7mr8730236wrw.165.1583769147787;
        Mon, 09 Mar 2020 08:52:27 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuxZwBEeKd41ZuDyKtmdkY8qKyyAAQOZ1rhXMhUYIQ36IGWq3i/Z2o/GbhrwKib2vpSgoZ30Q==
X-Received: by 2002:a5d:69c7:: with SMTP id s7mr8730220wrw.165.1583769147525;
        Mon, 09 Mar 2020 08:52:27 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q4sm17294521wro.56.2020.03.09.08.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 08:52:25 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liran Alon <liran.alon@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: [PATCH 3/6] KVM: nVMX: properly handle errors in nested_vmx_handle_enlightened_vmptrld()
Date:   Mon,  9 Mar 2020 16:52:13 +0100
Message-Id: <20200309155216.204752-4-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309155216.204752-1-vkuznets@redhat.com>
References: <20200309155216.204752-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nested_vmx_handle_enlightened_vmptrld() fails in two cases:
- when we fail to kvm_vcpu_map() the supplied GPA
- when revision_id is incorrect.
Genuine Hyper-V raises #UD in the former case (at least with *some*
incorrect GPAs) and does VMfailInvalid() in the later. KVM doesn't do
anything so L1 just gets stuck retrying the same faulty VMLAUNCH.

nested_vmx_handle_enlightened_vmptrld() has two call sites:
nested_vmx_run() and nested_get_vmcs12_pages(). The former needs to queue
do much: the failure there happens after migration when L2 was running (and
L1 did something weird like wrote to VP assist page from a different vCPU),
just kill L1 with KVM_EXIT_INTERNAL_ERROR.

Reported-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/evmcs.h  |  7 +++++++
 arch/x86/kvm/vmx/nested.c | 39 +++++++++++++++++++++++++++++----------
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/vmx/evmcs.h b/arch/x86/kvm/vmx/evmcs.h
index 6de47f2569c9..e5f7a7ebf27d 100644
--- a/arch/x86/kvm/vmx/evmcs.h
+++ b/arch/x86/kvm/vmx/evmcs.h
@@ -198,6 +198,13 @@ static inline void evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf) {}
 static inline void evmcs_touch_msr_bitmap(void) {}
 #endif /* IS_ENABLED(CONFIG_HYPERV) */
 
+enum nested_evmptrld_status {
+	EVMPTRLD_DISABLED,
+	EVMPTRLD_SUCCEEDED,
+	EVMPTRLD_VMFAIL,
+	EVMPTRLD_ERROR,
+};
+
 bool nested_enlightened_vmentry(struct kvm_vcpu *vcpu, u64 *evmcs_gpa);
 uint16_t nested_get_evmcs_version(struct kvm_vcpu *vcpu);
 int nested_enable_evmcs(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 72398e3bc92b..65df8bcbb9c8 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1910,18 +1910,18 @@ static int copy_vmcs12_to_enlightened(struct vcpu_vmx *vmx)
  * This is an equivalent of the nested hypervisor executing the vmptrld
  * instruction.
  */
-static int nested_vmx_handle_enlightened_vmptrld(struct kvm_vcpu *vcpu,
-						 bool from_launch)
+enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
+	struct kvm_vcpu *vcpu, bool from_launch)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	bool evmcs_gpa_changed = false;
 	u64 evmcs_gpa;
 
 	if (likely(!vmx->nested.enlightened_vmcs_enabled))
-		return 1;
+		return EVMPTRLD_DISABLED;
 
 	if (!nested_enlightened_vmentry(vcpu, &evmcs_gpa))
-		return 1;
+		return EVMPTRLD_DISABLED;
 
 	if (unlikely(!vmx->nested.hv_evmcs ||
 		     evmcs_gpa != vmx->nested.hv_evmcs_vmptr)) {
@@ -1932,7 +1932,7 @@ static int nested_vmx_handle_enlightened_vmptrld(struct kvm_vcpu *vcpu,
 
 		if (kvm_vcpu_map(vcpu, gpa_to_gfn(evmcs_gpa),
 				 &vmx->nested.hv_evmcs_map))
-			return 0;
+			return EVMPTRLD_ERROR;
 
 		vmx->nested.hv_evmcs = vmx->nested.hv_evmcs_map.hva;
 
@@ -1961,7 +1961,7 @@ static int nested_vmx_handle_enlightened_vmptrld(struct kvm_vcpu *vcpu,
 		if ((vmx->nested.hv_evmcs->revision_id != KVM_EVMCS_VERSION) &&
 		    (vmx->nested.hv_evmcs->revision_id != VMCS12_REVISION)) {
 			nested_release_evmcs(vcpu);
-			return 0;
+			return EVMPTRLD_VMFAIL;
 		}
 
 		vmx->nested.dirty_vmcs12 = true;
@@ -1990,7 +1990,7 @@ static int nested_vmx_handle_enlightened_vmptrld(struct kvm_vcpu *vcpu,
 		vmx->nested.hv_evmcs->hv_clean_fields &=
 			~HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL;
 
-	return 1;
+	return EVMPTRLD_SUCCEEDED;
 }
 
 void nested_sync_vmcs12_to_shadow(struct kvm_vcpu *vcpu)
@@ -3050,8 +3050,21 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 	 * L2 was running), map it here to make sure vmcs12 changes are
 	 * properly reflected.
 	 */
-	if (vmx->nested.enlightened_vmcs_enabled && !vmx->nested.hv_evmcs)
-		nested_vmx_handle_enlightened_vmptrld(vcpu, false);
+	if (vmx->nested.enlightened_vmcs_enabled && !vmx->nested.hv_evmcs) {
+		enum nested_evmptrld_status evmptrld_status =
+			nested_vmx_handle_enlightened_vmptrld(vcpu, false);
+
+		if (evmptrld_status == EVMPTRLD_VMFAIL ||
+		    evmptrld_status == EVMPTRLD_ERROR) {
+			pr_debug_ratelimited("%s: enlightened vmptrld failed\n",
+					     __func__);
+			vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+			vcpu->run->internal.suberror =
+				KVM_INTERNAL_ERROR_EMULATION;
+			vcpu->run->internal.ndata = 0;
+			return false;
+		}
+	}
 
 	if (nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES)) {
 		/*
@@ -3316,12 +3329,18 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	enum nvmx_vmentry_status status;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	u32 interrupt_shadow = vmx_get_interrupt_shadow(vcpu);
+	enum nested_evmptrld_status evmptrld_status;
 
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	if (!nested_vmx_handle_enlightened_vmptrld(vcpu, launch))
+	evmptrld_status = nested_vmx_handle_enlightened_vmptrld(vcpu, launch);
+	if (evmptrld_status == EVMPTRLD_ERROR) {
+		kvm_queue_exception(vcpu, UD_VECTOR);
 		return 1;
+	} else if (evmptrld_status == EVMPTRLD_VMFAIL) {
+		return nested_vmx_failInvalid(vcpu);
+	}
 
 	if (!vmx->nested.hv_evmcs && vmx->nested.current_vmptr == -1ull)
 		return nested_vmx_failInvalid(vcpu);
-- 
2.24.1

