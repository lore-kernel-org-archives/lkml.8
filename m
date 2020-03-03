Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C93CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7283A20CC7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258426;
	bh=Ape+vf9e720NWypWUtF6MoJSuweeNFaLsz/ZeT6VWyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CJ5xOACtykMtOarHKI4YxLn/APTSp1lG/Z0HY8w3u3kl2/n+xxQwAwG4887ikTWm3
	 RhxAAadZlxSLalE7Oay8cuZofJOFj8L3S64YHLMstv6L0AH3ET9kg2e3VsoIyMGowv
	 yPrnBTgeK6hcIWjmkKwKuAZHxeQqC5w53Ixw//1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387775AbgCCSAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:00:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732698AbgCCSAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 13:00:20 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BC9120728;
        Tue,  3 Mar 2020 18:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258419;
        bh=Ape+vf9e720NWypWUtF6MoJSuweeNFaLsz/ZeT6VWyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+j17X5piH7LlItrYBk2WrNwyxiT/xkt/pGVp8abjJJXLxiFNgvyW0DpkmSsbJ5Vk
         M76t55T3xulBaVZPMrCf6liETNveiHB7/XmGMo+pnffZkfgX66FdTYczD4kZLcPP19
         6QxNdWBK8whvBghRz3Jcq9pDUk7HzEybcQ+1MJl4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kiszka <jan.kiszka@web.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Oliver Upton <oupton@google.com>
Subject: [PATCH 4.19 43/87] KVM: VMX: check descriptor table exits on instruction emulation
Date:   Tue,  3 Mar 2020 18:43:34 +0100
Message-Id: <20200303174354.237462333@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174349.075101355@linuxfoundation.org>
References: <20200303174349.075101355@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Upton <oupton@google.com>

commit 86f7e90ce840aa1db407d3ea6e9b3a52b2ce923c upstream.

KVM emulates UMIP on hardware that doesn't support it by setting the
'descriptor table exiting' VM-execution control and performing
instruction emulation. When running nested, this emulation is broken as
KVM refuses to emulate L2 instructions by default.

Correct this regression by allowing the emulation of descriptor table
instructions if L1 hasn't requested 'descriptor table exiting'.

Fixes: 07721feee46b ("KVM: nVMX: Don't emulate instructions in guest mode")
Reported-by: Jan Kiszka <jan.kiszka@web.de>
Cc: stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Jim Mattson <jmattson@google.com>
Signed-off-by: Oliver Upton <oupton@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -13724,6 +13724,7 @@ static int vmx_check_intercept_io(struct
 	else
 		intercept = nested_vmx_check_io_bitmaps(vcpu, port, size);
 
+	/* FIXME: produce nested vmexit and return X86EMUL_INTERCEPTED.  */
 	return intercept ? X86EMUL_UNHANDLEABLE : X86EMUL_CONTINUE;
 }
 
@@ -13753,6 +13754,20 @@ static int vmx_check_intercept(struct kv
 	case x86_intercept_outs:
 		return vmx_check_intercept_io(vcpu, info);
 
+	case x86_intercept_lgdt:
+	case x86_intercept_lidt:
+	case x86_intercept_lldt:
+	case x86_intercept_ltr:
+	case x86_intercept_sgdt:
+	case x86_intercept_sidt:
+	case x86_intercept_sldt:
+	case x86_intercept_str:
+		if (!nested_cpu_has2(vmcs12, SECONDARY_EXEC_DESC))
+			return X86EMUL_CONTINUE;
+
+		/* FIXME: produce nested vmexit and return X86EMUL_INTERCEPTED.  */
+		break;
+
 	/* TODO: check more intercepts... */
 	default:
 		break;


