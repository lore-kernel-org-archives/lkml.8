Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53401C55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 08:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2519B206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 08:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P23NUkhK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDYIHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 04:07:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54605 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726035AbgDYIHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 04:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587802058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pvUeVwhxbFNu8fxCD76T9F++Vo/CGAqd9wlUHbwgwQs=;
        b=P23NUkhKfL+FBgpngeseRNh6WLsacVdYsSdxFFWiSVPioyq6s7VS7dOssSKyxCOVYZLuN5
        vIIfiPEk/4GDjcP9n+Wji0amyZUUtMrBKuE0jzZ2L4qnkymN6ELm3+c4zQXWQkwv6mzytY
        8fNlOO8QYRMJ65cjxQnrl6v9IFjGLdE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-iptoTfrYMPWbUN4o17V63Q-1; Sat, 25 Apr 2020 04:07:36 -0400
X-MC-Unique: iptoTfrYMPWbUN4o17V63Q-1
Received: by mail-wr1-f72.google.com with SMTP id y10so6357255wrn.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 01:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pvUeVwhxbFNu8fxCD76T9F++Vo/CGAqd9wlUHbwgwQs=;
        b=O7tgQ55+EwXDsfd+3b1dFZ3izLGms92HQQkHerTzjGjOytNDjmGBC2N/fOIbFwXZRw
         +5ei2ZnR3ym5tCTr6/qiXpNxFXc3F5nb+XLi8iUw6w2EBoMrFkMC0WPI1OOx5jkhpCs4
         aSbeyHLsSD3TMHWAfy7qOZXZaPuZRzTmj9MzR3uZtskevbBG/JqEIxUUXeZruE/yfT4O
         tTXMyfD9LlKgL7iGigl+8oYnOjWYl4Fg5W7CWW0DMzvPkbj6nmUOys1orq5jwKgVnVLZ
         S4IbmSbCYYUXTyfp3WwjX0gdIeYiXu3SHRaUnXHAyLW2ZWE63lrmja1HMLCFANahUIzc
         DLNQ==
X-Gm-Message-State: AGi0PuZX76dcsw2M1aTpmZ7v0TC0l9+rO9HvP4b7urPl6oZJoB8vSwyt
        ZD3O8r9xxLhSvuWY8pFPmKcKYFocjnF2wXGlu8CmnX/34VhnFWfJ6CHnmWNZu5jIz5D5GJbqStS
        PjFKpy6FWUj2UCfGBTPooxa6Z
X-Received: by 2002:a5d:42c7:: with SMTP id t7mr15617036wrr.336.1587802054951;
        Sat, 25 Apr 2020 01:07:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypKrwadT37ORpuSWqL7KFA7Vn4EEv0pM8gAAHxk81t93H9Ty3/mW93rUSVcRT1/mVnWRP1JZWg==
X-Received: by 2002:a5d:42c7:: with SMTP id t7mr15617013wrr.336.1587802054737;
        Sat, 25 Apr 2020 01:07:34 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id c190sm6289379wme.4.2020.04.25.01.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 01:07:34 -0700 (PDT)
Subject: Re: [RFC PATCH 1/3] kvm: x86: Rename KVM_DEBUGREG_RELOAD to
 KVM_DEBUGREG_NEED_RELOAD
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org
Cc:     Nadav Amit <namit@cs.technion.ac.il>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20200416101509.73526-1-xiaoyao.li@intel.com>
 <20200416101509.73526-2-xiaoyao.li@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <85cb5946-2109-28a0-578d-bed31d1b8298@redhat.com>
Date:   Sat, 25 Apr 2020 10:07:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200416101509.73526-2-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/20 12:15, Xiaoyao Li wrote:
> To make it more clear that the flag means DRn (except DR7) need to be
> reloaded before vm entry.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>

I wonder if KVM_DEBUGREG_RELOAD is needed at all.  It should be easy to
write selftests for it, using the testcase in commit message
172b2386ed16 and the information in commit ae561edeb421.

Paolo

> ---
>  arch/x86/include/asm/kvm_host.h | 2 +-
>  arch/x86/kvm/x86.c              | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index c7da23aed79a..f465c76e6e5a 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -511,7 +511,7 @@ struct kvm_pmu_ops;
>  enum {
>  	KVM_DEBUGREG_BP_ENABLED = 1,
>  	KVM_DEBUGREG_WONT_EXIT = 2,
> -	KVM_DEBUGREG_RELOAD = 4,
> +	KVM_DEBUGREG_NEED_RELOAD = 4,
>  };
>  
>  struct kvm_mtrr_range {
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index de77bc9bd0d7..cce926658d10 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1067,7 +1067,7 @@ static void kvm_update_dr0123(struct kvm_vcpu *vcpu)
>  	if (!(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP)) {
>  		for (i = 0; i < KVM_NR_DB_REGS; i++)
>  			vcpu->arch.eff_db[i] = vcpu->arch.db[i];
> -		vcpu->arch.switch_db_regs |= KVM_DEBUGREG_RELOAD;
> +		vcpu->arch.switch_db_regs |= KVM_DEBUGREG_NEED_RELOAD;
>  	}
>  }
>  
> @@ -8407,7 +8407,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  		set_debugreg(vcpu->arch.eff_db[2], 2);
>  		set_debugreg(vcpu->arch.eff_db[3], 3);
>  		set_debugreg(vcpu->arch.dr6, 6);
> -		vcpu->arch.switch_db_regs &= ~KVM_DEBUGREG_RELOAD;
> +		vcpu->arch.switch_db_regs &= ~KVM_DEBUGREG_NEED_RELOAD;
>  	}
>  
>  	kvm_x86_ops.run(vcpu);
> @@ -8424,7 +8424,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  		kvm_update_dr0123(vcpu);
>  		kvm_update_dr6(vcpu);
>  		kvm_update_dr7(vcpu);
> -		vcpu->arch.switch_db_regs &= ~KVM_DEBUGREG_RELOAD;
> +		vcpu->arch.switch_db_regs &= ~KVM_DEBUGREG_NEED_RELOAD;
>  	}
>  
>  	/*
> 

