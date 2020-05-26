Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA47AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9098320723
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="McbNL7jb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389184AbgEZRXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 13:23:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50216 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389041AbgEZRXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590513797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mazbyic5SNu4z+oYUVy8aNG0fo9KurpfXXhcRmnZBAA=;
        b=McbNL7jbIhlzjsntIKnmaPrxiVWAklJbg5OqqDFtyvNiN4bSFs8I0PDFCHV6fSB0/BEpUM
        2ldTBW306JCZQLFuCULJ3cpcc4/7zSXp4Fw7sCGgkBnCGjtj5myQuieumsD2qKcHe0CrSB
        NWSF03I8NmtRY02KCMunVY5HRc4z7JA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-R9dLhXesMk2XvwjrBP7zzQ-1; Tue, 26 May 2020 13:23:13 -0400
X-MC-Unique: R9dLhXesMk2XvwjrBP7zzQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 530621855A08;
        Tue, 26 May 2020 17:23:12 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE1F710013DB;
        Tue, 26 May 2020 17:23:11 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com, mlevitsk@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH 04/28] KVM: nSVM: remove exit_required
Date:   Tue, 26 May 2020 13:22:44 -0400
Message-Id: <20200526172308.111575-5-pbonzini@redhat.com>
In-Reply-To: <20200526172308.111575-1-pbonzini@redhat.com>
References: <20200526172308.111575-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All events now inject vmexits before vmentry rather than after vmexit.  Therefore,
exit_required is not set anymore and we can remove it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/nested.c |  3 +--
 arch/x86/kvm/svm/svm.c    | 14 --------------
 arch/x86/kvm/svm/svm.h    |  3 ---
 3 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 87fc5879dfaa..bbf991cfe24b 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -792,8 +792,7 @@ static int svm_check_nested_events(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	bool block_nested_events =
-		kvm_event_needs_reinjection(vcpu) || svm->nested.exit_required ||
-		svm->nested.nested_run_pending;
+		kvm_event_needs_reinjection(vcpu) || svm->nested.nested_run_pending;
 
 	if (vcpu->arch.exception.pending) {
 		if (block_nested_events)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 251c457820a1..270061fa6cfa 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2889,13 +2889,6 @@ static int handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	if (npt_enabled)
 		vcpu->arch.cr3 = svm->vmcb->save.cr3;
 
-	if (unlikely(svm->nested.exit_required)) {
-		nested_svm_vmexit(svm);
-		svm->nested.exit_required = false;
-
-		return 1;
-	}
-
 	if (is_guest_mode(vcpu)) {
 		int vmexit;
 
@@ -3327,13 +3320,6 @@ static fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
 	svm->vmcb->save.rsp = vcpu->arch.regs[VCPU_REGS_RSP];
 	svm->vmcb->save.rip = vcpu->arch.regs[VCPU_REGS_RIP];
 
-	/*
-	 * A vmexit emulation is required before the vcpu can be executed
-	 * again.
-	 */
-	if (unlikely(svm->nested.exit_required))
-		return EXIT_FASTPATH_NONE;
-
 	/*
 	 * Disable singlestep if we're injecting an interrupt/exception.
 	 * We don't want our modified rflags to be pushed on the stack where
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 8342032291fc..89fab75dd4f5 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -95,9 +95,6 @@ struct nested_state {
 	u64 vmcb_msrpm;
 	u64 vmcb_iopm;
 
-	/* A VMEXIT is required but not yet emulated */
-	bool exit_required;
-
 	/* A VMRUN has started but has not yet been performed, so
 	 * we cannot inject a nested vmexit yet.  */
 	bool nested_run_pending;
-- 
2.26.2


