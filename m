Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBEFC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 135F1206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MiO6kYWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390612AbgDNO0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:26:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60030 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733197AbgDNO0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586874367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uSEGx3gNn1oGf/i6GkkhJSWUv9DBqbvzJo4hv43gN+I=;
        b=MiO6kYWpZd39GQL673Mv2f46lY7jJcd6duW2hrO8ONp1egGrckndauvYXd3L3dC7yzOBhd
        iLPLPLwxmMqqb49mCvwMn6TNcXlZgWScFlR/SfMXeMf/5tiwuxWaRbDO2GpMKMlQr6BiUF
        BAhI1o8KO8ELBCYGgdzRdz9947oPB4U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-V3VjEoAfNESt9GjOWKXzQQ-1; Tue, 14 Apr 2020 10:26:05 -0400
X-MC-Unique: V3VjEoAfNESt9GjOWKXzQQ-1
Received: by mail-wr1-f70.google.com with SMTP id e5so195947wrs.23
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 07:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uSEGx3gNn1oGf/i6GkkhJSWUv9DBqbvzJo4hv43gN+I=;
        b=UzosCiVzqyN5Um88MyAI284f8MqWIxlX0RJFlBtrA2t1uXFP5KUSOVpfsoL0HC06RD
         bnbyq0HU1SOL5rOw1IZF5crosnwWJ5LqFpid1ka2iZGWv8vT3yWS6HuPJ0wOdiLFkVgn
         2qtpnER+6X04urhZ74DsedQbAe6vw85EXcB9jbBODa3U5iLNFUEgDjQPBK5BDZxmgAoK
         JbDX4GtjMj8G/WxkcVbPQp2te4DEhe7AYvRqcqlk8C9ysHDeIi98lMdU5ovqBY5ATNwZ
         GFdRD11DZP8FldkZMvxHJGT5uxowlnoajHrGcGrpUfDAxkgfOhqS/SFHcsRJAQ3viG6Z
         B8qw==
X-Gm-Message-State: AGi0PuacfjsX32lX03wLmnjW4aNagOK7LA8pdu71PyteZMgoK6H1+c5M
        KyfS9Jvi5BJYqnZkdyc5lJzw1xLOQQkjdxGvlGMfbBmuRv8TlhVnC/svyW47P6yRTvMO5XWnR01
        7TtrVO8Yz1HnY8rEwBd80Sf5s
X-Received: by 2002:a1c:4409:: with SMTP id r9mr102716wma.165.1586874363878;
        Tue, 14 Apr 2020 07:26:03 -0700 (PDT)
X-Google-Smtp-Source: APiQypJqgbBq9xhT1LszvRzgjgWUmQyELrXGBlfZ5uFizKdfdTJlTiXTCHR6m1nvQHHbl9Aa0nzYPg==
X-Received: by 2002:a1c:4409:: with SMTP id r9mr102702wma.165.1586874363651;
        Tue, 14 Apr 2020 07:26:03 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id v10sm7145993wrq.45.2020.04.14.07.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 07:26:03 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        tianjia.zhang@linux.alibaba.com, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Subject: Re: [PATCH] KVM: Optimize kvm_arch_vcpu_ioctl_run function
In-Reply-To: <20200413034523.110548-1-tianjia.zhang@linux.alibaba.com>
References: <20200413034523.110548-1-tianjia.zhang@linux.alibaba.com>
Date:   Tue, 14 Apr 2020 16:26:01 +0200
Message-ID: <875ze2ywhy.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tianjia Zhang <tianjia.zhang@linux.alibaba.com> writes:

> kvm_arch_vcpu_ioctl_run() is only called in the file kvm_main.c,
> where vcpu->run is the kvm_run parameter, so it has been replaced.
>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  arch/x86/kvm/x86.c | 8 ++++----
>  virt/kvm/arm/arm.c | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 3bf2ecafd027..70e3f4abbd4d 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8726,18 +8726,18 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>  		r = -EAGAIN;
>  		if (signal_pending(current)) {
>  			r = -EINTR;
> -			vcpu->run->exit_reason = KVM_EXIT_INTR;
> +			kvm_run->exit_reason = KVM_EXIT_INTR;

I have a more generic question: why do we need to pass 'kvm_run' to
kvm_arch_vcpu_ioctl_run() if it can be extracted from 'struct kvm_vcpu'?
The only call site looks like

virt/kvm/kvm_main.c:            r = kvm_arch_vcpu_ioctl_run(vcpu, vcpu->run);

>  			++vcpu->stat.signal_exits;
>  		}
>  		goto out;
>  	}
>  
> -	if (vcpu->run->kvm_valid_regs & ~KVM_SYNC_X86_VALID_FIELDS) {
> +	if (kvm_run->kvm_valid_regs & ~KVM_SYNC_X86_VALID_FIELDS) {
>  		r = -EINVAL;
>  		goto out;
>  	}
>  
> -	if (vcpu->run->kvm_dirty_regs) {
> +	if (kvm_run->kvm_dirty_regs) {
>  		r = sync_regs(vcpu);
>  		if (r != 0)
>  			goto out;
> @@ -8767,7 +8767,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>  
>  out:
>  	kvm_put_guest_fpu(vcpu);
> -	if (vcpu->run->kvm_valid_regs)
> +	if (kvm_run->kvm_valid_regs)
>  		store_regs(vcpu);
>  	post_kvm_run_save(vcpu);
>  	kvm_sigset_deactivate(vcpu);
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 48d0ec44ad77..ab9d7966a4c8 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -659,7 +659,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  		return ret;
>  
>  	if (run->exit_reason == KVM_EXIT_MMIO) {
> -		ret = kvm_handle_mmio_return(vcpu, vcpu->run);
> +		ret = kvm_handle_mmio_return(vcpu, run);
>  		if (ret)
>  			return ret;
>  	}

-- 
Vitaly

