Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DE0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 759482067D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592584726;
	bh=f9IqoZYz1ciQfOagfwTGYcDo8bK24CSu/A4kgC8ilqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tmVM8iFVI+Bw81o0hwlkcpi9VihQu4uBKYUWMiOFSxRk6PEWEhpNbL0veWxAYKetH
	 OEnQMphEZaeiuh8Arpzxh1lEVdMV0HXWZ8VfacTndY54A1PvDkA9RosTZKlyXENkii
	 tNVly6yrYjNJyVeAzIYRSm1grf0DOSU4NRGVOZc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395186AbgFSQip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:38:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388950AbgFSOrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:47:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 477A720DD4;
        Fri, 19 Jun 2020 14:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578042;
        bh=f9IqoZYz1ciQfOagfwTGYcDo8bK24CSu/A4kgC8ilqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vxr1AKO1Kcb525KAbXpcCAaPG2Q9ZpCSmbnfTZdXOxptfYc0hST4S9LcgBpbTU4nL
         5vuuE5EPQGaiDaJg06CtiQq2j2G9BsIT9qJlSqYAI26okP5J+8fQXJygOueo5UE4ja
         3ARyk21gXCJpvQ4gj3y+S12esWwKMHVj++Wa71wE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.14 058/190] KVM: nVMX: Consult only the "basic" exit reason when routing nested exit
Date:   Fri, 19 Jun 2020 16:31:43 +0200
Message-Id: <20200619141636.474352819@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141633.446429600@linuxfoundation.org>
References: <20200619141633.446429600@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 2ebac8bb3c2d35f5135466490fc8eeaf3f3e2d37 upstream.

Consult only the basic exit reason, i.e. bits 15:0 of vmcs.EXIT_REASON,
when determining whether a nested VM-Exit should be reflected into L1 or
handled by KVM in L0.

For better or worse, the switch statement in nested_vmx_exit_reflected()
currently defaults to "true", i.e. reflects any nested VM-Exit without
dedicated logic.  Because the case statements only contain the basic
exit reason, any VM-Exit with modifier bits set will be reflected to L1,
even if KVM intended to handle it in L0.

Practically speaking, this only affects EXIT_REASON_MCE_DURING_VMENTRY,
i.e. a #MC that occurs on nested VM-Enter would be incorrectly routed to
L1, as "failed VM-Entry" is the only modifier that KVM can currently
encounter.  The SMM modifiers will never be generated as KVM doesn't
support/employ a SMI Transfer Monitor.  Ditto for "exit from enclave",
as KVM doesn't yet support virtualizing SGX, i.e. it's impossible to
enter an enclave in a KVM guest (L1 or L2).

Fixes: 644d711aa0e1 ("KVM: nVMX: Deciding if L0 or L1 should handle an L2 exit")
Cc: Jim Mattson <jmattson@google.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Message-Id: <20200227174430.26371-1-sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8711,7 +8711,7 @@ static bool nested_vmx_exit_reflected(st
 				vmcs_read32(VM_EXIT_INTR_ERROR_CODE),
 				KVM_ISA_VMX);
 
-	switch (exit_reason) {
+	switch ((u16)exit_reason) {
 	case EXIT_REASON_EXCEPTION_NMI:
 		if (is_nmi(intr_info))
 			return false;


