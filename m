Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAADC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A875624656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NS60GhjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgAORKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:10:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55816 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728963AbgAORKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 12:10:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579108223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mPgwZ2FjiJ6HjtpTVTA+tuZ9QlXeQvuG1PK2sLPEBfc=;
        b=NS60GhjOaBy/3TJznvsFgWh3gKyre6x0kyTTkPhyY9N113Hc04fd48X9MU6bo6QL6wSpe3
        qdEjx3jl8Yh1QWnotYN1yfmGXs92kFnUU5MYOAkZ5KoqjwMhN9JG1FxULImcRuPjLqQAWj
        +bWoEMGEcEuk/vONihnH6gMnoJb6PHY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-UkHHSHg6M_WFDyGjBTSMyQ-1; Wed, 15 Jan 2020 12:10:21 -0500
X-MC-Unique: UkHHSHg6M_WFDyGjBTSMyQ-1
Received: by mail-wr1-f72.google.com with SMTP id r2so8217848wrp.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 09:10:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mPgwZ2FjiJ6HjtpTVTA+tuZ9QlXeQvuG1PK2sLPEBfc=;
        b=rvM89aKv0PN9dMf0emp0QGuEzSiguLTq5AxkfkhY4q9DKGBKn0A5DQWys4QoFKtgMO
         qbdjFwUoNB6bmoPbaxbL7pPTC016rvmWzs5E5uFZsfZD3g70sB8m7aeq5/fJVQa4gWC/
         3I/YbYraAqtSDtTepWyuR5gekpYfoCHoKu21JdK+Bvl45nSYAu7m+2cpeO0BDEN7zNKa
         /XJ7naC08enkw+ZK3joHFSCmhFcQnGjI7SE3IFSUOoJ5b98mZwcgwnT/j41phQYPfiwH
         hQfHNLBdp2HbT60iMLB4ksBFnWCN4vDGWo7LSI4D48UflXoyjy89o1R1hZnwEB17BP74
         djaA==
X-Gm-Message-State: APjAAAXaltCeD/2ZQXKv7+UA93890/aUQf5EAGFiT79hUw8M+TwstZR5
        4CR4BpFG3vZpenaPBzjv4MtLGZ6n9WYILMk1M1bL61XJV+Vky4vJM89VCOaks0aJUvnvjGuTOxC
        lCxroVf+VbEAkkDRs8tXZv4kE
X-Received: by 2002:a5d:6089:: with SMTP id w9mr31924017wrt.228.1579108220832;
        Wed, 15 Jan 2020 09:10:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqzT7NE1CAajyd81QPxS6ycq9X5t7RxfdMr8x+Cmi4zgK1Ws1nujDxnaGNIEn84dq9nX1odeBw==
X-Received: by 2002:a5d:6089:: with SMTP id w9mr31923992wrt.228.1579108220555;
        Wed, 15 Jan 2020 09:10:20 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y20sm525071wmi.25.2020.01.15.09.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 09:10:19 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Liran Alon <liran.alon@oracle.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: [PATCH RFC 3/3] x86/kvm/hyper-v: don't allow to turn on unsupported VMX controls for nested guests
Date:   Wed, 15 Jan 2020 18:10:14 +0100
Message-Id: <20200115171014.56405-4-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115171014.56405-1-vkuznets@redhat.com>
References: <20200115171014.56405-1-vkuznets@redhat.com>
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
 arch/x86/kvm/vmx/evmcs.c  | 56 ++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/vmx/evmcs.h  |  1 +
 arch/x86/kvm/vmx/nested.c |  3 +++
 3 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
index b5d6582ba589..88f462866396 100644
--- a/arch/x86/kvm/vmx/evmcs.c
+++ b/arch/x86/kvm/vmx/evmcs.c
@@ -4,9 +4,11 @@
 #include <linux/smp.h>
 
 #include "../hyperv.h"
-#include "evmcs.h"
 #include "vmcs.h"
+#include "vmcs12.h"
+#include "evmcs.h"
 #include "vmx.h"
+#include "trace.h"
 
 DEFINE_STATIC_KEY_FALSE(enable_evmcs);
 
@@ -378,6 +380,58 @@ void nested_evmcs_filter_control_msr(u32 msr_index, u64 *pdata)
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
index b88d9807a796..cb7517a5a41c 100644
--- a/arch/x86/kvm/vmx/evmcs.h
+++ b/arch/x86/kvm/vmx/evmcs.h
@@ -202,5 +202,6 @@ uint16_t nested_get_evmcs_version(struct kvm_vcpu *vcpu);
 int nested_enable_evmcs(struct kvm_vcpu *vcpu,
 			uint16_t *vmcs_version);
 void nested_evmcs_filter_control_msr(u32 msr_index, u64 *pdata);
+int nested_evmcs_check_controls(struct vmcs12 *vmcs12);
 
 #endif /* __KVM_X86_VMX_EVMCS_H */
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 4aea7d304beb..7c720b095663 100644
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

