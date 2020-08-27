Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BBAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6D2D22BEB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="er1QEuRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgH0RMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:12:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48003 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727008AbgH0RMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598548326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uchtyp5DVRtl0VqaI00HMpgs89YiVvUyiaRTklLzvhY=;
        b=er1QEuRPHuLywTHB/SVDbxKutnoeriNLng13OTJoFe/WdG1YuCduMvrjsSKSLLr76Vz/By
        BfEtw2AjDLz8vAILjiQN2S0iqJrXEw5ya7+a49wY08iWID6WAoW7G2u8VyrSFimbUE/chU
        AInpE+GufF2Ouww9hu91HRzZYz+shrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-Spc_LnLqN0aOBBtLmk_-XA-1; Thu, 27 Aug 2020 13:11:57 -0400
X-MC-Unique: Spc_LnLqN0aOBBtLmk_-XA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CBFB10ABDD4;
        Thu, 27 Aug 2020 17:11:56 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72FB15D9E8;
        Thu, 27 Aug 2020 17:11:50 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT)), Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v3 1/8] KVM: SVM: rename a variable in the svm_create_vcpu
Date:   Thu, 27 Aug 2020 20:11:38 +0300
Message-Id: <20200827171145.374620-2-mlevitsk@redhat.com>
In-Reply-To: <20200827171145.374620-1-mlevitsk@redhat.com>
References: <20200827171145.374620-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'page' is to hold the vcpu's vmcb so name it as such to
avoid confusion.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/svm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0cfb8c08e744e..722769eaaf8ce 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1171,7 +1171,7 @@ static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 static int svm_create_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm;
-	struct page *page;
+	struct page *vmcb_page;
 	struct page *msrpm_pages;
 	struct page *hsave_page;
 	struct page *nested_msrpm_pages;
@@ -1181,8 +1181,8 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
 	svm = to_svm(vcpu);
 
 	err = -ENOMEM;
-	page = alloc_page(GFP_KERNEL_ACCOUNT);
-	if (!page)
+	vmcb_page = alloc_page(GFP_KERNEL_ACCOUNT);
+	if (!vmcb_page)
 		goto out;
 
 	msrpm_pages = alloc_pages(GFP_KERNEL_ACCOUNT, MSRPM_ALLOC_ORDER);
@@ -1216,9 +1216,9 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
 	svm->nested.msrpm = page_address(nested_msrpm_pages);
 	svm_vcpu_init_msrpm(svm->nested.msrpm);
 
-	svm->vmcb = page_address(page);
+	svm->vmcb = page_address(vmcb_page);
 	clear_page(svm->vmcb);
-	svm->vmcb_pa = __sme_set(page_to_pfn(page) << PAGE_SHIFT);
+	svm->vmcb_pa = __sme_set(page_to_pfn(vmcb_page) << PAGE_SHIFT);
 	svm->asid_generation = 0;
 	init_vmcb(svm);
 
@@ -1234,7 +1234,7 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
 free_page2:
 	__free_pages(msrpm_pages, MSRPM_ALLOC_ORDER);
 free_page1:
-	__free_page(page);
+	__free_page(vmcb_page);
 out:
 	return err;
 }
-- 
2.26.2

