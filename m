Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2A4C35DFE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C13021744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbgBYJ0m convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 04:26:42 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:40876 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726905AbgBYJ0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 04:26:41 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 818559168C1018F379AB;
        Tue, 25 Feb 2020 17:26:30 +0800 (CST)
Received: from dggeme701-chm.china.huawei.com (10.1.199.97) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 25 Feb 2020 17:26:29 +0800
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme701-chm.china.huawei.com (10.1.199.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 25 Feb 2020 17:26:30 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1713.004;
 Tue, 25 Feb 2020 17:26:29 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     "rmuncrief@humanavance.com" <rmuncrief@humanavance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH] KVM: SVM: allocate AVIC data structures based on kvm_amd
 moduleparameter
Thread-Topic: [PATCH] KVM: SVM: allocate AVIC data structures based on kvm_amd
 moduleparameter
Thread-Index: AdXruJOTY+xs7ME3Q+aCsVJWLiz78A==
Date:   Tue, 25 Feb 2020 09:26:29 +0000
Message-ID: <1e573a529ff149f9858ae1c809ddb8c0@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.221.158]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:
>Even if APICv is disabled at startup, the backing page and ir_list need to be initialized in case they are needed later.  The only case in which this can be skipped is for userspace irqchip, and that must be done because avic_init_backing_page dereferences vcpu->arch.apic (which is NULL for userspace irqchip).
>
>Tested-by: rmuncrief@humanavance.com
>Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=206579
>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>---
> arch/x86/kvm/svm.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c index ad3f5b178a03..bd02526300ab 100644
>--- a/arch/x86/kvm/svm.c
>+++ b/arch/x86/kvm/svm.c
>@@ -2194,8 +2194,9 @@ static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)  static int avic_init_vcpu(struct vcpu_svm *svm)  {
> 	int ret;
>+	struct kvm_vcpu *vcpu = &svm->vcpu;
> 
>-	if (!kvm_vcpu_apicv_active(&svm->vcpu))
>+	if (!avic || !irqchip_in_kernel(vcpu->kvm))
> 		return 0;
>
> 	ret = avic_init_backing_page(&svm->vcpu);
>--
>1.8.3.1
>

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

