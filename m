Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DBAC31E51
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B996F20897
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jRA4hHfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbgICUCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:02:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55492 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729356AbgICUCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599163359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eTM798jNWSto3aJECGa6KA1td+/NCZqVTNN5qgvcw9E=;
        b=jRA4hHfSPmfHNz1Ic/cVwwM+4rGeIIt4WAyBDRvQYO85pafxkcThCoG621quEGlK4D+7Fw
        LV3CF4nQ81Y76P1QAScv27ZZ48ywz5mK5WNgpBQlgMQLdI5DGvW7IVVy46ToeghqKicFKn
        0lPTQJJ7iR1FJvkAviWG/H4la+oN60c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-rKuZmjWjNzu4QS_iZ__9OQ-1; Thu, 03 Sep 2020 16:02:38 -0400
X-MC-Unique: rKuZmjWjNzu4QS_iZ__9OQ-1
Received: by mail-ed1-f70.google.com with SMTP id y21so1731546edu.23
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 13:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eTM798jNWSto3aJECGa6KA1td+/NCZqVTNN5qgvcw9E=;
        b=VvhFyYQI2t/YleidvxU7wjBf7/3buuf8Uvpy+46RIVhf/zifvQ2+YlS/IL+RJeiNwn
         5OL9UGZU8Ave05o+tHG9to67+n+R27qtfACTOwKB2gju2J6w8kyZVdZuvvjO5ZewqHbX
         9o6VzsxNL05hLiAfTaS9810465MjYorfovp/jGr0G6bfribO2eXatsCiYo/Zyhu/PiGg
         BpEvmqkBcSF+IWbzKiGlVEuNWtwhv7pUyx+fROzKKpXIWoHRON4iFox4QCicLHSOUbCC
         +2F0hYe64nk82tnWswMgw42jd1lYCPyqXZFvoIJVGoUF74BBMmkMpdrxm2mt6hNJhHNr
         9DIA==
X-Gm-Message-State: AOAM531mlnrWFF3iaYLMMM7rYhfR1j3niWkppsFhFcsuqLbJTGxP55Xt
        uRLz8G5S6iAw7xqEFMdq3d5dhg8HreOWzaOmF/4n6OCmLWgZPPszcUZffF7APKrkGA4fqI7Nk12
        Vlzu662+ydLG5k6OpeKwjzLw4
X-Received: by 2002:aa7:dc08:: with SMTP id b8mr5097749edu.271.1599163356662;
        Thu, 03 Sep 2020 13:02:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqAihHLVWx8nsoBhNdHXWJZozf9ULqwWiHS0vDDzSA7zMtyXkYRo+FtNbxhAEz8eRAejJChg==
X-Received: by 2002:aa7:dc08:: with SMTP id b8mr5097707edu.271.1599163356372;
        Thu, 03 Sep 2020 13:02:36 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id k16sm4043049ejg.64.2020.09.03.13.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 13:02:35 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: VMX: Make smaller physical guest address space
 support user-configurable
To:     Jim Mattson <jmattson@google.com>
Cc:     Mohammed Gamal <mgamal@redhat.com>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20200903141122.72908-1-mgamal@redhat.com>
 <CALMp9eTrc8_z3pKBtLVmbnMvC+KtzXMYbYTXZPPz5F0UWW8oNQ@mail.gmail.com>
 <00b0f9eb-286b-72e8-40b5-02f9576f2ce3@redhat.com>
 <CALMp9eS6O18WcEyw8b6npRSazsyKiGtBjV+coZVGxDNU1JEOsQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <208da546-e8e3-ccd5-9686-f260d07b73fd@redhat.com>
Date:   Thu, 3 Sep 2020 22:02:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eS6O18WcEyw8b6npRSazsyKiGtBjV+coZVGxDNU1JEOsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/20 20:32, Jim Mattson wrote:
>> [Checking writes to CR3] would be way too slow.  Even the current
>> trapping of present #PF can introduce some slowdown depending on the
>> workload.
>
> Yes, I was concerned about that...which is why I would not want to
> enable pedantic mode. But if you're going to be pedantic, why go
> halfway?

Because I am not sure about any guest, even KVM, caring about setting
bits 51:46 in CR3.

>>> Does the typical guest care about whether or not setting any of the
>>> bits 51:46 in a PFN results in a fault?
>>
>> At least KVM with shadow pages does, which is a bit niche but it shows
>> that you cannot really rely on no one doing it.  As you guessed, the
>> main usage of the feature is for machines with 5-level page tables where
>> there are no reserved bits; emulating smaller MAXPHYADDR allows
>> migrating VMs from 4-level page-table hosts.
>>
>> Enabling per-VM would not be particularly useful IMO because if you want
>> to disable this code you can just set host MAXPHYADDR = guest
>> MAXPHYADDR, which should be the common case unless you want to do that
>> kind of Skylake to Icelake (or similar) migration.
> 
> I expect that it will be quite common to run 46-bit wide legacy VMs on
> Ice Lake hardware, as Ice Lake machines start showing up in
> heterogeneous data centers.

If you'll be okay with running _all_ 46-bit wide legacy VMs without
MAXPHYADDR emulation, that's what this patch is for.  If you'll be okay
with running _only_ 46-bit wide VMs without emulation, you still don't
need special enabling per-VM beyond the automatic one based on
CPUID[0x8000_0008].  Do you think you'll need to enable it for some
special 46-bit VMs?

Paolo

