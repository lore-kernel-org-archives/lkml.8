Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716BFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C88B2053B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNmhToKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbgFDQV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:21:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36578 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729699AbgFDQV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591287717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IFnB5YH86FkA9ElQ2/nU7J/Gt0lAQ+ZY8dNiGTQihDo=;
        b=eNmhToKMVVaKRtUsTS6TGLqbS7jggaFIe+ODDa2eThO1lbK0jgrS34+g4JqTb2ZnJ6wsUe
        +Pp/iYIl8cnjvyglEyZT35eW+6qdDZ4EczIe6/fnczZX/9dvcakv/ZR3jpLse909heuStL
        7Ea7c4Qrn/2It3/RM8QIztlVLtq4lEc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-SynaG8d4MHKOi5F6qHHBiw-1; Thu, 04 Jun 2020 12:21:55 -0400
X-MC-Unique: SynaG8d4MHKOi5F6qHHBiw-1
Received: by mail-wr1-f70.google.com with SMTP id h6so2647237wrx.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 09:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IFnB5YH86FkA9ElQ2/nU7J/Gt0lAQ+ZY8dNiGTQihDo=;
        b=T7SxEWNf15t6pQIQjx4pfx88ujchLsM06h1FArT4PehIBiaN1gKX0YEvKtUNJkkgoy
         9hCa1xHGV5kYZrCTycC18laNbO/fea+X6fwN1brv5GmS6Ez44tJQ74QhyBzC0Yt+Bfh4
         RtmKTydBC2ae2Ewn46uJtrPLJ4ZaZTzvjDTYScGjdVzmKRR7x0S5BqCAhdNOGTjHT0dV
         KcgC8kLiJW1+sKhWluIQVGQrd0NaSGxA+5uKm1KZ8DC1u7ul/9OJgX9WpSmgDGprZDBP
         HROUvI2vG3SOgi6ekuoS4La6t1MSnzEv4udBvFU8QoxjXuXFusnZxNummnr3mt+8+swH
         Y9fA==
X-Gm-Message-State: AOAM532h2w/Pheu+Zi7adIuubLHp2JXIgc6zILuNzDfB4tBdQeAU5DqA
        xdVwn67EQdD/E/xvqJJQ7J1DJHJNzN113hiqB2Tdx753lvkJOL51/QtV5MJ7DYDnLE9GPIwtXOs
        GbnsvQytRqyQthUJHgpvpnNO8
X-Received: by 2002:a7b:c399:: with SMTP id s25mr4991227wmj.185.1591287714284;
        Thu, 04 Jun 2020 09:21:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLoi5S0xA4EpyLYB78gRmIzq6SOAKHh8FD57JzJ5oWW57P3f0077C/yNMMqKxBeCYMsxvChw==
X-Received: by 2002:a7b:c399:: with SMTP id s25mr4991205wmj.185.1591287714053;
        Thu, 04 Jun 2020 09:21:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb? ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
        by smtp.gmail.com with ESMTPSA id 62sm8888268wrm.1.2020.06.04.09.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 09:21:53 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: x86: Assign correct value to array.maxnent
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoyao Li <xiaoyao.li@intel.com>
References: <20200604041636.1187-1-xiaoyao.li@intel.com>
 <20200604151233.GC30223@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <16f6f2f6-f10a-b385-2ce1-7a3515633b43@redhat.com>
Date:   Thu, 4 Jun 2020 18:21:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200604151233.GC30223@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/20 17:12, Sean Christopherson wrote:
> On Thu, Jun 04, 2020 at 12:16:36PM +0800, Xiaoyao Li wrote:
>> Delay the assignment of array.maxnent to use correct value for the case
>> cpuid->nent > KVM_MAX_CPUID_ENTRIES.
>>
>> Fixes: e53c95e8d41e ("KVM: x86: Encapsulate CPUID entries and metadata in struct")
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>> v2:
>>    - remove "const" of maxnent to fix build error.
>> ---
>>  arch/x86/kvm/cpuid.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index 253b8e875ccd..3d88ddf781d0 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -426,7 +426,7 @@ EXPORT_SYMBOL_GPL(kvm_set_cpu_caps);
>>  
>>  struct kvm_cpuid_array {
>>  	struct kvm_cpuid_entry2 *entries;
>> -	const int maxnent;
>> +	int maxnent;
>>  	int nent;
>>  };
>>  
>> @@ -870,7 +870,6 @@ int kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
>>  
>>  	struct kvm_cpuid_array array = {
>>  		.nent = 0,
>> -		.maxnent = cpuid->nent,
>>  	};
>>  	int r, i;
>>  
>> @@ -887,6 +886,8 @@ int kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
>>  	if (!array.entries)
>>  		return -ENOMEM;
>>  
>> +	array.maxnent = cpuid->nent;
> 
> Eh, I'd vote to just do:
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 253b8e875ccd..1e5b1ee75a76 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -870,7 +870,7 @@ int kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
> 
>         struct kvm_cpuid_array array = {
>                 .nent = 0,
> -               .maxnent = cpuid->nent,
> +               .maxnent = min(cpuid->nent, (u32)KVM_MAX_CPUID_ENTRIES),
>         };
>         int r, i;
> 

Both are fine, I've queued Xiaoyao's patch.

Paolo

