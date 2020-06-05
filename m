Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC6DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 17:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF69B206F0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 17:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1626IfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgFERWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 13:22:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20751 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726885AbgFERWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 13:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591377726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RuGOZnvDJQpKp0vYUjuXJhQewOvwWhd7fsqAjWE3CVg=;
        b=g1626IfHyB6QfQ0W+j8pIHCLXHFlhzLZguhdJHSt5s80+RzFrJD/SuVA2VUvOfYr8x6poO
        zBtCJX+xjFxM4SBh1LSuM+lgSDUZPnArnLYSpAD8/j+GMpyMcvCPhi/MWQupbVh7am4ESp
        iLh/RXtGURKES8zQ/Y4CZH4w4XJVudc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-AUpy80pMO8SqAQST4-oqSg-1; Fri, 05 Jun 2020 13:22:05 -0400
X-MC-Unique: AUpy80pMO8SqAQST4-oqSg-1
Received: by mail-wr1-f69.google.com with SMTP id d6so4034326wrn.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 10:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RuGOZnvDJQpKp0vYUjuXJhQewOvwWhd7fsqAjWE3CVg=;
        b=EAQTRGPGT+Fd6UtfkxYtFsL+RhKMR2Dkkv6oMgwsyr7zSTScr5vU6fkUQPtF+LZxdA
         9hlGM6u/5kph1fClo6xrZClDZc+F3Ml2jOGL/mLy39W4Iyedq5c/WqPmFQ5own4Ub8Qa
         ZNZfjld9lWcfxu6tKH4GnQGPt9MZzkj/uHsht+oWH9cqOmT2M7+IEiDkYqP8+lc5aZ7B
         hPQh5DGHOKR1z6oRXr6EzBFQcn31ckE+gnAJCz2ef3O9CmQKwKEc9kEIroST5/MD8DUY
         SQF0ZKNJmoBNBN4yuh8XhvY1L2DMOom6tguuq0j0V8n5ooCJ2cpBWwUJZqitvPhdNZV7
         QgyA==
X-Gm-Message-State: AOAM531QPffUp1AyplJjIIVlfSDmqMkMztQlLJi4xyQLYOOLQl1rtody
        AvS038/FmvXkCqZdBB/4dUbNg8ayOsLdqlWgJrfgwYRhZ2eftz7A0dk2HegGBwBsP0PeL0ct2MP
        /NhXpViEKzCruLK1ZJPmPe8zn
X-Received: by 2002:a1c:a3c5:: with SMTP id m188mr3603534wme.152.1591377724075;
        Fri, 05 Jun 2020 10:22:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5wq8gAEGIe/TueSuRhHHG/GUN8VXb01KrQUne6C0jKYAGiBSE6KmKG/6ub93AAeD3fqYx8g==
X-Received: by 2002:a1c:a3c5:: with SMTP id m188mr3603512wme.152.1591377723877;
        Fri, 05 Jun 2020 10:22:03 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.243.176])
        by smtp.gmail.com with ESMTPSA id j11sm12720518wru.69.2020.06.05.10.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 10:22:03 -0700 (PDT)
Subject: Re: [PATCH][v6] KVM: X86: support APERF/MPERF registers
To:     Jim Mattson <jmattson@google.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Li RongQing <lirongqing@baidu.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        wei.huang2@amd.com
References: <1591321466-2046-1-git-send-email-lirongqing@baidu.com>
 <b70d03dd-947f-dee5-5499-3b381372497d@intel.com>
 <72a75924-c3cb-6b23-62bd-67b739dec166@redhat.com>
 <CALMp9eSrDehftA5o6tU2sE_098F2ucztYtzhvgguYDnWqwHJaw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a1aa9cc5-96c7-11fe-17e1-22fe46b940f3@redhat.com>
Date:   Fri, 5 Jun 2020 19:22:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eSrDehftA5o6tU2sE_098F2ucztYtzhvgguYDnWqwHJaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/20 19:16, Jim Mattson wrote:
>>>> @@ -4930,6 +4939,11 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>>>>           kvm->arch.exception_payload_enabled = cap->args[0];
>>>>           r = 0;
>>>>           break;
>>>> +    case KVM_CAP_APERFMPERF:
>>>> +        kvm->arch.aperfmperf_mode =
>>>> +            boot_cpu_has(X86_FEATURE_APERFMPERF) ? cap->args[0] : 0;
>>> Shouldn't check whether cap->args[0] is a valid value?
>> Yes, only valid values should be allowed.
>>
>> Also, it should fail with -EINVAL if the host does not have
>> X86_FEATURE_APERFMPERF.
> Should enabling/disabling this capability be disallowed once vCPUs
> have been created?
> 

That's a good idea, yes.

Paolo

