Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CE4C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A10F620575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588100172;
	bh=/X1Thn25F5eOx7AvzYW79Uz65g8fKtvmXvUVWcUGf44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e2lB2asjqsB9cO2zM853enp8V+oO4zTaHrcXVlJlfvg4wsbX9MiSrm2zS3Tb1Svph
	 HbzvUccQxixca572/g7UWqD9PpMnivMRCwqV7oJZGGjuCdJzaUEP8mYp75TT1Z1/Ud
	 1gzlENRfaYpDxU+hPuuP9INpg39ZlrlwfDGo8V4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgD1Sbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:31:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728658AbgD1Sbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:31:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 491BE20BED;
        Tue, 28 Apr 2020 18:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098692;
        bh=/X1Thn25F5eOx7AvzYW79Uz65g8fKtvmXvUVWcUGf44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LqY7+1QaIlvIBHREDfUrqA7vVqHGhqS3yt6o1HY3PhHr05nPkk1aqPMvnZROT36U4
         FR5FbDSicGOtWQbRWxBLVH/EdFH0IxoN23QDRJ0mEtER3UYyb+SeScJ93JgG95UiP5
         bBx8BHHNjiCldaiNTHZsuDTvJNNJlfUDWzBdWbrM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 042/131] KVM: VMX: Zero out *all* general purpose registers after VM-Exit
Date:   Tue, 28 Apr 2020 20:24:14 +0200
Message-Id: <20200428182230.356721332@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182224.822179290@linuxfoundation.org>
References: <20200428182224.822179290@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 0e0ab73c9a0243736bcd779b30b717e23ba9a56d upstream.

...except RSP, which is restored by hardware as part of VM-Exit.

Paolo theorized that restoring registers from the stack after a VM-Exit
in lieu of zeroing them could lead to speculative execution with the
guest's values, e.g. if the stack accesses miss the L1 cache[1].
Zeroing XORs are dirt cheap, so just be ultra-paranoid.

Note that the scratch register (currently RCX) used to save/restore the
guest state is also zeroed as its host-defined value is loaded via the
stack, just with a MOV instead of a POP.

[1] https://patchwork.kernel.org/patch/10771539/#22441255

Fixes: 0cb5b30698fd ("kvm: vmx: Scrub hardware GPRs at VM-exit")
Cc: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[bwh: Backported to 4.19: adjust filename, context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index d37b48173e9cf..e4d0ad06790e1 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10841,6 +10841,15 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		"mov %%r13, %c[r13](%0) \n\t"
 		"mov %%r14, %c[r14](%0) \n\t"
 		"mov %%r15, %c[r15](%0) \n\t"
+
+		/*
+		 * Clear all general purpose registers (except RSP, which is loaded by
+		 * the CPU during VM-Exit) to prevent speculative use of the guest's
+		 * values, even those that are saved/loaded via the stack.  In theory,
+		 * an L1 cache miss when restoring registers could lead to speculative
+		 * execution with the guest's values.  Zeroing XORs are dirt cheap,
+		 * i.e. the extra paranoia is essentially free.
+		 */
 		"xor %%r8d,  %%r8d \n\t"
 		"xor %%r9d,  %%r9d \n\t"
 		"xor %%r10d, %%r10d \n\t"
@@ -10855,8 +10864,11 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 
 		"xor %%eax, %%eax \n\t"
 		"xor %%ebx, %%ebx \n\t"
+		"xor %%ecx, %%ecx \n\t"
+		"xor %%edx, %%edx \n\t"
 		"xor %%esi, %%esi \n\t"
 		"xor %%edi, %%edi \n\t"
+		"xor %%ebp, %%ebp \n\t"
 		"pop  %%" _ASM_BP "; pop  %%" _ASM_DX " \n\t"
 		".pushsection .rodata \n\t"
 		".global vmx_return \n\t"
-- 
2.20.1



