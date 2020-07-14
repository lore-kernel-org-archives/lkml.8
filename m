Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00ACC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FADA2255F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753271;
	bh=imOiDUvX9IgMI4DgKmLXDbP4TlQTsiuChEG4SULf2I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ILuQBrKzHyEUxDa4f/ad0okOdu+fAEfCXUY0lIV20QKWIEZnD73Ydg/F5catSOLsO
	 c+iWwYp0jRSp1C4c0jnFDEY9aftH5cDoOePJd6TLlVxQMC68HY496zWdz91szRArJK
	 q6FXTytVZJiRw7WRf6hCLOenskOMAOOgcGenEz8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbgGNTBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:01:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730809AbgGNTAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:00:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2331222B9;
        Tue, 14 Jul 2020 19:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594753211;
        bh=imOiDUvX9IgMI4DgKmLXDbP4TlQTsiuChEG4SULf2I0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EYJrgTHhUhtPF+6F1VSPisLCcfctAA/8NHBzeFY32dURW75WhgxLxaYJpAmN1PBUr
         dfLWvIpjk2YXVbjlVYQlQtOc71CeMrWC/UWcgZG1umMa4Fo2RESKNVvktwDDPaR/Fj
         lmNhklmX3k+zGQrKb1Z+uNaTCZGAMLBANpb7KYeE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.7 122/166] KVM: x86: Mark CR4.TSD as being possibly owned by the guest
Date:   Tue, 14 Jul 2020 20:44:47 +0200
Message-Id: <20200714184121.677249888@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 7c83d096aed055a7763a03384f92115363448b71 upstream.

Mark CR4.TSD as being possibly owned by the guest as that is indeed the
case on VMX.  Without TSD being tagged as possibly owned by the guest, a
targeted read of CR4 to get TSD could observe a stale value.  This bug
is benign in the current code base as the sole consumer of TSD is the
emulator (for RDTSC) and the emulator always "reads" the entirety of CR4
when grabbing bits.

Add a build-time assertion in to ensure VMX doesn't hand over more CR4
bits without also updating x86.

Fixes: 52ce3c21aec3 ("x86,kvm,vmx: Don't trap writes to CR4.TSD")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Message-Id: <20200703040422.31536-2-sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/kvm_cache_regs.h |    2 +-
 arch/x86/kvm/vmx/vmx.c        |    2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/kvm_cache_regs.h
@@ -7,7 +7,7 @@
 #define KVM_POSSIBLE_CR0_GUEST_BITS X86_CR0_TS
 #define KVM_POSSIBLE_CR4_GUEST_BITS				  \
 	(X86_CR4_PVI | X86_CR4_DE | X86_CR4_PCE | X86_CR4_OSFXSR  \
-	 | X86_CR4_OSXMMEXCPT | X86_CR4_LA57 | X86_CR4_PGE)
+	 | X86_CR4_OSXMMEXCPT | X86_CR4_LA57 | X86_CR4_PGE | X86_CR4_TSD)
 
 #define BUILD_KVM_GPR_ACCESSORS(lname, uname)				      \
 static __always_inline unsigned long kvm_##lname##_read(struct kvm_vcpu *vcpu)\
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3932,6 +3932,8 @@ void vmx_set_constant_host_state(struct
 
 void set_cr4_guest_host_mask(struct vcpu_vmx *vmx)
 {
+	BUILD_BUG_ON(KVM_CR4_GUEST_OWNED_BITS & ~KVM_POSSIBLE_CR4_GUEST_BITS);
+
 	vmx->vcpu.arch.cr4_guest_owned_bits = KVM_CR4_GUEST_OWNED_BITS;
 	if (enable_ept)
 		vmx->vcpu.arch.cr4_guest_owned_bits |= X86_CR4_PGE;


