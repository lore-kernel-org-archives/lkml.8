Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6389C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A16C620643
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DU4JC8Ih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgEOIYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 04:24:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47747 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726694AbgEOIYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 04:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589531090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0DQftDX0379nFESU6WazrW1lD4fM3GC98zH3yfUsrwE=;
        b=DU4JC8Ihy/bwGsg4hANYlhSwQmaAoCLM3prjkLXeBlBA30XbL3yX7Qz2jD2YfyB6UZzvwh
        /6sjzhi7UyBMYuZpuZnA/Ouwfu3UqAcD862pe3sRCDmxn2DYhi06sMg+7964VMxc2k2Z+9
        xfI9qA9Ns8uuujrvSii5ddIjDt6XZto=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-5OivfA2kNfOdwdUTKLC_CA-1; Fri, 15 May 2020 04:24:49 -0400
X-MC-Unique: 5OivfA2kNfOdwdUTKLC_CA-1
Received: by mail-wr1-f72.google.com with SMTP id d16so795156wrv.18
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 01:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=0DQftDX0379nFESU6WazrW1lD4fM3GC98zH3yfUsrwE=;
        b=LPKgPKBD/SfhManSe0RCEXEfiRRviFTH/sN+cJ4lepTqw+l3JSyKc8lBXzRTxNZ+mo
         tIrSlzfjCzbjeXkNQxrYuSOw2PM30tIKuc9CTUVYmOGptPL5zGuuX3ocFOygCSF4jbpH
         bNMTNGPk/ZD1OMoswSp4OP/V6SxDljLzbjXkKemjTnbljpAiXsRVBxSMnhiNxTb1i3kV
         m3GQohWSOIvKNDk15iaTR53phm0dEOB9VkKUOywR2XhyKPx0JskdD6s1VQTEpOaM06x4
         /y0I1+qA30pGMxj2VigqptUFoFvNg9JI2n104cv7rE+TA93c+3i8XD2Y2ffB7q5U6V7v
         H4Fg==
X-Gm-Message-State: AOAM532iERilnaBdOqUKCUavJ4pcshtvrpFKbL9CbUoYkc482qxvFGzG
        s9M4Mo8ZUlVM5cny3/3x7FTQrw7YGq9QEEN83+oAcE6zR/g1jWJQ7h5D4XfDzEU0yfHd32SsAk/
        3Yff+TqOIjV5jnj035CLiaNoN
X-Received: by 2002:a5d:62c7:: with SMTP id o7mr2914716wrv.212.1589531087915;
        Fri, 15 May 2020 01:24:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWc8/zKYnO5ihSmyMO25yKM3a8VD+LjoaKKI+gb3ocgg3J9JGwXdm6ilapNMfvQgQoDQ4XVw==
X-Received: by 2002:a5d:62c7:: with SMTP id o7mr2914689wrv.212.1589531087638;
        Fri, 15 May 2020 01:24:47 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id r11sm2419027wrv.14.2020.05.15.01.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 01:24:46 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Tsirkin <mst@redhat.com>,
        Julia Suvorova <jsuvorov@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, x86@kernel.org
Subject: Re: [PATCH RFC 2/5] KVM: x86: introduce KVM_MEM_ALLONES memory
In-Reply-To: <20200514191823.GA15847@linux.intel.com>
References: <20200514180540.52407-1-vkuznets@redhat.com> <20200514180540.52407-3-vkuznets@redhat.com> <20200514191823.GA15847@linux.intel.com>
Date:   Fri, 15 May 2020 10:24:45 +0200
Message-ID: <87imgxwqpe.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Thu, May 14, 2020 at 08:05:37PM +0200, Vitaly Kuznetsov wrote:
>> PCIe config space can (depending on the configuration) be quite big but
>> usually is sparsely populated. Guest may scan it by accessing individual
>> device's page which, when device is missing, is supposed to have 'pci
>> holes' semantics: reads return '0xff' and writes get discarded. Currently,
>> userspace has to allocate real memory for these holes and fill them with
>> '0xff'. Moreover, different VMs usually require different memory.
>> 
>> The idea behind the feature introduced by this patch is: let's have a
>> single read-only page filled with '0xff' in KVM and map it to all such
>> PCI holes in all VMs. This will free userspace of obligation to allocate
>> real memory. Later, this will also allow us to speed up access to these
>> holes as we can aggressively map the whole slot upon first fault.
>> 
>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  Documentation/virt/kvm/api.rst  | 22 ++++++---
>>  arch/x86/include/uapi/asm/kvm.h |  1 +
>>  arch/x86/kvm/x86.c              |  9 ++--
>>  include/linux/kvm_host.h        | 15 ++++++-
>>  include/uapi/linux/kvm.h        |  2 +
>>  virt/kvm/kvm_main.c             | 79 +++++++++++++++++++++++++++++++--
>>  6 files changed, 113 insertions(+), 15 deletions(-)
>> 
>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>> index d871dacb984e..2b87d588a7e0 100644
>> --- a/Documentation/virt/kvm/api.rst
>> +++ b/Documentation/virt/kvm/api.rst
>> @@ -1236,7 +1236,8 @@ yet and must be cleared on entry.
>>  
>>    /* for kvm_memory_region::flags */
>>    #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
>> -  #define KVM_MEM_READONLY	(1UL << 1)
>> +  #define KVM_MEM_READONLY		(1UL << 1)
>> +  #define KVM_MEM_ALLONES		(1UL << 2)
>
> Why not call this KVM_MEM_PCI_HOLE or something else that better conveys
> that this is memslot is intended to emulate PCI master abort semantics?
>

Becuase there's always hope this can be usefult for something else but
PCI? :-) Actually, I was thinking about generalizing this a little bit
to something like KVM_MEM_CONSTANT with a way to set the pattern but I'm
failing to see any need for anything but all-ones or all-zeroes. Maybe
other-than-x86 architectures have some needs?

I'm definitely fine with renaming this to KVM_MEM_PCI_HOLE.

-- 
Vitaly

