Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274F7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01F732076A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijCxRGKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgGJRkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:40:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41432 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727065AbgGJRkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594402814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/IkQPdXSHaUMhvBTo4/ZFo40yEF0ln1C5QCttyzLIBw=;
        b=ijCxRGKxqaOvCvELg3qGBYj5m07pSfSDlIxK6ax6CJcl87q51BEJRE/2VolWrpEpDaB31y
        cJOdUkamApe5IEkdgdQFntsK7X2ilEgIrXQSQ2Ill7jKMz55ETOnli1nvsx8vPP0QJZZeF
        X3MVsrvKG8vK9nJqCkZAX4XYFYe1PLg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-yu7xFYdIMZat8vc-LrboQg-1; Fri, 10 Jul 2020 13:40:12 -0400
X-MC-Unique: yu7xFYdIMZat8vc-LrboQg-1
Received: by mail-wm1-f70.google.com with SMTP id 65so7400518wmd.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/IkQPdXSHaUMhvBTo4/ZFo40yEF0ln1C5QCttyzLIBw=;
        b=QmwwcVyUrmNGvcMPOa4Fv1AOYa6c3w/j5au5hQ9kpXQdm+tpeY7n4lTNqxFYvaLWkH
         exlxyNdao/8iakNgtt3FLa/pJMcEQA57gKLczsjWrluiEyWOMZY+Wnli6NLCEmKB6o9b
         7J5mPpHOafBQstGJAcbFoD1xVdkoHvKHiF6F7BXI2x0Z5SGaNxbRKngdGNtdmb0G+ZGf
         0XTw2YKes6zFmRL8+e+mNMRQyRC7nSZHbmkzyRb3ed3xEn5fdqB4kdj2zrGoE0ElZOUO
         0eywZRDoMDp7snKXAU6cqzZF5FDI3yRjbhUKxfPnRgU5v0HtqXKCKZCCtjzB7ff0FuSM
         4BmA==
X-Gm-Message-State: AOAM533paZ/pZr9Jjp+hWeQifsqo4h8Z3M+f377nYQPgtBJGTICwljHK
        PRGzgoGUnxtbsgc0nx8n+GloA+Azd0+DrgpdyuZVsPNooJ5wZysN9ullfYrlzyVUYKB5wQooM7k
        aFApsIaxXw4rg3RMWis/ItX5O
X-Received: by 2002:adf:f209:: with SMTP id p9mr65624120wro.86.1594402811225;
        Fri, 10 Jul 2020 10:40:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgdBFsI6NpM0cOEYE9Zd0CxeHVbzpJqrUECEdskVqorMpkRotRA6xd/OKf7+5nsRvVTo8ujA==
X-Received: by 2002:adf:f209:: with SMTP id p9mr65624106wro.86.1594402811022;
        Fri, 10 Jul 2020 10:40:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id c15sm10333052wme.23.2020.07.10.10.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 10:40:10 -0700 (PDT)
Subject: Re: [PATCH v3 0/9] KVM: Support guest MAXPHYADDR < host MAXPHYADDR
To:     Jim Mattson <jmattson@google.com>
Cc:     Mohammed Gamal <mgamal@redhat.com>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20200710154811.418214-1-mgamal@redhat.com>
 <CALMp9eRfZ50iyrED0-LU75VWhHu_kVoB2Qw55VzEFzZ=0QCGow@mail.gmail.com>
 <0c892b1e-6fe6-2aa7-602e-f5fadc54c257@redhat.com>
 <CALMp9eQXHGnXo4ACX2-qYww4XdRODMn-O6CAvhupib67Li9S2w@mail.gmail.com>
 <9e784c62-15ee-63b7-4942-474493bac536@redhat.com>
 <CALMp9eRGTedw-wNL4HcrJOpAQBa_Qsqcir0BtJ-dEO6EhvWGqA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5d9e2483-81ba-1d94-5324-08245ced7d0e@redhat.com>
Date:   Fri, 10 Jul 2020 19:40:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eRGTedw-wNL4HcrJOpAQBa_Qsqcir0BtJ-dEO6EhvWGqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/20 19:26, Jim Mattson wrote:
>> Intel only has MAXPHYADDR > 46 on LA57 machines (because in general OSes
>> like to have a physical 1:1 map into the kernel part of the virtual
>> address space, so having a higher MAXPHYADDR would be of limited use
>> with 48-bit linear addresses).
> We all know that the direct map is evil. :-)
> 
> Sorry it took me so long to get there. I didn't realize that Linux was
> incapable of using more physical memory than it could map into the
> kernel's virtual address space. (Wasn't that the whole point of PAE
> originally?)

Yes, but it's so slow that Linux preferred not to go that way for 64-bit
kernels.

That said, that justification for MAXPHYADDR==46 came from Intel
processor architects, and when they say "OSes" they usually refer to a
certain vendor from the Pacific north-west.

Paolo

