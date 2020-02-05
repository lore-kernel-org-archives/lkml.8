Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE1EC35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0F5217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvuN2YC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgBEMaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 07:30:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43313 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727999AbgBEMap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 07:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580905844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kH9R5qygaELgrXQXaWn/tfFU/2DvggTDzmG5IhlZM0c=;
        b=WvuN2YC4EYNkxalkPkS4Lpnu9xCfgwerpiWAKiE1mKMAN0IlanwXOUqtBR2/vaxuGrT0k2
        WCS2lH44qK1z5GygQBMRdMX75l9ASuwr29O0clNwMVxHzkMQ4hNoKuLzYb1U0O/iNca0Qg
        53H9VNAiH/8lVeIW7bgZpPCz8xed1lg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-aEpMxZXRMAO_YefeJl_nIg-1; Wed, 05 Feb 2020 07:30:42 -0500
X-MC-Unique: aEpMxZXRMAO_YefeJl_nIg-1
Received: by mail-wr1-f70.google.com with SMTP id c6so1098409wrm.18
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 04:30:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kH9R5qygaELgrXQXaWn/tfFU/2DvggTDzmG5IhlZM0c=;
        b=NV8Nf4qJhjKlQ6EzKO+qxqn/ShmdgbnXCHehPpravCRB1rtbUmNj9atfoCh6ZvNEXd
         Iv1h7/b8tcR0Ik2WFQZlyf99o8Xk6smQ3US+BvXwuKKggmXmRG6jEd2ZAQAXjgLeyiEp
         p7NbwbAlCzO6te04XjTfeOBxEBWbvWcYAkB3q5zLWCU9gMhzV1LJROG/9C21P5NT+upu
         E3z4xWhhZGKwpUPhGP0Aun57tC9GZDSLTEqALhCkKvcX77cD3AxGUs+YyIHOSGNxfGqo
         1ie8QEKVulU4kASb1jok0lUk3UepBcR6L0UT15Jp0Wm6YQ2JkoYiKeXuzZ+Wa145gOK/
         3y8w==
X-Gm-Message-State: APjAAAUEahB0heU6BjfLifeAaxzTeCLE68gr+HgYL2aMkjHEO8tIBZHn
        ZQfZ+ZmIlbKF8R/NzZRyvlGskIj+qZQ/4YUc4djkHLJASIRo8vnZYdA8vRTiy604Fudh8kbb5/o
        H1u/NNaP/ni1pMSfxHK5d2/so
X-Received: by 2002:adf:ea4d:: with SMTP id j13mr23997730wrn.292.1580905841362;
        Wed, 05 Feb 2020 04:30:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqy6a7nZphH4CpZdYImL27XES4Yf2yGaYtSWHx6fRouFNr/X6nSst7FOsMjeu0DoqFuZVNRk3A==
X-Received: by 2002:adf:ea4d:: with SMTP id j13mr23997707wrn.292.1580905841119;
        Wed, 05 Feb 2020 04:30:41 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g7sm34227251wrq.21.2020.02.05.04.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 04:30:39 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Liran Alon <liran.alon@oracle.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: [PATCH 3/3] x86/kvm/hyper-v: don't allow to turn on unsupported VMX controls for nested guests
Date:   Wed,  5 Feb 2020 13:30:34 +0100
Message-Id: <20200205123034.630229-4-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205123034.630229-1-vkuznets@redhat.com>
References: <20200205123034.630229-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sane L1 hypervisors are not supposed to turn any of the unsupported VMX
controls on for its guests and nested_vmx_check_controls() checks for
that. This is, however, not the case for the controls which are supported
on the host but are missing in enlightened VMCS and when eVMCS is in use.

It would certainly be possible to add these missing checks to
nested_check_vm_execution_controls()/_vm_exit_controls()/.. but it seems
preferable to keep eVMCS-specific stuff in eVMCS and reduce the impact on
non-eVMCS guests by doing less unrelated checks. Create a separate
nested_evmcs_check_controls() for this purpose.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/evmcs.c  | 53 +++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/evmcs.h  |  2 ++
 arch/x86/kvm/vmx/nested.c |  3 +++
 3 files changed, 58 insertions(+)

diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
index ba886fb7bc39..303813423c3e 100644
--- a/arch/x86/kvm/vmx/evmcs.c
+++ b/arch/x86/kvm/vmx/evmcs.c
@@ -7,6 +7,7 @@
 #include "evmcs.h"
 #include "vmcs.h"
 #include "vmx.h"
+#include "trace.h"
 
 DEFINE_STATIC_KEY_FALSE(enable_evmcs);
 
@@ -372,6 +373,58 @@ void nested_evmcs_filter_control_msr(u32 msr_index, u64 *pdata)
 	*pdata = ctl_low | ((u64)ctl_high << 32);
 }
 
+int nested_evmcs_check_controls(struct vmcs12 *vmcs12)
+{
+	int ret = 0;
+	u32 unsupp_ctl;
+
+	unsupp_ctl = vmcs12->pin_based_vm_exec_control &
+		EVMCS1_UNSUPPORTED_PINCTRL;
+	if (unsupp_ctl) {
+		trace_kvm_nested_vmenter_failed(
+			"eVMCS: unsupported pin-based VM-execution controls",
+			unsupp_ctl);
+		ret = -EINVAL;
+	}
+
+	unsupp_ctl = vmcs12->secondary_vm_exec_control &
+		EVMCS1_UNSUPPORTED_2NDEXEC;
+	if (unsupp_ctl) {
+		trace_kvm_nested_vmenter_failed(
+			"eVMCS: unsupported secondary VM-execution controls",
+			unsupp_ctl);
+		ret = -EINVAL;
+	}
+
+	unsupp_ctl = vmcs12->vm_exit_controls &
+		EVMCS1_UNSUPPORTED_VMEXIT_CTRL;
+	if (unsupp_ctl) {
+		trace_kvm_nested_vmenter_failed(
+			"eVMCS: unsupported VM-exit controls",
+			unsupp_ctl);
+		ret = -EINVAL;
+	}
+
+	unsupp_ctl = vmcs12->vm_entry_controls &
+		EVMCS1_UNSUPPORTED_VMENTRY_CTRL;
+	if (unsupp_ctl) {
+		trace_kvm_nested_vmenter_failed(
+			"eVMCS: unsupported VM-entry controls",
+			unsupp_ctl);
+		ret = -EINVAL;
+	}
+
+	unsupp_ctl = vmcs12->vm_function_control & EVMCS1_UNSUPPORTED_VMFUNC;
+	if (unsupp_ctl) {
+		trace_kvm_nested_vmenter_failed(
+			"eVMCS: unsupported VM-function controls",
+			unsupp_ctl);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 int nested_enable_evmcs(struct kvm_vcpu *vcpu,
 			uint16_t *vmcs_version)
 {
diff --git a/arch/x86/kvm/vmx/evmcs.h b/arch/x86/kvm/vmx/evmcs.h
index b88d9807a796..6de47f2569c9 100644
--- a/arch/x86/kvm/vmx/evmcs.h
+++ b/arch/x86/kvm/vmx/evmcs.h
@@ -10,6 +10,7 @@
 
 #include "capabilities.h"
 #include "vmcs.h"
+#include "vmcs12.h"
 
 struct vmcs_config;
 
@@ -202,5 +203,6 @@ uint16_t nested_get_evmcs_version(struct kvm_vcpu *vcpu);
 int nested_enable_evmcs(struct kvm_vcpu *vcpu,
 			uint16_t *vmcs_version);
 void nested_evmcs_filter_control_msr(u32 msr_index, u64 *pdata);
+int nested_evmcs_check_controls(struct vmcs12 *vmcs12);
 
 #endif /* __KVM_X86_VMX_EVMCS_H */
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 6879966b7648..b9fd508f40c5 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2767,6 +2767,9 @@ static int nested_vmx_check_controls(struct kvm_vcpu *vcpu,
 	    nested_check_vm_entry_controls(vcpu, vmcs12))
 		return -EINVAL;
 
+	if (to_vmx(vcpu)->nested.enlightened_vmcs_enabled)
+		return nested_evmcs_check_controls(vmcs12);
+
 	return 0;
 }
 
-- 
2.24.1

