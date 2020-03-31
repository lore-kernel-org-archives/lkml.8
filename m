Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817FCC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 12:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC1720714
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 12:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7ygkBjj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbgCaMQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 08:16:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42230 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730343AbgCaMQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 08:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585656992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AIkdm1RPzoMJraitwnvvrTQS82YbBm+BBWTAYvOw/a0=;
        b=V7ygkBjjVC7byuxTLIiu/9ck2JdtrQ2EaL1EAwyB90fy8M0AG/aTVgTb+5EGZgwXPKvDqQ
        h0qXSdUFKs8JuN2GuVKiiPAwnSS+On0oZXQrEHuObC52nL8HMEZEABvkpOV4CvBmAIt9ze
        nhMZtuhqfSeIEj6VJYL+U+7VZlRotc4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-ovqkbLb-OdyJhgql6ixa_A-1; Tue, 31 Mar 2020 08:16:30 -0400
X-MC-Unique: ovqkbLb-OdyJhgql6ixa_A-1
Received: by mail-wr1-f72.google.com with SMTP id d17so12917027wrw.19
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 05:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AIkdm1RPzoMJraitwnvvrTQS82YbBm+BBWTAYvOw/a0=;
        b=Ki5aQx04WdzCBNl++4CfsUFRoEyGmv9JzbAPjUlz+32A80iVj29kKRwbM/a1gaHfl2
         UbdDUKwgiYy+AZbNCMmxiZ1Iuaic3arIsq2HNj3JxixDALuZ2cVI9pLOTtzlI1WsoDSb
         Zz8v/mTcv0FABx8XlIe1V9d4vD3rYNIL69q4yARNnvOJTSd+ZCKCV83c51SlDYSWaA8Y
         L1GZ7X8A3D4Z1JWYd+Rpgi/vS7yHBEN9GrLlCUKihf6iGFNe+m4Ag/u05S+rz3U4VfYe
         iFlEypze86BoUI20ve96NUnh0HoO9W6u6VKaEqtPfyqkgMxbhUC1rOHLmojZIGuldRBZ
         +16w==
X-Gm-Message-State: ANhLgQ1suFHGANSc433RGOYphVRBBQscNUE4CVh2EgmAZKi++0OB7rZG
        6sQgy1K4YzSR1aXj1EVZIEmzdHx8glUJG6V4apyue4K+u5Bvtzqn2Nsbn+ZxgapbOmHhCB8uSXl
        JL1KFDsbES6IjJHkzbHZl0IaZ
X-Received: by 2002:a1c:f409:: with SMTP id z9mr3340247wma.51.1585656989319;
        Tue, 31 Mar 2020 05:16:29 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvcbyZLww2LXTEarvjb+E499WK7YYqe/vu5BI2QScvGR8UQClxweAMw8FUdntCdulV276PfnA==
X-Received: by 2002:a1c:f409:: with SMTP id z9mr3340231wma.51.1585656989082;
        Tue, 31 Mar 2020 05:16:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b55d:5ed2:8a41:41ea? ([2001:b07:6468:f312:b55d:5ed2:8a41:41ea])
        by smtp.gmail.com with ESMTPSA id b199sm3939974wme.23.2020.03.31.05.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 05:16:28 -0700 (PDT)
Subject: Re: [PATCH 1/3] KVM: x86: introduce kvm_mmu_invalidate_gva
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Junaid Shahid <junaids@google.com>
References: <20200326093516.24215-1-pbonzini@redhat.com>
 <20200326093516.24215-2-pbonzini@redhat.com>
 <20200328182631.GQ8104@linux.intel.com>
 <2a1f9477-c289-592e-25ff-f22a37044457@redhat.com>
 <20200330184726.GJ24988@linux.intel.com>
 <87v9mk24qy.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bb7b1075-a4fc-e0d3-d8fd-f516d107d5e2@redhat.com>
Date:   Tue, 31 Mar 2020 14:16:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87v9mk24qy.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/20 12:33, Vitaly Kuznetsov wrote:
>> Works for me.  My vote is for anything other than guest_mmu :-)
>
> Oh come on guys, nobody protested when I called it this way :-)

Sure I take full responsibility for that. :)

> Peronally, I don't quite like 'shadow_tdp_mmu' because it doesn't have
> any particular reference to the fact that it is a nested/L2 related
> thing (maybe it's just a shadow MMU?)

Well, nested virt is the only case in which you shadow TDP.  Both
interpretations work:

* "shadow tdp_mmu": an MMU for two-dimensional page tables that employs
shadowing

* "shadow_tdp MMU": the MMU for two-dimensional page tables.

> Also, we already have a thing
> called 'nested_mmu'... Maybe let's be bold and rename all three things,
> like
>
> root_mmu -> l1_mmu
> guest_mmu -> l1_nested_mmu
> nested_mmu -> l2_mmu (l2_walk_mmu)

I am not particularly fond of using l1/l2 outside code that specifically
deals with nested virt.  Also, l1_nested_mmu is too confusing with
respect to the current nested_mmu (likewise for root_mmu I would rename
it to guest_mmu but it would be an awful source of mental confusion as
well as semantic source code conflicts).

That said, I wouldn't mind replacing nested_mmu to something else, for
example nested_walk_mmu.

Paolo

