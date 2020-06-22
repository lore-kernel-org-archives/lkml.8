Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78AAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A15CC2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSdYGrp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbgFVQsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:48:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39197 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729492AbgFVQsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592844483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iOeVX/Nmmhafg16NYOvc8EUfqW7AqnkiAPvBHza8Wys=;
        b=eSdYGrp+eWP0KUjr88ygVT3aDSNbTdKsKEiB2stqOTRpcSKjf57K9mwc15YI4gBlPs/Qqg
        4Rr6N9NtZ18tinpxPphyNy4H88I+87k6DSk6blMz4xEbi+rtaEVeBTHPLeNI1gbN3MBfHc
        5gTHLRDFOAN/UEXVTYSxx75vF7sUgEk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-Fzvk4pWYPoCGQCJxdaQUHw-1; Mon, 22 Jun 2020 12:47:59 -0400
X-MC-Unique: Fzvk4pWYPoCGQCJxdaQUHw-1
Received: by mail-wr1-f72.google.com with SMTP id e7so11213565wrp.14
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iOeVX/Nmmhafg16NYOvc8EUfqW7AqnkiAPvBHza8Wys=;
        b=Yzx7OgE4rrn6t6RbPIz/3vyTV1Wvp8rJ9crfvsIkAm6GSkpk5394qS+yKe0LiDWM3e
         kaSLqBTc7Vp1rE+QX2b4mRfoFlB+39kyTQPI8577TWiPkEiz+i399eJx7iV67jlwKE+w
         fZy9QsWX/XKtiQbGIaOBUNY554+qbHlJ02jY5bFbcAHaseF/BFsu9sTegzw3pZM/vbZ0
         qeXyXu+mnAS1jcLZuzuemfCukUA7BLY0xhUri4+nG8CnvodCNc5vnFEALgEg+FAMcZA+
         ILx676qRUAwo+T6zZxNmhh45fX2Pr8HXh8eWXbVitCh3VwYF75XNT6QJeIJBoT8GvvSf
         r7eQ==
X-Gm-Message-State: AOAM533Trv4amu/RNFb7CE0Xn8egTzLtfL+WDiptx5iwT7hGG5gZyzEQ
        Ki8Zs4c2i5RLZ/uE9S0Os0VrfoammcDF53Vf7n0pkkyd4C2IYwe/ol2NCJtjNwZUSInm0uGFuiX
        yFsyEgyAwC+yRkgvgXX0a/y0L
X-Received: by 2002:a05:600c:d5:: with SMTP id u21mr13001284wmm.156.1592844478703;
        Mon, 22 Jun 2020 09:47:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHLwyIASJ1NU8MCn0vyMb6gJ0n7NqOi3eUC+ZSx8IQnYJvHUsEt91e44yFMyg/Pc1Zq7UIrg==
X-Received: by 2002:a05:600c:d5:: with SMTP id u21mr13001265wmm.156.1592844478401;
        Mon, 22 Jun 2020 09:47:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:fd64:dd90:5ad5:d2e1? ([2001:b07:6468:f312:fd64:dd90:5ad5:d2e1])
        by smtp.gmail.com with ESMTPSA id j14sm18864654wrs.75.2020.06.22.09.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 09:47:57 -0700 (PDT)
Subject: Re: [PATCH] kvm: lapic: fix broken vcpu hotplug
To:     Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     sean.j.christopherson@intel.com, vkuznets@redhat.com,
        kvm@vger.kernel.org, wanpengli@tencent.com
References: <20200622160830.426022-1-imammedo@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c00acf88-0655-686e-3b8c-7aad03791f20@redhat.com>
Date:   Mon, 22 Jun 2020 18:47:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200622160830.426022-1-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/20 18:08, Igor Mammedov wrote:
> Guest fails to online hotplugged CPU with error
>   smpboot: do_boot_cpu failed(-1) to wakeup CPU#4
> 
> It's caused by the fact that kvm_apic_set_state(), which used to call
> recalculate_apic_map() unconditionally and pulled hotplugged CPU into
> apic map, is updating map conditionally [1] on state change which doesn't
> happen in this case and apic map update is skipped.
> 
> Note:
> new CPU during kvm_arch_vcpu_create() is not visible to
> kvm_recalculate_apic_map(), so all related update calls endup
> as NOP and only follow up kvm_apic_set_state() used to trigger map
> update that counted in hotplugged CPU.
> Fix issue by forcing unconditional update from kvm_apic_set_state(),
> like it used to be.
> 
> 1)
> Fixes: (4abaffce4d25a KVM: LAPIC: Recalculate apic map in batch)
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> PS:
> it's alternative to full revert of [1], I've posted earlier
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2205600.html
> so fii free to pick up whatever is better by now
> ---
>  arch/x86/kvm/lapic.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 34a7e0533dad..5696831d4005 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2556,6 +2556,7 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
>  	struct kvm_lapic *apic = vcpu->arch.apic;
>  	int r;
>  
> +	apic->vcpu->kvm->arch.apic_map_dirty = true;
>  	kvm_lapic_set_base(vcpu, vcpu->arch.apic_base);
>  	/* set SPIV separately to get count of SW disabled APICs right */
>  	apic_set_spiv(apic, *((u32 *)(s->regs + APIC_SPIV)));
> 

Queued, but it's better to set apic_map_dirty just before the call to
kvm_recalculate_apic_map, or you can have a variant of the race that you
pointed out.

Paolo

