Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD5EC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E4920679
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAB7oGb1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgBUOkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:40:15 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29244 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728068AbgBUOkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582296013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7koPtbeBb5w+hzgMwDrOYC28FFGb3sjxwiIasS6oSIA=;
        b=IAB7oGb1IFu1jqXe/7wxhWfaZhuiKIsiAcxnrfYk2CND0iESMoaMrvtFar3EGzxItx3Wmi
        aVFYZsUVA03qo63bUQVy9lQM4UjzTXyQoS+51QyXuOG8Q5FeYQMQAFDVhUp+YsDeswNQIj
        WK/JqeOTuYvk6sKVcFb9WC2dblrIscg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-unyLSEvoPSaHRocWpMnqsw-1; Fri, 21 Feb 2020 09:40:11 -0500
X-MC-Unique: unyLSEvoPSaHRocWpMnqsw-1
Received: by mail-wm1-f71.google.com with SMTP id k21so656106wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 06:40:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=7koPtbeBb5w+hzgMwDrOYC28FFGb3sjxwiIasS6oSIA=;
        b=LvujidCmI5C8Uf+c8ZMj1Upxs2iEg5o83PuWOKldMh79CxWpvCGugrSFCEK2VYAlK6
         pkcZwWGu1RiuE4SgR4w3835GLG8Eg2QWiiM3qgnGwzFMZP47GR1aJMLd/imwstrxRBHk
         CE2K/QVH70rfW2ZIq5Sfzqxbr/exckaRxyniEtqwBIG1Ig6p9Pj2AF0Au29pfAiCfHLB
         M4iEu8qZx4tzSuDypQkzvI9JImAIOd6hxX24pqMWw2YlK1fqU5YZW4emkKITiQ3TYoxb
         +75HlfN4RTvopa+eFdRFYaPVo44R14rOXozYnt0WxS+OqCXc8qjpaVDxgaRbN6bjTYyX
         6Xdg==
X-Gm-Message-State: APjAAAXMR8vVoD2fO2BvCPhTD1QQkYbkh9ECgRELVM+vjaMegLsbywWZ
        bbe6cyz4wx1TlRRkwo/5RhfqYQt8qGUM22uh5YzA36JXxfDnOlccTJMTTKNZpZmc/wi0C8+Swno
        gwfpkC4l5KbmTHgauscKdmmOw
X-Received: by 2002:a7b:c190:: with SMTP id y16mr4290504wmi.107.1582296010203;
        Fri, 21 Feb 2020 06:40:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqxTZLZSlB+bzSFgFQD27t5eSQEei+VCnJrgcq94fiIh6QgLci/t90O3aJHrS+r+nYtPI2JPhg==
X-Received: by 2002:a7b:c190:: with SMTP id y16mr4290480wmi.107.1582296009981;
        Fri, 21 Feb 2020 06:40:09 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id r5sm4142186wrt.43.2020.02.21.06.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 06:40:09 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/61] KVM: x86: Refactor CPUID 0x4 and 0x8000001d handling
In-Reply-To: <20200201185218.24473-16-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-16-sean.j.christopherson@intel.com>
Date:   Fri, 21 Feb 2020 15:40:08 +0100
Message-ID: <871rqorol3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Refactoring the sub-leaf handling for CPUID 0x4/0x8000001d to eliminate
> a one-off variable and its associated brackets.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 5044a595799f..d75d539da759 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -545,20 +545,16 @@ static inline int __do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 function,
>  		break;
>  	/* functions 4 and 0x8000001d have additional index. */
>  	case 4:
> -	case 0x8000001d: {
> -		int cache_type;
> -
> -		/* read more entries until cache_type is zero */
> -		for (i = 1; ; ++i) {
> -			cache_type = entry[i - 1].eax & 0x1f;
> -			if (!cache_type)
> -				break;
> -
> +	case 0x8000001d:
> +		/*
> +		 * Read entries until the cache type in the previous entry is
> +		 * zero, i.e. indicates an invalid entry.
> +		 */
> +		for (i = 1; entry[i - 1].eax & 0x1f; ++i) {
>  			if (!do_host_cpuid(&entry[i], nent, maxnent, function, i))
>  				goto out;
>  		}
>  		break;
> -	}
>  	case 6: /* Thermal management */
>  		entry->eax = 0x4; /* allow ARAT */
>  		entry->ebx = 0;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

