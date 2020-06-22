Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CC3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D6C20656
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5aBm6Nx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbgFVWUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:20:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38736 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730840AbgFVWUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592864433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+r7BKrKGWvMG5qhiOpLap0PhRC2znMPWIsJQP36DWQY=;
        b=S5aBm6NxbJGw1eFMUmbUi7Lj2HE2X0slSkskKSAtYk9zSYU9cQx+rRyO2Y5pL5wHgyrH3b
        oRJzdOm1O7fOJQgSF/dr8Mjfb53Z02RdbXmyaUKJ3B2zrch4xHhYhAZt+ocse759ESv1Xf
        KdrLGSHge9DgvZKEFuH8+rWD8kBxVOU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-irzln1TZNoGTH8diJwsVyQ-1; Mon, 22 Jun 2020 18:20:31 -0400
X-MC-Unique: irzln1TZNoGTH8diJwsVyQ-1
Received: by mail-wr1-f71.google.com with SMTP id a18so377895wrm.14
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+r7BKrKGWvMG5qhiOpLap0PhRC2znMPWIsJQP36DWQY=;
        b=lA7ERwJOt8F2ipQ73N3q8Op63kUfRZxb8EpNoVQjqfKscr2jzQ/I/cGQ94dJjhekTb
         KthTtFKtXH1alSS7tJyy9awFnE2jIcTA6UHC7/ooIar1DWSL57Iz/6yfgnkEFQy4bGq8
         zrnvoDwuNlOn8xZvfbfEgmzjOW6FfQyKooPQl3v6inxRffEeDi3sB7cAHH4ApBBc/2B/
         N4yjsz7p10o68a/HOSOGukgbLOKxXof3s5oYP1d049yI2CNsh60YCy4UADLWLE3fG+HT
         VFxLA1Z7nILwzOfnqg6ATTUgm+h8QSYOwTAjje5IUWttdxx5iVJaMll/pdOUeYFzRdQq
         Vt3Q==
X-Gm-Message-State: AOAM533rOhbnn3r11ccpmDfM7W6ejL+4Ue3BKD2MioP2cjee2pb2wTL6
        NdaffgTicLq+oVLbpm11sB1lEJZFZpDwl2ZLtEE0pvi1mxRARkJ34t5iuVREdNn7+RRhnQOJlNI
        xkJZbRf8ltikcjkQM8aTsK4Qt
X-Received: by 2002:a5d:50c9:: with SMTP id f9mr22339326wrt.9.1592864430216;
        Mon, 22 Jun 2020 15:20:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz45s3tZQ+/TSVf6JTtKxvVlACFv07bLL+dxB020RBft9zTO3YnObOaP7u62VAjD6X6NaUs3w==
X-Received: by 2002:a5d:50c9:: with SMTP id f9mr22339302wrt.9.1592864429972;
        Mon, 22 Jun 2020 15:20:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:fd64:dd90:5ad5:d2e1? ([2001:b07:6468:f312:fd64:dd90:5ad5:d2e1])
        by smtp.gmail.com with ESMTPSA id d201sm1024184wmd.34.2020.06.22.15.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 15:20:29 -0700 (PDT)
Subject: Re: [PATCH v2 00/11] KVM: Support guest MAXPHYADDR < host MAXPHYADDR
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Mohammed Gamal <mgamal@redhat.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, babu.moger@amd.com
References: <20200619153925.79106-1-mgamal@redhat.com>
 <5a52fd65-e1b2-ca87-e923-1d5ac167cfb9@amd.com>
 <52295811-f78a-46c5-ff9e-23709ba95a3d@redhat.com>
 <0d1acded-93a4-c1fa-b8f8-cfca9e082cd1@amd.com>
 <40ac43a1-468f-24d5-fdbf-d012bdae49ed@redhat.com>
 <c89bda4a-2db9-6cb1-8b01-0a6e69694f43@amd.com>
 <4ed45f38-6a31-32ab-cec7-baade67a8c1b@redhat.com>
 <77388079-6e1b-5788-4912-86ad4c28ee70@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b0f3c36d-a6a5-f10d-443a-3270047d7bec@redhat.com>
Date:   Tue, 23 Jun 2020 00:20:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <77388079-6e1b-5788-4912-86ad4c28ee70@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/20 21:14, Tom Lendacky wrote:
>>> I guess I'm trying to understand why RSVD has to be reported to the guest
>>> on a #PF (vs an NPF) when there's no guarantee that it can receive that
>>> error code today even when guest MAXPHYADDR == host MAXPHYADDR. That would
>>> eliminate the need to trap #PF.
>>
>> That's an interesting observation!  But do processors exist where either:
>>
>> 1) RSVD doesn't win over all other bits, assuming no race conditions
> 
> There may not be any today, but, present bit aside (which is always
> checked), there is no architectural statement that says every error
> condition has to be checked and reported in a #PF error code. So software
> can't rely on RSVD being present when there are other errors present.
> That's why I'm saying I don't think trapping #PF just to check and report
> RSVD should be done.

Fair enough---if I could get rid of the #PF case I would only be happy.
 But I'm worried about guests being upset if they see non-RSVD page
faults for a page table entry that has one or more reserved bits set.

>> 2) A/D bits can be clobbered in a page table entry that has reserved
>> bits set?
> 
> There is nothing we can do about this one. The APM documents this when
> using nested page tables.

Understood.

> If the guest is using the same MAXPHYADDR as the
> host, then I'm pretty sure this doesn't happen, correct? So it's only when
> the guest is using something less than the host MAXPHYADDR that this occurs.
> I'm not arguing against injecting a #PF with the RSVD on an NPF where it's
> detected that bits are set above the guest MAXPHYADDR, just the #PF trapping.

Got it.  My question is: is there an architectural guarantee that the
dirty bit is not set if the instruction raises a page fault?  (And what
about the accessed bit?).

If so, the NPF behavior makes it impossible to emulate lower MAXPHYADDR
values from the NPF vmexit handler.  It would be incorrect to inject a
#PF with the RSVD error code from the NPF handler, because the guest
would not expect the dirty bits to be set in the page table entry.

Even if there's no such guarantee, I would be reluctant to break it
because software could well be expecting it.

Paolo

> Thanks,
> Tom
> 
>>
>> Running the x86/access.flat testcase from kvm-unit-tests on bare metal
>> suggests that all existing processors do neither of the above.
>>
>> In particular, the second would be a showstopper on AMD.
>>
>> Paolo
>>
> 

