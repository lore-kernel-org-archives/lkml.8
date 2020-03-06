Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44F6C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBFB208CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3K+PvWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgCFNC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:02:27 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41074 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726635AbgCFNCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:02:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583499743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DEYmwO34ejd5Fehx/7gH5NvWBz/ItGWjm6SWsG9bpRU=;
        b=R3K+PvWpRd2EWLVto9/+HoNoaZbEwko7m+qrxAEH73dADnb2W0dDfmLoUyEExw75s5A/Jd
        uJUU6akwtA39pjQCZQpvod80Eb4aHnkz+/IPXzY7NQoll89+zuYuwnpcPiHrGjXQRj9qZ2
        LI9440kEC9nUSJBRZ+6SuULh3UKvVk4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-tNWInp2bNvCSba2xVDsxzg-1; Fri, 06 Mar 2020 08:02:22 -0500
X-MC-Unique: tNWInp2bNvCSba2xVDsxzg-1
Received: by mail-wr1-f72.google.com with SMTP id b12so974155wro.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 05:02:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DEYmwO34ejd5Fehx/7gH5NvWBz/ItGWjm6SWsG9bpRU=;
        b=sVTsYdMAdB2prscGNVqFIKQYn3aAfwuTEkSQtmbg62QZEklUqL3/F4ehDRlHT7RCP7
         J2D6LqkovPUX6QkjDd5au6gNPKqti6Uho9CHHmHRcRKWJC7bSH5x0JETClacBBJQrOw1
         UBaYz/KB5us3ij3d+9TTe/PziqNMdEq0lMYXcvjVb19h6cSDY1/q826uWv9CzKYZV+Yn
         HflDy1K0QAqL7CcTX/3PklVTPOmWWjSWsvSD6TFUAit5gm199a7s+QaqLl4ausrR8rIf
         BUgJkhiA/IUZjDK/MQpZPaMG9sm7imEXvc7prDDzx9jhZiYMRNvIsftZBYC/7mFBmYGl
         HH7A==
X-Gm-Message-State: ANhLgQ0hl45mcVgpQ8ZnhHklZE/QqBq6nJ/5FS9IN8I5SrlL3NSFEfu2
        Rkh0AB7sSZKzPqqeT4/6PgYMPHewMYLn+h7dtK9n45YpAdjNbG2qxlMKoiAH1eiawhyvArASLk9
        Fn7dhv+nVwSy3x4Zu3H2vKKZV
X-Received: by 2002:a5d:4cc6:: with SMTP id c6mr3928186wrt.30.1583499741192;
        Fri, 06 Mar 2020 05:02:21 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvzKd18Q9ZyAetOJWJu+50Kd94+STONaewuv+fP1bA7GRouCbY0I5lzU1pvtQCmm1vExEeYRg==
X-Received: by 2002:a5d:4cc6:: with SMTP id c6mr3928150wrt.30.1583499740818;
        Fri, 06 Mar 2020 05:02:20 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i67sm26613243wri.50.2020.03.06.05.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 05:02:20 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] KVM: VMX: untangle VMXON revision_id setting when using eVMCS
Date:   Fri,  6 Mar 2020 14:02:15 +0100
Message-Id: <20200306130215.150686-3-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200306130215.150686-1-vkuznets@redhat.com>
References: <20200306130215.150686-1-vkuznets@redhat.com>
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
index e920d7834d73..8c0ed62b29be 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4566,7 +4566,7 @@ static struct vmcs *alloc_shadow_vmcs(struct kvm_vcpu *vcpu)
 	WARN_ON(loaded_vmcs == &vmx->vmcs01 && loaded_vmcs->shadow_vmcs);
 
 	if (!loaded_vmcs->shadow_vmcs) {
-		loaded_vmcs->shadow_vmcs = alloc_vmcs(true);
+		loaded_vmcs->shadow_vmcs = alloc_vmcs(SHADOW_VMCS_REGION);
 		if (loaded_vmcs->shadow_vmcs)
 			vmcs_clear(loaded_vmcs->shadow_vmcs);
 	}
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index dab19e4e5f2b..a45d3721e7d7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2554,7 +2554,7 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 	return 0;
 }
 
-struct vmcs *alloc_vmcs_cpu(bool shadow, int cpu, gfp_t flags)
+struct vmcs *alloc_vmcs_cpu(enum vmcs_type type, int cpu, gfp_t flags)
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
@@ -2599,7 +2607,7 @@ void free_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
 
 int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
 {
-	loaded_vmcs->vmcs = alloc_vmcs(false);
+	loaded_vmcs->vmcs = alloc_vmcs(VMCS_REGION);
 	if (!loaded_vmcs->vmcs)
 		return -ENOMEM;
 
@@ -2652,25 +2660,13 @@ static __init int alloc_vmxon_regions(void)
 	for_each_possible_cpu(cpu) {
 		struct vmcs *vmcs;
 
-		vmcs = alloc_vmcs_cpu(false, cpu, GFP_KERNEL);
+		/* The VMXON region is really just a special type of VMCS. */
+		vmcs = alloc_vmcs_cpu(VMXON_REGION, cpu, GFP_KERNEL);
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
index e64da06c7009..a5eb92638ac2 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -489,16 +489,22 @@ static inline struct pi_desc *vcpu_to_pi_desc(struct kvm_vcpu *vcpu)
 	return &(to_vmx(vcpu)->pi_desc);
 }
 
-struct vmcs *alloc_vmcs_cpu(bool shadow, int cpu, gfp_t flags);
+enum vmcs_type {
+	VMXON_REGION,
+	VMCS_REGION,
+	SHADOW_VMCS_REGION,
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
2.24.1

