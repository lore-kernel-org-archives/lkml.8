Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF30CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A660420814
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6eqwoj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgFIKS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 06:18:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31457 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728743AbgFIKSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 06:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591697914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3sdqb6g4ihbLhkBEfIP/iQpvtsvP33bVeevH+3u62Oc=;
        b=Z6eqwoj0COLg1FcufXkHswB9CBPmL5puxLkRbLcBMdh0V3FVsq9JKHV6SkQmyUx4BDFm0l
        NO6jgyFFqkSOmSCWm9LbgJuuJTRbHNITJUkddx7y+es/EvLhrPVaO/4B53LC2su8qCAER1
        VmSNCPJhAlSVwYjswuJbDZUOPhJHreo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-xVWACGCuN1qlO0EXLlEtWw-1; Tue, 09 Jun 2020 06:18:32 -0400
X-MC-Unique: xVWACGCuN1qlO0EXLlEtWw-1
Received: by mail-wr1-f69.google.com with SMTP id c14so8369631wrw.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 03:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3sdqb6g4ihbLhkBEfIP/iQpvtsvP33bVeevH+3u62Oc=;
        b=jYncyfXcih7i3jp75wmv30FA3Gkd5qXaHTQdIfeiW8tuw4zVT8AkEe0g4SBhFCKDGt
         VqPEYo17efq9aps5ETs15OW6T2SwHlAWZaRgfVvKDIIHS/zHGdLHrlbYxZTPAfgC/saO
         cTdBqnqD3Tx7WbMvbLdk7qeUkaHP48jqdrvUj9gFNz+nu7JJIiYNhXyarfUdgSPSwqV7
         yx4PJbHepUivhR+xBMADLfDIrYG86M+kHHy7bleB8V/pdKlN+Q6mRPAEazPOB5sS+7aJ
         yWaM/mSwohcARMzrNk38qQz+0BhaTXji4/AkKAZ3PdLjXbsl0u50adrt7j7TKP0mF2fZ
         oSwA==
X-Gm-Message-State: AOAM531R5jdI/5dFJ/8u/zbh/F2s112ZQz8wjpgoNshGdc59GP/78J7K
        mcHezVo76Kw05AK2iZI7a5qakNNIBdSKPqRgyRwE+s1shsYtMGPsh4wefSYSbVAV4D48HvbvVKl
        ObAL2ncZY+pNMFkVU2ch5DS8y
X-Received: by 2002:a1c:a74f:: with SMTP id q76mr3438091wme.65.1591697910892;
        Tue, 09 Jun 2020 03:18:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfIL2Q+jM3CRYMhgS5kqzHuXFhLEuV0UP3eNIF2scHlFcuKXLYyS3L1Q5Mu5PD1R+s2YSGxA==
X-Received: by 2002:a1c:a74f:: with SMTP id q76mr3438060wme.65.1591697910629;
        Tue, 09 Jun 2020 03:18:30 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.172.168])
        by smtp.gmail.com with ESMTPSA id g82sm2452249wmf.1.2020.06.09.03.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 03:18:30 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: nVMX: Consult only the "basic" exit reason when
 routing nested exit
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Oliver Upton <oupton@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>
References: <20200608191857.30319-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6153e63a-b68e-3537-8fab-d92163c329f0@redhat.com>
Date:   Tue, 9 Jun 2020 12:18:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200608191857.30319-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/20 21:18, Sean Christopherson wrote:
> Consult only the basic exit reason, i.e. bits 15:0 of vmcs.EXIT_REASON,
> when determining whether a nested VM-Exit should be reflected into L1 or
> handled by KVM in L0.
> 
> For better or worse, the switch statements nested_vmx_l0_wants_exit()
> and nested_vmx_l1_wants_exit() default to reflecting the VM-Exit into L1
> for any nested VM-Exit without dedicated logic.  Because the case
> statements only contain the basic exit reason, any VM-Exit with modifier
> bits set will be reflected to L1, even if KVM intended to handle it in
> L0.
> 
> Practically speaking, this only affects EXIT_REASON_MCE_DURING_VMENTRY,
> i.e. a #MC that occurs on nested VM-Enter would be incorrectly routed to
> L1, as "failed VM-Entry" is the only modifier that KVM can currently
> encounter.  The SMM modifiers will never be generated as KVM doesn't
> support/employ a SMI Transfer Monitor.  Ditto for "exit from enclave",
> as KVM doesn't yet support virtualizing SGX, i.e. it's impossible to
> enter an enclave in a KVM guest (L1 or L2).
> 
> Note, the original version of this fix[*] is functionally equivalent and
> far more suited to backporting as the affected code was refactored since
> the original patch was posted.
> 
> [*] https://lkml.kernel.org/r/20200227174430.26371-1-sean.j.christopherson@intel.com
> 
> Fixes: 644d711aa0e1 ("KVM: nVMX: Deciding if L0 or L1 should handle an L2 exit")
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: stable@vger.kernel.org
> Cc: Oliver Upton <oupton@google.com>
> Cc: Krish Sadhukhan <krish.sadhukhan@oracle.com>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
> 
> Another wounded soldier. 
> 
> Oliver, Krish, and Miaohe all provided reviews for v1, but I didn't feel
> comfortable adding the tags to v2 because this is far from a straight
> rebase.
> 
> v2: Rebased to kvm/queue, commit fb7333dfd812 ("KVM: SVM: fix calls ...").
> 
>  arch/x86/kvm/vmx/nested.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index bcb50724be38..adb11b504d5c 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -5672,7 +5672,7 @@ static bool nested_vmx_l0_wants_exit(struct kvm_vcpu *vcpu, u32 exit_reason)
>  {
>  	u32 intr_info;
>  
> -	switch (exit_reason) {
> +	switch ((u16)exit_reason) {
>  	case EXIT_REASON_EXCEPTION_NMI:
>  		intr_info = vmx_get_intr_info(vcpu);
>  		if (is_nmi(intr_info))
> @@ -5733,7 +5733,7 @@ static bool nested_vmx_l1_wants_exit(struct kvm_vcpu *vcpu, u32 exit_reason)
>  	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
>  	u32 intr_info;
>  
> -	switch (exit_reason) {
> +	switch ((u16)exit_reason) {
>  	case EXIT_REASON_EXCEPTION_NMI:
>  		intr_info = vmx_get_intr_info(vcpu);
>  		if (is_nmi(intr_info))
> 

Thanks, queued with git magic (committed v1 based on v5.7, merged into
kvm/queue, added the delta to v2 in the merge commit) so that stable
branches can cherry-pick cleanly.

Paolo

