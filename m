Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEADC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6129207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxDs99KS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgGIRrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:47:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39048 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728679AbgGIRrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594316831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tQEZ/X60w4Dr4Yx057tjgU0MuPGoc8zws3NdcP5xzU0=;
        b=IxDs99KS/vPtVEJ9ywdxFYS61v+fbsUXCrn9xgWGljWEFe9Uvt4U1EAncIJZraHuL/Tygi
        fr7wQkyAjmtBDhYzZcq/vgET8doxz9GuREd3nGU+iCz1yJEZ2Sz0bCHaMdDpsfuVvDdFDg
        pqleWg7PsfxdWXR7gohIWT4gszNgors=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98--Re0OQwkNeqCA8xihz34sQ-1; Thu, 09 Jul 2020 13:47:10 -0400
X-MC-Unique: -Re0OQwkNeqCA8xihz34sQ-1
Received: by mail-wr1-f72.google.com with SMTP id b14so2649312wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 10:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tQEZ/X60w4Dr4Yx057tjgU0MuPGoc8zws3NdcP5xzU0=;
        b=ipSVj2FGpGiOQw9UAwTbXu71XN6SjiTpLTh9b4pWtbjyRIUf1lTF3THm6uoqz9Qt29
         kMOoaAVZT+qw4tjihzFe2KJ1jUf7+l9J01i3DWWenS06LxxtvetOSZHDip5j60CHgOPN
         RxEAyf+EqlN/7tCqws9qBPVfTgB+CR5qUvn7s4Ve7PAjY9pRkeKGyWFY4AcW0gkPShAO
         v7+TBiETmTw2OxODXSvn1W1Gj2/DkrGRBxwpf01ZDf6iUcV0HUwOfjliuG8NKfXNvQYn
         hSRXW5bAgpFB33chDqEwyetUbPGam3/+syBykXNtH44KYrEhYhYXndYcgjS/26M2P7N1
         1tdg==
X-Gm-Message-State: AOAM531J7sYpQzyslYf1fDznBvNQsD0u/qSPCdLKWStI2gTeQRMDpTVW
        XCM3cGxhv3KgpGcwYE8mTVHtCSTr3EwA6rLQRESSDOAxHe0TsexoVMBbpVUIJIQrvXgdIo9q9fq
        woX7jFkXdqGOeDHzU3doWO+Rm
X-Received: by 2002:adf:ec42:: with SMTP id w2mr65079442wrn.269.1594316828757;
        Thu, 09 Jul 2020 10:47:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzKy2sg6Y5Mw1xuBaOwDSwnR6MCjcqFzdAlEFQ64OSxQdEBmpqMG1KLCfhQXYJsbmlYAJtCw==
X-Received: by 2002:adf:ec42:: with SMTP id w2mr65079426wrn.269.1594316828506;
        Thu, 09 Jul 2020 10:47:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id f15sm6067638wrx.91.2020.07.09.10.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 10:47:08 -0700 (PDT)
Subject: Re: [PATCH v3 2/9] KVM: nSVM: stop dereferencing vcpu->arch.mmu to
 get the context in kvm_init_shadow{,_npt}_mmu()
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Junaid Shahid <junaids@google.com>,
        linux-kernel@vger.kernel.org
References: <20200709145358.1560330-1-vkuznets@redhat.com>
 <20200709145358.1560330-3-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1c6999b7-1eae-4b26-7220-6e3e68457511@redhat.com>
Date:   Thu, 9 Jul 2020 19:47:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709145358.1560330-3-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/20 16:53, Vitaly Kuznetsov wrote:
> Now as kvm_init_shadow_npt_mmu() is separated from kvm_init_shadow_mmu()
> we always know the MMU context we need to use so there is no need to
> dereference vcpu->arch.mmu pointer.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 

This is actually true of all init functions, so we can squash this in too
(my fault for being too concise):

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 2c4fb5684782..78c88e8aecfa 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4850,7 +4850,7 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu, bool base_only)
 
 static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
 {
-	struct kvm_mmu *context = vcpu->arch.mmu;
+	struct kvm_mmu *context = &vcpu->arch.root_mmu;
 	union kvm_mmu_role new_role =
 		kvm_calc_tdp_mmu_root_page_role(vcpu, false);
 
@@ -4989,7 +4989,7 @@ kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
 void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 			     bool accessed_dirty, gpa_t new_eptp)
 {
-	struct kvm_mmu *context = vcpu->arch.mmu;
+	struct kvm_mmu *context = &vcpu->arch.guest_mmu;
 	u8 level = vmx_eptp_page_walk_level(new_eptp);
 	union kvm_mmu_role new_role =
 		kvm_calc_shadow_ept_root_page_role(vcpu, accessed_dirty,
@@ -5023,7 +5023,7 @@ EXPORT_SYMBOL_GPL(kvm_init_shadow_ept_mmu);
 
 static void init_kvm_softmmu(struct kvm_vcpu *vcpu)
 {
-	struct kvm_mmu *context = vcpu->arch.mmu;
+	struct kvm_mmu *context = &vcpu->arch.root_mmu;
 
 	kvm_init_shadow_mmu(vcpu,
 			    kvm_read_cr0_bits(vcpu, X86_CR0_PG),


(BTW, a patch to rename nested_mmu to nested_walk_mmu and guest_mmu to
nested_tdp_mmu would be welcome).

Paolo

