Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D14C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE622168B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341074;
	bh=vDtliPvSlbfDkb50DUqZRsPnWT/6NC4eXoZfyTTUwxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EJ92JwLFWledDqZZ8e3QPnjxAdiDNcFQKiyCJfKn7dLljsHezJJBCuzZvU6Bk6PIc
	 jhCU0NAm1PAoxADc+CrO3RDglpZdHSsODZv8OqqUH5v8dZycvAxL1FUG11HJunGZxN
	 mEfoZR4A6HrsRz3dj2S5JHwfSUyK52OaGqcHlm6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgBJMhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:37:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:54622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728229AbgBJMgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:36:03 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61A9F2467D;
        Mon, 10 Feb 2020 12:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338163;
        bh=vDtliPvSlbfDkb50DUqZRsPnWT/6NC4eXoZfyTTUwxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DWe6hCoveV+TpNW5vNl1JteeVAAlpdGtaR5FBdyIY+FoWxC/lvGYjD9viAtpC8kRR
         Yv9JTRhoY3VHQxpp6MDsNdZvTJ5rL1YBmOjCLozCdthLKxD0V2/gy28i5jXx1YH72j
         h3pIeZWXoiOpKX0UnpHjNfLD0eznEX6if800Tb2Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 140/195] KVM: x86: Free wbinvd_dirty_mask if vCPU creation fails
Date:   Mon, 10 Feb 2020 04:33:18 -0800
Message-Id: <20200210122318.972258390@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 16be9ddea268ad841457a59109963fff8c9de38d upstream.

Free the vCPU's wbinvd_dirty_mask if vCPU creation fails after
kvm_arch_vcpu_init(), e.g. when installing the vCPU's file descriptor.
Do the freeing by calling kvm_arch_vcpu_free() instead of open coding
the freeing.  This adds a likely superfluous, but ultimately harmless,
call to kvmclock_reset(), which only clears vcpu->arch.pv_time_enabled.
Using kvm_arch_vcpu_free() allows for additional cleanup in the future.

Fixes: f5f48ee15c2ee ("KVM: VMX: Execute WBINVD to keep data consistency with assigned devices")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8702,7 +8702,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vc
 	kvm_mmu_unload(vcpu);
 	vcpu_put(vcpu);
 
-	kvm_x86_ops->vcpu_free(vcpu);
+	kvm_arch_vcpu_free(vcpu);
 }
 
 void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)


