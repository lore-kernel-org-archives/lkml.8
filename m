Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EB3C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A92DB21D91
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ID5DZtvH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442659AbgDPP4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:56:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59613 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2442746AbgDPP4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587052561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nvu+MW6oZUAc4Rt+d0KHMjWiSPVqXx7NpVhFclBCSuA=;
        b=ID5DZtvH9sTXEpFaffj3HRg4lfpKkzt5Eql5S3WZluccUKLn/MODDhQWE18HIm5N2+o4W6
        asQly0N2VAinsyOyxwMOkrAU2pfROdRYIjOTof9z9sYOK4B87LKnuPmwemuOcnsvGp8xcS
        DnzXGw1KxO02JWd4zJwfczZdXbSCFPY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-Zc0gFejYOlal_U7CHfHI0w-1; Thu, 16 Apr 2020 11:55:59 -0400
X-MC-Unique: Zc0gFejYOlal_U7CHfHI0w-1
Received: by mail-wr1-f70.google.com with SMTP id s11so1944920wru.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nvu+MW6oZUAc4Rt+d0KHMjWiSPVqXx7NpVhFclBCSuA=;
        b=bYdNGt/Nc8XstAMOxr+ITvh8rpAg7enoOBy5jeI3mNQbCJDe73fvh2hG05rmgp+iln
         97xVPK5uNS62SbGMvJJic1LvmAEzrigp1R7fm/Inwuw95aYAR7UCvGhoxSV2sV5rPey2
         E9NAPaWYU7TkXSniKUcla4/Zfk8C+/ou9RPb2m81sjDFsbj2A5FrFNNP0iH9LjbDgcOU
         +vkAshsAqexLA0+9MZ3VsQnNzXNcq8cUT38d9f8QyjHfT9p5BTyOzNPHJfrlVC+Ndklk
         /hJWeEOW1scg384s7YjKFD9DJNmm8tmXPH5JjOf4FzoMqrbadTBdcwUvLKPt//aalg42
         5HEQ==
X-Gm-Message-State: AGi0PuZR7wBQy9zzbiuvvNz3uhJ/Ph/A+VEDYk8CDKOKLxBDHmeYhroE
        INW3UHzc1fbVbTGwuE4isSkFBskZII2Bydaeq0siodl64AMnpH7mW8CnBztAQEbFYvS0F/AkB0O
        KULNaMS7/ONTs6KwmDyGmmXP9
X-Received: by 2002:a5d:4442:: with SMTP id x2mr18151632wrr.101.1587052558411;
        Thu, 16 Apr 2020 08:55:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypIL1Ng21KPZXq7/mqYvYnYksD3lb24Jyd1BsaIZ28zHv5VGpa6h6z5Fa+Khf5lPYqGvRQv9/g==
X-Received: by 2002:a5d:4442:: with SMTP id x2mr18151609wrr.101.1587052558056;
        Thu, 16 Apr 2020 08:55:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:399d:3ef7:647c:b12d? ([2001:b07:6468:f312:399d:3ef7:647c:b12d])
        by smtp.gmail.com with ESMTPSA id 5sm4231405wmg.34.2020.04.16.08.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 08:55:57 -0700 (PDT)
Subject: Re: [PATCH v2] KVM/arm64: Support enabling dirty log gradually in
 small chunks
To:     Marc Zyngier <maz@kernel.org>
Cc:     Keqian Zhu <zhukeqian1@huawei.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jay Zhou <jianjay.zhou@huawei.com>, wanghaibin.wang@huawei.com
References: <20200413122023.52583-1-zhukeqian1@huawei.com>
 <be45ec89-2bdb-454b-d20a-c08898e26024@redhat.com>
 <20200416160939.7e9c1621@why>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <442f288e-2934-120c-4994-5357e3e9216b@redhat.com>
Date:   Thu, 16 Apr 2020 17:55:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200416160939.7e9c1621@why>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/20 17:09, Marc Zyngier wrote:
> On Wed, 15 Apr 2020 18:13:56 +0200
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
>> On 13/04/20 14:20, Keqian Zhu wrote:
>>> There is already support of enabling dirty log graually in small chunks
>>> for x86 in commit 3c9bd4006bfc ("KVM: x86: enable dirty log gradually in
>>> small chunks"). This adds support for arm64.
>>>
>>> x86 still writes protect all huge pages when DIRTY_LOG_INITIALLY_ALL_SET
>>> is eanbled. However, for arm64, both huge pages and normal pages can be
>>> write protected gradually by userspace.
>>>
>>> Under the Huawei Kunpeng 920 2.6GHz platform, I did some tests on 128G
>>> Linux VMs with different page size. The memory pressure is 127G in each
>>> case. The time taken of memory_global_dirty_log_start in QEMU is listed
>>> below:
>>>
>>> Page Size      Before    After Optimization
>>>   4K            650ms         1.8ms
>>>   2M             4ms          1.8ms
>>>   1G             2ms          1.8ms
>>>
>>> Besides the time reduction, the biggest income is that we will minimize
>>> the performance side effect (because of dissloving huge pages and marking
>>> memslots dirty) on guest after enabling dirty log.
>>>
>>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>>> ---
>>>  Documentation/virt/kvm/api.rst    |  2 +-
>>>  arch/arm64/include/asm/kvm_host.h |  3 +++
>>>  virt/kvm/arm/mmu.c                | 12 ++++++++++--
>>>  3 files changed, 14 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>>> index efbbe570aa9b..0017f63fa44f 100644
>>> --- a/Documentation/virt/kvm/api.rst
>>> +++ b/Documentation/virt/kvm/api.rst
>>> @@ -5777,7 +5777,7 @@ will be initialized to 1 when created.  This also improves performance because
>>>  dirty logging can be enabled gradually in small chunks on the first call
>>>  to KVM_CLEAR_DIRTY_LOG.  KVM_DIRTY_LOG_INITIALLY_SET depends on
>>>  KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE (it is also only available on
>>> -x86 for now).
>>> +x86 and arm64 for now).
>>>  
>>>  KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 was previously available under the name
>>>  KVM_CAP_MANUAL_DIRTY_LOG_PROTECT, but the implementation had bugs that make
>>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>>> index 32c8a675e5a4..a723f84fab83 100644
>>> --- a/arch/arm64/include/asm/kvm_host.h
>>> +++ b/arch/arm64/include/asm/kvm_host.h
>>> @@ -46,6 +46,9 @@
>>>  #define KVM_REQ_RECORD_STEAL	KVM_ARCH_REQ(3)
>>>  #define KVM_REQ_RELOAD_GICv4	KVM_ARCH_REQ(4)
>>>  
>>> +#define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
>>> +				     KVM_DIRTY_LOG_INITIALLY_SET)
>>> +
>>>  DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
>>>  
>>>  extern unsigned int kvm_sve_max_vl;
>>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>>> index e3b9ee268823..1077f653a611 100644
>>> --- a/virt/kvm/arm/mmu.c
>>> +++ b/virt/kvm/arm/mmu.c
>>> @@ -2265,8 +2265,16 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>>>  	 * allocated dirty_bitmap[], dirty pages will be be tracked while the
>>>  	 * memory slot is write protected.
>>>  	 */
>>> -	if (change != KVM_MR_DELETE && mem->flags & KVM_MEM_LOG_DIRTY_PAGES)
>>> -		kvm_mmu_wp_memory_region(kvm, mem->slot);
>>> +	if (change != KVM_MR_DELETE && mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
>>> +		/*
>>> +		 * If we're with initial-all-set, we don't need to write
>>> +		 * protect any pages because they're all reported as dirty.
>>> +		 * Huge pages and normal pages will be write protect gradually.
>>> +		 */
>>> +		if (!kvm_dirty_log_manual_protect_and_init_set(kvm)) {
>>> +			kvm_mmu_wp_memory_region(kvm, mem->slot);
>>> +		}
>>> +	}
>>>  }
>>>  
>>>  int kvm_arch_prepare_memory_region(struct kvm *kvm,
>>>   
>>
>> Marc, what is the status of this patch?
> 
> I just had a look at it. Is there any urgency for merging it?

No, I thought I was still replying to the v1.

Paolo

