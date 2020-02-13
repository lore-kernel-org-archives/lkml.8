Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FE7C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0302073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609239;
	bh=0srs3T9ZsXX8Nrsv68rGqAiZFnG5/45JnzEHQ3vjyHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AjhWtGx/svY1XCMaqlcUcpPfGDZnlkD/4KgJ67q8o+hITfd+9Edp8UxHFqnPdDUuc
	 sbXFqG+55VUUp9ciUrewzeB8xG3AZgZrL3RL7x/TAn8OaIeFJiAx0/SjDfoSYdyGBW
	 /I83sKd4TTlo7TUW/Z4/4lgjiAs4K2jn1pwSraEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388227AbgBMPx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:53:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:43060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729145AbgBMPZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:25:58 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AF342469C;
        Thu, 13 Feb 2020 15:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607558;
        bh=0srs3T9ZsXX8Nrsv68rGqAiZFnG5/45JnzEHQ3vjyHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jMgAVb+3zz8+t2cC8c6XfzjcRelp5Icp7XtUiwSsQgxs0/b6st2lmLCQAmI/O5aJm
         nYb1tbkzgAYuvIH9mrKBuiglsrcs4jDcdcB1RZ1n5tTACSsmTCKW8k4FX2/Sw8kkI5
         46XTL1RxSWKv8xdZANoY4mEI9Xal670qBFaXb0C0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 130/173] KVM: x86: Fix potential put_fpu() w/o load_fpu() on MPX platform
Date:   Thu, 13 Feb 2020 07:20:33 -0800
Message-Id: <20200213152004.943982276@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

[ Upstream commit f958bd2314d117f8c29f4821401bc1925bc2e5ef ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b6d80c0190563..d915ea0e69cfd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7677,6 +7677,9 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
+	if (kvm_mpx_supported())
+		kvm_load_guest_fpu(vcpu);
+
 	kvm_apic_accept_events(vcpu);
 	if (vcpu->arch.mp_state == KVM_MP_STATE_HALTED &&
 					vcpu->arch.pv.pv_unhalted)
@@ -7684,6 +7687,8 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 	else
 		mp_state->mp_state = vcpu->arch.mp_state;
 
+	if (kvm_mpx_supported())
+		kvm_put_guest_fpu(vcpu);
 	return 0;
 }
 
-- 
2.20.1



