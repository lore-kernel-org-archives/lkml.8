Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15B6C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB47420719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdAVkdZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgDGMfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 08:35:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31073 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728447AbgDGMfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 08:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586262923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qj/NCHNTy8cKBQLrOFei5N4fXMJmrkSwVdyGWxnI98o=;
        b=fdAVkdZHggSIqrSDUjpbbS/xXC4yKtpJiWA7z6Qrun7nmRcPo0bSPLI5CKHgUDSgUM56OE
        y4lWiAcbq/V8Cgmo08pRUtyjSpS8YmvyvSbomWYezpcJIXxBbqI0r4fK/Y71r4KzI6BGOG
        H756abaY8HU5QqJ3K+7O9GNiUZcuqAU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-meKj4tUhP_qrewzk8yUyMA-1; Tue, 07 Apr 2020 08:35:21 -0400
X-MC-Unique: meKj4tUhP_qrewzk8yUyMA-1
Received: by mail-wr1-f69.google.com with SMTP id w12so1687895wrl.23
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 05:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qj/NCHNTy8cKBQLrOFei5N4fXMJmrkSwVdyGWxnI98o=;
        b=mVGRqWG7eWo7RuybDMhPu/m6zUNdMkjaAAjWs0PCPJmdcMZFlK9PfwiRMDMxYUAEPI
         ONAue5LU0BucpaiOrtHPWXF/ouQgKraNb7E8Xzjhzd7zozHfYsVyy/aIG3qQyOIPiSOs
         kpk6+9F2/Ez9XjjX3fl2m4IG7Pkx6LkjVUW2z86ZQlOBHolzMh8Sk+gszUxM5GEG7GQG
         zE36jTdU99Xa4bFVkk4kKtQUFR79I5A5PaxfS5ura84Yu/BtOv2OxgtedNfoZmdfnIKy
         /eaDBJ8yZxJUK5Ue1GPCba2Ji4gHnMjEDHWghijO1QapQI4t/vw3K8zXAiZsh0hft4/0
         XYdQ==
X-Gm-Message-State: AGi0PubAsRi7xA4ltlu4217Fv++DHw4NhM9mghMSR6lcOUrWmYNMDTP2
        HL224egDhv1HeJB0h68deIU5gOdP3ge5AiyxeKY9ZIy1y9i83Jtzkn1OOtwUxNivi+LhGsSxPDE
        6zYZvcm5iDKXwosSjtlSxuCbY
X-Received: by 2002:a7b:cf02:: with SMTP id l2mr2224569wmg.4.1586262920073;
        Tue, 07 Apr 2020 05:35:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypKpOChN8tGzByvwHEKGAyg4BmSbrzIK1wsR3YYnAfmm17DVuuJcLPkB5PdpW+tBGHaK6JYitA==
X-Received: by 2002:a7b:cf02:: with SMTP id l2mr2224546wmg.4.1586262919855;
        Tue, 07 Apr 2020 05:35:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bd61:914:5c2f:2580? ([2001:b07:6468:f312:bd61:914:5c2f:2580])
        by smtp.gmail.com with ESMTPSA id f1sm32628821wrv.37.2020.04.07.05.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 05:35:19 -0700 (PDT)
Subject: Re: [PATCH] KVM: VMX: fix crash cleanup when KVM wasn't used
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200401081348.1345307-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c2504c0-8dac-4bbf-bd50-a503be755d3f@redhat.com>
Date:   Tue, 7 Apr 2020 14:35:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200401081348.1345307-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/20 10:13, Vitaly Kuznetsov wrote:
> If KVM wasn't used at all before we crash the cleanup procedure fails with
>  BUG: unable to handle page fault for address: ffffffffffffffc8
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 23215067 P4D 23215067 PUD 23217067 PMD 0
>  Oops: 0000 [#8] SMP PTI
>  CPU: 0 PID: 3542 Comm: bash Kdump: loaded Tainted: G      D           5.6.0-rc2+ #823
>  RIP: 0010:crash_vmclear_local_loaded_vmcss.cold+0x19/0x51 [kvm_intel]
> 
> The root cause is that loaded_vmcss_on_cpu list is not yet initialized,
> we initialize it in hardware_enable() but this only happens when we start
> a VM.
> 
> Previously, we used to have a bitmap with enabled CPUs and that was
> preventing [masking] the issue.
> 
> Initialized loaded_vmcss_on_cpu list earlier, right before we assign
> crash_vmclear_loaded_vmcss pointer. blocked_vcpu_on_cpu list and
> blocked_vcpu_on_cpu_lock are moved altogether for consistency.
> 
> Fixes: 31603d4fc2bb ("KVM: VMX: Always VMCLEAR in-use VMCSes during crash with kexec support")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 3aba51d782e2..39a5dde12b79 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2257,10 +2257,6 @@ static int hardware_enable(void)
>  	    !hv_get_vp_assist_page(cpu))
>  		return -EFAULT;
>  
> -	INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
> -	INIT_LIST_HEAD(&per_cpu(blocked_vcpu_on_cpu, cpu));
> -	spin_lock_init(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
> -
>  	r = kvm_cpu_vmxon(phys_addr);
>  	if (r)
>  		return r;
> @@ -8006,7 +8002,7 @@ module_exit(vmx_exit);
>  
>  static int __init vmx_init(void)
>  {
> -	int r;
> +	int r, cpu;
>  
>  #if IS_ENABLED(CONFIG_HYPERV)
>  	/*
> @@ -8060,6 +8056,12 @@ static int __init vmx_init(void)
>  		return r;
>  	}
>  
> +	for_each_possible_cpu(cpu) {
> +		INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
> +		INIT_LIST_HEAD(&per_cpu(blocked_vcpu_on_cpu, cpu));
> +		spin_lock_init(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
> +	}
> +
>  #ifdef CONFIG_KEXEC_CORE
>  	rcu_assign_pointer(crash_vmclear_loaded_vmcss,
>  			   crash_vmclear_local_loaded_vmcss);
> 

Queued, thanks.

Paolo

