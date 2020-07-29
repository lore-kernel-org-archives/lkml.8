Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD87C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AC922067D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYcrp0Uy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgG2XJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:09:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55645 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727986AbgG2XJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 19:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596064173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MOzWsoV4V1UYpUe37YHfLbYZNy/u93r4LzdthqJ6/oA=;
        b=PYcrp0Uyl9y/FbwJ11K8ey7+Kito7FRBAYzDFgclXeqeieeGvaYoujH5JkJGpxfc4G6b6M
        dFNjR0XwK3Tdx/qmh++b3EEukRRIS2UCJvuAqMIyXdy0Cc7FoScuijIfbntXoLM6mUMc5z
        L78BHc7q163ESaKlGu1afvxMs3jRa9A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-z6dW0zYCMUiOHwTMVUvWZQ-1; Wed, 29 Jul 2020 19:09:31 -0400
X-MC-Unique: z6dW0zYCMUiOHwTMVUvWZQ-1
Received: by mail-wr1-f72.google.com with SMTP id m7so7143174wrb.20
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 16:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MOzWsoV4V1UYpUe37YHfLbYZNy/u93r4LzdthqJ6/oA=;
        b=gmLgFGflsyZIoNfxaeTdTiw7LcUTV9N+KV764KAV+jREL/XbKBB0gzbe6iKZv/IRzh
         15BQP6InxaZ0WIidZ3UMeZK5BvOZ7Nn7O9oeqXJsz3IQVgSZ3GeRyPmVV6QK+WzUBfHz
         lwR1dYBb1fdt36H7mnYthe3au0hxtGJGT4S/AhhMraW01xRWodIW6KHPJ7/frl8zDx9h
         hCXHX+SQKixXPbjmJ++XQBk/9O+JC+3xo0BvckYN6IBSc22r5odIrguklb/7Jp1U/ybv
         GXIEVTygekMrCHahCfDBiWVH+hMnc9g5ZJ4Jy/WrlkvDsJ89FK9R+Dsoh7vLBdjs0VZ1
         kftg==
X-Gm-Message-State: AOAM530qD+gy2XqoZKFSq0qBL6kyhi1s0DS47kRdvVGygMGtPXnugoZZ
        amoBwDk/zp6cB3PBufTnVbvCVy3Pzi6TvXJJ5Wl/0j2bU9hWJXnB3tjEf5ToR/0VIviTAylSO0J
        fogUlMgbXPaqFAVr+YJbBV03Q
X-Received: by 2002:a5d:618e:: with SMTP id j14mr22469wru.374.1596064170193;
        Wed, 29 Jul 2020 16:09:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6A8g5r+z6yS7wZ5SDypfCJ/7uTsFty4Vrb8Ti/KJDrWVOKGqmBLEWrbhtsfBg4vBNjr4YvA==
X-Received: by 2002:a5d:618e:: with SMTP id j14mr22406wru.374.1596064169050;
        Wed, 29 Jul 2020 16:09:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:101f:6e7:e073:454c? ([2001:b07:6468:f312:101f:6e7:e073:454c])
        by smtp.gmail.com with ESMTPSA id s20sm6324317wmh.21.2020.07.29.16.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 16:09:28 -0700 (PDT)
Subject: Re: [PATCH v3 01/11] KVM: SVM: Introduce __set_intercept,
 __clr_intercept and __is_intercept
To:     Babu Moger <babu.moger@amd.com>, vkuznets@redhat.com,
        wanpengli@tencent.com, sean.j.christopherson@intel.com,
        jmattson@google.com
Cc:     kvm@vger.kernel.org, joro@8bytes.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, tglx@linutronix.de
References: <159597929496.12744.14654593948763926416.stgit@bmoger-ubuntu>
 <159597947370.12744.8741858978174141331.stgit@bmoger-ubuntu>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7c6c66d0-85cd-e558-f43e-a2d5d57e8913@redhat.com>
Date:   Thu, 30 Jul 2020 01:09:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <159597947370.12744.8741858978174141331.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/20 01:37, Babu Moger wrote:
> This is in preparation for the future intercept vector additions.
> 
> Add new functions __set_intercept, __clr_intercept and __is_intercept
> using kernel APIs __set_bit, __clear_bit and test_bit espectively.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kvm/svm/svm.h |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 6ac4c00a5d82..3b669718190a 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -217,6 +217,21 @@ static inline struct vmcb *get_host_vmcb(struct vcpu_svm *svm)
>  		return svm->vmcb;
>  }
>  
> +static inline void __set_intercept(void *addr, int bit)
> +{
> +	__set_bit(bit, (unsigned long *)addr);
> +}
> +
> +static inline void __clr_intercept(void *addr, int bit)
> +{
> +	__clear_bit(bit, (unsigned long *)addr);
> +}
> +
> +static inline bool __is_intercept(void *addr, int bit)
> +{
> +	return test_bit(bit, (unsigned long *)addr);
> +}
> +

Probably worth adding a range check?

Paolo

>  static inline void set_cr_intercept(struct vcpu_svm *svm, int bit)
>  {
>  	struct vmcb *vmcb = get_host_vmcb(svm);
> 

