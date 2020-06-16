Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE4AC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9EB72071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323976;
	bh=xxAjpRjVLlI8NKW4e1lJlk10UMBdmbGEv5G6zi0b0B8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m/7S35Pvz14Oq8N1h69C9Tt9aNXVRJSllWz/wIGvR2OvngoaLcq82F+oQBLRJ5mYb
	 fb+bjdfvaOTBl/l/L5araY/c+5MVPids1VdJP1qEXEveqhP3i+Bjd8gb7a+HThgYI8
	 65cJfJ7dqRoL1+N15dL9ol8PGYEMR0QNRkr0qdAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbgFPPnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:43:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731153AbgFPPno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:43:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E643208D5;
        Tue, 16 Jun 2020 15:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322223;
        bh=xxAjpRjVLlI8NKW4e1lJlk10UMBdmbGEv5G6zi0b0B8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tn8UR3Vr6w66lUdOkCuSRvLA4vZ5z2XfQHSYj3MbQXhuErZCNuYPYXwOCuW7Jj/0Q
         pQw0v3IK71Ey0+cIg97K/H/+avMlve5457UhEkU/BlBtJusTSQwsTz4qIp8u6CE9HX
         HXfvZp4Ko+hvjREsX/dKf3zb+4oHjbXWZc0A8bks=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felipe Franciosi <felipe@nutanix.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.7 048/163] KVM: x86: respect singlestep when emulating instruction
Date:   Tue, 16 Jun 2020 17:33:42 +0200
Message-Id: <20200616153109.154140150@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
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
@@ -6923,7 +6923,7 @@ restart:
 		if (!ctxt->have_exception ||
 		    exception_type(ctxt->exception.vector) == EXCPT_TRAP) {
 			kvm_rip_write(vcpu, ctxt->eip);
-			if (r && ctxt->tf)
+			if (r && (ctxt->tf || (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP)))
 				r = kvm_vcpu_do_singlestep(vcpu);
 			if (kvm_x86_ops.update_emulated_instruction)
 				kvm_x86_ops.update_emulated_instruction(vcpu);


