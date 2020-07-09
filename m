Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FCFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9429120672
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8z58mni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgGIWSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 18:18:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41486 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726821AbgGIWSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 18:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594333102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JhIiSAhu+eKDD4LqE1U44H9+yD3bGyMgOiR/v2Po9pA=;
        b=U8z58mnii8nIescmg7q95Dp0dwuHK7jGLePxZ28NNO94qw3tIu6neToJXVvh5l1SWItdnH
        u04EIfaUS4C+ARPJGKcmX45bUNhWf3qA4UtHiq1yq+7inkt6KcI5aaLckriXh9dV0a6S8Z
        2q/DDf+ZrJTCligJeI8b0lmpCHBZLNI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-kZJV1ZUtPgWwIxo1m_MHXg-1; Thu, 09 Jul 2020 18:18:20 -0400
X-MC-Unique: kZJV1ZUtPgWwIxo1m_MHXg-1
Received: by mail-wm1-f71.google.com with SMTP id s134so3710516wme.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 15:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JhIiSAhu+eKDD4LqE1U44H9+yD3bGyMgOiR/v2Po9pA=;
        b=m1+DiIYgQ1HVBUxpAPnNIbR3XB5LRoLdn2Bqxy1SUDvotDVi3jQ/+PVBdJ/rt9GVmi
         nNYyPvmP1QryQvKz1chUUHbVEmyNL8Ql4S5VsBVpTpvlDKtiuSb2+D6fKFzU9IyzGL2M
         gaRW2qO6EY6Wygvbi7+SonnfVxlvGdXPxto52euKom9Xntc03fk2/eGl3hqGri/mfuug
         5iRvLEGnx2Qha1eObO6GNXHMy4wgYw5g0DTRcW3A/Lihw/zGJMeilBbEIXeuDdxHwPYA
         Uw1YyApPqRkOBGLN9OUWLKr1McShPBWY4VntY9L7QLJ4LWyRAAeGHUcNot9DSQaqh8nh
         /nfA==
X-Gm-Message-State: AOAM531NWsTvuFTAHQhcQ0u3C7OFeIca+UUKYXqT9D6D0T+ujwUgAbeX
        jjl2WAYJIffaH+fTxs5yzR0BpoPdvyGTqc0TXQa0/gf0MS1L7HGUNxAbZP4Qv6cVH507c1IuID+
        VcQSDjNAUBBPNDm/f8REdwPP4
X-Received: by 2002:adf:ed8c:: with SMTP id c12mr31545652wro.359.1594333099433;
        Thu, 09 Jul 2020 15:18:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGDqzx+gzniXiWP2qzH4hqdbNZTAc8mphaCAqFZQ27IjOnlswG36D7Q/CTjmFXJVOhbGtqMg==
X-Received: by 2002:adf:ed8c:: with SMTP id c12mr31545633wro.359.1594333099223;
        Thu, 09 Jul 2020 15:18:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id j4sm7501523wrp.51.2020.07.09.15.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 15:18:18 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86/mmu: Add capability to zap only sptes for the
 affected memslot
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiong Zhang <xiong.y.zhang@intel.com>,
        Wayne Boyer <wayne.boyer@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>
References: <20200703025047.13987-1-sean.j.christopherson@intel.com>
 <51637a13-f23b-8b76-c93a-76346b4cc982@redhat.com>
 <20200709211253.GW24919@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <49c7907a-3ab4-b5db-ccb4-190b990c8be3@redhat.com>
Date:   Fri, 10 Jul 2020 00:18:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709211253.GW24919@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/20 23:12, Sean Christopherson wrote:
>> It's bad that we have no clue what's causing the bad behavior, but I
>> don't think it's wise to have a bug that is known to happen when you
>> enable the capability. :/

(Note that this wasn't a NACK, though subtly so).

> I don't necessarily disagree, but at the same time it's entirely possible
> it's a Qemu bug.

No, it cannot be.  QEMU is not doing anything but
KVM_SET_USER_MEMORY_REGION, and it's doing that synchronously with
writes to the PCI configuration space BARs.

> Even if this is a kernel bug, I'm fairly confident at this point that it's
> not a KVM bug.  Or rather, if it's a KVM "bug", then there's a fundamental
> dependency in memslot management that needs to be rooted out and documented.

Heh, here my surmise is that  it cannot be anything but a KVM bug,
because  Memslots are not used by anything outside KVM...  But maybe I'm
missing something.

> And we're kind of in a catch-22; it'll be extremely difficult to narrow down
> exactly who is breaking what without being able to easily test the optimized
> zapping with other VMMs and/or setups.

I agree with this, and we could have a config symbol that depends on
BROKEN and enables it unconditionally.  However a capability is the
wrong tool.

Paolo

