Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24396C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81F82073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609865;
	bh=BGhSltwy/SzWp5viB2C1ip1c1zJyhs+DsDXWV/utVLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=enBYEMAD9cODASOOYjjrzWgNDt/fpasdgj2B5CWhxCWNVlzUoGM9yBBVqIg2dAgR0
	 MAqG0rZWkkwXUEIc2xn1mfHhTzlNWRvLNumbtN2nxP60cD5VCLqE6F1HH4v1rIoP/V
	 647JGWEeSbhL/tvHY+F/PVJcj6QBuk+AJ2RN0QjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbgBMQEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:04:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387407AbgBMPYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:24:04 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE38D24691;
        Thu, 13 Feb 2020 15:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607443;
        bh=BGhSltwy/SzWp5viB2C1ip1c1zJyhs+DsDXWV/utVLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DW6WBiJVJtjWu2sdUwTd7lzIN9FMj0JwHmoeDdTeQu9Ys5MpxWbus5phUCRIizOyn
         FGULJ62bG+m2rEWiLuBxAQxy2M5wGbMNYTP14/wW3oLaUC0+BFrDusaVY8/vBFgCBe
         78jD9XhVmVA5UlKD3TuJgvnqxcRCOpXnxkku0qFM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.9 056/116] KVM: x86: Free wbinvd_dirty_mask if vCPU creation fails
Date:   Thu, 13 Feb 2020 07:20:00 -0800
Message-Id: <20200213151904.663022132@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151842.259660170@linuxfoundation.org>
References: <20200213151842.259660170@linuxfoundation.org>
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
@@ -7809,7 +7809,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vc
 	kvm_mmu_unload(vcpu);
 	vcpu_put(vcpu);
 
-	kvm_x86_ops->vcpu_free(vcpu);
+	kvm_arch_vcpu_free(vcpu);
 }
 
 void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)


