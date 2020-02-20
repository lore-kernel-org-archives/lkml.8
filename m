Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA631C11D10
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916F3207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDW5mfze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgBTRWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:22:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33043 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726959AbgBTRWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:22:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582219336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4zSPAFD+pq1zzy8dMD3rvr6m7tZzVDJbOvdVC9ghOhg=;
        b=fDW5mfzePmyEcutRQZgQDLLWdAUP9vCfr0SqnudvF8myoGbZLjmCNflGCLiN//XYcLXzzD
        hN+nRrYyIZrWzaiLyS2fq3FRfPRsfSoS8UoO4aytQ9DzjO/pGDfPowQX6SPOWoG9b7d/mv
        DyFXer5lUxbFTR/Dy8ZQ4yK7Jo6GMi0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-F8OHhkEvMNiisYxtqkM80g-1; Thu, 20 Feb 2020 12:22:12 -0500
X-MC-Unique: F8OHhkEvMNiisYxtqkM80g-1
Received: by mail-wm1-f71.google.com with SMTP id m4so845291wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 09:22:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4zSPAFD+pq1zzy8dMD3rvr6m7tZzVDJbOvdVC9ghOhg=;
        b=QDatkQgji/AZOugnBYEyyGgDOsFOHmxsbS2xF5WQ3rSGbR4SC2wIspJ9Q6EhI/3UMG
         4Nf8LxDKUnZfNfAigcFIz1LNV16alnQrJ8nVqFD852xAgVm32WObB7QwEvDRv6YTu2ox
         Qhq6sCD8RnZ3VU0PUr0Rr7lThIXKB4UIpJdyGzsZTLpoj+761n4QwTPL7BjC1cAg501D
         fyLxLtdPiG34rBxNCYUPweKXwcHuJe/npel+IpAEmYSmDtnTPzH5wGl6YhE42tthn9BD
         11EOwtWyvX7bvBFfLIH56x4TIPNLOC7uzCZwq0WUkrmz14uaiq6zHUWzj4PGk5C/zAvC
         ZW5A==
X-Gm-Message-State: APjAAAVXqCIBIz6SgWbHEHBp3F4Omk9grNeFXFuAR8UieaSeYiKCSGbT
        DmOjb0/QEueIcHDZND6KflIehE5WWAXBjyEWEb6FT2QDpg3jMQa/2MF4qpzm4nEp4IBTu6prSCK
        unewpDyaoVNmrWQ6PS6eF61Fg
X-Received: by 2002:a7b:c3cd:: with SMTP id t13mr5561886wmj.88.1582219330729;
        Thu, 20 Feb 2020 09:22:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqyaovZTBPl60h/IscrnJlDVyp+IMSAuBmQqHyvNDD+J1VGVoB56M/2PEkihV8OeoQNnZMmPIw==
X-Received: by 2002:a7b:c3cd:: with SMTP id t13mr5561873wmj.88.1582219330489;
        Thu, 20 Feb 2020 09:22:10 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a184sm5355891wmf.29.2020.02.20.09.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 09:22:09 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/2] KVM: nVMX: handle nested posted interrupts when apicv is disabled for L1
Date:   Thu, 20 Feb 2020 18:22:05 +0100
Message-Id: <20200220172205.197767-3-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220172205.197767-1-vkuznets@redhat.com>
References: <20200220172205.197767-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even when APICv is disabled for L1 it can (and, actually, is) still
available for L2, this means we need to always call
vmx_deliver_nested_posted_interrupt() when attempting an interrupt
delivery.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/lapic.c            |  5 +----
 arch/x86/kvm/svm.c              |  7 ++++++-
 arch/x86/kvm/vmx/vmx.c          | 13 +++++++++----
 4 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 40a0c0fd95ca..a84e8c5acda8 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1146,7 +1146,7 @@ struct kvm_x86_ops {
 	void (*load_eoi_exitmap)(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
 	void (*set_virtual_apic_mode)(struct kvm_vcpu *vcpu);
 	void (*set_apic_access_page_addr)(struct kvm_vcpu *vcpu, hpa_t hpa);
-	void (*deliver_posted_interrupt)(struct kvm_vcpu *vcpu, int vector);
+	int (*deliver_posted_interrupt)(struct kvm_vcpu *vcpu, int vector);
 	int (*sync_pir_to_irr)(struct kvm_vcpu *vcpu);
 	int (*set_tss_addr)(struct kvm *kvm, unsigned int addr);
 	int (*set_identity_map_addr)(struct kvm *kvm, u64 ident_addr);
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index afcd30d44cbb..cc8ee8125712 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1046,11 +1046,8 @@ static int __apic_accept_irq(struct kvm_lapic *apic, int delivery_mode,
 						       apic->regs + APIC_TMR);
 		}
 
-		if (vcpu->arch.apicv_active)
-			kvm_x86_ops->deliver_posted_interrupt(vcpu, vector);
-		else {
+		if (kvm_x86_ops->deliver_posted_interrupt(vcpu, vector)) {
 			kvm_lapic_set_irr(vector, apic);
-
 			kvm_make_request(KVM_REQ_EVENT, vcpu);
 			kvm_vcpu_kick(vcpu);
 		}
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index bef0ba35f121..970a3ab2e926 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -5255,8 +5255,11 @@ static void svm_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
 	return;
 }
 
-static void svm_deliver_avic_intr(struct kvm_vcpu *vcpu, int vec)
+static int svm_deliver_avic_intr(struct kvm_vcpu *vcpu, int vec)
 {
+	if (!vcpu->arch.apicv_active)
+		return -1;
+
 	kvm_lapic_set_irr(vec, vcpu->arch.apic);
 	smp_mb__after_atomic();
 
@@ -5268,6 +5271,8 @@ static void svm_deliver_avic_intr(struct kvm_vcpu *vcpu, int vec)
 		put_cpu();
 	} else
 		kvm_vcpu_wake_up(vcpu);
+
+	return 0;
 }
 
 static bool svm_dy_apicv_has_pending_interrupt(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 946c74e661e2..92a14ea4be69 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3818,24 +3818,29 @@ static int vmx_deliver_nested_posted_interrupt(struct kvm_vcpu *vcpu,
  * 2. If target vcpu isn't running(root mode), kick it to pick up the
  * interrupt from PIR in next vmentry.
  */
-static void vmx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector)
+static int vmx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	int r;
 
 	r = vmx_deliver_nested_posted_interrupt(vcpu, vector);
 	if (!r)
-		return;
+		return 0;
+
+	if (!vcpu->arch.apicv_active)
+		return -1;
 
 	if (pi_test_and_set_pir(vector, &vmx->pi_desc))
-		return;
+		return 0;
 
 	/* If a previous notification has sent the IPI, nothing to do.  */
 	if (pi_test_and_set_on(&vmx->pi_desc))
-		return;
+		return 0;
 
 	if (!kvm_vcpu_trigger_posted_interrupt(vcpu, false))
 		kvm_vcpu_kick(vcpu);
+
+	return 0;
 }
 
 /*
-- 
2.24.1

