Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC550C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCAC3206BE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VAXJoyh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731627AbgGAOt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 10:49:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48115 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731039AbgGAOt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 10:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593614995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VfENiHNRnwNDgfhjH2onCnBOkQjCEWTV+c8v5VnSwKY=;
        b=VAXJoyh3HUqwMTqJTzlH/sK6sg6JQwIeW7/UjkTdYY4vnByGAcSMw+BMMCHrOJtHOyjW+N
        2Xoe8myinWbIOMTImY11pPjm7gROUVl/vDBQCqD0PQVkNsw8TcKUufSdzGsqmaSrXyBWhk
        PMUw646pG+kw4NB0XgXMWw5zjKFq/y4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-9eIput8GOCWexlF-w2gYNg-1; Wed, 01 Jul 2020 10:49:53 -0400
X-MC-Unique: 9eIput8GOCWexlF-w2gYNg-1
Received: by mail-ej1-f71.google.com with SMTP id g6so15712301ejo.18
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 07:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VfENiHNRnwNDgfhjH2onCnBOkQjCEWTV+c8v5VnSwKY=;
        b=npvo35BgpSTPCfm6Y12/Br967j2BU63nTqmN0cMVFKA2730Z955e25Wis7VOY4oz93
         WHhE8rYLg7qkMB5MOKAJD8Z6Gybeul9AbxSSZhgPZUkFk9nCNyrquzLBbV7tFpm/ix2h
         ngsydPB/i3LjC6lFemLpHGkmVhrlO5eBk133DFQoxcUDs47vhwIC30CKuc2Nb00mB4yT
         YA0BePQuKXnZmv+Zf7hYr79iCCBEwBRpuu1zFXgcO9vZGn9DyJpcp7mdDLuKFWPzDSx/
         zrus8QgWafuOfBIE+lYbF0BqVG8aB0Hvn+fuRkMHOHcHs61n0JA9bbEXQkztxYPLavXP
         McVg==
X-Gm-Message-State: AOAM530N7XTqpXuoxJdzPgmA0EL7FNKzygICzAVTEDmMzR/4vzSFdPnJ
        yBJpmAMBWa4jaGqHPTXbiJqPC8ag7eyxSij7vNJ/blhFhH41eucGwjtjUy8ucJtc4IaHpdVd4Tn
        YBWR9jCK5ZCXASIUw/u1cT0Zh
X-Received: by 2002:a17:906:4f87:: with SMTP id o7mr22886626eju.233.1593614991816;
        Wed, 01 Jul 2020 07:49:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFsmocBW6sUuPzil85gcSE/fWsfuLfnmCtOnoI7ei4G309ht7jv4kcRD+SnbqzFh2OzQabFg==
X-Received: by 2002:a17:906:4f87:: with SMTP id o7mr22886610eju.233.1593614991615;
        Wed, 01 Jul 2020 07:49:51 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id z25sm4831346ejd.38.2020.07.01.07.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 07:49:50 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Chenyi Qiang <chenyi.qiang@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC 2/2] KVM: VMX: Enable bus lock VM exit
In-Reply-To: <adad61e8-8252-0491-7feb-992a52c1b4f3@intel.com>
References: <20200628085341.5107-1-chenyi.qiang@intel.com> <20200628085341.5107-3-chenyi.qiang@intel.com> <878sg3bo8b.fsf@vitty.brq.redhat.com> <0159554d-82d5-b388-d289-a5375ca91323@intel.com> <87366bbe1y.fsf@vitty.brq.redhat.com> <adad61e8-8252-0491-7feb-992a52c1b4f3@intel.com>
Date:   Wed, 01 Jul 2020 16:49:49 +0200
Message-ID: <87zh8j9to2.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 7/1/2020 8:44 PM, Vitaly Kuznetsov wrote:
>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>> 
>>> On 7/1/2020 5:04 PM, Vitaly Kuznetsov wrote:
>>>> Chenyi Qiang <chenyi.qiang@intel.com> writes:
>>> [...]
>>>>>    static const int kvm_vmx_max_exit_handlers =
>>>>> @@ -6830,6 +6838,13 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
>>>>>    	if (unlikely(vmx->exit_reason.failed_vmentry))
>>>>>    		return EXIT_FASTPATH_NONE;
>>>>>    
>>>>> +	/*
>>>>> +	 * check the exit_reason to see if there is a bus lock
>>>>> +	 * happened in guest.
>>>>> +	 */
>>>>> +	if (vmx->exit_reason.bus_lock_detected)
>>>>> +		handle_bus_lock(vcpu);
>>>>
>>>> In case the ultimate goal is to have an exit to userspace on bus lock,
>>>
>>> I don't think we will need an exit to userspace on bus lock. See below.
>>>
>>>> the two ways to reach handle_bus_lock() are very different: in case
>>>> we're handling EXIT_REASON_BUS_LOCK we can easily drop to userspace by
>>>> returning 0 but what are we going to do in case of
>>>> exit_reason.bus_lock_detected? The 'higher priority VM exit' may require
>>>> exit to userspace too. So what's the plan? Maybe we can ignore the case
>>>> when we're exiting to userspace for some other reason as this is slow
>>>> already and force the exit otherwise?
>>>
>>>> And should we actually introduce
>>>> the KVM_EXIT_BUS_LOCK and a capability to enable it here?
>>>>
>>>
>>> Introducing KVM_EXIT_BUS_LOCK maybe help nothing. No matter
>>> EXIT_REASON_BUS_LOCK or exit_reason.bus_lock_detected, the bus lock has
>>> already happened. Exit to userspace cannot prevent bus lock, so what
>>> userspace can do is recording and counting as what this patch does in
>>> vcpu->stat.bus_locks.
>> 
>> Exiting to userspace would allow to implement custom 'throttling'
>> policies to mitigate the 'noisy neighbour' problem. The simplest would
>> be to just inject some sleep time.
>> 
>
> So you want an exit to userspace for every bus lock and leave it all to 
> userspace. Yes, it's doable.
>

In some cases we may not even want to have a VM exit: think
e.g. real-time/partitioning case when even in case of bus lock we may
not want to add additional latency just to count such events. I'd
suggest we make the new capability tri-state:
- disabled (no vmexit, default)
- stats only (what this patch does)
- userspace exit
But maybe this is an overkill, I'd like to hear what others think.

> As you said, the exit_reason.bus_lock_detected case is the tricky one. 
> We cannot do the similar to extend vcpu->run->exit_reason, this breaks 
> ABI. Maybe we can extend the vcpu->run->flags to indicate bus lock 
> detected for the other exit reason?

This is likely the easiest solution.

-- 
Vitaly

