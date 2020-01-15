Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBF4C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77572187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5IFPyY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgAOSSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:18:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39776 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728904AbgAOSSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:18:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579112295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T1l2IaCJc8x3A4Xb+p+1AqY/vTkonHYiWw1rDR8HsKQ=;
        b=g5IFPyY8zb8LbIGrpukr4InNkVehjBZKGSx6QmxB4TmwKpc5suqrI9Fit7GTlcLqPC8ijR
        aWKC9eWwbTTIoxiXtp/L/QgiwgLNP0xrHkxknnCDVZgO7cNquoiM8lkcq4QLh8dSweQPNu
        F8Y1eT7bBNMRwUJOcb9wbg7+sMtCvEs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-yuVPlQctO8eew0dAzVKEYg-1; Wed, 15 Jan 2020 13:18:12 -0500
X-MC-Unique: yuVPlQctO8eew0dAzVKEYg-1
Received: by mail-wr1-f71.google.com with SMTP id j4so8281865wrs.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 10:18:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T1l2IaCJc8x3A4Xb+p+1AqY/vTkonHYiWw1rDR8HsKQ=;
        b=Oy6f4emI+UQ6W7ItcNkzoZoKUAt710844HFWB1u23eqijHvonK2OMtUTGjFGXg63AO
         ckvUDQI9yDFUtx2K3zomXzTwGie2rHxY5Czh5j1g/8NRsTABDy5iJj7ZPbLUeu4R0ap6
         SwFdYDj5bWYsBZCKHbhvBxrvSBIOgp8NmyJWXm5cKJsaFcnDgBeXsN8mY71OQHDU4mpL
         HCmJjs6ZX4huuLmidaRoyWQ5hEeDyqLMboHU2O3oHWuq8oARJo0lYBo1aW3Amn4IRIFa
         Ifa0hV0u+JaoHGztuhpzP7bBw8VqOaNd8LCvVCgNUVbLogvSV0H4UDFrUeL3Bn/84tfs
         dfag==
X-Gm-Message-State: APjAAAWOpNIScWzWnDWdbgj4k7XDSGMMklB2oF20mU1ESCQVAi4VfByN
        xYDPoD3ugCokEdm9vv6B8/CIxJJbzNY2ydIvYtlMN5Xoh5u6jiGgWrWwij+f6iIplytAv7aQIII
        z1i8/pILVEPvdtapSRff9hzDZ
X-Received: by 2002:a1c:a382:: with SMTP id m124mr1300982wme.90.1579112291791;
        Wed, 15 Jan 2020 10:18:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqxBVFhQpDtas7p6reCH+kqo20jIbm0fibecd2WNuUARhRD91nkW5xhG2OY4Crq9r+f3v1Rb3g==
X-Received: by 2002:a1c:a382:: with SMTP id m124mr1300961wme.90.1579112291587;
        Wed, 15 Jan 2020 10:18:11 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:436:e17d:1fd9:d92a? ([2001:b07:6468:f312:436:e17d:1fd9:d92a])
        by smtp.gmail.com with ESMTPSA id u18sm25235793wrt.26.2020.01.15.10.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 10:18:10 -0800 (PST)
Subject: Re: [PATCH v2] KVM: nVMX: vmread should not set rflags to specify
 success in case of #PF
To:     linmiaohe <linmiaohe@huawei.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     liran.alon@oracle.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <1577514324-18362-1-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <10e98b1b-773f-5b8b-6e30-84b167944d12@redhat.com>
Date:   Wed, 15 Jan 2020 19:18:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1577514324-18362-1-git-send-email-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/12/19 07:25, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> In case writing to vmread destination operand result in a #PF, vmread
> should not call nested_vmx_succeed() to set rflags to specify success.
> Similar to as done in VMPTRST (See handle_vmptrst()).
> 
> Reviewed-by: Liran Alon <liran.alon@oracle.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
> v2:
> 	rephrase commit title & message
> ---
>  arch/x86/kvm/vmx/nested.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 8edefdc9c0cb..c1ec9f25a417 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -4799,8 +4799,10 @@ static int handle_vmread(struct kvm_vcpu *vcpu)
>  					instr_info, true, len, &gva))
>  			return 1;
>  		/* _system ok, nested_vmx_check_permission has verified cpl=0 */
> -		if (kvm_write_guest_virt_system(vcpu, gva, &value, len, &e))
> +		if (kvm_write_guest_virt_system(vcpu, gva, &value, len, &e)) {
>  			kvm_inject_page_fault(vcpu, &e);
> +			return 1;
> +		}
>  	}
>  
>  	return nested_vmx_succeed(vcpu);
> 

Queued, thanks.

Paolo

