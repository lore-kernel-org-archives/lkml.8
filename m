Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B96C38BFA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300942176D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpsUEzkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgBXWZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:25:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24931 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726651AbgBXWZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 17:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582583130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bot62eJ1QDSkALNx5M99l4TX45t0SfA6NlI29a+aUK0=;
        b=hpsUEzkVdVV+83QHXQFzaJ+25pZLN9Y0dZEGhHHWyykvymlhA3iLfDMhFGavtp8tAJcw1G
        g+j4kZTfaI8P8mDyp/i9+gYqEGoJ7UX6O0TUexPcHkeOm/NnUd9Jd6N7Q4eckNWckBmrN/
        Rj4nOAhIf40hI9LIDn2g0eddVm/6tS4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-0bomdRrbPVyUWNUKPxy_Gw-1; Mon, 24 Feb 2020 17:25:28 -0500
X-MC-Unique: 0bomdRrbPVyUWNUKPxy_Gw-1
Received: by mail-wm1-f69.google.com with SMTP id o24so327114wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 14:25:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Bot62eJ1QDSkALNx5M99l4TX45t0SfA6NlI29a+aUK0=;
        b=nKfroqcX+iDkCuBurc3BhCj5IZOljpO3W6oJEm5tSN/TIHfNXnylSsVMUEZtLII+Yl
         biKrTFcrlQqXo8UWsOVpCWDZn2laPFxqEcQfW8KCcLIxHkE1jl0+avHODVYWivw/FFK7
         //bWr9JVF0mOkXjDyKLoD1hZdoGpqNNrvwYKBCwYgDbNZLish8PVk3tAYdvdK+RGe1hy
         2QlCQStpBKjAkNfJmMWXKJTG9UKtImHVTOJ6g0c1FEXmOXGzkaov6Ub0k8sd9IG8rP35
         BnZxAB9PRuglYM9pCsPrbzHEwhvgFhVoGoObdBR8otY6vWIhq/1fAy7HIXgGMNmq7KXt
         t1vw==
X-Gm-Message-State: APjAAAXJZHLfZRxO5TrpMtX4GVt+TQPH63ah25GEl+0OtMjzM2flZZ/C
        Q9JPJJno7HiYHk97ef0HSpovrmE5zwj0FJdpn4PJmeY9Ce0/iZcDygImbrTXy/E0v6pz/DNHjYc
        cqwKKApq+5802uM9hPZDZEyek
X-Received: by 2002:a5d:6284:: with SMTP id k4mr70626440wru.398.1582583126671;
        Mon, 24 Feb 2020 14:25:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqxdW0lbkDcKo6cvmGoaTL3byAKPZzz+xGIZ0lou3jF2Nzg4YqBYrlczj+0NSU2EHCBclycImw==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr70626416wru.398.1582583126397;
        Mon, 24 Feb 2020 14:25:26 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b67sm1206714wmc.38.2020.02.24.14.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 14:25:25 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 46/61] KVM: x86: Remove the unnecessary loop on CPUID 0x7 sub-leafs
In-Reply-To: <20200201185218.24473-47-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-47-sean.j.christopherson@intel.com>
Date:   Mon, 24 Feb 2020 23:25:24 +0100
Message-ID: <87tv3fmxm3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Explicitly handle CPUID 0x7 sub-leaf 1.  The kernel is currently aware
> of exactly one feature in CPUID 0x7.1,  which means there is room for
> another 127 features before CPUID 0x7.2 will see the light of day, i.e.
> the looping is likely to be dead code for years to come.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 7362e5238799..47f61f4497fb 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -533,11 +533,9 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  		if (boot_cpu_has(X86_FEATURE_AMD_SSBD))
>  			cpuid_entry_set(entry, X86_FEATURE_SPEC_CTRL_SSBD);
>  
> -		for (i = 1, max_idx = entry->eax; i <= max_idx; i++) {
> -			if (WARN_ON_ONCE(i > 1))
> -				break;
> -
> -			entry = do_host_cpuid(array, function, i);
> +		/* KVM only supports 0x7.0 and 0x7.1, capped above via min(). */
> +		if (entry->eax == 1) {
> +			entry = do_host_cpuid(array, function, 1);
>  			if (!entry)
>  				goto out;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

