Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22566CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB0D4206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363764;
	bh=uOn2jVsOAi8MJ1k+gKPrzUStYyLbvoFTVJirpKIjyCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0rgNlSE74AQCIkbeeRNRegwTfjUyTpv9ckBHpRVwTIY+I+BjN/7t1uf58A7wDJ6cF
	 utbo5lUT+vEyEXko1+fGQ0YXbBrIsleB+iYoasBQWG4Fj5EitCFyvLZXlSvJvlJszo
	 FMLNanAPUGV4LdlkNbSFXYz8MWGizOnNRH3bR9eM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbgEMJz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:55:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388325AbgEMJzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:55:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C485123127;
        Wed, 13 May 2020 09:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363751;
        bh=uOn2jVsOAi8MJ1k+gKPrzUStYyLbvoFTVJirpKIjyCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aMGdokVavKmd0WwG9Kc+8/Wccobo+BMTQkz7ABXC5TOOtGPhekDKCSNhXmwKnZjMT
         Th0ZjGqAjrAxejoCsJYywg2PwvmYKqkgpvt6bgZTX7BqnrYEY+ZfhW38Nei2Rz7Jwu
         Xf7iE3aGe4uguWnm4ImULsD2QiVp+uWn3gRuWgIc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.6 072/118] KVM: VMX: Explicitly clear RFLAGS.CF and RFLAGS.ZF in VM-Exit RSB path
Date:   Wed, 13 May 2020 11:44:51 +0200
Message-Id: <20200513094424.032138370@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094417.618129545@linuxfoundation.org>
References: <20200513094417.618129545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit c7cb2d650c9e78c03bd2d1c0db89891825f8c0f4 upstream.

Clear CF and ZF in the VM-Exit path after doing __FILL_RETURN_BUFFER so
that KVM doesn't interpret clobbered RFLAGS as a VM-Fail.  Filling the
RSB has always clobbered RFLAGS, its current incarnation just happens
clear CF and ZF in the processs.  Relying on the macro to clear CF and
ZF is extremely fragile, e.g. commit 089dd8e53126e ("x86/speculation:
Change FILL_RETURN_BUFFER to work with objtool") tweaks the loop such
that the ZF flag is always set.

Reported-by: Qian Cai <cai@lca.pw>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: stable@vger.kernel.org
Fixes: f2fde6a5bcfcf ("KVM: VMX: Move RSB stuffing to before the first RET after VM-Exit")
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Message-Id: <20200506035355.2242-1-sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx/vmenter.S |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -86,6 +86,9 @@ SYM_FUNC_START(vmx_vmexit)
 	/* IMPORTANT: Stuff the RSB immediately after VM-Exit, before RET! */
 	FILL_RETURN_BUFFER %_ASM_AX, RSB_CLEAR_LOOPS, X86_FEATURE_RETPOLINE
 
+	/* Clear RFLAGS.CF and RFLAGS.ZF to preserve VM-Exit, i.e. !VM-Fail. */
+	or $1, %_ASM_AX
+
 	pop %_ASM_AX
 .Lvmexit_skip_rsb:
 #endif


