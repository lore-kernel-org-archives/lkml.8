Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B08BC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 13:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D64FA20644
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 13:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XaIsj1Sr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgEIN2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 09:28:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40457 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726013AbgEIN2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 09:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589030928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pgV5qMXPn6nUxGDkwIRdUCv59PWTCDtCRVhIT5FCAXg=;
        b=XaIsj1SrZjx9ca4dPU/oj0VErKs+qo/5ayh1wHIOZVNY0CNvTWDvPzzyzOr42Su86+siRE
        MVaZBJNurGyJgb1KixhNMQHmhEQ70F3TH+ZScFo7wNTxewCLY9Dc6fglQxlB2jNm9BLMVF
        sCEc4eTarvZZNL9dDno3XbDGDwwbga0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-7134pw3TMBiwMAw7aBGILQ-1; Sat, 09 May 2020 09:28:46 -0400
X-MC-Unique: 7134pw3TMBiwMAw7aBGILQ-1
Received: by mail-wr1-f72.google.com with SMTP id a12so2397945wrv.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 06:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pgV5qMXPn6nUxGDkwIRdUCv59PWTCDtCRVhIT5FCAXg=;
        b=Fiuzi23GbmnBtEFkxeQyMtNCl0bo7D3LOwv0PlH+B1n56NIFD3qE48zvfD7x+lfeys
         KHBo7ET2F4BkyAI+vPS8/cr5j/hDfUrowLqbw00RrVfI453++G3sS8hVLgbdYQWAZYGu
         qXE7tRh5tTaYsoEh2eD6IXBLJ8lY85wimp6B2YTIChlXj/MgLvBFn9TwFCWnyk9uASaJ
         B7FMPbNlB+Ajv2+hdcV1vMJ639NQCL88qXYqgsdsNqTxQBuBRtkL23vRq/2f7rRjRLWd
         knbYVlTI70H3IV7ZczsmjFejztOhvps3564LmwSkA29Gy7wQuiuavUEStrYoqqzelKoE
         yJhg==
X-Gm-Message-State: AGi0PuYgy0gTpauDCTKgT3jVHtPf438ihU6GfV5eEA01snhi2QBDQ0NQ
        xI9Mm6zyyfacBSF2Hxt5C7Syr+3zaIYtcSfCR12BSxTpLiCik5GstcoFXViz4v8rYKu+8hYuB9V
        bM6tkFbi9qqEXcr3ePahFjWOj
X-Received: by 2002:a5d:66c9:: with SMTP id k9mr6288185wrw.307.1589030925672;
        Sat, 09 May 2020 06:28:45 -0700 (PDT)
X-Google-Smtp-Source: APiQypI2iks93LwOr88tUV8jDKcOHKVjqxqThuwkg1n5O41W5X1Qga1b8PVXal6PWA7BMuHirdznnQ==
X-Received: by 2002:a5d:66c9:: with SMTP id k9mr6288169wrw.307.1589030925435;
        Sat, 09 May 2020 06:28:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cb4:2b36:6750:73ce? ([2001:b07:6468:f312:1cb4:2b36:6750:73ce])
        by smtp.gmail.com with ESMTPSA id f123sm4155582wmf.44.2020.05.09.06.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 06:28:44 -0700 (PDT)
Subject: Re: [PATCH v2 8/9] KVM: x86, SVM: isolate vcpu->arch.dr6 from
 vmcb->save.dr6
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200507115011.494562-1-pbonzini@redhat.com>
 <20200507115011.494562-9-pbonzini@redhat.com> <20200507192808.GK228260@xz-x1>
 <dd8eb45b-4556-6aaa-0061-11b9124020b1@redhat.com>
 <20200508153210.GZ228260@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a0dd65bc-bfea-75b8-60d7-5060b9ee6c51@redhat.com>
Date:   Sat, 9 May 2020 15:28:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200508153210.GZ228260@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/20 17:32, Peter Xu wrote:
> On Fri, May 08, 2020 at 12:33:57AM +0200, Paolo Bonzini wrote:
>> On 07/05/20 21:28, Peter Xu wrote:
>>>> -	svm->vcpu.arch.dr6 = dr6;
>>>> +	WARN_ON(svm->vcpu.arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT);
>>>> +	svm->vcpu.arch.dr6 &= ~(DR_TRAP_BITS | DR6_RTM);
>>>> +	svm->vcpu.arch.dr6 |= dr6 & ~DR6_FIXED_1;
>>> I failed to figure out what the above calculation is going to do... 
>>
>> The calculation is merging the cause of the #DB with the guest DR6.
>> It's basically the same effect as kvm_deliver_exception_payload.
> 
> Shall we introduce a helper for both kvm_deliver_exception_payload and here
> (e.g. kvm_merge_dr6)?  Also, wondering whether this could be a bit easier to
> follow by defining:

It would make sense indeed but I plan to get rid of this in 5.9 (so in
about a month), as explained in the comment.

Paolo

