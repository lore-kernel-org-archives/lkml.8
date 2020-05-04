Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C225C4724C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32A2F206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Il1J6gnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgEDQ5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 12:57:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57159 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729669AbgEDQ5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 12:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588611426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cA54hjMXQwu2Lvqq0IfxR+bA86FjlLo/DYJm0KvwWBE=;
        b=Il1J6gnYJXJPNlNFmIuYFatwT8uMd6xX3sqyDhrTEPs9Wpka8Y/78EoglEBkup0cMGMtNV
        gVPIW8uicDpx4rArlUXAyUiuH0UiUNzICG5lDoEbiRfr6SZ7Z7egn56ynfxrQYN62O5q07
        l4zjD+ObpIGScEkxgTuSoJbGlb6nDnQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-ff3kMVPiOB-mnP4FWqbJCQ-1; Mon, 04 May 2020 12:57:04 -0400
X-MC-Unique: ff3kMVPiOB-mnP4FWqbJCQ-1
Received: by mail-wm1-f72.google.com with SMTP id u11so104816wmc.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 09:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cA54hjMXQwu2Lvqq0IfxR+bA86FjlLo/DYJm0KvwWBE=;
        b=PKB1ycCfl6agmqcyGaDb774ggFYXdh4grjb/0jns7VjE4wb8kV4hxay7O23ieoSiGq
         cY+D4TuB29BTyr1CFP4o6CBOyij5qlYIH4fEEDUuPHf8yPVetUFuEAMZL5GTM/MdyArd
         cq7t+m7p3/gtWCGQKuxOvt76xbmzXkLHG/vc5TXxzql7X+LYmQqRKH/i1JMAXDgWHSz3
         gpriDPrOlmI10hcpamWuXrU2L3FWz6oZCv+3kxz65Jydi9SY+kR4c/I7QB+aPQlrab6D
         Rr+k0mzEoKi4/PSesjmC/RRiHJOyUG6iPuA7DVIw0f78u8bfsJsPo8Qd2JIqnXAVNTJQ
         1MJQ==
X-Gm-Message-State: AGi0PuZRLtzjGv7EeLSvczm+Eo0EQGkRkM1yhIB44n+m0K9jZIA9Zl6G
        kbPF8RrONHk/jdLZoScw8YgxofaA8Z8kGrtL3hphugmx9DiqFkPGl91XIOg7AfX/4oF/PKVzx+k
        rjp+NY8uYlFoe5sJ/eEuHFeYb
X-Received: by 2002:a1c:7416:: with SMTP id p22mr16405977wmc.80.1588611422615;
        Mon, 04 May 2020 09:57:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypLfpkBvwAD0WlLP09KJEHHrrBHKkgnUHm4rVDiq9YqMhWUzzIs80/IV4XB8GGW3iWPsax4ENw==
X-Received: by 2002:a1c:7416:: with SMTP id p22mr16405959wmc.80.1588611422393;
        Mon, 04 May 2020 09:57:02 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
        by smtp.gmail.com with ESMTPSA id u2sm17818146wrd.40.2020.05.04.09.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 09:57:01 -0700 (PDT)
Subject: Re: [RESEND PATCH] KVM: x86/pmu: Support full width counting
To:     Like Xu <like.xu@linux.intel.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200427071922.86257-1-like.xu@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aa182eec-3d0b-1452-19cc-20654190a2ae@redhat.com>
Date:   Mon, 4 May 2020 18:57:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200427071922.86257-1-like.xu@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/20 09:19, Like Xu wrote:
> +	if (vmx_supported_perf_capabilities())
> +		kvm_cpu_cap_check_and_set(X86_FEATURE_PDCM);

I think we can always set it, worst case it will be zero.

However, blocking intel_pmu_set_msr altogether is incorrect.  Instead,
you need to:

- list the MSR in msr_based_features_all so that it appears in
KVM_GET_MSR_FEATURE_INDEX_LIST

- return the supported bits in vmx_get_msr_feature

- allow host-initiated writes (as long as they only set supported bits)
of the MSR in intel_pmu_set_msr.

Thanks,

Paolo

