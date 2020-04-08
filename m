Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089E9C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 08:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58952075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 08:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDM3Wioe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgDHIYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 04:24:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27008 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726670AbgDHIYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 04:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586334245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V8GBvWJYx/17VO9qjtI+ZZsm46USQUPFYArvzlSyCX0=;
        b=GDM3Wioe+IW/y0fjnYWdM5yGCHwHLbtvld69sslB0AVI0f3VnFI4lXG93nRqqphJaFgIn2
        RD2Z3XvT9MHb3h2PXDtTuBJpPCJtgTsY4kJvsk/uZ/2oZNKIvAIfCPNWT22i0wKHqC6/+Z
        uOspbJF5LyR+TCpyQlE9UXgLQgn5k/I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-us2plJ9vNf6IEdOoh2NtCw-1; Wed, 08 Apr 2020 04:24:03 -0400
X-MC-Unique: us2plJ9vNf6IEdOoh2NtCw-1
Received: by mail-wr1-f70.google.com with SMTP id g6so3599998wru.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 01:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V8GBvWJYx/17VO9qjtI+ZZsm46USQUPFYArvzlSyCX0=;
        b=VOK54kuSbolQV/Rg2L4PJD3hlqmfKteek39HeoClFJqIBTqri/h08Qar0oGPV2fXON
         vS4Q2YImeiQ8Mtzo8APDUWowsjbYhg900lXAVSOkwENmPvHZhHB+n6uPavMfu7LJGc6g
         ri9baFI/V4+xes6yt0+95X45B2wii73qGnjbFmWnoQsRW9Uzi70jJLEwWylPf7RcvNSH
         gfG6cJQ4qY9+rCHVNEI7IaiGvkBvtaLuJZKIUk0AOV087jfO6/YFKvLvdC9RWtiFFb6C
         G6KtWKW6VWppJ4oSJCiwhzZg0UQQOTZ28oJeyoSr3hyZgviuDFr7qMFr348ob1YWs+M2
         ZhFQ==
X-Gm-Message-State: AGi0PuZCRLeUteHXYVBrWKngW7fOzTYF+QruhqZ3HGDkrn8iW8UcBUAo
        4Ar9zbL7RewmqX3LrwRSQHNrOoX2xtLbw4oIqNCFE8XeHj695rgoRwb5vM8U69b0srdrn+kaj5l
        /pNHKGLJyjxFMoAKOYDv+KD9J
X-Received: by 2002:a1c:7301:: with SMTP id d1mr3651747wmb.26.1586334242038;
        Wed, 08 Apr 2020 01:24:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypLRHkZKamZXG95b7dvVdIZL49HfD4EV4KT2DnjNBTmCibYNUX8cjaACuR1soo87T9jeXOkUzA==
X-Received: by 2002:a1c:7301:: with SMTP id d1mr3651721wmb.26.1586334241722;
        Wed, 08 Apr 2020 01:24:01 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id f14sm5818101wmb.3.2020.04.08.01.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 01:24:01 -0700 (PDT)
Subject: Re: [PATCH v2] x86/kvm: Disable KVM_ASYNC_PF_SEND_ALWAYS
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Vivek Goyal <vgoyal@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>, stable <stable@vger.kernel.org>
References: <20200407172140.GB64635@redhat.com>
 <772A564B-3268-49F4-9AEA-CDA648F6131F@amacapital.net>
 <87eeszjbe6.fsf@nanos.tec.linutronix.de>
 <ce81c95f-8674-4012-f307-8f32d0e386c2@redhat.com>
 <874ktukhku.fsf@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <274f3d14-08ac-e5cc-0b23-e6e0274796c8@redhat.com>
Date:   Wed, 8 Apr 2020 10:23:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <874ktukhku.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/20 01:21, Thomas Gleixner wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 07/04/20 22:20, Thomas Gleixner wrote:
>>>>> Havind said that, I thought disabling interrupts does not mask exceptions.
>>>>> So page fault exception should have been delivered even with interrupts
>>>>> disabled. Is that correct? May be there was no vm exit/entry during
>>>>> those 10 seconds and that's why.
>>> No. Async PF is not a real exception. It has interrupt semantics and it
>>> can only be injected when the guest has interrupts enabled. It's bad
>>> design.
>>
>> Page-ready async PF has interrupt semantics.
>>
>> Page-not-present async PF however does not have interrupt semantics, it
>> has to be injected immediately or not at all (falling back to host page
>> fault in the latter case).
> 
> If interrupts are disabled in the guest then it is NOT injected and the
> guest is suspended. So it HAS interrupt semantics. Conditional ones,
> i.e. if interrupts are disabled, bail, if not then inject it.

Interrupts can be delayed by TPR or STI/MOV SS interrupt window, async
page faults cannot (again, not the page-ready kind).  Page-not-present
async page faults are almost a perfect match for the hardware use of #VE
(and it might even be possible to let the processor deliver the
exceptions).  There are other advantages:

- the only real problem with using #PF (with or without
KVM_ASYNC_PF_SEND_ALWAYS) seems to be the NMI reentrancy issue, which
would not be there for #VE.

- #VE are combined the right way with other exceptions (the
benign/contributory/pagefault stuff)

- adjusting KVM and Linux to use #VE instead of #PF would be less than
100 lines of code.

Paolo

> But that does not make it an exception by any means.
> 
> It never should have been hooked to #PF in the first place and it never
> should have been named that way. The functionality is to opportunisticly
> tell the guest to do some other stuff.
> 
> So the proper name for this seperate interrupt vector would be:
> 
>    VECTOR_OMG_DOS - Opportunisticly Make Guest Do Other Stuff
> 
> and the counter part
> 
>    VECTOR_STOP_DOS - Stop Doing Other Stuff 
> 
>> So page-not-present async PF definitely needs to be an exception, this
>> is independent of whether it can be injected when IF=0.
> 
> That wants to be a straight #PF. See my reply to Andy.
> 
>> Hypervisors do not have any reserved exception vector, and must use
>> vectors up to 31, which is why I believe #PF was used in the first place
>> (though that predates my involvement in KVM by a few years).
> 
> No. That was just bad taste or something worse. It has nothing to do
> with exceptions, see above. Stop proliferating the confusion.
> 
>> These days, #VE would be a much better exception to use instead (and
>> it also has a defined mechanism to avoid reentrancy).
> 
> #VE is not going to solve anything.
> 
> The idea of OMG_DOS is to (opportunisticly) avoid that the guest (and
> perhaps host) sit idle waiting for I/O until the fault has been
> resolved. That makes sense as there might be enough other stuff to do
> which does not depend on that particular page. If not then fine, the
> guest will go idle.
> 
> Thanks,
> 
>         tglx
> 

