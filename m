Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27209C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25F42077C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QdCOrxf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgAWTJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:09:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56444 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728655AbgAWTJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579806549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CVnbh8HU2D1CHz2shEx/+7LoktnChzwhzRO+F+tdk+E=;
        b=QdCOrxf2ZmjYgcy5m2JRBy5urepkcKOHbq3HF7+z+YruKE8XjD0zTIHtLDJ6sTCwEII5Dw
        On7E9IpmKkxUOJmuTVHWJI2McFGQzttQZn6TRyd6l4MVlSRr8HkZS8AaN8DdcdXBHvW02i
        N1Ih62o1gdjQyUhncWkymVxBdC9TT8w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-U3ypDvPlOoKWSiiHbHaL0g-1; Thu, 23 Jan 2020 14:09:06 -0500
X-MC-Unique: U3ypDvPlOoKWSiiHbHaL0g-1
Received: by mail-wr1-f69.google.com with SMTP id o6so2368312wrp.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 11:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CVnbh8HU2D1CHz2shEx/+7LoktnChzwhzRO+F+tdk+E=;
        b=mMMpDOfihtq8BVCt3D3ULcZq15JbZxSLfOSzMNRCGT4QYRSPV1oR8uZdy15OT4/6Q2
         BREoIBdWf3dOpPK+zS3xCkGAN9fmbFPjqN3P3NTxm9D56aHk0Ou5saomIx0JIwWKGLOp
         pQsCkWzTum4hnTTigRuC8G0TuC6QhiUtPf7lTRKTwK4R7qA+CZWdDD6xzbDOijDRV7tH
         bNKxvRkg4I490FwJfW8O6HSgYyFbyyvEUl/TT2MmJ5oEVA0liMRrNdUC9N/u21iEkEqo
         5BPYlGThBWdFLxAYYObixb3YUGbU7Y0CvdYDUK+RdlkMMYvlyOAy63tb41YEg/hOz4NM
         x4SQ==
X-Gm-Message-State: APjAAAXciZS92NwdPk4CNPUKJ3FW4La2j2SXQVXSPQ73PMi4Xyu7Zol7
        ofeMX399s+C7sUVX+Z6SnDQ6V1VZTwaMiea4OlILhgkByGh/XCWjtg+x5VhtQarcs2+2r0KZ0zg
        BJELZBu68q4aII/3FLsB8MVhc
X-Received: by 2002:adf:b64b:: with SMTP id i11mr20131898wre.58.1579806544991;
        Thu, 23 Jan 2020 11:09:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqxhHAI+4XBKY/NA4TwevDsu40I1kE/M4h9jsZP1lj8js0WQLrhkO57jgoIYF23sM7nfjFL84g==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr20131866wre.58.1579806544727;
        Thu, 23 Jan 2020 11:09:04 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t5sm4071069wrr.35.2020.01.23.11.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 11:09:03 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Liran Alon <liran.alon@oracle.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH RFC 2/3] x86/kvm/hyper-v: move VMX controls sanitization out of nested_enable_evmcs()
In-Reply-To: <87zheer0si.fsf@vitty.brq.redhat.com>
References: <20200115171014.56405-1-vkuznets@redhat.com> <20200115171014.56405-3-vkuznets@redhat.com> <6c4bdb57-08fb-2c2d-9234-b7efffeb72ed@redhat.com> <20200122054724.GD18513@linux.intel.com> <9c126d75-225b-3b1b-d97a-bcec1f189e02@redhat.com> <87eevrsf3s.fsf@vitty.brq.redhat.com> <20200122155108.GA7201@linux.intel.com> <87blqvsbcy.fsf@vitty.brq.redhat.com> <f15d9e98-25e9-2031-2db5-6aaa6c78c0eb@redhat.com> <87zheer0si.fsf@vitty.brq.redhat.com>
Date:   Thu, 23 Jan 2020 20:09:03 +0100
Message-ID: <87lfpyq9bk.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Paolo Bonzini <pbonzini@redhat.com> writes:
>
>> On 22/01/20 17:29, Vitaly Kuznetsov wrote:
>>> Yes, in case we're back to the idea to filter things out in QEMU we can
>>> do this. What I don't like is that every other userspace which decides
>>> to enable eVMCS will have to perform the exact same surgery as in case
>>> it sets allow_unsupported_controls=0 it'll have to know (hardcode) the
>>> filtering (or KVM_SET_MSRS will fail) and in case it opts for
>>> allow_unsupported_controls=1 Windows guests just won't boot without the
>>> filtering.
>>> 
>>> It seems to be 1:1, eVMCSv1 requires the filter.
>>
>> Yes, that's the point.  It *is* a hack in KVM, but it is generally
>> preferrable to have an easier API for userspace, if there's only one way
>> to do it.
>>
>> Though we could be a bit more "surgical" and only remove
>> SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES---thus minimizing the impact on
>> non-eVMCS guests.  Vitaly, can you prepare a v2 that does that and adds
>> a huge "hack alert" comment that explains the discussion?
>
> Yes, sure. I'd like to do more testing to make sure filtering out
> SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES is enough for other Hyper-V
> versions too (who knows how many bugs are there :-)

... and the answer is -- more than one :-)

I've tested Hyper-V 2016/2019 BIOS and UEFI-booted and the minimal
viable set seems to be:

MSR_IA32_VMX_PROCBASED_CTLS2: 
	~SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES

MSR_IA32_VMX_ENTRY_CTLS/MSR_IA32_VMX_TRUE_ENTRY_CTLS:
	~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL

MSR_IA32_VMX_EXIT_CTLS/MSR_IA32_VMX_TRUE_EXIT_CTLS:
	~VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL
 
with these filtered out all 4 versions are at least able to boot with >1
vCPU and run a nested guest (different from Windows management
partition).

This still feels a bit fragile as who knows under which circumstances
Hyper-V might want to enable additional (missing) controls.

If there are no objections and if we still think it would be beneficial
to minimize the list of controls we filter out (and not go with the full
set like my RFC suggests), I'll prepare v2. (v1, actually, this was RFC).

-- 
Vitaly

