Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8261CC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E31520737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TX9vN7M8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368672AbgDOMOW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:14:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57638 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S368585AbgDOMLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 08:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586952703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3g8pOUWTOZg7Xu60Mt7A1x/Ov3i7r+YKQXs6UW5HczM=;
        b=TX9vN7M8wNoXIs7b+mTp3O3Z9lnzjwOo1Xiwi3SZaKfKRIsjpaVzCOd9YxUDg0fU6W+cJz
        MQLhQNH6pdXyEoDJeWQXgNKU8VHWuh/HhzgKBjjnxQgzpyPc/zgHv00rfCVksQNlAgeTWa
        FvdOAyg02kAzRpNnQswwPBo9xJKqnko=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-4jfSZbonPua50qWsx4nm7Q-1; Wed, 15 Apr 2020 08:11:39 -0400
X-MC-Unique: 4jfSZbonPua50qWsx4nm7Q-1
Received: by mail-wm1-f69.google.com with SMTP id t62so5684568wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 05:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3g8pOUWTOZg7Xu60Mt7A1x/Ov3i7r+YKQXs6UW5HczM=;
        b=bHryk+4XbDWnmFGOmttAHJFbGPC7TtoX3IDDHj/T0pFAb9kY60Bw0hQq/IYWyZklGF
         +5X4f1J0Oed7a14cPx48hYkQdTjvC0iWQRZsWkMB83JYgqJEGrsDCKLeM+KOJRCpvA/i
         WZhMJA8hOltrR3gjfw7PE/+/MWS6hcyh7yB9N9yG/eU4yphdiIs7vsVUUhEQhSRj1dOz
         bEzaszcbenWBoqeB0unves4k7o0SRVfLv3Li8f+S6oHuHFmAzTSbSZLJu/UtfPtA4iKe
         gs8lGBBL87Yv/UoBC/K1VaeXs8BeGULYAEpdAd4/F+K2EwAFp1bEyoHD19qIRw+0oBEY
         BWnQ==
X-Gm-Message-State: AGi0PuYGNmKqC0CUBtwrd41q8syhURKKScq6ov65Pqlw1xpK72BMWHnY
        /ECWutKDixardeILZHwQaqpzOvG/O1cpykJfbf1kzWlZpm8bDJdRGkyRLlk3FzVX1p+dvChvW/e
        Pky/gKNkZlAaRqi1eM+SfQhOj
X-Received: by 2002:a5d:688f:: with SMTP id h15mr29234455wru.352.1586952698403;
        Wed, 15 Apr 2020 05:11:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypKdWpo7ENEPbDqHP93vSXvdpZwuSMQZ1BbP1xfwyNZcod/63Icpez1n6CuR5oR+nIQbYmcMPw==
X-Received: by 2002:a5d:688f:: with SMTP id h15mr29234435wru.352.1586952698180;
        Wed, 15 Apr 2020 05:11:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9066:4f2:9fbd:f90e? ([2001:b07:6468:f312:9066:4f2:9fbd:f90e])
        by smtp.gmail.com with ESMTPSA id q8sm22064722wmg.22.2020.04.15.05.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 05:11:37 -0700 (PDT)
Subject: Re: [PATCH 3/4] kvm: Replace vcpu->swait with rcuwait
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     tglx@linutronix.de, bigeasy@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, torvalds@linux-foundation.org,
        will@kernel.org, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paul Mackerras <paulus@ozlabs.org>,
        kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
References: <20200324044453.15733-1-dave@stgolabs.net>
 <20200324044453.15733-4-dave@stgolabs.net>
 <a6b23828-aa50-bea0-1d2d-03e2871239d4@redhat.com>
 <20200414211243.7vehybdrvbzmbduu@linux-p48b>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b2f87633-8eef-4f84-5e65-a80523ca34f8@redhat.com>
Date:   Wed, 15 Apr 2020 14:11:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200414211243.7vehybdrvbzmbduu@linux-p48b>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/20 23:12, Davidlohr Bueso wrote:
> On Wed, 25 Mar 2020, Paolo Bonzini wrote:
> 
>> On 24/03/20 05:44, Davidlohr Bueso wrote:
>>> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
>>> index 71244bf87c3a..e049fcb3dffb 100644
>>> --- a/arch/mips/kvm/mips.c
>>> +++ b/arch/mips/kvm/mips.c
>>> @@ -290,8 +290,7 @@ static enum hrtimer_restart
>>> kvm_mips_comparecount_wakeup(struct hrtimer *timer)
>>>     kvm_mips_callbacks->queue_timer_int(vcpu);
>>>
>>>     vcpu->arch.wait = 0;
>>> -    if (swq_has_sleeper(&vcpu->wq))
>>> -        swake_up_one(&vcpu->wq);
>>> +    rcuwait_wake_up(&vcpu->wait)
>>
>> This is missing a semicolon.  (KVM MIPS is known not to compile and will
>> be changed to "depends on BROKEN" in 5.7).
> 
> Do you want me to send another version with this fix or do you prefer
> fixing it when/if picked up?

It's up to the TIP tree people, but sending a fixed version is probably
the best way to get their attention. :)

I can also queue it myself (for 5.7 even) if I get an Acked-by from
Peter though.

Paolo

