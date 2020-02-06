Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F82EC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DAE22464
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXK8N1Dp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgBFPY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:24:59 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59293 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727944AbgBFPYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:24:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581002694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VDikhD16Evvn1Sryhm3WQZr7k9nYSi7+3qLuDWiD+FI=;
        b=MXK8N1DprrE3kZJjg9zYnPcprnIFyquLHGkk9w1oN9z76bUOxTGHArE2HSdjjn8YlixEow
        K6VLbADpAP48xy8smru6Cg0EShPfeYlh2koAlCtbOoRr8Z3vWXPYGJw+u0Dvx+npeHcR3n
        PKaeTGASHtq64JbzMVLnZivbQcrTDfo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-4R0Oml9PNNWJsmVctskRKQ-1; Thu, 06 Feb 2020 10:24:51 -0500
X-MC-Unique: 4R0Oml9PNNWJsmVctskRKQ-1
Received: by mail-wr1-f69.google.com with SMTP id l1so3605553wrt.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 07:24:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VDikhD16Evvn1Sryhm3WQZr7k9nYSi7+3qLuDWiD+FI=;
        b=YlqpK2GaC3JbTozMdhiRgKaFjOzDFR7PQxNFUXZeXsb3CDIaDONGzXPbydMsMLhWXs
         1R369qrXlTMUzWRdO5+VdyUFCzSqcJyRBzsU31UQAX4txTIJExGyu4sVTq0IKCfZWHO+
         6PbSXbpUokmWYcBeVCbHsG7ygUW8Emr5WFHlL0Mhg8ptZS1fDWda8U8B2Eq8AK/7mRnp
         +EWBf/doTlYPIUKJJFT2+7ZvCpYeGtSwGsWg/TOGfhNXJ4YcRwKpvkPkNlz66ZiCFFAO
         rP9jIB41FTEKdwdniy/yg6nfA9nt74ResoV9GXUNiUm8eRBEVb0LI2TDRqRkjY5VWw/J
         Sr+A==
X-Gm-Message-State: APjAAAVakGLFGbPe4WGU+FqgQM6UlT9fS/N3kZJXdMCQB8Ez3zA2/b9s
        vtV5Kygjz6nKz24yTtbvQ9nzpJHnbJmgoRQ4hr6u11EiGSGOL4BKYpR/u1bt6jbzPjn1MQswBpy
        1IH6vaExkwZLt529x4aDh415v
X-Received: by 2002:a5d:5706:: with SMTP id a6mr4360395wrv.108.1581002690141;
        Thu, 06 Feb 2020 07:24:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqyDfgeM519VoXEHCNZuvgRVP3rjGryo/TbI5trM9zUhz8/cXUgb/b8aGM99u2lpQAJWzti+PA==
X-Received: by 2002:a5d:5706:: with SMTP id a6mr4360377wrv.108.1581002689876;
        Thu, 06 Feb 2020 07:24:49 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w7sm3991741wmi.9.2020.02.06.07.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 07:24:49 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 05/61] KVM: x86: Check userapce CPUID array size after validating sub-leaf
In-Reply-To: <20200201185218.24473-6-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-6-sean.j.christopherson@intel.com>
Date:   Thu, 06 Feb 2020 16:24:48 +0100
Message-ID: <87k14zg2m7.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Verify that the next sub-leaf of CPUID 0x4 (or 0x8000001d) is valid
> before rejecting the entire KVM_GET_SUPPORTED_CPUID due to insufficent
> space in the userspace array.
>
> Note, although this is technically a bug, it's not visible to userspace
> as KVM_GET_SUPPORTED_CPUID is guaranteed to fail on KVM_CPUID_SIGNATURE,
> which is hardcoded to be added after the affected leafs.  The real
> motivation for the change is to tightly couple the nent/maxnent and
> do_host_cpuid() sequences in preparation for future cleanup.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 11d5f311ef10..e5cf1e0cf84a 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -552,12 +552,12 @@ static inline int __do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 function,
>  
>  		/* read more entries until cache_type is zero */
>  		for (i = 1; ; ++i) {
> -			if (*nent >= maxnent)
> -				goto out;
> -
>  			cache_type = entry[i - 1].eax & 0x1f;
>  			if (!cache_type)
>  				break;
> +
> +			if (*nent >= maxnent)
> +				goto out;
>  			do_host_cpuid(&entry[i], function, i);
>  			++*nent;
>  		}

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

