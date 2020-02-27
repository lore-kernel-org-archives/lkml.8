Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590B6C34022
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8A524697
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814799;
	bh=qek24UEhQYTcA5b0RkuuEoNKEAaZQPUX61T55Muiaiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ClXEhdgBoEGKGQqsAmAzbuN5i9xOHUkdJpOaGzuNbupP5wmTiImDSZc1tAUrXaMqu
	 EkQjizetj8TzT8I6xfrZ9NhBsolPK4U8hDmooSXkQ2U8YENfaq416RbSW4gFGskrJH
	 Mlsg1TZUgZR695KZBLW6WUCPD5YJc3I+0e2Hf+R0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731862AbgB0Oqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:46:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:40978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730343AbgB0NpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:45:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACF3520578;
        Thu, 27 Feb 2020 13:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811108;
        bh=qek24UEhQYTcA5b0RkuuEoNKEAaZQPUX61T55Muiaiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LdFNhM4Jou46/P0dcHjt3XjON/PkEqkJK/D7MWkl+igIM3arbxRx2/MT2BggqF51C
         H4HoNCrmiTLiARvdbrwZ9w79vmJPRKc/96xwLadB/nJh8YCHl6+Gsp1OnKCKhr4N7U
         3xyZHE4EETUqMGAAzsI5aJO7MMgkr2Hk3zEtHd6U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.4 104/113] KVM: nVMX: Check IO instruction VM-exit conditions
Date:   Thu, 27 Feb 2020 14:37:00 +0100
Message-Id: <20200227132228.432911955@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132211.791484803@linuxfoundation.org>
References: <20200227132211.791484803@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Upton <oupton@google.com>

commit 35a571346a94fb93b5b3b6a599675ef3384bc75c upstream.

Consult the 'unconditional IO exiting' and 'use IO bitmaps' VM-execution
controls when checking instruction interception. If the 'use IO bitmaps'
VM-execution control is 1, check the instruction access against the IO
bitmaps to determine if the instruction causes a VM-exit.

Signed-off-by: Oliver Upton <oupton@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 7 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4281,7 +4281,7 @@ static bool nested_vmx_exit_handled_io(s
 				       struct vmcs12 *vmcs12)
 {
 	unsigned long exit_qualification;
-	unsigned int port;
+	unsigned short port;
 	int size;
 
 	if (!nested_cpu_has(vmcs12, CPU_BASED_USE_IO_BITMAPS))
@@ -10754,6 +10754,39 @@ static void nested_vmx_entry_failure(str
 		to_vmx(vcpu)->nested.sync_shadow_vmcs = true;
 }
 
+static int vmx_check_intercept_io(struct kvm_vcpu *vcpu,
+				  struct x86_instruction_info *info)
+{
+	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
+	unsigned short port;
+	bool intercept;
+	int size;
+
+	if (info->intercept == x86_intercept_in ||
+	    info->intercept == x86_intercept_ins) {
+		port = info->src_val;
+		size = info->dst_bytes;
+	} else {
+		port = info->dst_val;
+		size = info->src_bytes;
+	}
+
+	/*
+	 * If the 'use IO bitmaps' VM-execution control is 0, IO instruction
+	 * VM-exits depend on the 'unconditional IO exiting' VM-execution
+	 * control.
+	 *
+	 * Otherwise, IO instruction VM-exits are controlled by the IO bitmaps.
+	 */
+	if (!nested_cpu_has(vmcs12, CPU_BASED_USE_IO_BITMAPS))
+		intercept = nested_cpu_has(vmcs12,
+					   CPU_BASED_UNCOND_IO_EXITING);
+	else
+		intercept = nested_vmx_check_io_bitmaps(vcpu, port, size);
+
+	return intercept ? X86EMUL_UNHANDLEABLE : X86EMUL_CONTINUE;
+}
+
 static int vmx_check_intercept(struct kvm_vcpu *vcpu,
 			       struct x86_instruction_info *info,
 			       enum x86_intercept_stage stage)
@@ -10761,18 +10794,30 @@ static int vmx_check_intercept(struct kv
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	struct x86_emulate_ctxt *ctxt = &vcpu->arch.emulate_ctxt;
 
+	switch (info->intercept) {
 	/*
 	 * RDPID causes #UD if disabled through secondary execution controls.
 	 * Because it is marked as EmulateOnUD, we need to intercept it here.
 	 */
-	if (info->intercept == x86_intercept_rdtscp &&
-	    !nested_cpu_has2(vmcs12, SECONDARY_EXEC_RDTSCP)) {
-		ctxt->exception.vector = UD_VECTOR;
-		ctxt->exception.error_code_valid = false;
-		return X86EMUL_PROPAGATE_FAULT;
-	}
+	case x86_intercept_rdtscp:
+		if (!nested_cpu_has2(vmcs12, SECONDARY_EXEC_RDTSCP)) {
+			ctxt->exception.vector = UD_VECTOR;
+			ctxt->exception.error_code_valid = false;
+			return X86EMUL_PROPAGATE_FAULT;
+		}
+		break;
+
+	case x86_intercept_in:
+	case x86_intercept_ins:
+	case x86_intercept_out:
+	case x86_intercept_outs:
+		return vmx_check_intercept_io(vcpu, info);
 
 	/* TODO: check more intercepts... */
+	default:
+		break;
+	}
+
 	return X86EMUL_UNHANDLEABLE;
 }
 


