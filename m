Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976D2C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 10:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633472087E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 10:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4zl/ptj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgDJKWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 06:22:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33095 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725913AbgDJKWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 06:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586514133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=myq4A86h+72R4CEen1ctYlXgwxnk1bi4qAeKXQag11M=;
        b=C4zl/ptjxIAW0GTb57CxJCq/BdR5dJrBlrO06k23Wirm+J7VEDE2KmF31hH/ebGdy61t9E
        gJzxqQ+xbxJyGXUS1hL1m2tJaLslyuXWpmQL2oHZK1WORWzS4/p5AlqYsICdIXiP7rSX7Z
        Vkwv2jykzw4Fnqm8IsLKaaSBz8IZD7A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-8SVEAZ9mPwClfD-6BAyAXQ-1; Fri, 10 Apr 2020 06:22:11 -0400
X-MC-Unique: 8SVEAZ9mPwClfD-6BAyAXQ-1
Received: by mail-wr1-f71.google.com with SMTP id k13so910806wrn.15
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 03:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=myq4A86h+72R4CEen1ctYlXgwxnk1bi4qAeKXQag11M=;
        b=LeGrEXcleaGgs7ERpAMqiMQ14wY1WlHfONuc5m+YyIKQc/7wv3sAUFH3SEqp/fdhmj
         /PDn0nppt5G9sCSQs35Y9uopO7oC+0+zrtSL92+DiaTKqGUg1x9V5zZ5zcvKDi0gbrET
         bL2i6APZhHmO49nAb0og78Ab44dvdPMVJZRkX/Pmal0i0I4IUVUrDqyni1u3RK/Xhlux
         PxF0WS41rWh0OPqFqP1QdJt0USJKRcs+qCgGmI+0m0DKbBmOnreNuajpDfkhGB8Du2vM
         6lMN6Atazgs7kHXcPdnZvvTpSM2eIFLA1Mnt6JgvGPHWPqr98YiQYd0vTybrLMSmlB/X
         edKQ==
X-Gm-Message-State: AGi0PuYAxeWjtCjAWVHA16fW3AeuoaM4MmpFy6qnocCtYDA3UEfMYYIN
        8j9Vu04U/88xje40HeM3leLXbl8wkcA3m9jydj1v6KA11MBRGL6yQYf+eAJW3E9cHJdef66eqrJ
        UwMSz26wwInztj1Ut+qIAkG6q
X-Received: by 2002:a5d:53ca:: with SMTP id a10mr3542876wrw.388.1586514130020;
        Fri, 10 Apr 2020 03:22:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypJnXEjma3SKgBTV5y3pd6mdJeWcBhmmfkn0ZTkl5TBS8W40HyiVAny9dCityJ0DdFx1CQ8z+g==
X-Received: by 2002:a5d:53ca:: with SMTP id a10mr3541020wrw.388.1586514099906;
        Fri, 10 Apr 2020 03:21:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e8a3:73c:c711:b995? ([2001:b07:6468:f312:e8a3:73c:c711:b995])
        by smtp.gmail.com with ESMTPSA id b199sm2443439wme.23.2020.04.10.03.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 03:21:39 -0700 (PDT)
Subject: Re: [PATCH 2/3] x86/split_lock: Refactor and export
 handle_user_split_lock() for KVM
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     x86@kernel.org, "Kenneth R . Crudup" <kenny@panix.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200402124205.334622628@linutronix.de>
 <20200402155554.27705-1-sean.j.christopherson@intel.com>
 <20200402155554.27705-3-sean.j.christopherson@intel.com>
 <87v9mhn7nf.fsf@nanos.tec.linutronix.de>
 <20200402171946.GH13879@linux.intel.com>
 <87mu7tn1w8.fsf@nanos.tec.linutronix.de>
 <716f5824-8d47-24cc-4935-c2dd32ed4629@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <283c549a-423f-a85e-c208-8a80d682ef77@redhat.com>
Date:   Fri, 10 Apr 2020 12:21:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <716f5824-8d47-24cc-4935-c2dd32ed4629@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/20 06:39, Xiaoyao Li wrote:
> 
>   +static bool guest_handles_ac(struct kvm_vcpu *vcpu)
> +{
> +    /*
> +     * If guest has alignment checking enabled in CR0 and activated in
> +     * eflags, then the #AC originated from CPL3 and the guest is able
> +     * to handle it. It does not matter whether this is a regular or
> +     * a split lock operation induced #AC.
> +     */
> +    if (vmx_get_cpl(vcpu) == 3 && kvm_read_cr0_bits(vcpu, X86_CR0_AM) &&
> +        kvm_get_rflags(vcpu) & X86_EFLAGS_AC)
> +        return true;
> +
> +    /* Add guest SLD handling checks here once it's supported */
> +    return false;
> +}
> +
>   static int handle_exception_nmi(struct kvm_vcpu *vcpu)
>   {
>       struct vcpu_vmx *vmx = to_vmx(vcpu);
> @@ -4630,6 +4647,7 @@ static int handle_exception_nmi(struct k
>       u32 intr_info, ex_no, error_code;
>       unsigned long cr2, rip, dr6;
>       u32 vect_info;
> +    int err;
>         vect_info = vmx->idt_vectoring_info;
>       intr_info = vmx->exit_intr_info;
> @@ -4688,9 +4706,6 @@ static int handle_exception_nmi(struct k
>           return handle_rmode_exception(vcpu, ex_no, error_code);
>         switch (ex_no) {
> -    case AC_VECTOR:
> -        kvm_queue_exception_e(vcpu, AC_VECTOR, error_code);
> -        return 1;
>       case DB_VECTOR:
>           dr6 = vmcs_readl(EXIT_QUALIFICATION);
>           if (!(vcpu->guest_debug &
> @@ -4719,6 +4734,29 @@ static int handle_exception_nmi(struct k
>           kvm_run->debug.arch.pc = vmcs_readl(GUEST_CS_BASE) + rip;
>           kvm_run->debug.arch.exception = ex_no;
>           break;
> +    case AC_VECTOR:
> +        if (guest_handles_ac(vcpu)) {
> +            kvm_queue_exception_e(vcpu, AC_VECTOR, error_code);
> +            return 1;
> +        }
> +        /*
> +         * Handle #AC caused by split lock detection. If the host
> +         * mode is sld_warn, then it warns, marks current with
> +         * TIF_SLD and disables split lock detection. So the guest
> +         * can just continue.
> +         *
> +         * If the host mode is fatal, the handling code warned. Let
> +         * qemu kill itself.
> +         *
> +         * If the host mode is off, then this #AC is bonkers and
> +         * something is badly wrong. Let it fail as well.
> +         */
> +        err = handle_ac_split_lock(kvm_rip_read(vcpu));
> +        if (!err)
> +            return 1;
> +        /* Propagate the error type to user space */
> +        error_code = err == -EFAULT ? 0x100 : 0x200;
> +        fallthrough;


Acked-by: Paolo Bonzini <pbonzini@redhat.com>

