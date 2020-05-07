Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C5AC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F9192078C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gy7yrFwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgEGI1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 04:27:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51075 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725809AbgEGI1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 04:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588840026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NPoYkk42Am6WOW9rBd2JK5/HKb1tfllVW3fkMFDg+40=;
        b=Gy7yrFwCfUMD3DdIYNVOVal5EYVsJlyB37ekoHYr2SGCf29SRG8TDZre6axvqeWERuN0Aj
        l/P/4/BgPJ5z2S6sGARqeoshV+56ZdSdOVDjprQUJwLZED9ydDJvmBFzL3LAQFSOj0OBMG
        fcd9FJ3rXeGxfxTubjyR8t/8sVqOArk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-uxXv6g1KOpaHpVPjZtvQIQ-1; Thu, 07 May 2020 04:27:02 -0400
X-MC-Unique: uxXv6g1KOpaHpVPjZtvQIQ-1
Received: by mail-wm1-f71.google.com with SMTP id o74so570841wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 01:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NPoYkk42Am6WOW9rBd2JK5/HKb1tfllVW3fkMFDg+40=;
        b=TFW9P8V+DxxsMa5TkNYj0CKqkyUSxDQoLJ+wmGR8ZEmcgpinO7i0xanUyEWU7LEepi
         OrSaqnEOr9cYYebrEgAa6BIXZ4FfQ0Ej13fVk1pXPCRUnb9UJTxWOV1etpIFBVwrWQQL
         vjpEGYACwSjpQdgCfj80ERbdJ3OfEz+RbIflvr+HeCoAmNhNNltr526IcTcWTywrnByW
         e+yXz4emDgtAus83OOiuiQ3BKyYSaF//liExW50jMnhjRyz44KY1AAobhjRbEdIg8Ihp
         Xmi3Klx483F2c1yDcaTRbES7DidfzIL3Kz5ANB3xVLiuFyY+ZbHejCkAZSbWqJxNND+M
         HHMw==
X-Gm-Message-State: AGi0PuZEDufDPJIOga66r2D6Dt2L24JRMnqyPT2guGbu0/ZnPLH8/4Gz
        Sqhysr0gE6aBPQgpi2sP2C4vHKApWQuVxHz1fvQn419DvBe7VPo7+bMV0W4dtnO4G+tGy2H3ezZ
        +grSqpPhIqOyuWdcRMPFWO6Zm
X-Received: by 2002:adf:bc41:: with SMTP id a1mr4893273wrh.302.1588840021532;
        Thu, 07 May 2020 01:27:01 -0700 (PDT)
X-Google-Smtp-Source: APiQypICgkhsdkD73J5RZB7foHUQ8HPIuCAtmaXh0izbxbK+Ominr6NyYwdA9dLW60G1PFuH6ke8Lw==
X-Received: by 2002:adf:bc41:: with SMTP id a1mr4893249wrh.302.1588840021254;
        Thu, 07 May 2020 01:27:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8d3e:39e5:cd88:13cc? ([2001:b07:6468:f312:8d3e:39e5:cd88:13cc])
        by smtp.gmail.com with ESMTPSA id v16sm6912902wml.30.2020.05.07.01.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 01:27:00 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: SVM: Disable AVIC before setting V_IRQ
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     joro@8bytes.org, jon.grimm@amd.com, mlevitsk@redhat.com
References: <1588818939-54264-1-git-send-email-suravee.suthikulpanit@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <793e7151-e14c-f254-7911-a4371ad635aa@redhat.com>
Date:   Thu, 7 May 2020 10:27:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1588818939-54264-1-git-send-email-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/20 04:35, Suravee Suthikulpanit wrote:
> The commit 64b5bd270426 ("KVM: nSVM: ignore L1 interrupt window
> while running L2 with V_INTR_MASKING=1") introduced a WARN_ON,
> which checks if AVIC is enabled when trying to set V_IRQ
> in the VMCB for enabling irq window.
> 
> The following warning is triggered because the requesting vcpu
> (to deactivate AVIC) does not get to process APICv update request
> for itself until the next #vmexit.
> 
> WARNING: CPU: 0 PID: 118232 at arch/x86/kvm/svm/svm.c:1372 enable_irq_window+0x6a/0xa0 [kvm_amd]
>  RIP: 0010:enable_irq_window+0x6a/0xa0 [kvm_amd]
>  Call Trace:
>   kvm_arch_vcpu_ioctl_run+0x6e3/0x1b50 [kvm]
>   ? kvm_vm_ioctl_irq_line+0x27/0x40 [kvm]
>   ? _copy_to_user+0x26/0x30
>   ? kvm_vm_ioctl+0xb3e/0xd90 [kvm]
>   ? set_next_entity+0x78/0xc0
>   kvm_vcpu_ioctl+0x236/0x610 [kvm]
>   ksys_ioctl+0x8a/0xc0
>   __x64_sys_ioctl+0x1a/0x20
>   do_syscall_64+0x58/0x210
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Fixes by sending APICV update request to all other vcpus, and
> immediately update APIC for itself.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Link: https://lkml.org/lkml/2020/5/2/167
> Fixes: 64b5bd270426 ("KVM: nSVM: ignore L1 interrupt window while running L2 with V_INTR_MASKING=1")
> ---
>  arch/x86/kvm/x86.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index df473f9..69a01ea 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8085,6 +8085,7 @@ void kvm_vcpu_update_apicv(struct kvm_vcpu *vcpu)
>   */
>  void kvm_request_apicv_update(struct kvm *kvm, bool activate, ulong bit)
>  {
> +	struct kvm_vcpu *except;
>  	unsigned long old, new, expected;
>  
>  	if (!kvm_x86_ops.check_apicv_inhibit_reasons ||
> @@ -8110,7 +8111,17 @@ void kvm_request_apicv_update(struct kvm *kvm, bool activate, ulong bit)
>  	trace_kvm_apicv_update_request(activate, bit);
>  	if (kvm_x86_ops.pre_update_apicv_exec_ctrl)
>  		kvm_x86_ops.pre_update_apicv_exec_ctrl(kvm, activate);
> -	kvm_make_all_cpus_request(kvm, KVM_REQ_APICV_UPDATE);
> +
> +	/*
> +	 * Sending request to update APICV for all other vcpus,
> +	 * while update the calling vcpu immediately instead of
> +	 * waiting for another #VMEXIT to handle the request.
> +	 */
> +	except = kvm_get_running_vcpu();
> +	kvm_make_all_cpus_request_except(kvm, KVM_REQ_APICV_UPDATE,
> +					 except);
> +	if (except)
> +		kvm_vcpu_update_apicv(except);
>  }
>  EXPORT_SYMBOL_GPL(kvm_request_apicv_update);
>  
> 

Queued, thanks.

Paolo

