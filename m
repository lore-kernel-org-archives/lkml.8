Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AEDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B6BE206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpUM4Zhm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732882AbgFSMPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:15:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56735 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731946AbgFSMOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 08:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592568884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R8cRJ9mKHnqlRMCmgZ9Saj2HVMswrOptw4ckNPEI2IU=;
        b=QpUM4ZhmlexdzLggh99pMgLG56jzHtlMbLLYXwLj/UwqfbnrswYKf9kkwUvflSpU/jqayL
        APTjWHptm4ZC2pan5RK4vZlo5CdmEJIB7U7qT/hJepY6m25r3BvepII9M8Y4oEU+H7CP5R
        ZOzV9CxZ2TlXfQeAgAHVLKOpjev3HYE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-cfpd_Iq4OGyrKS2WTkCDVw-1; Fri, 19 Jun 2020 08:14:42 -0400
X-MC-Unique: cfpd_Iq4OGyrKS2WTkCDVw-1
Received: by mail-wr1-f71.google.com with SMTP id m14so4194673wrj.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 05:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R8cRJ9mKHnqlRMCmgZ9Saj2HVMswrOptw4ckNPEI2IU=;
        b=lyB27ydupdZCManRT5/e4JMIT6GDNnuiVr3evOcmYhPVxgl1C31//NV+Im228UDcyf
         Txmt+WPKQBtPc5bDTpCehiXTRQVeSc+oPIfnyW2mKWC0X+H8Sw8xAJIdmYzXbqd2Tfdr
         gTf7o8w+/bs/s4tBhiy3RuPnD0XIxSc2aM230csE+I/GWMv6dcbtBf0EaKdkSHtKA7to
         zxKAAPLib7hcEL+O1esqinowD5F5C8UGrSR+TsuPAK5RrH1AlXlukNlQ2DA9kPy5SJ5V
         DOSEwiTIpxXt8vBvNY5KvlQvnWvfq9GZTW43tWHNINorVUVv8Ci4T1tm7bAMvo7AG4ka
         YIYg==
X-Gm-Message-State: AOAM533z4wy+E1ewLxGLPcFHOGl47fmqqPvrGeP8w+5PPpsnKY6VTAaP
        yuH6D/xlqkkogTZ0EfhrVtZXAx7VGm5zzhL6R41lRf1dr/Avg9lD3BMkZjP1CLpRxzFNO1YKfOQ
        s2+nosMIKtLaHsVA9jkGGoYET
X-Received: by 2002:adf:db09:: with SMTP id s9mr3724454wri.256.1592568881585;
        Fri, 19 Jun 2020 05:14:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzI0DHsQbRkAzRAW/4WimBoJGHA0E5juzZDQy4xA4UsJjmsZK6Wry3yY0B5r4VoAJNzMN1cjA==
X-Received: by 2002:adf:db09:: with SMTP id s9mr3724431wri.256.1592568881336;
        Fri, 19 Jun 2020 05:14:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e1d2:138e:4eff:42cb? ([2001:b07:6468:f312:e1d2:138e:4eff:42cb])
        by smtp.gmail.com with ESMTPSA id b201sm6852671wmb.36.2020.06.19.05.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 05:14:40 -0700 (PDT)
Subject: Re: [PATCH RFC] Revert "KVM: VMX: Micro-optimize vmexit time when not
 exposing PMU"
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20200619094046.654019-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d72de2a8-7c65-6ad1-8f53-5a2a94533018@redhat.com>
Date:   Fri, 19 Jun 2020 14:13:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200619094046.654019-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/20 11:40, Vitaly Kuznetsov wrote:
> Guest crashes are observed on a Cascade Lake system when 'perf top' is
> launched on the host, e.g.
> 
>  BUG: unable to handle kernel paging request at fffffe0000073038
>  PGD 7ffa7067 P4D 7ffa7067 PUD 7ffa6067 PMD 7ffa5067 PTE ffffffffff120
>  Oops: 0000 [#1] SMP PTI
>  CPU: 1 PID: 1 Comm: systemd Not tainted 4.18.0+ #380
> ...
>  Call Trace:
>   serial8250_console_write+0xfe/0x1f0
>   call_console_drivers.constprop.0+0x9d/0x120
>   console_unlock+0x1ea/0x460
> 
> Call traces are different but the crash is imminent. The problem was
> blindly bisected to the commit 041bc42ce2d0 ("KVM: VMX: Micro-optimize
> vmexit time when not exposing PMU"). It was also confirmed that the
> issue goes away if PMU is exposed to the guest.
> 
> With some instrumentation of the guest we can see what is being switched
> (when we do atomic_switch_perf_msrs()):
> 
>  vmx_vcpu_run: switching 2 msrs
>  vmx_vcpu_run: switching MSR38f guest: 70000000d host: 70000000f
>  vmx_vcpu_run: switching MSR3f1 guest: 0 host: 2
> 
> The current guess is that PEBS (MSR_IA32_PEBS_ENABLE, 0x3f1) is to blame.
> Regardless of whether PMU is exposed to the guest or not, PEBS needs to
> be disabled upon switch.
> 
> This reverts commit 041bc42ce2d0efac3b85bbb81dea8c74b81f4ef9.
> 
> Reported-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> - Perf/KVM interractions are a mystery to me, thus RFC.
> ---
>  arch/x86/kvm/vmx/vmx.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 36c771728c8c..b1a23ad986ff 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6728,8 +6728,7 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  
>  	pt_guest_enter(vmx);
>  
> -	if (vcpu_to_pmu(vcpu)->version)
> -		atomic_switch_perf_msrs(vmx);
> +	atomic_switch_perf_msrs(vmx);
>  	atomic_switch_umwait_control_msr(vmx);
>  
>  	if (enable_preemption_timer)
> 

Queued, thanks.

Paolo

