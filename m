Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F155EC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C776F22AAA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752450;
	bh=L20Zm7GZCYXy/G0BHbY7qhmQ9cOpWth7HfFw16eKR/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tr8PlwG7IX6WdoF1vVFBaHc8sOv+NRPAW5vff2leVkdMJ6eQIUFZMkzYUCR1cgmmY
	 bZXny8VGMyUzODTT32VaNdr2a6gv8Y5aKH6qL0tcIs3B/sIvFt0mHpQEcysCyxeCI3
	 FUZH43VD5vuBHEtdCzOAhVDl83l3kb8N4svjQw6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgGNSr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729730AbgGNSrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:47:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38BA222AAE;
        Tue, 14 Jul 2020 18:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752443;
        bh=L20Zm7GZCYXy/G0BHbY7qhmQ9cOpWth7HfFw16eKR/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QPjHxNkGUfhRt/LCydXdBG+PLnPcnRpODTg/HLnm5bDkO+TH5OmYZLIb9re02u4Ue
         Xt9hvOIQaaH6IudlpdjsFKwKwe3sK0V1vmkAnaTeC0e0gF13TXgCb3XDva2zdcCny+
         QNv4TRkY3GT2D8kXsnUIg1ISrWoygrjlG8/RHHr8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 44/58] KVM: x86: Inject #GP if guest attempts to toggle CR4.LA57 in 64-bit mode
Date:   Tue, 14 Jul 2020 20:44:17 +0200
Message-Id: <20200714184058.332482083@linuxfoundation.org>
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

commit d74fcfc1f0ff4b6c26ecef1f9e48d8089ab4eaac upstream.

Inject a #GP on MOV CR4 if CR4.LA57 is toggled in 64-bit mode, which is
illegal per Intel's SDM:

  CR4.LA57
    57-bit linear addresses (bit 12 of CR4) ... blah blah blah ...
    This bit cannot be modified in IA-32e mode.

Note, the pseudocode for MOV CR doesn't call out the fault condition,
which is likely why the check was missed during initial development.
This is arguably an SDM bug and will hopefully be fixed in future
release of the SDM.

Fixes: fd8cb433734ee ("KVM: MMU: Expose the LA57 feature to VM.")
Cc: stable@vger.kernel.org
Reported-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Message-Id: <20200703021714.5549-1-sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -865,6 +865,8 @@ int kvm_set_cr4(struct kvm_vcpu *vcpu, u
 	if (is_long_mode(vcpu)) {
 		if (!(cr4 & X86_CR4_PAE))
 			return 1;
+		if ((cr4 ^ old_cr4) & X86_CR4_LA57)
+			return 1;
 	} else if (is_paging(vcpu) && (cr4 & X86_CR4_PAE)
 		   && ((cr4 ^ old_cr4) & pdptr_bits)
 		   && !load_pdptrs(vcpu, vcpu->arch.walk_mmu,


