Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F005BC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A1D20674
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHGvPuSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgGJRQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:16:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54288 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728215AbgGJRQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594401382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VYYAKT69qJC8cXBBjJthRJSXfG2nYGjV6nWSQ+iUBs0=;
        b=UHGvPuSxw+Jz10fbJ3FSyUHbTRiXmdqF/9kFq9UZd+a7OQMakLWfcKKcR62aEmPAohi1mO
        RU3m2kOreQ4Vs2sI6Z2h5KXgX2JJXtIlX1Hp02iFGG+4IX/bXvkUskFsw78zBvb2lkYnPS
        ZAftfhM2liv8QxLo5Z73Pl6dgmtPHJw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-RGxl7ilzNA6B9YhG-v_W6g-1; Fri, 10 Jul 2020 13:16:18 -0400
X-MC-Unique: RGxl7ilzNA6B9YhG-v_W6g-1
Received: by mail-wm1-f69.google.com with SMTP id e15so7417556wme.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VYYAKT69qJC8cXBBjJthRJSXfG2nYGjV6nWSQ+iUBs0=;
        b=g7iKmY3Kkk3C5QY8EGyZ1pK5HugAt5T4AUj+JB5HKKTWYkIyyYeAjm37C3hMSny87r
         1P2y2925nqt/b9KFSEpbRgoY2xkfIXqA5hYgDxe0tSnUchk+f/96KqW2eH2jMBj5Qyp4
         8aQO2WcWkBJs4/3Mf504aLqMHxGDuyinnQwvNepj0TivRQMzpaAklwMzN/dW1rWr90CM
         SmS5ZcD5ox7qiWg8zLz1zmYbD9m1s+AXf6Mk/b3EtYFMsXwN0mYOQeL6dhGUl/OHza65
         TzMkmWR8dwwzZUd6WRIqs21NuqxFCG67VPI/wAWkrPllTvxvp42ysAdievPD284AWc+p
         6L8g==
X-Gm-Message-State: AOAM530Zb+yUNEnHGwH70plMNDSDuC5rKGktzAzQ2itQ8VRjuzKSyP19
        Jt/6Fq6f+qiacNmaKuo4KHjueMrVVRR5Rjx1gMIUD6FbLumHP+DWqx7zeljCW4y4A5wvAM7Ib/P
        CGpdYKMtjd4KThm/LY0nETyv/
X-Received: by 2002:adf:db42:: with SMTP id f2mr68136088wrj.298.1594401377387;
        Fri, 10 Jul 2020 10:16:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXnEfdioHVFKguZS3kZcS8dBW7ubOyBPqnpSZpaWNF4miTy+T6IbMEcoEtCVas5nZXP6TxGw==
X-Received: by 2002:adf:db42:: with SMTP id f2mr68136068wrj.298.1594401377138;
        Fri, 10 Jul 2020 10:16:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id r1sm10847140wrt.73.2020.07.10.10.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 10:16:16 -0700 (PDT)
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
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9e784c62-15ee-63b7-4942-474493bac536@redhat.com>
Date:   Fri, 10 Jul 2020 19:16:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eQXHGnXo4ACX2-qYww4XdRODMn-O6CAvhupib67Li9S2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/20 19:13, Jim Mattson wrote:
> On Fri, Jul 10, 2020 at 10:06 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 10/07/20 18:30, Jim Mattson wrote:
>>>>
>>>> This can be problem when having a mixed setup of machines with 5-level page
>>>> tables and machines with 4-level page tables, as live migration can change
>>>> MAXPHYADDR while the guest runs, which can theoretically introduce bugs.
>>>
>>> Huh? Changing MAXPHYADDR while the guest runs should be illegal. Or
>>> have I missed some peculiarity of LA57 that makes MAXPHYADDR a dynamic
>>> CPUID information field?
>>
>> Changing _host_ MAXPHYADDR while the guest runs, such as if you migrate
>> from a host-maxphyaddr==46 to a host-maxphyaddr==52 machine (while
>> keeping guest-maxphyaddr==46).
> 
> Ah, but what does that have to do with LA57?

Intel only has MAXPHYADDR > 46 on LA57 machines (because in general OSes
like to have a physical 1:1 map into the kernel part of the virtual
address space, so having a higher MAXPHYADDR would be of limited use
with 48-bit linear addresses).

In other words, while this issue has existed forever it could be ignored
until IceLake introduced MAXPHYADDR==52 machines.  I'll introduce
something like this in a commit message.

Paolo

