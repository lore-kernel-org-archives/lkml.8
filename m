Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551B9C33CB6
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 21:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2902524683
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 21:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddAmTOPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgARV1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 16:27:03 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46254 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726957AbgARV1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 16:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579382821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8SoUZ6kA7er6ACVnsGobCaUYtb3x9ncX9KA1N8TyDd4=;
        b=ddAmTOPceqt1ldzgV3G1BOJKoD+Wv89uHqQDCPGWnadwCV6yk/59wEnoDmqZhG0bR1Ny6z
        DTigJOCEJKhwsXQM0TidIdroBIrf4FzQPZn0akzAUPUomzeuWC5MxTl9bHFvdMWkkw7T3x
        haA4WU2frZNudgeCIhTjWXDULnuX4kk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-DFtnpMOpP0yqiKcEQHP6Hw-1; Sat, 18 Jan 2020 16:26:58 -0500
X-MC-Unique: DFtnpMOpP0yqiKcEQHP6Hw-1
Received: by mail-wr1-f72.google.com with SMTP id c17so12053169wrp.10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 13:26:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8SoUZ6kA7er6ACVnsGobCaUYtb3x9ncX9KA1N8TyDd4=;
        b=t4woexb0gggSaosvqOq2yBnpZyOIqlUdYY1kwG8UGrs8AhESCt7O6RDTnvfGi+Lsjx
         b/BuD/9ndllEIoYRbqW+vjB1nY8FQh+9Dsy3QxsYtDG90jCpeuTor7dOmanMHAeo1V+C
         k9OM+bPIml/qqwYLqDW3m5fMmPpGk6HddgO18Ti7IokRR8E1Y+ko2eW8JeuJEgIHgRef
         /WcTW6pFsl3I997rO53kLNbd5Kgns/6Tk4bdte70Y9+fycmYCtCQYYfuQf7Hne7i0CBo
         d0LnxKzcfoZSZNlMu4Bo716Tpbijkb0rImmYaepIvWCToXo4PX/koOKOuyaIz4oUSXee
         d/SA==
X-Gm-Message-State: APjAAAVeol3dUs+KJbP0wupkD43fFnJfmOoL09LxVvO3O3E5lCBU3B+b
        gmycvDA7kZus8tcpArZtdhhaPuSoP0bF8DzoGCB0PGWdp64fB/Vm72+N7IlYmQbET1op1yGjpyG
        pyvpsHN8CFrOoZQW3W/ijS4v6
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr9782324wro.375.1579382816990;
        Sat, 18 Jan 2020 13:26:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqzKbULLGgSbmncb6Oa5ppPsxM+7ljn9oiaQFYP3SIq9dnDvmwsvpMGT53d5nrj7vu0BV4hrNw==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr9782315wro.375.1579382816773;
        Sat, 18 Jan 2020 13:26:56 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e0d6:d2cd:810b:30a9? ([2001:b07:6468:f312:e0d6:d2cd:810b:30a9])
        by smtp.gmail.com with ESMTPSA id i8sm41644376wro.47.2020.01.18.13.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2020 13:26:55 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: avoid clearing pending exception event twice
To:     linmiaohe <linmiaohe@huawei.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <1579315315-6444-1-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <58e9932a-99e7-33c3-d615-ee5f2ad766e8@redhat.com>
Date:   Sat, 18 Jan 2020 22:26:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1579315315-6444-1-git-send-email-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/20 03:41, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> The exception pending event is cleared by kvm_clear_exception_queue(). We
> shouldn't clear it again.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/x86.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 93bbbce67a03..10fa42f627d9 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9180,7 +9180,6 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>  	vcpu->arch.nmi_injected = false;
>  	kvm_clear_interrupt_queue(vcpu);
>  	kvm_clear_exception_queue(vcpu);
> -	vcpu->arch.exception.pending = false;
>  
>  	memset(vcpu->arch.db, 0, sizeof(vcpu->arch.db));
>  	kvm_update_dr0123(vcpu);
> 

Queued, thanks.

Paolo

