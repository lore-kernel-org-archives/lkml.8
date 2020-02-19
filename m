Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2A5C34054
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 16:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D1F2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 16:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ON1U9gur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgBSQTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:19:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44025 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726528AbgBSQTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 11:19:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582129188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eQG6wOR7XEH6waSn1u4s8c6iKIaqZZz3sGjiy8AFd8A=;
        b=ON1U9gurDwl30R+16T/cL2o1LSaoU4Z1cTPS88i3JcBhvoc18PxI88veWoR2P1iC/t+72E
        X6bg8tQMNDwUMhxdbpmiFayvnjl4b927RktIrJi1txmQaEuqrjavzILEuy03gCUQT1IfR9
        0rFnjwsW9YmFuzRQDlOFinjUOyJbjT8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-jzfV-FEyOgGAQDK_n6994Q-1; Wed, 19 Feb 2020 11:19:45 -0500
X-MC-Unique: jzfV-FEyOgGAQDK_n6994Q-1
Received: by mail-wm1-f70.google.com with SMTP id b8so316036wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 08:19:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eQG6wOR7XEH6waSn1u4s8c6iKIaqZZz3sGjiy8AFd8A=;
        b=exCCHgg5QrM0Yj2YD24bA8IF3g+CZ7iKcc8sd1cLVeaLnTW6O26IEbg0XtoiYVYBat
         768r49ym5XXbPvUIkWdGIIXqH7zBR12n9GM0USxHj2Mscxf4k1iXs1K9dwwg2NEczJP1
         /dO/66VciGyxc+22tEjNotVtx5m2yC3wzaa7f3fKN5Gk+PbNpC8c6kUcW3yp3IqQB6Ls
         w8VDcFJjiQHBkWuIpFqYx58AZWnTPMDt3V4S7PCfOKnjNPienYYaBZA3wfPqzhyUfqgA
         xDW6XtVh/xsTBoqunCdWP2FhDEqyLDHHwjSrAPyK4U1NQJblpSVPBHAlKIT90HF2O9bg
         F3zw==
X-Gm-Message-State: APjAAAWZrpgbx6tux6dzCaQ96ap/s4/hcAgoKy2hqVSq29Z/Fr+KqyOc
        HXWBUhgHG5kZe0rsEH5fo6BcGmkZsLj0kOfP/rL4IqJ5UEORpQP56VDHFVqno3DxvDxFJGhY/yP
        JffwBJW8pdywhDSx0B1J26bCA
X-Received: by 2002:a05:600c:2c13:: with SMTP id q19mr11142421wmg.144.1582129184441;
        Wed, 19 Feb 2020 08:19:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqxA0P0y9HeEt0jYJ8WWr+k4KMpNa61zp/pvvV7y6klztlfomtqNm/je1u9mUu7gPxdvz1k58g==
X-Received: by 2002:a05:600c:2c13:: with SMTP id q19mr11142396wmg.144.1582129184190;
        Wed, 19 Feb 2020 08:19:44 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ec41:5e57:ff4d:8e51? ([2001:b07:6468:f312:ec41:5e57:ff4d:8e51])
        by smtp.gmail.com with ESMTPSA id j5sm321626wrw.24.2020.02.19.08.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 08:19:43 -0800 (PST)
Subject: Re: [PATCH v2] KVM: VMX: Add 'else' to split mutually exclusive case
To:     linmiaohe <linmiaohe@huawei.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <1581951750-17854-1-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <088c58ac-90f8-120c-af3a-d8e10ff7ed99@redhat.com>
Date:   Wed, 19 Feb 2020 17:19:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1581951750-17854-1-git-send-email-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/20 16:02, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> Each if branch in handle_external_interrupt_irqoff() is mutually
> exclusive. Add 'else' to make it clear and also avoid some unnecessary
> check.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
> v1->v2:
> add braces to all if branches
> ---
>  arch/x86/kvm/vmx/vmx.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 9a6664886f2e..a13368b2719c 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6176,15 +6176,13 @@ static void handle_exception_nmi_irqoff(struct vcpu_vmx *vmx)
>  	vmx->exit_intr_info = vmcs_read32(VM_EXIT_INTR_INFO);
>  
>  	/* if exit due to PF check for async PF */
> -	if (is_page_fault(vmx->exit_intr_info))
> +	if (is_page_fault(vmx->exit_intr_info)) {
>  		vmx->vcpu.arch.apf.host_apf_reason = kvm_read_and_reset_pf_reason();
> -
>  	/* Handle machine checks before interrupts are enabled */
> -	if (is_machine_check(vmx->exit_intr_info))
> +	} else if (is_machine_check(vmx->exit_intr_info)) {
>  		kvm_machine_check();
> -
>  	/* We need to handle NMIs before interrupts are enabled */
> -	if (is_nmi(vmx->exit_intr_info)) {
> +	} else if (is_nmi(vmx->exit_intr_info)) {
>  		kvm_before_interrupt(&vmx->vcpu);
>  		asm("int $2");
>  		kvm_after_interrupt(&vmx->vcpu);
> 

Queued, thanks.

Paolo

