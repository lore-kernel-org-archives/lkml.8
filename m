Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2660FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6FA120885
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvSaWWD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgHTJNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:13:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52817 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726853AbgHTJNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597914822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZcRR+zhuRSPQz3y/P4w6mA/wG4YpwsNTibjI7+ECMsI=;
        b=OvSaWWD7xj8YvzyQD0P7ebQwjDCMEyYNIEt9ACIt8F7mGqRbfAF7fJBe1UdCNh0gR4HEgq
        6DlXhrjOOzED9TVbA5cy700Bj9l3UjyuZg2CuIVEYhB4U8ih63hvALYy2gX9IAiWJiuNCK
        /N0aEBxDGzoXzJsebivZRsztlYBoWec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-dQH393HBP0y4UCERGNaR3w-1; Thu, 20 Aug 2020 05:13:38 -0400
X-MC-Unique: dQH393HBP0y4UCERGNaR3w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC759801A9E;
        Thu, 20 Aug 2020 09:13:36 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 257C1747B0;
        Thu, 20 Aug 2020 09:13:32 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT)),
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Ingo Molnar <mingo@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 1/8] KVM: SVM: rename a variable in the svm_create_vcpu
Date:   Thu, 20 Aug 2020 12:13:20 +0300
Message-Id: <20200820091327.197807-2-mlevitsk@redhat.com>
In-Reply-To: <20200820091327.197807-1-mlevitsk@redhat.com>
References: <20200820091327.197807-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'page' is to hold the vcpu's vmcb so name it as such to
avoid confusion.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 03dd7bac8034..562a79e3e63a 100644
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

