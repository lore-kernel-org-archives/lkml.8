Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6B0C47254
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 13:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20D6F2073B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 13:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/LL0X4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgEDNTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 09:19:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50342 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726712AbgEDNTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 09:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588598371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y5YC7u0uAUwZps5v9qeTVARlcP53sa4chmEqYPiy2DU=;
        b=T/LL0X4l4mAemZ1NNF4agZqYv0vXQm3uuKnNW06ARmx+sQABTI0xAdkaaPEGfgTX588XfZ
        qyWfAzJAB/w/xQMXMHL6yuPuoHvhwcQV8ZzqmQo9eJ7vg+KJ1lZ+TAODkt/6CeR5xYC8DL
        tlVESpGMvXHZZqZprXBWI7h/F7rZFEM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-0dEjlYqXOj-JaIs6yq4qug-1; Mon, 04 May 2020 09:19:29 -0400
X-MC-Unique: 0dEjlYqXOj-JaIs6yq4qug-1
Received: by mail-wr1-f70.google.com with SMTP id u4so10751632wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 06:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y5YC7u0uAUwZps5v9qeTVARlcP53sa4chmEqYPiy2DU=;
        b=FvfsDNYr0zTqJB/CBh825kgRaZvQLfgpSZKBJ5gYBRAnqbhAbjGEgYTBl8NduDRmB/
         ++m8vtGeiVeZCt+jPrvx6Lfk0aHsfNEoS393sW9NlSTzJsEKwnax6/+Y0rLnN9Z4USWQ
         c+kKx9vjZjXeGLVEHpiYdJi2yQYOPsPI3c2RODjwORMqQcBrTKT+uZwlw3Y0Gts4jvkg
         m76hj70WoQD+QCYdSM4waKZU0/w6ARMbYiGhChDhXf2/uwFs7vE5Xyx4Qlf637Fy9k+L
         vOXwy9WIx3zuXwijRwnS9gwV30D23Q4IdPLca5QmuRjZVOnKGA+2T0n2FMxdMXDoksI8
         owSg==
X-Gm-Message-State: AGi0PuZQdbknnbN1jez0GyHpr9Q/HCC1ouaSEAGGthm5ZBSbqtGNeTwz
        nj+/q6tkdRC9yaOedpZ5Xoe+cFFUnWyKVD1irWpBfKfhaKGOyl8PKRafGoisWHejZhxN3ZOKgPk
        d0FSFE07J0T95MBtZ3vCuT+P3
X-Received: by 2002:a7b:ca47:: with SMTP id m7mr15727719wml.55.1588598367562;
        Mon, 04 May 2020 06:19:27 -0700 (PDT)
X-Google-Smtp-Source: APiQypJSJ5WclevXzlwrOAyFhNpJ7zwzP5hPdJR6klqa4Z145sCzWMrN0JZJiVKhgd5TWeppuq6yFQ==
X-Received: by 2002:a7b:ca47:: with SMTP id m7mr15727692wml.55.1588598367274;
        Mon, 04 May 2020 06:19:27 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
        by smtp.gmail.com with ESMTPSA id v10sm19428804wrq.45.2020.05.04.06.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 06:19:26 -0700 (PDT)
Subject: Re: [PATCH 03/10] KVM: x86: Make kvm_x86_ops' {g,s}et_dr6() hooks
 optional
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200502043234.12481-1-sean.j.christopherson@intel.com>
 <20200502043234.12481-4-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <37a30f26-2561-aada-9bdc-7bc9cddf0d7f@redhat.com>
Date:   Mon, 4 May 2020 15:19:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200502043234.12481-4-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/20 06:32, Sean Christopherson wrote:
> Make get_dr6() and set_dr6() optional and drop the VMX implementations,
> which are for all intents and purposes nops.  This avoids a retpoline on
> VMX when reading/writing DR6, at minimal cost (~1 uop) to SVM.

Can't get_dr6 be killed off completely here, since vcpu->arch.dr6 is the
only value that is ever passed to set_dr6?  OTOH no complaint about
adding the if for vmx_set_dr6, since that will also be covered nicely by
DEFINE_STATIC_COND_CALL.

Paolo

> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 11 -----------
>  arch/x86/kvm/x86.c     |  6 ++++--
>  2 files changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index de18cd386bb1..e157bdc218ea 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5008,15 +5008,6 @@ static int handle_dr(struct kvm_vcpu *vcpu)
>  	return kvm_skip_emulated_instruction(vcpu);
>  }
>  
> -static u64 vmx_get_dr6(struct kvm_vcpu *vcpu)
> -{
> -	return vcpu->arch.dr6;
> -}
> -
> -static void vmx_set_dr6(struct kvm_vcpu *vcpu, unsigned long val)
> -{
> -}
> -
>  static void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
>  {
>  	get_debugreg(vcpu->arch.db[0], 0);
> @@ -7799,8 +7790,6 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
>  	.set_idt = vmx_set_idt,
>  	.get_gdt = vmx_get_gdt,
>  	.set_gdt = vmx_set_gdt,
> -	.get_dr6 = vmx_get_dr6,
> -	.set_dr6 = vmx_set_dr6,
>  	.set_dr7 = vmx_set_dr7,
>  	.sync_dirty_debug_regs = vmx_sync_dirty_debug_regs,
>  	.cache_reg = vmx_cache_reg,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 8ec356ac1e6e..eccbfcb6a4e5 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1069,7 +1069,8 @@ static void kvm_update_dr0123(struct kvm_vcpu *vcpu)
>  
>  static void kvm_update_dr6(struct kvm_vcpu *vcpu)
>  {
> -	if (!(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP))
> +	if (!(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP) &&
> +	    kvm_x86_ops.set_dr6)
>  		kvm_x86_ops.set_dr6(vcpu, vcpu->arch.dr6);
>  }
>  
> @@ -1148,7 +1149,8 @@ int kvm_get_dr(struct kvm_vcpu *vcpu, int dr, unsigned long *val)
>  	case 4:
>  		/* fall through */
>  	case 6:
> -		if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP)
> +		if ((vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP) ||
> +		    !kvm_x86_ops.get_dr6)
>  			*val = vcpu->arch.dr6;
>  		else
>  			*val = kvm_x86_ops.get_dr6(vcpu);
> 

