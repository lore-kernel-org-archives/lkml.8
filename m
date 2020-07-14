Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BE8C433ED
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 516AF22B2C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752455;
	bh=cYOpxKAoXkdPePsgbV3CLteCZS+Kk1WupGIBIWeo6Aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w5Q8X/5G6ZWCL43IViOXDpYUgvjco6VWebDS2d5sMDw2JZaXirVfyD+4mX4yp8kqu
	 99smqgNVzjIXNLx5bVfIipgeqV0gz78+zq5ZUKiZwLqkxwLh/++TLHlNCKk0n0iK3M
	 7+5Jbkt5CkulkaVPUeH1QIBFsFmNjt4I4r9Ulue4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgGNSrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:47:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729738AbgGNSr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:47:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E81322AAA;
        Tue, 14 Jul 2020 18:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752447;
        bh=cYOpxKAoXkdPePsgbV3CLteCZS+Kk1WupGIBIWeo6Aw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WwNWyU9DVHuS8jN27EMobr15pkpb7EXuF90jV3ODuyFwYL9E4TEMv3NufDJwd0mGJ
         B9olLmo7OiSV8SVjOnW8VhXKJ9ZTpMoymrFt1XxLPrhUGf3Ynes7utHrie0rTpUxF8
         87YKW7+1d48r8ww8GBMTCj74mt5sBHryH5MGx+UA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 45/58] KVM: x86: Mark CR4.TSD as being possibly owned by the guest
Date:   Tue, 14 Jul 2020 20:44:18 +0200
Message-Id: <20200714184058.398101684@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184056.149119318@linuxfoundation.org>
References: <20200714184056.149119318@linuxfoundation.org>
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
 arch/x86/kvm/vmx.c            |    2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/kvm_cache_regs.h
@@ -5,7 +5,7 @@
 #define KVM_POSSIBLE_CR0_GUEST_BITS X86_CR0_TS
 #define KVM_POSSIBLE_CR4_GUEST_BITS				  \
 	(X86_CR4_PVI | X86_CR4_DE | X86_CR4_PCE | X86_CR4_OSFXSR  \
-	 | X86_CR4_OSXMMEXCPT | X86_CR4_LA57 | X86_CR4_PGE)
+	 | X86_CR4_OSXMMEXCPT | X86_CR4_LA57 | X86_CR4_PGE | X86_CR4_TSD)
 
 static inline unsigned long kvm_register_read(struct kvm_vcpu *vcpu,
 					      enum kvm_reg reg)
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -6335,6 +6335,8 @@ static void vmx_set_constant_host_state(
 
 static void set_cr4_guest_host_mask(struct vcpu_vmx *vmx)
 {
+	BUILD_BUG_ON(KVM_CR4_GUEST_OWNED_BITS & ~KVM_POSSIBLE_CR4_GUEST_BITS);
+
 	vmx->vcpu.arch.cr4_guest_owned_bits = KVM_CR4_GUEST_OWNED_BITS;
 	if (enable_ept)
 		vmx->vcpu.arch.cr4_guest_owned_bits |= X86_CR4_PGE;


