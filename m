Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF58C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4019B2063A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585760024;
	bh=mtfkkCt5SFGhLPN1U7MCkZ3jcSv/3FhZA5jJUw2+TxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nCuGPrZMAyrMGSA5Bmh/iB9+STsaxhPXHvi4INwXaB2ZczrcQHUHMSSZ0VxXpDjGl
	 VgKaOstIMgcTKjiogSoxdZNBGjH0xiU3LlYwFga5SNhjkK0iez8hZFD/N/6NOppTMb
	 cTcWsGxpJSD4HW2rdcD6vvB5ccatBW7Ml5AuKtXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388194AbgDAQxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:53:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388328AbgDAQbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:31:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 228B12063A;
        Wed,  1 Apr 2020 16:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758698;
        bh=mtfkkCt5SFGhLPN1U7MCkZ3jcSv/3FhZA5jJUw2+TxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dOXJbAU6S/pg/fW0wQ4ib5dnwpjCZgDCWwUd1azR5hfbxGIG5TvJsslwslNSCLBVP
         Spl2WOM1ig9nNXwnF3cv9xNapHciXwP1g8QwBfpewbrf2DdpPNSn8f5kglBFpXcIzu
         TfC0vzxNgdgLKdqL3yjMrOxfXLtXVqK4M3/+my6s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 47/91] KVM: VMX: Do not allow reexecute_instruction() when skipping MMIO instr
Date:   Wed,  1 Apr 2020 18:17:43 +0200
Message-Id: <20200401161529.578652949@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161512.917494101@linuxfoundation.org>
References: <20200401161512.917494101@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

[ Upstream commit c4409905cd6eb42cfd06126e9226b0150e05a715 ]

Re-execution after an emulation decode failure is only intended to
handle a case where two or vCPUs race to write a shadowed page, i.e.
we should never re-execute an instruction as part of MMIO emulation.
As handle_ept_misconfig() is only used for MMIO emulation, it should
pass EMULTYPE_NO_REEXECUTE when using the emulator to skip an instr
in the fast-MMIO case where VM_EXIT_INSTRUCTION_LEN is invalid.

And because the cr2 value passed to x86_emulate_instruction() is only
destined for use when retrying or reexecuting, we can simply call
emulate_instruction().

Fixes: d391f1207067 ("x86/kvm/vmx: do not use vm-exit instruction length
                      for fast MMIO when running nested")
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 78daf891abec8..2634b45562026 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -6187,8 +6187,8 @@ static int handle_ept_misconfig(struct kvm_vcpu *vcpu)
 			return 1;
 		}
 		else
-			return x86_emulate_instruction(vcpu, gpa, EMULTYPE_SKIP,
-						       NULL, 0) == EMULATE_DONE;
+			return emulate_instruction(vcpu, EMULTYPE_SKIP) ==
+								EMULATE_DONE;
 	}
 
 	ret = handle_mmio_page_fault(vcpu, gpa, true);
-- 
2.20.1



