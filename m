Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4B9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D987E20702
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNQnKP4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbgGAMoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:44:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57493 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729959AbgGAMoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593607459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=riQxZ5rhfq+xTLDrKWBK+2YUUfRaxcLTVz5p24IUk7M=;
        b=KNQnKP4bZX5ip8QxMTRT510a0Owrw0CX5cpBTpDOMgNgooqMHlQ6USrqUwzMk3+L7xveCs
        gIO9KeeIfgESXWw1vRMjb83ThR5fMZSlI261RicfyvJA1BObWf/t7v1O5I+aRgN1/iJZvn
        /xe9a2FQe474rsHwnwp/hkv54I+rWHw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-7qe1mhN3MEm2Cat7hA70tw-1; Wed, 01 Jul 2020 08:44:17 -0400
X-MC-Unique: 7qe1mhN3MEm2Cat7hA70tw-1
Received: by mail-ej1-f70.google.com with SMTP id op28so13671586ejb.15
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 05:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=riQxZ5rhfq+xTLDrKWBK+2YUUfRaxcLTVz5p24IUk7M=;
        b=EZLVLw2TLe1C8CPTpP8PiisJbkwragYSUPvH1xb5pOI9gJS1JLbNhEXCfwuOygFOMi
         FPvMnJF7eM5n6JuCbTM9BTMldETFqwQeN0GF/DYJqsrDveEPx6jJmcn9UZ2s0W8F4+UU
         7MTmlu+OvcdL0liSYG9/u8S0zaihTbmdaCyCk9BbSCfGUpAnwf3gBWR1orrjd7lcHuuD
         Q5PmLGyKkxKBDevpvhksULR58r2NDA8sV6nQPnjDzaRty8ih6qvz9Ff+Q5mXHvZzrL2K
         copy6oDkdAbL58PI4Z7MK2Dh6ivl52tHev9UP9YbIzs8DewiWJStKa4rBppNaBMXM59o
         iNeg==
X-Gm-Message-State: AOAM5339AIGWh49JTMxKGKbBboWaIP0GB2IfftCusYCEjLOa7vOHyXfX
        ZBpcIMS2jyZVxDTeqZDEDrIwymAPwSqSBxT/gE3mcdVg+Je3bZOiUtg1Vvv5Et+R6f2R7AKCOu6
        peEb37pCDn8/OY5NAsDJVtSed
X-Received: by 2002:a05:6402:31ba:: with SMTP id dj26mr22401324edb.181.1593607455471;
        Wed, 01 Jul 2020 05:44:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlhs2/hMdT+AuIFl2+vhvO3qechJDVg98Gz7ZMissArc72TZWdEtQtZ/ZYXN935osYIJZjfg==
X-Received: by 2002:a05:6402:31ba:: with SMTP id dj26mr22401299edb.181.1593607455292;
        Wed, 01 Jul 2020 05:44:15 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id c18sm4595965eja.59.2020.07.01.05.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 05:44:13 -0700 (PDT)
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
In-Reply-To: <0159554d-82d5-b388-d289-a5375ca91323@intel.com>
References: <20200628085341.5107-1-chenyi.qiang@intel.com> <20200628085341.5107-3-chenyi.qiang@intel.com> <878sg3bo8b.fsf@vitty.brq.redhat.com> <0159554d-82d5-b388-d289-a5375ca91323@intel.com>
Date:   Wed, 01 Jul 2020 14:44:09 +0200
Message-ID: <87366bbe1y.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 7/1/2020 5:04 PM, Vitaly Kuznetsov wrote:
>> Chenyi Qiang <chenyi.qiang@intel.com> writes:
> [...]
>>>   static const int kvm_vmx_max_exit_handlers =
>>> @@ -6830,6 +6838,13 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
>>>   	if (unlikely(vmx->exit_reason.failed_vmentry))
>>>   		return EXIT_FASTPATH_NONE;
>>>   
>>> +	/*
>>> +	 * check the exit_reason to see if there is a bus lock
>>> +	 * happened in guest.
>>> +	 */
>>> +	if (vmx->exit_reason.bus_lock_detected)
>>> +		handle_bus_lock(vcpu);
>> 
>> In case the ultimate goal is to have an exit to userspace on bus lock,
>
> I don't think we will need an exit to userspace on bus lock. See below.
>
>> the two ways to reach handle_bus_lock() are very different: in case
>> we're handling EXIT_REASON_BUS_LOCK we can easily drop to userspace by
>> returning 0 but what are we going to do in case of
>> exit_reason.bus_lock_detected? The 'higher priority VM exit' may require
>> exit to userspace too. So what's the plan? Maybe we can ignore the case
>> when we're exiting to userspace for some other reason as this is slow
>> already and force the exit otherwise? 
>
>> And should we actually introduce
>> the KVM_EXIT_BUS_LOCK and a capability to enable it here?
>> 
>
> Introducing KVM_EXIT_BUS_LOCK maybe help nothing. No matter 
> EXIT_REASON_BUS_LOCK or exit_reason.bus_lock_detected, the bus lock has 
> already happened. Exit to userspace cannot prevent bus lock, so what 
> userspace can do is recording and counting as what this patch does in 
> vcpu->stat.bus_locks.

Exiting to userspace would allow to implement custom 'throttling'
policies to mitigate the 'noisy neighbour' problem. The simplest would
be to just inject some sleep time.

-- 
Vitaly

