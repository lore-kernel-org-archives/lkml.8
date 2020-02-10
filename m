Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AEAC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B3020708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338767;
	bh=rANDrOgXbYxPRIcctAMUipvFcg2f5rSxJKS9mHD7wEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VK+Q0HByALwXJbRhFlXUizjREEhfy1a06PHngh7lmjy0Q+K53e0P0/kjKsRnZRlCu
	 q6s8TFDaQgVb+hR6LjZqUJss9YI4vV7Z1chGSMiT4fLvG/rfX4pzt3UhZOWOUmYlu4
	 cSHP5vEoyCIW4wJ+2EKiFM0w/MdnlIP8raNm5NBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbgBJMqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:46:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728336AbgBJMlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:41:20 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06A7920842;
        Mon, 10 Feb 2020 12:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338480;
        bh=rANDrOgXbYxPRIcctAMUipvFcg2f5rSxJKS9mHD7wEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x9/iTGBp4fX3UJBQbnoPpeBHwcrw1ld0hP/5nGIbAmmAaLYZrUKWHzwyD758Y5Lkh
         hcJ4PIYL/xM5OAI0T9tuDbbAM3X0aoNGZLL3rglwtLtcNaYzWbKgzmUUXWpjxDRr6x
         uGuBuMLURE4rzNKqfdFfpC/f94es9RYxHylw9QMw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.5 255/367] KVM: x86: Handle TIF_NEED_FPU_LOAD in kvm_{load,put}_guest_fpu()
Date:   Mon, 10 Feb 2020 04:32:48 -0800
Message-Id: <20200210122447.978478212@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit c9aef3b85f425d1f6635382ec210ee5a7ef55d7d upstream.

Handle TIF_NEED_FPU_LOAD similar to how fpu__copy() handles the flag
when duplicating FPU state to a new task struct.  TIF_NEED_FPU_LOAD can
be set any time control is transferred out of KVM, be it voluntarily,
e.g. if I/O is triggered during a KVM call to get_user_pages, or
involuntarily, e.g. if softirq runs after an IRQ occurs.  Therefore,
KVM must account for TIF_NEED_FPU_LOAD whenever it is (potentially)
accessing CPU FPU state.

Fixes: 5f409e20b7945 ("x86/fpu: Defer FPU state load until return to userspace")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8517,12 +8517,26 @@ static int complete_emulated_mmio(struct
 	return 0;
 }
 
+static void kvm_save_current_fpu(struct fpu *fpu)
+{
+	/*
+	 * If the target FPU state is not resident in the CPU registers, just
+	 * memcpy() from current, else save CPU state directly to the target.
+	 */
+	if (test_thread_flag(TIF_NEED_FPU_LOAD))
+		memcpy(&fpu->state, &current->thread.fpu.state,
+		       fpu_kernel_xstate_size);
+	else
+		copy_fpregs_to_fpstate(fpu);
+}
+
 /* Swap (qemu) user FPU context for the guest FPU context. */
 static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu)
 {
 	fpregs_lock();
 
-	copy_fpregs_to_fpstate(vcpu->arch.user_fpu);
+	kvm_save_current_fpu(vcpu->arch.user_fpu);
+
 	/* PKRU is separately restored in kvm_x86_ops->run.  */
 	__copy_kernel_to_fpregs(&vcpu->arch.guest_fpu->state,
 				~XFEATURE_MASK_PKRU);
@@ -8538,7 +8552,8 @@ static void kvm_put_guest_fpu(struct kvm
 {
 	fpregs_lock();
 
-	copy_fpregs_to_fpstate(vcpu->arch.guest_fpu);
+	kvm_save_current_fpu(vcpu->arch.guest_fpu);
+
 	copy_kernel_to_fpregs(&vcpu->arch.user_fpu->state);
 
 	fpregs_mark_activate();


