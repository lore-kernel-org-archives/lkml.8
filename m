Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7B3C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B31E20704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PItbGq8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgDXRZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:25:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35277 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726698AbgDXRYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587749076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=urUA8szmOjF8TY/rJiBW3e0Wg6p5Hv2oHLXiGg8Oq0o=;
        b=PItbGq8yXnn57sg39Ya6mdtl3ZLdhhrEMKWB3S5A/c9KI32fydvs9pv9rg4EmEpzLvsxBV
        2VAtSguXLYumKzqw1KAN/vnA5Bi11W7SsekH4XcfXU+KzFYR69Qpgk5tdO4L75XfflDqgO
        Nuz19mZufMvINOQOYsGNfQq/9wTgPho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-0mgY1dxVNxO22Tior9hslg-1; Fri, 24 Apr 2020 13:24:33 -0400
X-MC-Unique: 0mgY1dxVNxO22Tior9hslg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA8371800D42;
        Fri, 24 Apr 2020 17:24:19 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1E651FDE1;
        Fri, 24 Apr 2020 17:24:18 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     wei.huang2@amd.com, cavery@redhat.com, vkuznets@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Oliver Upton <oupton@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH v2 01/22] KVM: SVM: introduce nested_run_pending
Date:   Fri, 24 Apr 2020 13:23:55 -0400
Message-Id: <20200424172416.243870-2-pbonzini@redhat.com>
In-Reply-To: <20200424172416.243870-1-pbonzini@redhat.com>
References: <20200424172416.243870-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to inject vmexits immediately from svm_check_nested_events,
so that the interrupt/NMI window requests happen in inject_pending_event
right after it returns.

This however has the same issue as in vmx_check_nested_events, so
introduce a nested_run_pending flag with the exact same purpose
of delaying vmexit injection after the vmentry.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 3 ++-
 arch/x86/kvm/svm/svm.c    | 1 +
 arch/x86/kvm/svm/svm.h    | 4 ++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index a7c3b3030e59..51cfab68428d 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -413,6 +413,7 @@ int nested_svm_vmrun(struct vcpu_svm *svm)
 
 	copy_vmcb_control_area(hsave, vmcb);
 
+	svm->nested.nested_run_pending = 1;
 	enter_svm_guest_mode(svm, vmcb_gpa, nested_vmcb, &map);
 
 	if (!nested_svm_vmrun_msrpm(svm)) {
@@ -792,7 +793,8 @@ static int svm_check_nested_events(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	bool block_nested_events =
-		kvm_event_needs_reinjection(vcpu) || svm->nested.exit_required;
+		kvm_event_needs_reinjection(vcpu) || svm->nested.exit_required ||
+		svm->nested.nested_run_pending;
 
 	if (kvm_cpu_has_interrupt(vcpu) && nested_exit_on_intr(svm)) {
 		if (block_nested_events)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index c86f7278509b..77440b5953e3 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3417,6 +3417,7 @@ static enum exit_fastpath_completion svm_vcpu_run(struct kvm_vcpu *vcpu)
 	sync_cr8_to_lapic(vcpu);
 
 	svm->next_rip = 0;
+	svm->nested.nested_run_pending = 0;
 
 	svm->vmcb->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 98c2890d561d..435f3328c99c 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -97,6 +97,10 @@ struct nested_state {
 	/* A VMEXIT is required but not yet emulated */
 	bool exit_required;
 
+	/* A VMRUN has started but has not yet been performed, so
+	 * we cannot inject a nested vmexit yet.  */
+	bool nested_run_pending;
+
 	/* cache for intercepts of the guest */
 	u32 intercept_cr;
 	u32 intercept_dr;
-- 
2.18.2


