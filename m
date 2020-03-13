Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7890C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD8720746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUo+S5oo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgCMMOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:14:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41772 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726550AbgCMMOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584101684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hqgOELx5Eh0w6B52bJXObYBgYmHtgSglsBGhlheS4bg=;
        b=MUo+S5oosy00fU0CFX6MRyo5u61KNcV1ZOr085zIuZAKn+IV56TpLWQ1Po4hYe6Gz+YPBt
        5ZItDAJLF0W1x7LNHBe1Sv17GxqOai67H6O3O1HKiY2B7XfonPcNVuW+AZXK73UIDd7t1w
        pindxoPN3WAS7nNfs8MYaWwZUagGpE8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-PASS1uZgOZi8fz-DwxNeiw-1; Fri, 13 Mar 2020 08:14:42 -0400
X-MC-Unique: PASS1uZgOZi8fz-DwxNeiw-1
Received: by mail-wr1-f71.google.com with SMTP id p2so1651068wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 05:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hqgOELx5Eh0w6B52bJXObYBgYmHtgSglsBGhlheS4bg=;
        b=m+Zng1aEEKnOnKLQDKG8IPqA+dJfpwQSkIsE5UdPyfv/JbU50lBjYVZu3a7P5RMvCE
         wKUzQzz32Y0sS6xXPWKJvLvBi6Ysly+bUCKxfeULH811WJgbVI7mga9BbICiAwXXpFiZ
         9Xc8kkEywnLY1Zb+RPsFk2lze2sCpqqNlvYp3Vanlde7aNANfQcvf36pLHmeLqCQgDVM
         Fb7lIcB7Eye/Kb2NTLjMk5VYu3X7XZAw8UqH7GqjG8Q8l6Cb0CmyWLfN5lkcD0kzGjI9
         btKL0sBg0Wkb3uf9PEfgY8e/2yYD4XY0/wIXrTLKjCfyiT3EECyEwhbNpVm/jfQ22ent
         Hvnw==
X-Gm-Message-State: ANhLgQ1QZvaIFEttblWrwCAzjmsN/N5e2EhWbW8oUGkksvQUTwFeZOX5
        EV/RoBEovEbtKz6Kgpna4uocEaMkoxyl6WzGI15dy6RqEtmx8HD+oiWNDxZWbSAiWRXUjUa85wP
        xlp4c5nPSb/PehwH4OPVHN+9y
X-Received: by 2002:a05:600c:20c9:: with SMTP id y9mr11209436wmm.83.1584101681172;
        Fri, 13 Mar 2020 05:14:41 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvjCNKxnvFmlZOYRIS69ZrrfDY8J2ZBKXrNdmq2sDPmSgUuGhwVfudb9nPw33+JXSmrftWkLQ==
X-Received: by 2002:a05:600c:20c9:: with SMTP id y9mr11209402wmm.83.1584101680892;
        Fri, 13 Mar 2020 05:14:40 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id l5sm16033461wml.3.2020.03.13.05.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 05:14:40 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH 02/10] KVM: nVMX: Drop a superfluous WARN on reflecting EXTERNAL_INTERRUPT
In-Reply-To: <20200312184521.24579-3-sean.j.christopherson@intel.com>
References: <20200312184521.24579-1-sean.j.christopherson@intel.com> <20200312184521.24579-3-sean.j.christopherson@intel.com>
Date:   Fri, 13 Mar 2020 13:14:39 +0100
Message-ID: <87h7yspi34.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Drop the WARN in nested_vmx_reflect_vmexit() that fires if KVM attempts
> to reflect an external interrupt.  nested_vmx_exit_reflected() is now
> called from nested_vmx_reflect_vmexit() and unconditionally returns
> false for EXTERNAL_INTERRUPT, i.e. barring a compiler or major CPU bug,
> the WARN will never fire.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/nested.h | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
> index 6bc379cf4755..8f5ff3e259c9 100644
> --- a/arch/x86/kvm/vmx/nested.h
> +++ b/arch/x86/kvm/vmx/nested.h
> @@ -84,12 +84,11 @@ static inline bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu,
>  		return false;
>  
>  	/*
> -	 * At this point, the exit interruption info in exit_intr_info
> -	 * is only valid for EXCEPTION_NMI exits.  For EXTERNAL_INTERRUPT
> -	 * we need to query the in-kernel LAPIC.
> +	 * vmcs.VM_EXIT_INTR_INFO is only valid for EXCEPTION_NMI exits.  For
> +	 * EXTERNAL_INTERRUPT, the value for vmcs12->vm_exit_intr_info would
> +	 * need to be synthesized by querying the in-kernel LAPIC, but external
> +	 * interrupts are never reflected to L1 so it's a non-issue.
>  	 */
> -	WARN_ON(exit_reason == EXIT_REASON_EXTERNAL_INTERRUPT);
> -
>  	exit_intr_info = vmcs_read32(VM_EXIT_INTR_INFO);
>  	if ((exit_intr_info &
>  	     (INTR_INFO_VALID_MASK | INTR_INFO_DELIVER_CODE_MASK)) ==

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

