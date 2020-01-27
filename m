Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A33CC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 08:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D3421569
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 08:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIwQFKqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgA0I4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 03:56:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42426 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726769AbgA0I4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 03:56:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580115393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9tIpoiGmCkuvevXLPoa3fIc79sIzbVYkocp+dAFtMA4=;
        b=aIwQFKqzTGeuQb7sPVe9E7oRdkvkF9pN+9rKLtAu5oKgYO2cKpDlPayKGlezWCrlmUuVnO
        7xRsqNbkcxlNIuznnsx0n1T0phYLoPOB2CqRj/P+ke1Ybr2ioJ4bCyYIWsudvlzO5sqt6V
        M5v3qCZmCt5PNN35ukdtSAaVkGi2Fbk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-SW6rgk7UNeCMCkiHFWeW_A-1; Mon, 27 Jan 2020 03:56:26 -0500
X-MC-Unique: SW6rgk7UNeCMCkiHFWeW_A-1
Received: by mail-wm1-f72.google.com with SMTP id p2so1237176wma.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 00:56:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9tIpoiGmCkuvevXLPoa3fIc79sIzbVYkocp+dAFtMA4=;
        b=T9PChhvXcJrRr3wskrIWWboZ9EajCrofMUlrE2Tr7i0yL0InewN9ltCb8yilXh6LtM
         /nhrR+EiNjmfTN355A58XTQu8V6Uet4/qtsyBFrCHg3c/DH8B8l2W/VpeRqQbeOw4spC
         WdlymvTakAaMOydkTETpTHsUQL5NTyJ3/2P4YqYjE0dBYeNBXsqorhGy5xNLXWfM8RfY
         yLv5kUK/W2sbl+gbeRKiaNd0KDheOygh4fAaHmD4nw/GPAVfm2TuxZx+2785gONFqod7
         Vs3ZVlbaWiP3vxJdQaXIphFF/mIit9zD2DqVYx6VMV7gAgEeAThub+0a31lQUbID9l5r
         Avzw==
X-Gm-Message-State: APjAAAV5st8Aazbv1JBcugippHuurjsw86II9nfb9E5Qyu2lnzAR/JcW
        xsVmgWjvnoSnHklRUxZqZckBiqKpGudWgqdYs0w5T76e6BJM982M2uJiZqmqGCm7ztYVRsc6/PS
        QfYlO8yqMBV4p87ei86RY4Nky
X-Received: by 2002:adf:fa43:: with SMTP id y3mr20078535wrr.65.1580115385279;
        Mon, 27 Jan 2020 00:56:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqwfWD3Za+5pEhMEVE+56LYHlHrEfSASb+WVAzjII+6SiMZWRYf0Md6ZspcLfH9Q2OmwQN3gXA==
X-Received: by 2002:adf:fa43:: with SMTP id y3mr20078506wrr.65.1580115384981;
        Mon, 27 Jan 2020 00:56:24 -0800 (PST)
Received: from vitty.brq.redhat.com ([195.39.4.224])
        by smtp.gmail.com with ESMTPSA id d23sm19860017wra.30.2020.01.27.00.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 00:56:24 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Nick Desaulniers <nick.desaulniers@gmail.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, pbonzini@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Subject: Re: [PATCH] dynamically allocate struct cpumask
In-Reply-To: <20200127071602.11460-1-nick.desaulniers@gmail.com>
References: <20200127071602.11460-1-nick.desaulniers@gmail.com>
Date:   Mon, 27 Jan 2020 09:56:26 +0100
Message-ID: <871rrlnupx.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Desaulniers <nick.desaulniers@gmail.com> writes:

> This helps avoid avoid a potentially large stack allocation.
>
> When building with:
> $ make CC=clang arch/x86/ CFLAGS=-Wframe-larger-than=1000
> The following warning is observed:
> arch/x86/kernel/kvm.c:494:13: warning: stack frame size of 1064 bytes in
> function 'kvm_send_ipi_mask_allbutself' [-Wframe-larger-than=]
> static void kvm_send_ipi_mask_allbutself(const struct cpumask *mask, int
> vector)
>             ^
> Debugging with:
> https://github.com/ClangBuiltLinux/frame-larger-than
> via:
> $ python3 frame_larger_than.py arch/x86/kernel/kvm.o \
>   kvm_send_ipi_mask_allbutself
> points to the stack allocated `struct cpumask newmask` in
> `kvm_send_ipi_mask_allbutself`. The size of a `struct cpumask` is
> potentially large, as it's CONFIG_NR_CPUS divided by BITS_PER_LONG for
> the target architecture. CONFIG_NR_CPUS for X86_64 can be as high as
> 8192, making a single instance of a `struct cpumask` 1024 B.
>
> Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> ---
>  arch/x86/kernel/kvm.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 32ef1ee733b7..d41c0a0d62a2 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -494,13 +494,15 @@ static void kvm_send_ipi_mask(const struct cpumask *mask, int vector)
>  static void kvm_send_ipi_mask_allbutself(const struct cpumask *mask, int vector)
>  {
>  	unsigned int this_cpu = smp_processor_id();
> -	struct cpumask new_mask;
> +	struct cpumask *new_mask;
>  	const struct cpumask *local_mask;
>  
> -	cpumask_copy(&new_mask, mask);
> -	cpumask_clear_cpu(this_cpu, &new_mask);
> -	local_mask = &new_mask;
> +	new_mask = kmalloc(sizeof(*new_mask), GFP_KERNEL);

You could've used alloc_cpumask_var() instead, however, I think that
memory allocation on this path is undesireable. We can always
pre-allocate 1 cpumask variable per cpu and use it every time, e.g. we
do this for Hyper-V.

> +	cpumask_copy(new_mask, mask);
> +	cpumask_clear_cpu(this_cpu, new_mask);
> +	local_mask = new_mask;
>  	__send_ipi_mask(local_mask, vector);
> +	kfree(new_mask);
>  }
>  
>  /*

-- 
Vitaly

