Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3C8C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A479022B48
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByfXBBzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbgBFO74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 09:59:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54707 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726956AbgBFO74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581001194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qmjLVdP5R8RM0ZvRPIl0Xv2Nz6Hwhfs77mUQxh0wahs=;
        b=ByfXBBzKskO4uZLnEWZzFdfuAyd0ezQh0gb/t3pa0VjSsmPVFVOyRIRQDv1TGCVYo4AdYO
        ImFQtY26xwI3B0YMz0kSvoPYGOBnrbYXkxb6tz2rLHdjeuV7QHtIsuM5CBYiYUAUZIiLeY
        HxRT8qcT5Fu/dKaiWiMK5r/AnOtKplU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-OLCLpWqiOzi5CtB_OEQa6g-1; Thu, 06 Feb 2020 09:59:52 -0500
X-MC-Unique: OLCLpWqiOzi5CtB_OEQa6g-1
Received: by mail-wm1-f71.google.com with SMTP id o193so106018wme.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 06:59:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qmjLVdP5R8RM0ZvRPIl0Xv2Nz6Hwhfs77mUQxh0wahs=;
        b=kLqW+oAAqEViD1p6c4OJ1iAKuWy8mhj3OlqdGRlDTFn3dElpEIwJjKAGOgizC0/qlK
         YAatln0EsGsvCyozFL9EL5mDCiTYy+HLiREH9bdW+Q+vQoClPJOC/Gf4QFwqcmmcY9Dh
         TQnwd5CRPC1Wbl4CkSxPzRJfnJHZ4V/bh68VtQ/G1NqVsr4pAgkIOvUJVlebC0pgnifw
         DLhOxDhKeKQshxglyYPcyLL/+izCFFUZgo4aG3RfVpwjBEgDyp+8Qj3m6J2elpUke6KC
         p548HGvVUI4e6L29kUaRWt3L5xnwzBb8zfqTVdsCpao2zgYOxHaYmi6QL8VwEnfrilBg
         VeHA==
X-Gm-Message-State: APjAAAV34sWiS+yUFKxPzaufvRMO+OPXarxPhEQpN7L23Bn+6xob3DgH
        j9z3HdJrK3S4jyx4Z/rziKqTZ0OinihZuGMnzKDZrYidMwSmUWj6Ot6aEl+vjgFu4YHxjacYG24
        E+xHkRSm55Nev7x6Mo+AU/EO4
X-Received: by 2002:a05:600c:cd:: with SMTP id u13mr4902092wmm.24.1581001191125;
        Thu, 06 Feb 2020 06:59:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqzSFSAnJto9BHznTO5jIGLECUtjqikpIoBHWuDLYA69tq1wXZv9J3fWCOARGMJFmdINf+BaEg==
X-Received: by 2002:a05:600c:cd:: with SMTP id u13mr4902075wmm.24.1581001190906;
        Thu, 06 Feb 2020 06:59:50 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v22sm3885858wml.11.2020.02.06.06.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 06:59:50 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 02/61] KVM: x86: Refactor loop around do_cpuid_func() to separate helper
In-Reply-To: <20200201185218.24473-3-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-3-sean.j.christopherson@intel.com>
Date:   Thu, 06 Feb 2020 15:59:49 +0100
Message-ID: <87sgjng3ru.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Move the guts of kvm_dev_ioctl_get_cpuid()'s CPUID func loop to a
> separate helper to improve code readability and pave the way for future
> cleanup.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 45 ++++++++++++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 18 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 47ce04762c20..f49fdd06f511 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -839,6 +839,29 @@ static bool is_centaur_cpu(const struct kvm_cpuid_param *param)
>  	return boot_cpu_data.x86_vendor == X86_VENDOR_CENTAUR;
>  }
>  
> +static int get_cpuid_func(struct kvm_cpuid_entry2 *entries, u32 func,
> +			  int *nent, int maxnent, unsigned int type)
> +{
> +	u32 limit;
> +	int r;
> +
> +	r = do_cpuid_func(&entries[*nent], func, nent, maxnent, type);
> +	if (r)
> +		return r;
> +
> +	limit = entries[*nent - 1].eax;
> +	for (func = func + 1; func <= limit; ++func) {
> +		if (*nent >= maxnent)
> +			return -E2BIG;
> +
> +		r = do_cpuid_func(&entries[*nent], func, nent, maxnent, type);
> +		if (r)
> +			break;
> +	}
> +
> +	return r;
> +}
> +
>  static bool sanity_check_entries(struct kvm_cpuid_entry2 __user *entries,
>  				 __u32 num_entries, unsigned int ioctl_type)
>  {
> @@ -871,8 +894,8 @@ int kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
>  			    unsigned int type)
>  {
>  	struct kvm_cpuid_entry2 *cpuid_entries;
> -	int limit, nent = 0, r = -E2BIG, i;
> -	u32 func;
> +	int nent = 0, r = -E2BIG, i;

Not this patches fault, but I just noticed that '-E2BIG' initializer
here is only being used for 

 'if (cpuid->nent < 1)'

case so I have two suggestion:
1) Return directly without the 'goto' , drop the initializer.
2) Return -EINVAL instead.

> +
>  	static const struct kvm_cpuid_param param[] = {
>  		{ .func = 0 },
>  		{ .func = 0x80000000 },
> @@ -901,22 +924,8 @@ int kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
>  		if (ent->qualifier && !ent->qualifier(ent))
>  			continue;
>  
> -		r = do_cpuid_func(&cpuid_entries[nent], ent->func,
> -				  &nent, cpuid->nent, type);
> -
> -		if (r)
> -			goto out_free;
> -
> -		limit = cpuid_entries[nent - 1].eax;
> -		for (func = ent->func + 1; func <= limit && r == 0; ++func) {
> -			if (nent >= cpuid->nent) {
> -				r = -E2BIG;
> -				goto out_free;
> -			}
> -			r = do_cpuid_func(&cpuid_entries[nent], func,
> -				          &nent, cpuid->nent, type);
> -		}
> -
> +		r = get_cpuid_func(cpuid_entries, ent->func, &nent,
> +				   cpuid->nent, type);
>  		if (r)
>  			goto out_free;
>  	}

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

