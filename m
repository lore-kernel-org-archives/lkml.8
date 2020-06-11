Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018EDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D038F2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4JIXey8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgFKIOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:14:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54886 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726623AbgFKIOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591863256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6d2EQPOsqa1ar4oQ2p7/Glt6a8pVE2+UZ79AyKGYcCI=;
        b=G4JIXey8Hqf8vXC9ypEJJN3zPJi8gs5APXEdRKQoRF6qicUV724w6GvnnZ01rJ8t0lJ1+N
        gXX9kYj3TqKvKnMQrAVLfOEVoBMmvtbTCCHlKXPG0tnqdOQhjKTBund767iHy4oW8f1ot/
        ELuitS1CNmEbk+BPZ4NPhi/9EHeGW4E=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-qOEE8kzOP_qW1F_BzXAM3g-1; Thu, 11 Jun 2020 04:14:15 -0400
X-MC-Unique: qOEE8kzOP_qW1F_BzXAM3g-1
Received: by mail-ed1-f69.google.com with SMTP id y5so1407432edw.19
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 01:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=6d2EQPOsqa1ar4oQ2p7/Glt6a8pVE2+UZ79AyKGYcCI=;
        b=peqL2irpIrkOzmpoq7pXA11ACOXIvN3+oK0xNWQoUKE+69CNwyOSxnxqOvbpfto5zE
         rbPAVatkSPRZqjsDVE90W1ZLg7cisRbSu4hujxgGOcZZj2ZAVNccgUPT2DMLo9ZYmpb+
         2MSwViAWiNQcV1WPwu09CpOp89wBigj33r5Iw9aiuM+53A5iAPk+saZDjfReUaPngOS/
         1UVCgcky9MM3C/Fo8j1tH+BM/3RW4g7onOL3ynhuj4fkkBjN5HRa1s5WYKgBmcFmkVUe
         YOqhQETJMmNXxMW58O3CoYcAsZi3v96TU+uARBa1yVhUPZaKZU8UvSInRwEDCvmkPMyV
         q20g==
X-Gm-Message-State: AOAM530Hlo87ufxkja2LLe6T8NqXisGSva+KKl7TXnQv1nMxsijfNX6G
        hfbmJhjxluoumfR9yK+ugDxh6TXNRoUMi3sQpTbrXJaKgt8ywY+kMSEEkjSDLF1yTUMflwbTuh/
        1tvgBEXorWNW08MAtKRt5hefm
X-Received: by 2002:a05:6402:1bdc:: with SMTP id ch28mr5781446edb.19.1591863253571;
        Thu, 11 Jun 2020 01:14:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyF/fbM6YhBbbEG+5RVEOLIWwN0fUrk9C7qt3qtRtoDs4uoIhuTSMMvI9gPov6XPGvOoLf5Kg==
X-Received: by 2002:a05:6402:1bdc:: with SMTP id ch28mr5781428edb.19.1591863253290;
        Thu, 11 Jun 2020 01:14:13 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u13sm1452034ejf.60.2020.06.11.01.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 01:14:12 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: async_pf: Inject 'page ready' event only if 'page not present' was previously injected
In-Reply-To: <20200610193211.GB243520@redhat.com>
References: <20200610175532.779793-1-vkuznets@redhat.com> <20200610175532.779793-2-vkuznets@redhat.com> <20200610193211.GB243520@redhat.com>
Date:   Thu, 11 Jun 2020 10:14:11 +0200
Message-ID: <87v9jy9fzg.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@redhat.com> writes:

> On Wed, Jun 10, 2020 at 07:55:32PM +0200, Vitaly Kuznetsov wrote:
>> 'Page not present' event may or may not get injected depending on
>> guest's state. If the event wasn't injected, there is no need to
>> inject the corresponding 'page ready' event as the guest may get
>> confused. E.g. Linux thinks that the corresponding 'page not present'
>> event wasn't delivered *yet* and allocates a 'dummy entry' for it.
>> This entry is never freed.
>> 
>> Note, 'wakeup all' events have no corresponding 'page not present'
>> event and always get injected.
>> 
>> s390 seems to always be able to inject 'page not present', the
>> change is effectively a nop.
>> 
>> Suggested-by: Vivek Goyal <vgoyal@redhat.com>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h | 2 +-
>>  arch/s390/kvm/kvm-s390.c         | 4 +++-
>>  arch/x86/include/asm/kvm_host.h  | 2 +-
>>  arch/x86/kvm/x86.c               | 7 +++++--
>>  include/linux/kvm_host.h         | 1 +
>>  virt/kvm/async_pf.c              | 2 +-
>>  6 files changed, 12 insertions(+), 6 deletions(-)
>> 
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>> index 3d554887794e..cee3cb6455a2 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -978,7 +978,7 @@ bool kvm_arch_can_dequeue_async_page_present(struct kvm_vcpu *vcpu);
>>  void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu,
>>  			       struct kvm_async_pf *work);
>>  
>> -void kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
>> +bool kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
>>  				     struct kvm_async_pf *work);
>
> Hi Vitaly,
>
> A minor nit. Using return code to figure out if exception was injected
> or not is little odd. How about we pass a pointer instead as parameter
> and kvm_arch_async_page_not_present() sets it to true if page not
> present exception was injected. This probably will be easier to
> read.
>
> If for some reason you don't like above, atleats it warrants a comment
> explaining what do 0 and 1 mean.
>

I think it's the 'kvm_arch_async_page_not_present' name which is a bit
misleading now, if we rename it to something like
kvm_arch_inject_apf_not_present() then it becomes a bit more clear
what's going on. We may as well write the code as

    if (kvm_arch_inject_apf_not_present())
        work->notpresent_injected = true;

or change the return type to int so it'll be

    if (!kvm_arch_inject_apf_not_present())
        work->notpresent_injected = true;

> Otherwise both the patches look good to me. I tested and I can confirm
> that now page ready events are not being delivered to guest if page
> not present was not injected.

Thank you for testing!

-- 
Vitaly

