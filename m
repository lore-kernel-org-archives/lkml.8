Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86C9C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A585621D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587049178;
	bh=0QWkgSBGNSY24xOj/Y0cCCQ4J4uNUMUkBlsyxRF5Sm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wSxouF3v3GfRD48yh5E2KTBBNIksrMF1K2h5UOvnrwP0Uv2B6E0hpJV7mQihi9avK
	 tVtKPVqIRGiczbXPrDMzu2LWfvfbfI0FISm01BxCCBMJfDARpnocl+wZ/mTrwrN8IV
	 KsKJO97uZPlTs6ecX91tiWhf4S99OMnI/ZGU/NFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409057AbgDPNyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:54:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896376AbgDPNhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:37:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8995D21BE5;
        Thu, 16 Apr 2020 13:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044274;
        bh=0QWkgSBGNSY24xOj/Y0cCCQ4J4uNUMUkBlsyxRF5Sm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s9YO2dNZylBPEb8bAWgO/TFCjyVUTyNWkfcp6056IxgMMbVa5fQNkYUYEt5SBcCsr
         KZAe1paHcO7oilvCFd6m2ii6dobkN70TInRAe03JpDE4qkOsIDTzQ8tFOCpn+XrIWD
         Ltf+3w4HO3R62JsEECR1FTcWHJhJeSWDOEkU3JSQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.5 150/257] KVM: VMX: fix crash cleanup when KVM wasnt used
Date:   Thu, 16 Apr 2020 15:23:21 +0200
Message-Id: <20200416131345.257475880@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

commit dbef2808af6c594922fe32833b30f55f35e9da6d upstream.

If KVM wasn't used at all before we crash the cleanup procedure fails with
 BUG: unable to handle page fault for address: ffffffffffffffc8
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 23215067 P4D 23215067 PUD 23217067 PMD 0
 Oops: 0000 [#8] SMP PTI
 CPU: 0 PID: 3542 Comm: bash Kdump: loaded Tainted: G      D           5.6.0-rc2+ #823
 RIP: 0010:crash_vmclear_local_loaded_vmcss.cold+0x19/0x51 [kvm_intel]

The root cause is that loaded_vmcss_on_cpu list is not yet initialized,
we initialize it in hardware_enable() but this only happens when we start
a VM.

Previously, we used to have a bitmap with enabled CPUs and that was
preventing [masking] the issue.

Initialized loaded_vmcss_on_cpu list earlier, right before we assign
crash_vmclear_loaded_vmcss pointer. blocked_vcpu_on_cpu list and
blocked_vcpu_on_cpu_lock are moved altogether for consistency.

Fixes: 31603d4fc2bb ("KVM: VMX: Always VMCLEAR in-use VMCSes during crash with kexec support")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Message-Id: <20200401081348.1345307-1-vkuznets@redhat.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx/vmx.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2232,10 +2232,6 @@ static int hardware_enable(void)
 	    !hv_get_vp_assist_page(cpu))
 		return -EFAULT;
 
-	INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
-	INIT_LIST_HEAD(&per_cpu(blocked_vcpu_on_cpu, cpu));
-	spin_lock_init(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
-
 	rdmsrl(MSR_IA32_FEATURE_CONTROL, old);
 
 	test_bits = FEATURE_CONTROL_LOCKED;
@@ -8006,7 +8002,7 @@ module_exit(vmx_exit);
 
 static int __init vmx_init(void)
 {
-	int r;
+	int r, cpu;
 
 #if IS_ENABLED(CONFIG_HYPERV)
 	/*
@@ -8060,6 +8056,12 @@ static int __init vmx_init(void)
 		return r;
 	}
 
+	for_each_possible_cpu(cpu) {
+		INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
+		INIT_LIST_HEAD(&per_cpu(blocked_vcpu_on_cpu, cpu));
+		spin_lock_init(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
+	}
+
 #ifdef CONFIG_KEXEC_CORE
 	rcu_assign_pointer(crash_vmclear_loaded_vmcss,
 			   crash_vmclear_local_loaded_vmcss);


