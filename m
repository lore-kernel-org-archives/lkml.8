Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A9AC3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C811208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+xolYjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgCEKBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 05:01:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38825 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727176AbgCEKBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 05:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583402493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qdo7x8MpejMs3Bq5JO4MC2hL+YdmdvCezwWgTT9glAE=;
        b=c+xolYjzH1H5W1kMTYb397dX1nrQFO1FeZqNiPzOQUv++4K1pS9dUabImI6jNjxcSbmok2
        6uq5j6VcR86SPpXbFBV2suQKK5oXBr7ZugV5pQ5kZVnzRHGiSczv9hidfGqvY46058JHvV
        AlArVZnUNWD4+5fRupEFF6PgnhA/rzQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-mxu-AMQ8PO-Gu5OJBDrjTg-1; Thu, 05 Mar 2020 05:01:31 -0500
X-MC-Unique: mxu-AMQ8PO-Gu5OJBDrjTg-1
Received: by mail-wr1-f72.google.com with SMTP id j14so2085956wru.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 02:01:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qdo7x8MpejMs3Bq5JO4MC2hL+YdmdvCezwWgTT9glAE=;
        b=uCGX4ue2lnZoNOh/Ng2p0chA3gKZiR1iVIRP1Leqbz+Xs1n7rnAl/bmnA7faiictNo
         FE4td+AfHpV6JrngC0T5hmRmfNqzYyvZLbc+caVsgJqxLxQZke2KQrUfW9NTxK6ZhuJm
         JoJboXFEEgmCrArUalmOPBlD4y1w7nlKg8frCIMn43ZIFNu3UeFfDp3kzwymM66OQxGz
         xhs/gMkxaDRXQVH14iTxiplF8WiCM2pcRAPTwGqs210vFQv738Wc8VmG/uovqAbGCpsh
         rj+QX+5MojAxLczr3uBKe9dSPErzroMYRsujOnY09UXsTlBFo0HkRGhFJPrevGXZ1MdS
         D8Rw==
X-Gm-Message-State: ANhLgQ1Ey9NzfMKXaB3ptdIzpPskJhNfmq14/bCpYwmwTMOKxyQUvnvh
        90XSlU5lE4U7F+vdQIiBGagyPaRQYkGo1FsS6SoUvAJSAZ3FqOyQkkbhg2GvuN9ROAAMboJk2MP
        VB27+9oJTITYUoQfkv1CLZT0S
X-Received: by 2002:a1c:7719:: with SMTP id t25mr8256324wmi.7.1583402488288;
        Thu, 05 Mar 2020 02:01:28 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuR36k+H5I0bH9ygje4jHPz2Ku/Ml99/fjX64Va9n4SX7D7Hg8q7BBs/EMdEjurRVCvPvehUw==
X-Received: by 2002:a1c:7719:: with SMTP id t25mr8256297wmi.7.1583402488063;
        Thu, 05 Mar 2020 02:01:28 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f207sm10440025wme.9.2020.03.05.02.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 02:01:27 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] KVM: x86: VMX: untangle VMXON revision_id setting when using eVMCS
Date:   Thu,  5 Mar 2020 11:01:23 +0100
Message-Id: <20200305100123.1013667-3-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305100123.1013667-1-vkuznets@redhat.com>
References: <20200305100123.1013667-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated in alloc_vmxon_regions(), VMXON region needs to be tagged with
revision id from MSR_IA32_VMX_BASIC even in case of eVMCS. The logic to
do so is not very straightforward: first, we set
hdr.revision_id = KVM_EVMCS_VERSION in alloc_vmcs_cpu() just to reset it
back to vmcs_config.revision_id in alloc_vmxon_regions(). Simplify this by
introducing 'enum vmx_area_type' parameter to what is now known as
alloc_vmx_area_cpu().

No functional change intended.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 31 +++++++++++++------------------
 arch/x86/kvm/vmx/vmx.h | 12 +++++++++---
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index dab19e4e5f2b..4ee19fb35cde 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2554,7 +2554,7 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 	return 0;
 }
 
-struct vmcs *alloc_vmcs_cpu(bool shadow, int cpu, gfp_t flags)
+struct vmcs *alloc_vmx_area_cpu(enum vmx_area_type type, int cpu, gfp_t flags)
 {
 	int node = cpu_to_node(cpu);
 	struct page *pages;
@@ -2566,13 +2566,21 @@ struct vmcs *alloc_vmcs_cpu(bool shadow, int cpu, gfp_t flags)
 	vmcs = page_address(pages);
 	memset(vmcs, 0, vmcs_config.size);
 
-	/* KVM supports Enlightened VMCS v1 only */
-	if (static_branch_unlikely(&enable_evmcs))
+	/*
+	 * When eVMCS is enabled, vmcs->revision_id needs to be set to the
+	 * supported eVMCS version (KVM_EVMCS_VERSION) instead of revision_id
+	 * reported by MSR_IA32_VMX_BASIC.
+	 *
+	 * However, even though not explicitly documented by TLFS, VMXArea
+	 * passed as VMXON argument should still be marked with revision_id
+	 * reported by physical CPU.
+	 */
+	if (type != VMXON_REGION && static_branch_unlikely(&enable_evmcs))
 		vmcs->hdr.revision_id = KVM_EVMCS_VERSION;
 	else
 		vmcs->hdr.revision_id = vmcs_config.revision_id;
 
-	if (shadow)
+	if (type == SHADOW_VMCS_REGION)
 		vmcs->hdr.shadow_vmcs = 1;
 	return vmcs;
 }
@@ -2652,25 +2660,12 @@ static __init int alloc_vmxon_regions(void)
 	for_each_possible_cpu(cpu) {
 		struct vmcs *vmcs;
 
-		vmcs = alloc_vmcs_cpu(false, cpu, GFP_KERNEL);
+		vmcs = alloc_vmx_area_cpu(VMXON_REGION, cpu, GFP_KERNEL);
 		if (!vmcs) {
 			free_vmxon_regions();
 			return -ENOMEM;
 		}
 
-		/*
-		 * When eVMCS is enabled, alloc_vmcs_cpu() sets
-		 * vmcs->revision_id to KVM_EVMCS_VERSION instead of
-		 * revision_id reported by MSR_IA32_VMX_BASIC.
-		 *
-		 * However, even though not explicitly documented by
-		 * TLFS, VMXArea passed as VMXON argument should
-		 * still be marked with revision_id reported by
-		 * physical CPU.
-		 */
-		if (static_branch_unlikely(&enable_evmcs))
-			vmcs->hdr.revision_id = vmcs_config.revision_id;
-
 		per_cpu(vmxarea, cpu) = vmcs;
 	}
 	return 0;
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index e64da06c7009..7bdac5a50432 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -489,7 +489,13 @@ static inline struct pi_desc *vcpu_to_pi_desc(struct kvm_vcpu *vcpu)
 	return &(to_vmx(vcpu)->pi_desc);
 }
 
-struct vmcs *alloc_vmcs_cpu(bool shadow, int cpu, gfp_t flags);
+enum vmx_area_type {
+	VMXON_REGION,
+	VMCS_REGION,
+	SHADOW_VMCS_REGION,
+};
+
+struct vmcs *alloc_vmx_area_cpu(enum vmx_area_type type, int cpu, gfp_t flags);
 void free_vmcs(struct vmcs *vmcs);
 int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs);
 void free_loaded_vmcs(struct loaded_vmcs *loaded_vmcs);
@@ -498,8 +504,8 @@ void loaded_vmcs_clear(struct loaded_vmcs *loaded_vmcs);
 
 static inline struct vmcs *alloc_vmcs(bool shadow)
 {
-	return alloc_vmcs_cpu(shadow, raw_smp_processor_id(),
-			      GFP_KERNEL_ACCOUNT);
+	return alloc_vmx_area_cpu(shadow ? SHADOW_VMCS_REGION : VMCS_REGION,
+				  raw_smp_processor_id(), GFP_KERNEL_ACCOUNT);
 }
 
 u64 construct_eptp(struct kvm_vcpu *vcpu, unsigned long root_hpa);
-- 
2.24.1

