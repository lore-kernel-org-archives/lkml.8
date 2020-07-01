Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E19C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90E95206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E503V4YE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgGAIG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:06:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20448 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728416AbgGAIG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593590816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kO3FhtcRdUCD2T/2dvT7E4BtzYPqfAKbnmCLMMGWuv8=;
        b=E503V4YEU0/h3cdfweZwq/l8HZHvdFkvPd8W+10fi92NPz1MB++wCs5yaRb/xNOrrrYOXz
        K3JP7LY1oluChImZx9Bss5wMM1onQcgITnkCzym6zBO+sKYYCRqgLqghk1i7zDiKfgUK1l
        w5CU3+fBYMg+SQCxp93rFMdXDr7ybYE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-Hsorz33mMYqVLT0dBQYB4A-1; Wed, 01 Jul 2020 04:06:55 -0400
X-MC-Unique: Hsorz33mMYqVLT0dBQYB4A-1
Received: by mail-ej1-f72.google.com with SMTP id d17so13459203ejy.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=kO3FhtcRdUCD2T/2dvT7E4BtzYPqfAKbnmCLMMGWuv8=;
        b=SaVbjYKhsCk2rG5X7qGxKgBRmgTepd0z22ipvapXolJR2rs4c3AUr6qEGPN7wu9IIC
         b2oXU8/q8PIyet7c10OvvaDiUeUSYwdWPGBdMhuicoZZ7iCtk2ZWyUo+LRJ3fxgcqukv
         h+Dp+ux6ulxHsPnYxiXt+NE99wsdEC4hqn8hZp07BoCItsqvyxyIcW8koeBh8bUrQYUA
         ljo/quyyfVj+Ur9DHDWXPDEZFOO2sJBEA9eKVZPSjxWg3ZOSyPuS8OM6djDAW+R0LVjj
         y0cjkVn5obAUtHGiMb/rb/MKr8K1BonSNYx7zzCugt7inc21EOlhcrWV/lg60rvgenSN
         kOcw==
X-Gm-Message-State: AOAM533IBDaJRovRZuYcvSLCXlP3uxTT6jW0HqwDDsR0E9lwxs7FjZnb
        lgYMN8T+pcei5rOU/3Xg1b9QS47AeTU/yZIrqdyIiwRMCGKHKJjnaWfv9C7P5yo1XChxGVMU94L
        V12NmWWWPs0bw2yPwBts7w8QH
X-Received: by 2002:a50:f384:: with SMTP id g4mr26484656edm.205.1593590813515;
        Wed, 01 Jul 2020 01:06:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJym7w7ayeemI+OJq6fBltA9j9TRv+bcySq7fBe3+w3surB27xebJp8+fpDWhMbJo7073orxBA==
X-Received: by 2002:a50:f384:: with SMTP id g4mr26484633edm.205.1593590813248;
        Wed, 01 Jul 2020 01:06:53 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id d22sm3992889ejc.90.2020.07.01.01.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:06:52 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     kvm@vger.kernel.org, virtio-fs@redhat.com, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] kvm,x86: Exit to user space in case of page fault error
In-Reply-To: <20200630182542.GA328891@redhat.com>
References: <20200625214701.GA180786@redhat.com> <87lfkach6o.fsf@vitty.brq.redhat.com> <20200626150303.GC195150@redhat.com> <874kqtd212.fsf@vitty.brq.redhat.com> <20200629220353.GC269627@redhat.com> <87sgecbs9w.fsf@vitty.brq.redhat.com> <20200630145303.GB322149@redhat.com> <87mu4kbn7x.fsf@vitty.brq.redhat.com> <20200630152529.GC322149@redhat.com> <87k0zobltx.fsf@vitty.brq.redhat.com> <20200630182542.GA328891@redhat.com>
Date:   Wed, 01 Jul 2020 10:06:51 +0200
Message-ID: <87blkzbqw4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@redhat.com> writes:

> On Tue, Jun 30, 2020 at 05:43:54PM +0200, Vitaly Kuznetsov wrote:
>> Vivek Goyal <vgoyal@redhat.com> writes:
>> 
>> > On Tue, Jun 30, 2020 at 05:13:54PM +0200, Vitaly Kuznetsov wrote:
>> >> 
>> >> > - If you retry in kernel, we will change the context completely that
>> >> >   who was trying to access the gfn in question. We want to retain
>> >> >   the real context and retain information who was trying to access
>> >> >   gfn in question.
>> >> 
>> >> (Just so I understand the idea better) does the guest context matter to
>> >> the host? Or, more specifically, are we going to do anything besides
>> >> get_user_pages() which will actually analyze who triggered the access
>> >> *in the guest*?
>> >
>> > When we exit to user space, qemu prints bunch of register state. I am
>> > wondering what does that state represent. Does some of that traces
>> > back to the process which was trying to access that hva? I don't
>> > know.
>> 
>> We can get the full CPU state when the fault happens if we need to but
>> generally we are not analyzing it. I can imagine looking at CPL, for
>> example, but trying to distinguish guest's 'process A' from 'process B'
>> may not be simple.
>> 
>> >
>> > I think keeping a cache of error gfns might not be too bad from
>> > implemetation point of view. I will give it a try and see how
>> > bad does it look.
>> 
>> Right; I'm only worried about the fact that every cache (or hash) has a
>> limited size and under certain curcumstances we may overflow it. When an
>> overflow happens, we will follow the APF path again and this can go over
>> and over.
>
> Sure. But what are the chances of that happening. Say our cache size is
> 64. That means we need atleast 128 processes to do co-ordinated faults
> (all in error zone) to skip the cache completely all the time. We
> have to hit cache only once. Chances of missing the error gnf
> cache completely for a very long time are very slim. And if we miss
> it few times, now harm done. We will just spin few times and then
> exit to qemu.
>
> IOW, chances of spinning infinitely are not zero. But they look so
> small that in practice I am not worried about it.
>
>> Maybe we can punch a hole in EPT/NPT making the PFN reserved/
>> not-present so when the guest tries to access it again we trap the
>> access in KVM and, if the error persists, don't follow the APF path?
>
> Cache solution seems simpler than this. Trying to maintain any state
> in page tables will be invariably more complex (Especially given
> many flavors of paging).
>
> I can start looking in this direction if you really think that its worth
> implementing  page table based solution for this problem. I feel that
> we implement something simpler for now and if there are easy ways
> to skip error gns, then replace it with something page table based
> solution (This will only require hypervisor change and no guest
> changes).

I think we're fine with an interim cache/hash solution as long as
chances of getting into an infinite loop accidentaially are very slim
and we don't have any specific latency requirements. Feel free to forget
about PT suggestion for now, we can certainly make it 'step 2' (IMO).

-- 
Vitaly

