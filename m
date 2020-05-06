Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171F3C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4FEA208DB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iT3SEj5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbgEFQK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:10:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52426 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730079AbgEFQK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588781456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=mO2cbCNKcikCnw3F7MmMk3VRPD9PlPNFWjMwHjblbP0=;
        b=iT3SEj5OOGfG+eZgzvOqGlxVI30ypHgsK9fmPkwAv7Z0aXubhaMWK2KgDtbwuyE2/4I58P
        rZlxsATbJsaAvPXXK84m3lhAoVjaON0oKFDWAiz+ztrqsvNv1B4Sf+IZ+r9vAsuflfsuIJ
        iuLecjTvXYCbHx2SBVsgAERs/CNhzGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-_1iY6fShO8WrymE-8YA11A-1; Wed, 06 May 2020 12:10:54 -0400
X-MC-Unique: _1iY6fShO8WrymE-8YA11A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6C4C100A8E7;
        Wed,  6 May 2020 16:10:52 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A1D6165F6;
        Wed,  6 May 2020 16:10:51 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     wanpengli@tencent.com, linxl3@wangsu.com,
        Haiwei Li <lihaiwei@tencent.com>
Subject: [PATCH 2/7] KVM: X86: Introduce kvm_vcpu_exit_request() helper
Date:   Wed,  6 May 2020 12:10:43 -0400
Message-Id: <20200506161048.28840-3-pbonzini@redhat.com>
In-Reply-To: <20200506161048.28840-1-pbonzini@redhat.com>
References: <20200506161048.28840-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Introduce kvm_vcpu_exit_request() helper, we need to check some conditions
before enter guest again immediately, we skip invoking the exit handler and
go through full run loop if complete fastpath but there is stuff preventing
we enter guest again immediately.

Tested-by: Haiwei Li <lihaiwei@tencent.com>
Cc: Haiwei Li <lihaiwei@tencent.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Message-Id: <1588055009-12677-5-git-send-email-wanpengli@tencent.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c | 10 ++++++++--
 arch/x86/kvm/x86.h |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e7017c656311..999275795bba 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1581,6 +1581,13 @@ int kvm_emulate_wrmsr(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_emulate_wrmsr);
 
+bool kvm_vcpu_exit_request(struct kvm_vcpu *vcpu)
+{
+	return vcpu->mode == EXITING_GUEST_MODE || kvm_request_pending(vcpu) ||
+		need_resched() || signal_pending(current);
+}
+EXPORT_SYMBOL_GPL(kvm_vcpu_exit_request);
+
 /*
  * The fast path for frequent and performance sensitive wrmsr emulation,
  * i.e. the sending of IPI, sending IPI early in the VM-Exit flow reduces
@@ -8365,8 +8372,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	if (kvm_lapic_enabled(vcpu) && vcpu->arch.apicv_active)
 		kvm_x86_ops.sync_pir_to_irr(vcpu);
 
-	if (vcpu->mode == EXITING_GUEST_MODE || kvm_request_pending(vcpu)
-	    || need_resched() || signal_pending(current)) {
+	if (kvm_vcpu_exit_request(vcpu)) {
 		vcpu->mode = OUTSIDE_GUEST_MODE;
 		smp_wmb();
 		local_irq_enable();
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 7b5ed8ed628e..e02fe28254b6 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -364,5 +364,6 @@ static inline bool kvm_dr7_valid(u64 data)
 void kvm_load_guest_xsave_state(struct kvm_vcpu *vcpu);
 void kvm_load_host_xsave_state(struct kvm_vcpu *vcpu);
 u64 kvm_spec_ctrl_valid_bits(struct kvm_vcpu *vcpu);
+bool kvm_vcpu_exit_request(struct kvm_vcpu *vcpu);
 
 #endif
-- 
2.18.2


