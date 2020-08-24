Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D232C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49E5920639
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262935;
	bh=nDKeBkCZF7RBxnQXZ7/rzYWC0ltlHNDDwfhT4Llmkqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tmTsPDNHrEfTbRIee1PSrjzd55IaqEBjQAhEXuP7jTTpGCEqcLGILAddgLYPugZtO
	 tkOR7VyOiEhyfwnzpfAgInDrtWPXqsM7b/lBFpTtOFbLl1b4Hnc+IwSsp0p0WIl92C
	 Gtga432sI4BI8NIYTOCt4Q36XVplJpN8rXXOtBVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgHXJzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbgHXIgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:36:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0789C207DF;
        Mon, 24 Aug 2020 08:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258190;
        bh=nDKeBkCZF7RBxnQXZ7/rzYWC0ltlHNDDwfhT4Llmkqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=peKrRHcVRLA2085fvZ7WRI66l5h+poATRFpoJfZX9vI09KdKYeaPOoxs6sgShp6cv
         BBiXjPR6MhnbW+zc7vehkf+pQeL5qBGNue/kVM/+F2lq3GtWO/CsC7GJkooI/BmN1X
         vWoOeosvyoaIEQyFOL7JGmXf4sqxUG2Rxvr/UPDU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huaitong Han <huaitong.han@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 107/148] kvm: x86: Toggling CR4.PKE does not load PDPTEs in PAE mode
Date:   Mon, 24 Aug 2020 10:30:05 +0200
Message-Id: <20200824082419.150385002@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Mattson <jmattson@google.com>

[ Upstream commit cb957adb4ea422bd758568df5b2478ea3bb34f35 ]

See the SDM, volume 3, section 4.4.1:

If PAE paging would be in use following an execution of MOV to CR0 or
MOV to CR4 (see Section 4.1.1) and the instruction is modifying any of
CR0.CD, CR0.NW, CR0.PG, CR4.PAE, CR4.PGE, CR4.PSE, or CR4.SMEP; then
the PDPTEs are loaded from the address in CR3.

Fixes: b9baba8614890 ("KVM, pkeys: expose CPUID/CR4 to guest")
Cc: Huaitong Han <huaitong.han@intel.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Peter Shier <pshier@google.com>
Reviewed-by: Oliver Upton <oupton@google.com>
Message-Id: <20200817181655.3716509-1-jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a70156b9b72e5..f7304132d5907 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -967,7 +967,7 @@ int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 {
 	unsigned long old_cr4 = kvm_read_cr4(vcpu);
 	unsigned long pdptr_bits = X86_CR4_PGE | X86_CR4_PSE | X86_CR4_PAE |
-				   X86_CR4_SMEP | X86_CR4_PKE;
+				   X86_CR4_SMEP;
 
 	if (kvm_valid_cr4(vcpu, cr4))
 		return 1;
-- 
2.25.1



