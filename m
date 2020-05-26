Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7587EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 466952088E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKAFI+oj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbgEZHdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:33:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22608 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726736AbgEZHdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590478415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YGp3YMRKFUOtwSIg5Cu6FMpQymGuRv9t/Z4LuF1Cd4U=;
        b=iKAFI+oj0DNUJyNWZIhigyAV94nhdGX664EsbB/zBOQMvGine3Zv/wad14hi/M0AIsYzil
        3WfJUi4ZA2g9OXxkpO/Li1rNfrPJw90jovU4wF+59mtEgNINItF7bX/MRX5PdzTOaS5Zw5
        07qVw8ITi2M6WGcdre3xwhHiq5Ti2Bk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-zhz1EFGDMVeESFFrjTVIZg-1; Tue, 26 May 2020 03:33:31 -0400
X-MC-Unique: zhz1EFGDMVeESFFrjTVIZg-1
Received: by mail-wm1-f71.google.com with SMTP id f9so727286wml.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=YGp3YMRKFUOtwSIg5Cu6FMpQymGuRv9t/Z4LuF1Cd4U=;
        b=qbAk4xCWVLuHTipGYFjHrAsTpuY2vKDS2rGMpkmXwKnQtBz7NwUl+VIKNWvr5scUR7
         T2Z7Csl0+eD0Nh3mzpzcAVo5/uvJ12P0y7NU2AlZROneb4xRJje07YL3tZIi9fBhi0//
         43IzhOb8d0znx/GjIy7jwXovcwbE5Du9Yrt/2y2K2uRS+uDGXQg7nfTBeu4zUasl2ILg
         HfpcEAoEMpqm8zRuax0u/vSefbaL7GlC/bHk2xDYA5+ezz7+93NuHlk/S+UQH+dSz6ps
         F5V840pZFZZIaMkCx7vU9E9DQcjzd4AzsN+qc6d2OXqWXLEiIJrKPkBeLQ3SQ0iI2KXp
         82HA==
X-Gm-Message-State: AOAM53033phBRkh0YoYffRTRbwu6fwtvlu5n2Jt3PU/r3g/E2VQRgCDY
        HI6dADA6THTsVRx8ugzptBy61EAIlmfqU7BLpSPB1JHs3lWfjED1gtMDlkia2XtHcJlTd9QN2+R
        I6cI5SgI5XaP15iv2AIAY4yfZ
X-Received: by 2002:a5d:6986:: with SMTP id g6mr13344946wru.27.1590478410562;
        Tue, 26 May 2020 00:33:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdQ4IEghrK6U3kHVDLWMkCekgw9MH67kIBkKD/yjzktHHSXF19lE8bi5+QeFcAIEnBoa/xew==
X-Received: by 2002:a5d:6986:: with SMTP id g6mr13344925wru.27.1590478410320;
        Tue, 26 May 2020 00:33:30 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id l17sm6367416wmi.3.2020.05.26.00.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 00:33:29 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: SVM: fix svn_pin_memory()'s use of get_user_pages_fast()
In-Reply-To: <20200526062207.1360225-2-jhubbard@nvidia.com>
References: <20200526062207.1360225-1-jhubbard@nvidia.com> <20200526062207.1360225-2-jhubbard@nvidia.com>
Date:   Tue, 26 May 2020 09:33:27 +0200
Message-ID: <87imgj6th4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Hubbard <jhubbard@nvidia.com> writes:

> There are two problems in svn_pin_memory():
>
> 1) The return value of get_user_pages_fast() is stored in an
> unsigned long, although the declared return value is of type int.
> This will not cause any symptoms, but it is misleading.
> Fix this by changing the type of npinned to "int".
>
> 2) The number of pages passed into get_user_pages_fast() is stored
> in an unsigned long, even though get_user_pages_fast() accepts an
> int. This means that it is possible to silently overflow the number
> of pages.
>
> Fix this by adding a WARN_ON_ONCE() and an early error return. The
> npages variable is left as an unsigned long for convenience in
> checking for overflow.
>
> Fixes: 89c505809052 ("KVM: SVM: Add support for KVM_SEV_LAUNCH_UPDATE_DATA command")
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: kvm@vger.kernel.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  arch/x86/kvm/svm/sev.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 89f7f3aebd31..9693db1af57c 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -313,7 +313,8 @@ static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
>  				    int write)
>  {
>  	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
> -	unsigned long npages, npinned, size;
> +	unsigned long npages, size;
> +	int npinned;
>  	unsigned long locked, lock_limit;
>  	struct page **pages;
>  	unsigned long first, last;
> @@ -333,6 +334,9 @@ static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
>  		return NULL;
>  	}
>  
> +	if (WARN_ON_ONCE(npages > INT_MAX))
> +		return NULL;
> +

I bit unrelated to this patch, but callers of sev_pin_memory() treat
NULL differently:

sev_launch_secret()/svm_register_enc_region() return -ENOMEM
sev_dbg_crypt() returns -EFAULT

Should we switch to ERR_PTR() to preserve the error?

>  	/* Avoid using vmalloc for smaller buffers. */
>  	size = npages * sizeof(struct page *);
>  	if (size > PAGE_SIZE)

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

