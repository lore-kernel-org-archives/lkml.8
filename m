Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BC8C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2615C2082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7po4bhm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgBEOhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:37:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40769 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726579AbgBEOhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580913458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jWlvFwUdUv+RENWF5c/fy1loseX2NrAzZ8YGZViIh9Q=;
        b=J7po4bhmcVl7DksZUjYu+Yh8mc45+NiKXs4ySOnWO7F4Cw0Bp7gZJIuwEl58MY45xcT2ar
        ln5CGU9IG0tvR3MteV7pmT2RDhIM5C43+RrT1j77moDPpTB/xDlkpFr8F8zLDtd6I7Qrlb
        dDTg3IYB58iH5jVza899k0QTK3T/4sU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-IHFcd2UFNY61aJraZBkQIg-1; Wed, 05 Feb 2020 09:37:20 -0500
X-MC-Unique: IHFcd2UFNY61aJraZBkQIg-1
Received: by mail-wm1-f71.google.com with SMTP id m21so910221wmg.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 06:37:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jWlvFwUdUv+RENWF5c/fy1loseX2NrAzZ8YGZViIh9Q=;
        b=tyaGxIWjq9F56L9R4eR8Xou9QsQuzbMbEuhKJtK0OkRzYiqJ9cxf+umCEKQcJzYdRS
         GWp/9qtYBfiSsisOxmWxwq/Uk5uooUApdPNxwBSvDNNwO1vzmdCYGdzAdvDOmeXwCebn
         OgL0r52S7GrABC632MxCwiWRiTEkP/UyfkdxTrqXzKDUVFc4tFFOhxpkAyQD0i4VKpx9
         N/s4cITtEimtV4IQMdqO58I/87kLwaFWu75D2aWN770L/LhoBYGlAetUsknpMw6eoI+m
         NEAw2TQULrTD65v2jkx8uJhUvc6aTNbVlySCLbHUSdhG4sSZiDHmIvH6xhbPCQQcVViL
         4A4Q==
X-Gm-Message-State: APjAAAV2LwVZ+gjNkh23BNFHG46VeHXWX4u0ZfosE/0Ez+eXQSYiAu3S
        0La93qGq/+cGWKNg3dJAudwl85SQXLRJyLSfAGdFX+5QofixubOozLTcbVcKZVS2GJyWQuOwOlv
        HyVi8tf9N/B4qIHDLdsmqAqWz
X-Received: by 2002:a5d:6144:: with SMTP id y4mr28122019wrt.367.1580913439820;
        Wed, 05 Feb 2020 06:37:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqzDnnQbP+VZROCaAZ6agojL2psHiA+jWmvjshHhDZUxQyLaSpAQAtfLUiTomj0vKySe4pbwqg==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr28122006wrt.367.1580913439652;
        Wed, 05 Feb 2020 06:37:19 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id g128sm8208807wme.47.2020.02.05.06.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 06:37:19 -0800 (PST)
Subject: Re: [PATCH 2/3] kvm: mmu: Separate generating and setting mmio ptes
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ben Gardon <bgardon@google.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20200203230911.39755-1-bgardon@google.com>
 <20200203230911.39755-2-bgardon@google.com>
 <87sgjpkve2.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1a920cd0-530b-f380-a81a-da7cc6969f3e@redhat.com>
Date:   Wed, 5 Feb 2020 15:37:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87sgjpkve2.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/20 14:37, Vitaly Kuznetsov wrote:
>> +static void mark_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, u64 gfn,
>> +			   unsigned int access)
>> +{
>> +	u64 mask = make_mmio_spte(vcpu, gfn, access);
>> +	unsigned int gen = get_mmio_spte_generation(mask);
>> +
>> +	access = mask & ACC_ALL;
>> +
>>  	trace_mark_mmio_spte(sptep, gfn, access, gen);
> 'access' and 'gen' are only being used for tracing, would it rather make
> sense to rename&move it to the newly introduced make_mmio_spte()? Or do
> we actually need tracing for both?

You would have the same issue with sptep.

> Also, I dislike re-purposing function parameters.

Yes, "trace_mark_mmio_spte(sptep, gfn, mask & ACC_ALL, gen);" is
slightly better.

Paolo

