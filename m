Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD912C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDA62166E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gua9GkdF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbgCCQD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:03:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35896 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729537AbgCCQD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583251435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/tRzL6U8zBIIOVOwiT19rvws3udmiVdmkMlNTXIZwbg=;
        b=gua9GkdF657u7bbrTLVXHOZNkk4e1uQdxYnyue1RNiUlHjGZls6wAs3BD6aQE0dScJjzRp
        rU8LsqYQENb9sb4HXKRZ3KwdZZnJLoTY/OcWkv1javn1YrVyEk4+VhDTCwZRDR++psSsBs
        lW+0Ie78MV3UelKW7sMvkoWlMnyXbs8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-XcsQ4dObOA293Pg_s4KuIw-1; Tue, 03 Mar 2020 11:03:53 -0500
X-MC-Unique: XcsQ4dObOA293Pg_s4KuIw-1
Received: by mail-wr1-f69.google.com with SMTP id d7so1436967wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 08:03:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/tRzL6U8zBIIOVOwiT19rvws3udmiVdmkMlNTXIZwbg=;
        b=ow+FG3bAJMOIMrHSaFs/PTafZQ/8qHWvQ1SejyasH+8IYCXk9qLXQs13v/sOxulVG0
         XzukAEo6PtKeH7TNixWEwRPZHDxKhESTu0/kNR0IA1XcujsGMf/jUyc7Mzdt9bQKEclQ
         MNGXrXR1MFOGt048+AFH4TEQjLOQ2rXFyDTShCf0aO1o0BpKqS0Hl6TOCRGk/ZPIc0mE
         fANAGdkFsJ7g9ozrI/SpC2Il08hre+bS21AzGOqtFbZTB/nVWxCJ0Hk8OjnOgmE8c6Zt
         N5bpKhtrcSF2NgCUweC6HGnxi7KREsiypKBuX5Vu6+xL67qiVlaYk9Wb+8UQLbU4n++c
         B6PA==
X-Gm-Message-State: ANhLgQ0Kh992o8AP+hB0t1QMs0CdSmHos/JOOFMtgmNRNt4OMPOVTwY7
        4UChEg+GjWCVSqXbgTFMzfTU70xlOb7PxhTNVxVL2bZaQX7U7b8Ny31w4ls/pAaw8BKLOLr5spj
        UcyxMl4+LmOMSAtwM6/AdjT8r
X-Received: by 2002:a1c:1f56:: with SMTP id f83mr4925968wmf.101.1583251432282;
        Tue, 03 Mar 2020 08:03:52 -0800 (PST)
X-Google-Smtp-Source: ADFU+vv9qk3kYMC9VwTgKWNbztNGZDgmdaZ4MofqEtQmju3UA91sffxYiA5AEMHy7QlEh1Q22+5+Mw==
X-Received: by 2002:a1c:1f56:: with SMTP id f83mr4925947wmf.101.1583251432026;
        Tue, 03 Mar 2020 08:03:52 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 25sm98565wmg.30.2020.03.03.08.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 08:03:51 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH v2 53/66] KVM: x86: Do kvm_cpuid_array capacity checks in terminal functions
In-Reply-To: <20200302235709.27467-54-sean.j.christopherson@intel.com>
References: <20200302235709.27467-1-sean.j.christopherson@intel.com> <20200302235709.27467-54-sean.j.christopherson@intel.com>
Date:   Tue, 03 Mar 2020 17:03:50 +0100
Message-ID: <87d09tfms9.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Perform the capacity checks on the userspace provided kvm_cpuid_array
> in the lower __do_cpuid_func() and __do_cpuid_func_emulated().
> Pre-checking the array in do_cpuid_func() no longer adds value now that
> __do_cpuid_func() has been trimmed down to size, i.e. doesn't invoke a
> big pile of retpolined functions before doing anything useful.
>
> Note, __do_cpuid_func() already checks the array capacity via
> do_host_cpuid(), "moving" the check to __do_cpuid_func() simply means
> removing a WARN_ON().
>
> Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index eebd7f613f67..f879fcbd6fb2 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -478,8 +478,12 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
>  
>  static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
>  {
> -	struct kvm_cpuid_entry2 *entry = &array->entries[array->nent];
> +	struct kvm_cpuid_entry2 *entry;
>  
> +	if (array->nent >= array->maxnent)
> +		return -E2BIG;
> +
> +	entry = &array->entries[array->nent];
>  	entry->function = func;
>  	entry->index = 0;
>  	entry->flags = 0;
> @@ -516,7 +520,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  	r = -E2BIG;
>  
>  	entry = do_host_cpuid(array, function, 0);
> -	if (WARN_ON(!entry))
> +	if (!entry)
>  		goto out;
>  
>  	switch (function) {
> @@ -787,9 +791,6 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  static int do_cpuid_func(struct kvm_cpuid_array *array, u32 func,
>  			 unsigned int type)
>  {
> -	if (array->nent >= array->maxnent)
> -		return -E2BIG;
> -
>  	if (type == KVM_GET_EMULATED_CPUID)
>  		return __do_cpuid_func_emulated(array, func);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

