Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB6DC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A882073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JE/hK63h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgAUMRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 07:17:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50114 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729459AbgAUMRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579609053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=++aOhMKuJnCXz0lh4xlX2vreaMatcfxy2SRwFiY0O7M=;
        b=JE/hK63hum/v7nJGsONjVCH0C5u0lGAFyhZYRH7RoAlCPsSs3PcPbH7JidqZQFmYQON+N1
        VuTqlmyZQHSL/5AfxHJv0plyRjDA7LIVXBRoT4g/OYCMQXJpj/059lBbJhWyIJzIUg6VUt
        yEH3AWtmN0k7jVpnK4WIP1mZwN54zmM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-KKbzqII0MdWn6GDeo2mRYA-1; Tue, 21 Jan 2020 07:17:31 -0500
X-MC-Unique: KKbzqII0MdWn6GDeo2mRYA-1
Received: by mail-wr1-f70.google.com with SMTP id v17so1216397wrm.17
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 04:17:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=++aOhMKuJnCXz0lh4xlX2vreaMatcfxy2SRwFiY0O7M=;
        b=s8tbLuaakIdpiX1yMO9dA6XG24mvzcwL9upwyCNPPOm54pKSeOYRG7dHd2vKuR6oGJ
         KULPY896Co2l+kEhd8YhcNuesNpy8wgZBXSf5tcZlkeXmsRAAtKyTw9jMq0/1+ZF46uV
         GOwLtBsRoUYfdtP9U2MiCpc8NyYzlzw4L2PDR7UFkh/IK+v3Iqbpz00QzFEPzTci/HLc
         +YrWG4H+2vIxII00DTSAXWxzX6ZFJsCgup4H4OyumWYZza5hx9rfU/NmrykGcJ5lWVdn
         HXS/6gdNliPb4kJ7lpPFVYJV4pFR2JQRsqX9KtmwSQJusyzUDde+s7RO/va3c3bR0Ou6
         BTiQ==
X-Gm-Message-State: APjAAAVlUuN9CWqKYFxZFdBWGKnHf9HxlHMZeUn32ZqtKZ0WiONLcam9
        aK0+8H3Rysu4IGqe9C+8OU60H7MwBOEtXNg1K10dmKw+tenaULSBCzCv1thZ8Ujqm0udNPXHFUH
        ro28FvTG/1scOJs71CqDG8BeK
X-Received: by 2002:a1c:7d8b:: with SMTP id y133mr4172641wmc.165.1579609050523;
        Tue, 21 Jan 2020 04:17:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqwh3izfydfXQQHoAxmjudVBVICUhx93cIF7FIn9lfmUPgTUiP3yymysVQ/I9JAl5sJ9yJ4zlw==
X-Received: by 2002:a1c:7d8b:: with SMTP id y133mr4172612wmc.165.1579609050230;
        Tue, 21 Jan 2020 04:17:30 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a? ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
        by smtp.gmail.com with ESMTPSA id f1sm53644157wro.85.2020.01.21.04.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 04:17:29 -0800 (PST)
Subject: Re: [PATCH] KVM: VMX: remove duplicated segment cache clear
To:     Miaohe Lin <linmiaohe@huawei.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20200121151518.27530-1-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c43b3126-64c8-216c-41e3-14417ced0175@redhat.com>
Date:   Tue, 21 Jan 2020 13:17:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200121151518.27530-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/20 16:15, Miaohe Lin wrote:
> vmx_set_segment() clears segment cache unconditionally, so we should not
> clear it again by calling vmx_segment_cache_clear().
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index b5a0c2e05825..b32236e6b513 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2688,8 +2688,6 @@ static void enter_pmode(struct kvm_vcpu *vcpu)
>  
>  	vmx->rmode.vm86_active = 0;
>  
> -	vmx_segment_cache_clear(vmx);
> -
>  	vmx_set_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_TR], VCPU_SREG_TR);
>  
>  	flags = vmcs_readl(GUEST_RFLAGS);
> 

Queued, thanks.

Paolo

