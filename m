Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7698FC35DE1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440982084E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQAxfxhQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbgBYOHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:07:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57636 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725788AbgBYOHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582639623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nsLsuFeIQPYcnkAa/VDzmAJLH88gjRW8GgyCncxisZ4=;
        b=IQAxfxhQedse0fMW8pb2e+3TJrYdaciwLEpYhEHz70scRi/B/Mr4FlnLEyst/PAHCQS0lI
        jBmonpQC2tqvdG8WkejA83zfhg+OT865aP2FBKVCZkSeNHsB5fbHFetrxPGLsQREjV9EbC
        lVdIHRnJ0FKct1xxAhnx8WpvtrBSprw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-F1leL3HyPj6Lhu-XYCTfbQ-1; Tue, 25 Feb 2020 09:06:59 -0500
X-MC-Unique: F1leL3HyPj6Lhu-XYCTfbQ-1
Received: by mail-wm1-f71.google.com with SMTP id p2so910444wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 06:06:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=nsLsuFeIQPYcnkAa/VDzmAJLH88gjRW8GgyCncxisZ4=;
        b=PqTwR44ySRAkOJN1EC/prFS+pU+J1RZzjD1uKTXRXiJs723xp3MV0vZVw7aFxmVE4c
         IHJEnOSs04Cvih5AuzHHoignTJXCxLPcexVML7+c3HPJyP6NRbfbZGr0t1l+y3F9lgwz
         UT49oxsrMCk5R/qDNonXqO9W+49MhOh0Y2VlG8ZQkdXYNSFQwpQgus8BW3QDdykQNVAw
         yZKQ52/JUibMMl6MJQPD8bH1KjY+Wfq4y4a2ieiT6xONXJCgV8D6Se4IQKVHIw/yXfqP
         o159jVc8k5MYIbQ8EAAtZeRjZ0VIkRii3jVlvPr7bAMSNe1sW7Oz3A0aK/SvteOdfjkF
         gy9w==
X-Gm-Message-State: APjAAAUPg/2MtNqwVH17nKoKmxDj27VubfBRjC2FkAjtzlzDp7klRr/F
        c8+5UqQ5w8+lz2jweL+cyI0QrJqg5Akp3S4jTjfOAigSWJ0ufvQPrNjfyxhcVuF5nXLyD4zc52v
        5nMX5Vv/6EWN21eHgDQU/WkKQ
X-Received: by 2002:a1c:f008:: with SMTP id a8mr5388830wmb.81.1582639618476;
        Tue, 25 Feb 2020 06:06:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqwaifqeoSZjnYk4Mg1qtEqaTG7voewFuaRxLLbNZc17nvAEuudygfkwayhsT4aeCSe1PaUqaw==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr5388814wmb.81.1582639618233;
        Tue, 25 Feb 2020 06:06:58 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id j66sm4400946wmb.21.2020.02.25.06.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 06:06:57 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 51/61] KVM: x86: Use kvm_cpu_caps to detect Intel PT support
In-Reply-To: <20200201185218.24473-52-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-52-sean.j.christopherson@intel.com>
Date:   Tue, 25 Feb 2020 15:06:56 +0100
Message-ID: <87v9nulq0v.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Check for Intel PT using kvm_cpu_cap_has() to pave the way toward
> eliminating ->pt_supported().
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index a37cb6fda979..3d287fc6eb6e 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -507,7 +507,6 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  {
>  	struct kvm_cpuid_entry2 *entry;
>  	int r, i, max_idx;
> -	unsigned f_intel_pt = kvm_x86_ops->pt_supported() ? F(INTEL_PT) : 0;
>  
>  	/* all calls to cpuid_count() should be made on the same cpu */
>  	get_cpu();
> @@ -687,7 +686,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  		break;
>  	/* Intel PT */
>  	case 0x14:
> -		if (!f_intel_pt) {
> +		if (!kvm_cpu_cap_has(X86_FEATURE_INTEL_PT)) {
>  			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
>  			break;
>  		}

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

