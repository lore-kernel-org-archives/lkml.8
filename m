Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E61C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20BEE21527
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322693;
	bh=zpYShMOZpswtC64OW2r7Dp1omfS1QSaZmPRDUdLIA9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xVSGxQWm2VjkTFQEMpybPD9jxqvR7hVi4HvqcGutF1b2CUY7w1NDFUaVt3rQxrs36
	 md+TpIbdTAyKuHfnsWF4KZG97cyA6l9zCt7FstgNHQZXmvv7h/5rur94CUqdQkXzJn
	 57is+EOwOdIkVLVjaawEXOGENtCiairHVEGY7HXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732673AbgFPPva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:51:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732653AbgFPPvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:51:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3BF4214DB;
        Tue, 16 Jun 2020 15:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322671;
        bh=zpYShMOZpswtC64OW2r7Dp1omfS1QSaZmPRDUdLIA9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DCmMYwYCcA1wD3Rk+1cplRGw7tmXHbXNQVBPOEARFXaH41YT6wnz0QX6WVq3dzw1n
         JIKwbJfKqo9i0T1EIPqI/vPs+gTtSv5u5LKnEs9+PvQ+Lp7MpE+mi8lNgEBBLoI/Hg
         7o2LJQjzIfdF5dJ4FhMb0lrCXMvu33mrLvWPhYRE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felipe Franciosi <felipe@nutanix.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.6 058/161] KVM: x86: respect singlestep when emulating instruction
Date:   Tue, 16 Jun 2020 17:34:08 +0200
Message-Id: <20200616153109.142280020@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.402291280@linuxfoundation.org>
References: <20200616153106.402291280@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felipe Franciosi <felipe@nutanix.com>

commit 384dea1c9183880be183cfaae161d99aafd16df6 upstream.

When userspace configures KVM_GUESTDBG_SINGLESTEP, KVM will manage the
presence of X86_EFLAGS_TF via kvm_set/get_rflags on vcpus. The actual
rflag bit is therefore hidden from callers.

That includes init_emulate_ctxt() which uses the value returned from
kvm_get_flags() to set ctxt->tf. As a result, x86_emulate_instruction()
will skip a single step, leaving singlestep_rip stale and not returning
to userspace.

This resolves the issue by observing the vcpu guest_debug configuration
alongside ctxt->tf in x86_emulate_instruction(), performing the single
step if set.

Cc: stable@vger.kernel.org
Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
Message-Id: <20200519081048.8204-1-felipe@nutanix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6908,7 +6908,7 @@ restart:
 		if (!ctxt->have_exception ||
 		    exception_type(ctxt->exception.vector) == EXCPT_TRAP) {
 			kvm_rip_write(vcpu, ctxt->eip);
-			if (r && ctxt->tf)
+			if (r && (ctxt->tf || (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP)))
 				r = kvm_vcpu_do_singlestep(vcpu);
 			if (kvm_x86_ops->update_emulated_instruction)
 				kvm_x86_ops->update_emulated_instruction(vcpu);


