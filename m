Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87A6C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DAA20753
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JRdLgNTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgCRRSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:18:08 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:29513 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727137AbgCRRSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584551885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=osqxPKvRCIWXWuFT/CxaCeJ4py4f1evn1ExGWO1bP8M=;
        b=JRdLgNTRzW8B0y0vV2PFvmo9M+MsK1ryvmssz74GPJ+wlZflWF4u44BjYnSfa9geueDqDv
        fYRiQF0P4TC7KfqIg/pXmRyChEPhWM3odeegj+6YAI9XEDBHaZrtVIClazPpx7yQxohM28
        KFjBD/zcpagq70sGPWnqZT9976dkDMg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-R1v5rGO8P22PEAIwmdnMtQ-1; Wed, 18 Mar 2020 13:18:04 -0400
X-MC-Unique: R1v5rGO8P22PEAIwmdnMtQ-1
Received: by mail-wm1-f71.google.com with SMTP id a23so1379023wmm.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=osqxPKvRCIWXWuFT/CxaCeJ4py4f1evn1ExGWO1bP8M=;
        b=sMwj2ipAvxdnLk5L0FgsKiplvVjvkvH3BW+cnA9POiHIsttpIiku6/LA5EGySWjtNs
         1ShmQMt4AVAb8caBBQz8z9dlHf/+JpYOxMEKgfbGFkPt5T7J0N0u1YLXAqKj1078gCwZ
         z3iA79Fb4xFACk30n/m1eBBr+MI+dbEW7AkwwXW8xdj/OYPtuuy3P4iyqvF1WiTmCYwv
         LU9jKjN0mMnDMPVjIktM8eyUm67l6JTEUq8UL7XeCly3qFeqOCwzzeA/KfzT9MZaB80O
         tbIysNO4kLLk9vHhgYZFJXV4lTwMVDANjqxYgMJVfm0Zcit32lQsX+fZt+6K9VR65w0b
         R6dw==
X-Gm-Message-State: ANhLgQ2LfWTTpaF5Li4SuIi/dNACsxq8spYubtouiSbHJdYF6HGakLKB
        9Waabrt0IdBhVeMpDzjRkNawQulmOx2K4wkHqFmU2cXERSr+Uo+nI2NpP/3CjLVtZefphtQHdBr
        acECIsOjFt7skzGS5V/w8ANQv
X-Received: by 2002:a5d:4d86:: with SMTP id b6mr6613549wru.253.1584551882558;
        Wed, 18 Mar 2020 10:18:02 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvL0SbgPICsxsmop2pNCAqWqf7Jg1CLWlDmbG7uRzFLFIagUltToENth0Nzi/IRSagEPvFVBw==
X-Received: by 2002:a5d:4d86:: with SMTP id b6mr6613188wru.253.1584551877460;
        Wed, 18 Mar 2020 10:17:57 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id r3sm10531597wrw.76.2020.03.18.10.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:17:56 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] KVM: VMX: untangle VMXON revision_id setting when using eVMCS
Date:   Wed, 18 Mar 2020 18:17:52 +0100
Message-Id: <20200318171752.173073-3-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200318171752.173073-1-vkuznets@redhat.com>
References: <20200318171752.173073-1-vkuznets@redhat.com>
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
introducing 'enum vmcs_type' parameter to alloc_vmcs_cpu()/alloc_vmcs().

No functional change intended.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/nested.c |  2 +-
 arch/x86/kvm/vmx/vmx.c    | 34 +++++++++++++++-------------------
 arch/x86/kvm/vmx/vmx.h    | 12 +++++++++---
 3 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 8578513907d7..7170c7d8aa1d 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4585,7 +4585,7 @@ static struct vmcs *alloc_shadow_vmcs(struct kvm_vcpu *vcpu)
 	WARN_ON(loaded_vmcs == &vmx->vmcs01 && loaded_vmcs->shadow_vmcs);
 
 	if (!loaded_vmcs->shadow_vmcs) {
-		loaded_vmcs->shadow_vmcs = alloc_vmcs(true);
+		loaded_vmcs->shadow_vmcs = alloc_vmcs(SHADOW_VMCS);
 		if (loaded_vmcs->shadow_vmcs)
 			vmcs_clear(loaded_vmcs->shadow_vmcs);
 	}
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f7ee7c31fe8c..534418b58247 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2541,7 +2541,7 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 	return 0;
 }
 
-struct vmcs *alloc_vmcs_cpu(bool shadow, int cpu, gfp_t flags)
+struct vmcs *alloc_vmcs_cpu(enum vmcs_type type, int cpu, gfp_t flags)
 {
 	int node = cpu_to_node(cpu);
 	struct page *pages;
@@ -2553,13 +2553,21 @@ struct vmcs *alloc_vmcs_cpu(bool shadow, int cpu, gfp_t flags)
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
+	if (type != VMXON_VMCS && static_branch_unlikely(&enable_evmcs))
 		vmcs->hdr.revision_id = KVM_EVMCS_VERSION;
 	else
 		vmcs->hdr.revision_id = vmcs_config.revision_id;
 
-	if (shadow)
+	if (type == SHADOW_VMCS)
 		vmcs->hdr.shadow_vmcs = 1;
 	return vmcs;
 }
@@ -2586,7 +2594,7 @@ void free_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
 
 int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
 {
-	loaded_vmcs->vmcs = alloc_vmcs(false);
+	loaded_vmcs->vmcs = alloc_vmcs(VMCS);
 	if (!loaded_vmcs->vmcs)
 		return -ENOMEM;
 
@@ -2639,25 +2647,13 @@ static __init int alloc_vmxon_regions(void)
 	for_each_possible_cpu(cpu) {
 		struct vmcs *vmcs;
 
-		vmcs = alloc_vmcs_cpu(false, cpu, GFP_KERNEL);
+		/* The VMXON region is really just a special type of VMCS. */
+		vmcs = alloc_vmcs_cpu(VMXON_VMCS, cpu, GFP_KERNEL);
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
index be93d597306c..b353e8cc3e7b 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -488,16 +488,22 @@ static inline struct pi_desc *vcpu_to_pi_desc(struct kvm_vcpu *vcpu)
 	return &(to_vmx(vcpu)->pi_desc);
 }
 
-struct vmcs *alloc_vmcs_cpu(bool shadow, int cpu, gfp_t flags);
+enum vmcs_type {
+	VMXON_VMCS,
+	VMCS,
+	SHADOW_VMCS,
+};
+
+struct vmcs *alloc_vmcs_cpu(enum vmcs_type type, int cpu, gfp_t flags);
 void free_vmcs(struct vmcs *vmcs);
 int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs);
 void free_loaded_vmcs(struct loaded_vmcs *loaded_vmcs);
 void loaded_vmcs_init(struct loaded_vmcs *loaded_vmcs);
 void loaded_vmcs_clear(struct loaded_vmcs *loaded_vmcs);
 
-static inline struct vmcs *alloc_vmcs(bool shadow)
+static inline struct vmcs *alloc_vmcs(enum vmcs_type type)
 {
-	return alloc_vmcs_cpu(shadow, raw_smp_processor_id(),
+	return alloc_vmcs_cpu(type, raw_smp_processor_id(),
 			      GFP_KERNEL_ACCOUNT);
 }
 
-- 
2.25.1

