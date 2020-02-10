Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8C9C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA16B208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338430;
	bh=WHrUJpBYRnBwqvlg3yOZvpKCUVvhczLfdnNV7q2dW9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=req/mKCxW2gR0kqvb+aIYZsEDaARLx0r9y7Aim+ATX5re00SLbBeg1oCNoqDmc7er
	 TyxX0U2zFIMXgM/9C9lq3JR6kEG3DHoOP4gf+MHYLFcMv89KEd77IAbS61H0ua09qX
	 hNrKAh2/fWsH3HeS93sMJWPWCiRWJFUHOxLSJGs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgBJMka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:40:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728537AbgBJMiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:38:21 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E8B321739;
        Mon, 10 Feb 2020 12:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338300;
        bh=WHrUJpBYRnBwqvlg3yOZvpKCUVvhczLfdnNV7q2dW9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KJqIsfvGbOJc2IjecUqxCIvZQlEuc8g4eqLQfqZaKjsracuSgAAqW2Rv/UrrpSGg1
         efD9AZetxLDZnh4GHGw6f0ATkqMXLWR/jEeV8iDCrv6QPNtB+Y+fQq2avUVbSr5+z3
         OMKWBFT9+DA8ptwacssni77Nn6veCmvNN3o/EESI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.4 210/309] KVM: x86: Fix potential put_fpu() w/o load_fpu() on MPX platform
Date:   Mon, 10 Feb 2020 04:32:46 -0800
Message-Id: <20200210122426.712308936@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit f958bd2314d117f8c29f4821401bc1925bc2e5ef upstream.

Unlike most state managed by XSAVE, MPX is initialized to zero on INIT.
Because INITs are usually recognized in the context of a VCPU_RUN call,
kvm_vcpu_reset() puts the guest's FPU so that the FPU state is resident
in memory, zeros the MPX state, and reloads FPU state to hardware.  But,
in the unlikely event that an INIT is recognized during
kvm_arch_vcpu_ioctl_get_mpstate() via kvm_apic_accept_events(),
kvm_vcpu_reset() will call kvm_put_guest_fpu() without a preceding
kvm_load_guest_fpu() and corrupt the guest's FPU state (and possibly
userspace's FPU state as well).

Given that MPX is being removed from the kernel[*], fix the bug with the
simple-but-ugly approach of loading the guest's FPU during
KVM_GET_MP_STATE.

[*] See commit f240652b6032b ("x86/mpx: Remove MPX APIs").

Fixes: f775b13eedee2 ("x86,kvm: move qemu/guest FPU switching out to vcpu_run")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8698,6 +8698,8 @@ int kvm_arch_vcpu_ioctl_get_mpstate(stru
 				    struct kvm_mp_state *mp_state)
 {
 	vcpu_load(vcpu);
+	if (kvm_mpx_supported())
+		kvm_load_guest_fpu(vcpu);
 
 	kvm_apic_accept_events(vcpu);
 	if (vcpu->arch.mp_state == KVM_MP_STATE_HALTED &&
@@ -8706,6 +8708,8 @@ int kvm_arch_vcpu_ioctl_get_mpstate(stru
 	else
 		mp_state->mp_state = vcpu->arch.mp_state;
 
+	if (kvm_mpx_supported())
+		kvm_put_guest_fpu(vcpu);
 	vcpu_put(vcpu);
 	return 0;
 }


