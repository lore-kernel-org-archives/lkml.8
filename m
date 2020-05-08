Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076CAC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4FEC21473
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSfrkPFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgEHJwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 05:52:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49510 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726904AbgEHJwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 05:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588931551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+dz6rA08h3MZ8FdUWtlFCXT77fAjr2cP8WCCtv+kX0E=;
        b=eSfrkPFvXJvWDjsB0JJYTMmvWKDh8SqEisWzeVA2p1EYXiY++XrpnfGcFeGCcrl62G4Zhx
        SR72efQqGYjQhujqUHP+M/IiaYzS2Lcnw2LsuUBKhwgLcM7Nbd9A0huQJnpw+FzPVkdrgb
        mXTwYLF89wctqIg0prucdt5vpi5FI/o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-mFWJut5rN7ivExL0uh0hCA-1; Fri, 08 May 2020 05:52:29 -0400
X-MC-Unique: mFWJut5rN7ivExL0uh0hCA-1
Received: by mail-wm1-f70.google.com with SMTP id l21so4935163wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 02:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+dz6rA08h3MZ8FdUWtlFCXT77fAjr2cP8WCCtv+kX0E=;
        b=shEZUIpzCC6lPdpPrcIh5TERtqYTUdV3jrMCNdICohMoLabaRgWVWnuy9YzMnfJx+Q
         BWm4y7X6Sdmpywol+HuMk01R70QoGpVHdyIB0rr76JM8OHvltMVX1XAMbxHeKUaXapQy
         mKS1CPCHB6x6wBuv9X+XpGEcZvWO6iqBPSNy3j7l1iIMUPi9LiuhuXtvSReejEjJ84K8
         5B+aR4Hjh9RYPhvrwfvxgTZJ5wpGIw7TugOkO8XG2PbtgxSA2Dkj6SQzjy9+4WH1U8AX
         xLiYeis7oQMylzzXIWIGXmXZelhnd1LsWiwynfOTMjUSmJPGoOAIqkCZoX2VtA+4FRmW
         23JQ==
X-Gm-Message-State: AGi0Pua9BNHUzNoVOLeM6pAsAOPW/TjAEF4rJ3NeA4naZ5DDxvouwuPY
        p4HWN8v14EBLn/YiHw7056lCZXzNjZuj20hqqs+/zs4Cu1U2oJ6m8WE1T4FdpBB1sgRm45fAIsD
        UQ5PjsLZcw/FogoxjbKJ9sJgp
X-Received: by 2002:adf:bc41:: with SMTP id a1mr2133064wrh.302.1588931548436;
        Fri, 08 May 2020 02:52:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypIXg2rUC+xsWJ1CTk51Rn7BwUDILnaCu2NtMy3/wwiwPkPeCChG25HI6ju147+iTr3raidjMA==
X-Received: by 2002:adf:bc41:: with SMTP id a1mr2133038wrh.302.1588931548233;
        Fri, 08 May 2020 02:52:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:20ea:bae4:47a7:31db? ([2001:b07:6468:f312:20ea:bae4:47a7:31db])
        by smtp.gmail.com with ESMTPSA id g12sm4237266wmk.1.2020.05.08.02.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 02:52:27 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: x86/pmu: Support full width counting
To:     like.xu@intel.com, Like Xu <like.xu@linux.intel.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200507021452.174646-1-like.xu@linux.intel.com>
 <3fb56700-7f0b-59e1-527a-f8eb601185b1@redhat.com>
 <72d7d120-85af-d846-a0d5-fe8fe058be34@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aabf0a54-ff60-5c1e-279b-9c8bf18e396d@redhat.com>
Date:   Fri, 8 May 2020 11:52:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <72d7d120-85af-d846-a0d5-fe8fe058be34@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/20 10:42, Xu, Like wrote:
>> Given the bugs, it is clear that you should also modify the pmu.c
>> testcase for kvm-unit-tests to cover full-width writes (and especially
>> the non-full-width write behavior of MSR_IA32_PERFCTRn).  Even before
>> the QEMU side is begin worked on, you can test it with "-cpu
>> host,migratable=off".
>
> Sure, I added some testcases in pmu.c to cover this feature.
> 
> Please review the v3 patch
> https://lore.kernel.org/kvm/20200508083218.120559-1-like.xu@linux.intel.com/
> 
> as well as the kvm-unit-tests testcase.

Awesome, thanks for the quick reply!

Paolo

