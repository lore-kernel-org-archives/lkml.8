Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F21C4BA1E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03DE206E6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RkQwD2LO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgBZRwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:52:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60727 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726875AbgBZRwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:52:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582739540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/RdTTd6K7JTQ5wyPAoL2rrTSkPB95hn/2+5eY5OdPYc=;
        b=RkQwD2LOzU1y04hsk4VAcm6mirrRmGYwAjxHuVBQ9T+0Gq6ogJqIN9vI4j3ceCIxjJ7cUz
        CWmq2TB98fWuEHpNIZQCic7RKTrj0rfJmoZQ7Dswwjag23RKwEK7WjDmRSJMKMIs7C4QdJ
        L5yKW9CYeN3uEyse5jwVo5BBZpPaX3M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-hD6jUvHVOxC7heMWwO5T4g-1; Wed, 26 Feb 2020 12:52:18 -0500
X-MC-Unique: hD6jUvHVOxC7heMWwO5T4g-1
Received: by mail-wr1-f71.google.com with SMTP id d9so73237wrv.21
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 09:52:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/RdTTd6K7JTQ5wyPAoL2rrTSkPB95hn/2+5eY5OdPYc=;
        b=ASgU3cOyTW16iM07PdO72de9jgC2FpAs8GiWRcvM4AGiL6cuJkyklvT44gq1U9FNIM
         ksLy1euxhgV8SysrUDVKxnGmKErubukfiUjuLvgR0JjAO8oRcuxyLilC2n6PffaOSPWz
         BED3Y5x9mmvmtdCd71kPrnVygZh9Z/vEkZKyiOshZ6mnGHinSuDZUnCSf9YPMnq+rdjY
         MeeuuYFjA9G7Du8K/MX5n85U2UOFOUkXjPkJLn9QjotLEG9EBnSZ1wmAGLU4RKY8I+NO
         slQ8Xn2YjNHyG4PuR6GI8WbuHSek+NH+WRrJheG3/GShLHx7KfIpsgPgbalmPqsBwXIo
         eUqg==
X-Gm-Message-State: APjAAAV3KvHNRE7ghYJAYaD/54QYGPlsfI5pVLPTd5k46pzSyriGU5dK
        Od48mTXqtswzyMemGVjAjPy3Jsd+ZFTYcusvDXZ8asVQj8vYFcdu3Zsepafu4WyVqbHjWv1sgRn
        Q4GOKJRcXetWF17WFz6Kvkr+b
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr36877wmi.51.1582739537226;
        Wed, 26 Feb 2020 09:52:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqz8ppifS6KUqwVMO25OvROjuof04E1Nq3/ZOCz+8OkVlU7zGHWWPvWAptHeVlGwliFuK37uyQ==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr36795wmi.51.1582739536070;
        Wed, 26 Feb 2020 09:52:16 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h3sm4383322wrb.23.2020.02.26.09.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 09:52:15 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/13] KVM: x86: Add helper to "handle" internal emulation error
In-Reply-To: <20200218232953.5724-12-sean.j.christopherson@intel.com>
References: <20200218232953.5724-1-sean.j.christopherson@intel.com> <20200218232953.5724-12-sean.j.christopherson@intel.com>
Date:   Wed, 26 Feb 2020 18:52:14 +0100
Message-ID: <87o8tli6cx.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Add a helper to set the appropriate error codes in vcpu->run when
> emulation fails (future patches will add additional failure scenarios).
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/x86.c | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index e1eaca65756b..7bffdc6f9e1b 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6491,6 +6491,14 @@ void kvm_inject_realmode_interrupt(struct kvm_vcpu *vcpu, int irq, int inc_eip)
>  }
>  EXPORT_SYMBOL_GPL(kvm_inject_realmode_interrupt);
>  
> +static int internal_emulation_error(struct kvm_vcpu *vcpu)
> +{
> +	vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
> +	vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
> +	vcpu->run->internal.ndata = 0;
> +	return 0;
> +}
> +
>  static int handle_emulation_failure(struct x86_emulate_ctxt *ctxt,
>  				    int emulation_type)
>  {
> @@ -6504,21 +6512,13 @@ static int handle_emulation_failure(struct x86_emulate_ctxt *ctxt,
>  		return 1;
>  	}
>  
> -	if (emulation_type & EMULTYPE_SKIP) {
> -		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
> -		vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
> -		vcpu->run->internal.ndata = 0;
> -		return 0;
> -	}
> +	if (emulation_type & EMULTYPE_SKIP)
> +		return internal_emulation_error(vcpu);
>  
>  	kvm_queue_exception(vcpu, UD_VECTOR);
>  
> -	if (!is_guest_mode(vcpu) && kvm_x86_ops->get_cpl(vcpu) == 0) {
> -		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
> -		vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
> -		vcpu->run->internal.ndata = 0;
> -		return 0;
> -	}
> +	if (!is_guest_mode(vcpu) && kvm_x86_ops->get_cpl(vcpu) == 0)
> +		return internal_emulation_error(vcpu);
>  
>  	return 1;
>  }
> @@ -8986,12 +8986,8 @@ int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
>  
>  	ret = emulator_task_switch(ctxt, tss_selector, idt_index, reason,
>  				   has_error_code, error_code);
> -	if (ret) {
> -		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
> -		vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
> -		vcpu->run->internal.ndata = 0;
> -		return 0;
> -	}
> +	if (ret)
> +		return internal_emulation_error(vcpu);
>  
>  	kvm_rip_write(vcpu, ctxt->eip);
>  	kvm_set_rflags(vcpu, ctxt->eflags);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

