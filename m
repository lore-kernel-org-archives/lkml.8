Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E5BC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887AC2192A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoY7YT/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgBFPJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:09:58 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56376 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727389AbgBFPJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581001797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EZiBMYoM5ngA1SWJXac8F1p5eppKDaYXsn4jaAv3LSk=;
        b=eoY7YT/kuC3ITEJdwBR241xbCV6nv1zgSARCNfwEdybEm3UAQfDmHYtim2wUFTMTpXnEHc
        06zQHfkMKJrD7M4Ddgd6enZKV4xmcl0J8bIqmZei29scPjZNBLFgIcNMR4AbZP6IsDQSTR
        3iRyokNn7P3hxEDaED3CWZWAtHH2408=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-MaYk6OVgMuC9t-3MiZbzew-1; Thu, 06 Feb 2020 10:09:56 -0500
X-MC-Unique: MaYk6OVgMuC9t-3MiZbzew-1
Received: by mail-wm1-f72.google.com with SMTP id s25so129437wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 07:09:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=EZiBMYoM5ngA1SWJXac8F1p5eppKDaYXsn4jaAv3LSk=;
        b=tv0xi5KcvtKWcrmjmR63xYrDJkZmQl68FQbHGNt3g3v0A8E+UznlOqxahQmu7gHE4A
         YJ5rJl38N/AXr2FrskWbEQxqDdZKvaz6Xvx4qjE+pEsjdcUUbdv6VI80j1f43sUWmP+s
         j7W1tpR5X8TA1K8OcRc3hObKGW2NFrxsqUga43w916lkPjBx+AhrX4PrCTjMZog5mwyr
         Yypj9B56sUypSebOLmqnZVkbi+6jCQxOG7CAImvdJb+BHjfJf//+v03R1+7vu7JBPXPa
         iyRQadjY6iusSYahbmb7mGNBNKulI9Ld/ERa/Gedkm5E+8/OMdfywix69jjx0yQsVK0P
         HIAA==
X-Gm-Message-State: APjAAAX4WyG1wA9MIbYoprwAH0zsOQS96MnwaTXexb0/hs2IZAIsWdcg
        pfQjAwu/2DM9QDuWA2GQ0VnMO7b8XzmSsqMxV5p6srZTUyOQWzjWZGZR/Aj3RXZhmYbKy+4uao2
        tZR9MC4xXwKglOKVShlzBSKAz
X-Received: by 2002:a1c:151:: with SMTP id 78mr4844280wmb.182.1581001794876;
        Thu, 06 Feb 2020 07:09:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqy7PZM8qvaN6WfZLfowxyRpKK0ElKwo8vzNSQ8xUj7u0xgC7aIvhuRCNLsPUGIuGsyl4qCxbg==
X-Received: by 2002:a1c:151:: with SMTP id 78mr4844246wmb.182.1581001794592;
        Thu, 06 Feb 2020 07:09:54 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q130sm4453532wme.19.2020.02.06.07.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 07:09:54 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 04/61] KVM: x86: Clean up error handling in kvm_dev_ioctl_get_cpuid()
In-Reply-To: <20200201185218.24473-5-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-5-sean.j.christopherson@intel.com>
Date:   Thu, 06 Feb 2020 16:09:53 +0100
Message-ID: <87mu9vg3b2.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Clean up the error handling in kvm_dev_ioctl_get_cpuid(), which has
> gotten a bit crusty as the function has evolved over the years.
>
> Opportunistically hoist the static @funcs declaration to the top of the
> function to make it more obvious that it's a "static const".
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index de52cbb46171..11d5f311ef10 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -889,45 +889,40 @@ int kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
>  			    struct kvm_cpuid_entry2 __user *entries,
>  			    unsigned int type)
>  {
> -	struct kvm_cpuid_entry2 *cpuid_entries;
> -	int nent = 0, r = -E2BIG, i;
> -
>  	static const u32 funcs[] = {
>  		0, 0x80000000, CENTAUR_CPUID_SIGNATURE, KVM_CPUID_SIGNATURE,
>  	};
>  
> +	struct kvm_cpuid_entry2 *cpuid_entries;
> +	int nent = 0, r, i;
> +
>  	if (cpuid->nent < 1)
> -		goto out;
> +		return -E2BIG;
>  	if (cpuid->nent > KVM_MAX_CPUID_ENTRIES)
>  		cpuid->nent = KVM_MAX_CPUID_ENTRIES;
>  
>  	if (sanity_check_entries(entries, cpuid->nent, type))
>  		return -EINVAL;
>  
> -	r = -ENOMEM;
>  	cpuid_entries = vzalloc(array_size(sizeof(struct kvm_cpuid_entry2),
>  					   cpuid->nent));
>  	if (!cpuid_entries)
> -		goto out;
> +		return -ENOMEM;
>  
> -	r = 0;
>  	for (i = 0; i < ARRAY_SIZE(funcs); i++) {
>  		r = get_cpuid_func(cpuid_entries, funcs[i], &nent, cpuid->nent,
>  				   type);
>  		if (r)
>  			goto out_free;
>  	}
> +	cpuid->nent = nent;
>  
> -	r = -EFAULT;
>  	if (copy_to_user(entries, cpuid_entries,
>  			 nent * sizeof(struct kvm_cpuid_entry2)))
> -		goto out_free;
> -	cpuid->nent = nent;
> -	r = 0;
> +		r = -EFAULT;
>  
>  out_free:
>  	vfree(cpuid_entries);
> -out:
>  	return r;
>  }

Please [partially] disregard my comment on PATCH 02

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

