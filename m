Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E5BC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCEB215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtGoi4z2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgCCIsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 03:48:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23962 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725840AbgCCIsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583225287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q+Dx+bhdegB+eWVNZExdRg6MuYP3hf9RoraGKKuypFY=;
        b=AtGoi4z2Xg+aBOhGpwQD+rirT3DUw3qglc+OanMxsXnf7LQwYsoqlq/yg+lAWWu1M2uvke
        AU/dCsMvrqDnVuFxHjI9v3jyDDf6jZLchAML2dZr2SCC6SflTJAGCgF3dJwaewl6imvwa2
        8VPXrOzVP+9QiCtq4sUC6+tOVyhOW5I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-A-BqoCXSNxqPgsD3v2wr5Q-1; Tue, 03 Mar 2020 03:48:06 -0500
X-MC-Unique: A-BqoCXSNxqPgsD3v2wr5Q-1
Received: by mail-wr1-f71.google.com with SMTP id w8so126828wrn.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 00:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q+Dx+bhdegB+eWVNZExdRg6MuYP3hf9RoraGKKuypFY=;
        b=EKfL7241BuJTBH9H8YQ7/Mlj7ShGOOkLpZfBr6JT0eKdz0IarElDyyxgbM4DRprK/t
         DUiGjXSL/pTAwOVXxL93JlqHAWHA+G8D15VCMsesQZrQ18YyidGHYihT7SpiRbVeh2Tx
         Q7TywvpHAfL8sm3Kpi46pzUet/RRswmnBqmHmqaSTR7/qCCjcuea9cp+SdnqTxzrYQn1
         Xy4tzPj85mZIafKUfl5Y0iqqwYLphw1J0dTjrlL+R0Z65vWnSQ+Z0LLmnZ3n1ag8ScNN
         XFcjRx+wu3xDSz/MvECQ2rIsdC9LadlVkw9zduTT5Lnv2St3yo8XK2z7xhRYbBxaqjot
         aexQ==
X-Gm-Message-State: ANhLgQ1D77fHPyvx9nlFYnQtS8azkcm7+zCALzeL4uN67fs8FDkAA4+u
        FsRBY934GGefQlBrZq4dCJ7p9Y6eomtlbb2veZn2sfZEDZbJqOVidkfwBx42pPlR02TnkTqxBZ4
        LQuO/VedIn+xNPnQVQtCcvtZ5
X-Received: by 2002:a5d:518b:: with SMTP id k11mr4535743wrv.114.1583225283702;
        Tue, 03 Mar 2020 00:48:03 -0800 (PST)
X-Google-Smtp-Source: ADFU+vv1gYGF0VZ5dtGf6hpUgpE0yOTX8+g8a9kir+oWZblHaZGanTWsFQFLvs9yrygomTwVX9GpGA==
X-Received: by 2002:a5d:518b:: with SMTP id k11mr4535701wrv.114.1583225283410;
        Tue, 03 Mar 2020 00:48:03 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:4c52:2f3b:d346:82de? ([2001:b07:6468:f312:4c52:2f3b:d346:82de])
        by smtp.gmail.com with ESMTPSA id i204sm2895140wma.44.2020.03.03.00.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 00:48:02 -0800 (PST)
Subject: Re: [PATCH 3/6] KVM: x86: Add dedicated emulator helper for grabbing
 CPUID.maxphyaddr
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
References: <20200302195736.24777-1-sean.j.christopherson@intel.com>
 <20200302195736.24777-4-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <de2ed4e9-409a-6cb1-e295-ea946be11e82@redhat.com>
Date:   Tue, 3 Mar 2020 09:48:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302195736.24777-4-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/20 20:57, Sean Christopherson wrote:
> Add a helper to retrieve cpuid_maxphyaddr() instead of manually
> calculating the value in the emulator via raw CPUID output.  In addition
> to consolidating logic, this also paves the way toward simplifying
> kvm_cpuid(), whose somewhat confusing return value exists purely to
> support the emulator's maxphyaddr calculation.
> 
> No functional change intended.

I don't think this is a particularly useful change.  Yes, it's not
intuitive but is it more than a matter of documentation (and possibly
moving the check_cr_write snippet into a separate function)?

Paolo

> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/kvm_emulate.h |  1 +
>  arch/x86/kvm/emulate.c             | 10 +---------
>  arch/x86/kvm/x86.c                 |  6 ++++++
>  3 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_emulate.h b/arch/x86/include/asm/kvm_emulate.h
> index bf5f5e476f65..ded06515d30f 100644
> --- a/arch/x86/include/asm/kvm_emulate.h
> +++ b/arch/x86/include/asm/kvm_emulate.h
> @@ -222,6 +222,7 @@ struct x86_emulate_ops {
>  
>  	bool (*get_cpuid)(struct x86_emulate_ctxt *ctxt, u32 *eax, u32 *ebx,
>  			  u32 *ecx, u32 *edx, bool check_limit);
> +	int (*get_cpuid_maxphyaddr)(struct x86_emulate_ctxt *ctxt);
>  	bool (*guest_has_long_mode)(struct x86_emulate_ctxt *ctxt);
>  	bool (*guest_has_movbe)(struct x86_emulate_ctxt *ctxt);
>  	bool (*guest_has_fxsr)(struct x86_emulate_ctxt *ctxt);
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index dd19fb3539e0..bf02ed51e90f 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -4244,16 +4244,8 @@ static int check_cr_write(struct x86_emulate_ctxt *ctxt)
>  
>  		ctxt->ops->get_msr(ctxt, MSR_EFER, &efer);
>  		if (efer & EFER_LMA) {
> -			u64 maxphyaddr;
> -			u32 eax, ebx, ecx, edx;
> +			int maxphyaddr = ctxt->ops->get_cpuid_maxphyaddr(ctxt);
>  
> -			eax = 0x80000008;
> -			ecx = 0;
> -			if (ctxt->ops->get_cpuid(ctxt, &eax, &ebx, &ecx,
> -						 &edx, false))
> -				maxphyaddr = eax & 0xff;
> -			else
> -				maxphyaddr = 36;
>  			rsvd = rsvd_bits(maxphyaddr, 63);
>  			if (ctxt->ops->get_cr(ctxt, 4) & X86_CR4_PCIDE)
>  				rsvd &= ~X86_CR3_PCID_NOFLUSH;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ddd1d296bd20..5467ee71c25b 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6209,6 +6209,11 @@ static bool emulator_get_cpuid(struct x86_emulate_ctxt *ctxt,
>  	return kvm_cpuid(emul_to_vcpu(ctxt), eax, ebx, ecx, edx, check_limit);
>  }
>  
> +static int emulator_get_cpuid_maxphyaddr(struct x86_emulate_ctxt *ctxt)
> +{
> +	return cpuid_maxphyaddr(emul_to_vcpu(ctxt));
> +}
> +
>  static bool emulator_guest_has_long_mode(struct x86_emulate_ctxt *ctxt)
>  {
>  	return guest_cpuid_has(emul_to_vcpu(ctxt), X86_FEATURE_LM);
> @@ -6301,6 +6306,7 @@ static const struct x86_emulate_ops emulate_ops = {
>  	.fix_hypercall       = emulator_fix_hypercall,
>  	.intercept           = emulator_intercept,
>  	.get_cpuid           = emulator_get_cpuid,
> +	.get_cpuid_maxphyaddr= emulator_get_cpuid_maxphyaddr,
>  	.guest_has_long_mode = emulator_guest_has_long_mode,
>  	.guest_has_movbe     = emulator_guest_has_movbe,
>  	.guest_has_fxsr      = emulator_guest_has_fxsr,
> 

