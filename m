Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C31C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6CE72087E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yze0Go7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgH0RMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:12:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50356 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726834AbgH0RM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598548347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W/YGWSLvG6lY5R83KUArknDiX8BRYjrRNnmUZit1EZI=;
        b=Yze0Go7wKX8CtxVniOw0Gk2lINKBj2yyxLTTrJesrun6cAmVBloc0cX/azWpLY61vqZPLP
        Wx3SXOXIdw5gZEn/KHxEcZ3TccMNmqigqX5VRi2x2M29lp6gZyYOtdnV9PhnOjw+u+Os92
        BLwUeWrW4WJ8Iv38kXqMnLjcxzGoaEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-DbTiD6I8MFqHmhuIjFc4kQ-1; Thu, 27 Aug 2020 13:12:26 -0400
X-MC-Unique: DbTiD6I8MFqHmhuIjFc4kQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A55E6802B47;
        Thu, 27 Aug 2020 17:12:24 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 402F45D9E8;
        Thu, 27 Aug 2020 17:12:21 +0000 (UTC)
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
Subject: [PATCH v3 5/8] KVM: SVM: refactor exit labels in svm_create_vcpu
Date:   Thu, 27 Aug 2020 20:11:42 +0300
Message-Id: <20200827171145.374620-6-mlevitsk@redhat.com>
In-Reply-To: <20200827171145.374620-1-mlevitsk@redhat.com>
References: <20200827171145.374620-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel coding style suggests not to use labels like error1,error2

Suggested-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 290b2d0cd78e3..b617579095277 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1196,11 +1196,11 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
 
 	hsave_page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 	if (!hsave_page)
-		goto free_page1;
+		goto error_free_vmcb_page;
 
 	err = avic_init_vcpu(svm);
 	if (err)
-		goto free_page2;
+		goto error_free_hsave_page;
 
 	/* We initialize this flag to true to make sure that the is_running
 	 * bit would be set the first time the vcpu is loaded.
@@ -1212,11 +1212,11 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
 
 	svm->msrpm = svm_vcpu_init_msrpm();
 	if (!svm->msrpm)
-		goto free_page2;
+		goto error_free_hsave_page;
 
 	svm->nested.msrpm = svm_vcpu_init_msrpm();
 	if (!svm->nested.msrpm)
-		goto free_page3;
+		goto error_free_msrpm;
 
 	svm->vmcb = page_address(vmcb_page);
 	svm->vmcb_pa = __sme_set(page_to_pfn(vmcb_page) << PAGE_SHIFT);
@@ -1228,11 +1228,11 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
 
 	return 0;
 
-free_page3:
+error_free_msrpm:
 	svm_vcpu_free_msrpm(svm->msrpm);
-free_page2:
+error_free_hsave_page:
 	__free_page(hsave_page);
-free_page1:
+error_free_vmcb_page:
 	__free_page(vmcb_page);
 out:
 	return err;
-- 
2.26.2

