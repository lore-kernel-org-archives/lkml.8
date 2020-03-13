Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1294C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84672206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D41oIJ+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgCMQhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 12:37:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25626 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726406AbgCMQhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584117422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B5vmgPlel0560X00H1BcuksviskLrEXRjpOcciFelUs=;
        b=D41oIJ+Pz/VXahiVFFowQy0N73xDJoye5E8hm4dnQ1Jzx13z/z0F6qn/ycDqIQxZpFqhWd
        ZFSlLT7P+UJspFs6q57px6lPh7yETP7W9s5Qyus+obRXBwIvs2YGt3bJ85BUfXAdFs8jj6
        bP+kA4ELBct3hMXrslBpXovAb2QAGoo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-a7viAAkJPYObcL6mgFvoew-1; Fri, 13 Mar 2020 12:37:01 -0400
X-MC-Unique: a7viAAkJPYObcL6mgFvoew-1
Received: by mail-wr1-f72.google.com with SMTP id b12so4603645wro.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 09:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=B5vmgPlel0560X00H1BcuksviskLrEXRjpOcciFelUs=;
        b=XhQ2PiGq31pK+cQ3BMvDZmCP+L7iGu9aJ8F7q56A4kBm32rBKVDEzJM40uyUP2iyT8
         H1/FxdylsifbwipQzUkIuJvDsLNtBku0rlanm2OfiInRZ4VrFa6UoKH7PqLWpB9J6K4j
         aVu4sRaUdiVATBFytY5HRL9aU4+Hge6ElZg117QvH3JURHDTkqBfD87OHScPyr6vji0S
         j1l4duE8ZOtV0i+Gw2PnaU1lsWnyACtE4tCzeZuRHHcEsvseFdJG1dlm5Q+FXSP4t9Tb
         LamuUB8tEVqw4sw/Zmj5Hc5PjlxaZNMK/QaRkSum2qsj0dr3zIBeJn/zUQhawKrsCKor
         vj9Q==
X-Gm-Message-State: ANhLgQ21ncKbbds7A9dfRhnlpFuYz0HFyfFIfEPYxJEAOvinntdK3lA+
        uxYp0eaClHTn+rPtTzmo/Pz7p31nYvYqxsW864BDSPJqTJ9C08+cj3yJNiE76gFIaG8cYy8czgX
        tt1oNr4SUg7hs/2cUpD6rdcyQ
X-Received: by 2002:a5d:4acc:: with SMTP id y12mr17871357wrs.385.1584117420187;
        Fri, 13 Mar 2020 09:37:00 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vto0arEsXEHCecWNhCQ2kBMtauh1MVvSAJfLKn1ULrNcH3owl+ZCD6BaC1i4Kj7Oja2MmqBYA==
X-Received: by 2002:a5d:4acc:: with SMTP id y12mr17871334wrs.385.1584117419955;
        Fri, 13 Mar 2020 09:36:59 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a1sm40608544wru.75.2020.03.13.09.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 09:36:59 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mtosatti@redhat.com, sean.j.christopherson@intel.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        pbonzini@redhat.com, peterx@redhat.com
Subject: Re: [Patch v2] KVM: x86: Initializing all kvm_lapic_irq fields in ioapic_write_indirect
In-Reply-To: <66c57868-52dd-94cc-e9ef-7bceb54a65e3@redhat.com>
References: <1584105384-4864-1-git-send-email-nitesh@redhat.com> <871rpwpesg.fsf@vitty.brq.redhat.com> <29c41f43-a8c6-3d72-8647-d46782094524@redhat.com> <e20e4fb5-247c-a029-e09f-49f83f2f9d1a@redhat.com> <87v9n8mdn0.fsf@vitty.brq.redhat.com> <66c57868-52dd-94cc-e9ef-7bceb54a65e3@redhat.com>
Date:   Fri, 13 Mar 2020 17:36:58 +0100
Message-ID: <87r1xwmct1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nitesh Narayan Lal <nitesh@redhat.com> writes:

> On 3/13/20 12:18 PM, Vitaly Kuznetsov wrote:
>> Nitesh Narayan Lal <nitesh@redhat.com> writes:
>>
>>> On 3/13/20 9:38 AM, Nitesh Narayan Lal wrote:
>>>> On 3/13/20 9:25 AM, Vitaly Kuznetsov wrote:
>>>>> Nitesh Narayan Lal <nitesh@redhat.com> writes:
>>>>>
>>>>>> Previously all fields of structure kvm_lapic_irq were not initialized
>>>>>> before it was passed to kvm_bitmap_or_dest_vcpus(). Which will cause
>>>>>> an issue when any of those fields are used for processing a request.
>>>>>> For example not initializing the msi_redir_hint field before passing
>>>>>> to the kvm_bitmap_or_dest_vcpus(), may lead to a misbehavior of
>>>>>> kvm_apic_map_get_dest_lapic(). This will specifically happen when the
>>>>>> kvm_lowest_prio_delivery() returns TRUE due to a non-zero garbage
>>>>>> value of msi_redir_hint, which should not happen as the request belongs
>>>>>> to APIC fixed delivery mode and we do not want to deliver the
>>>>>> interrupt only to the lowest priority candidate.
>>>>>>
>>>>>> This patch initializes all the fields of kvm_lapic_irq based on the
>>>>>> values of ioapic redirect_entry object before passing it on to
>>>>>> kvm_bitmap_or_dest_vcpus().
>>>>>>
>>>>>> Fixes: 7ee30bc132c6("KVM: x86: deliver KVM IOAPIC scan request to target vCPUs")
>>>>>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
>>>>>> ---
>>>>>>  arch/x86/kvm/ioapic.c | 7 +++++--
>>>>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
>>>>>> index 7668fed..3a8467d 100644
>>>>>> --- a/arch/x86/kvm/ioapic.c
>>>>>> +++ b/arch/x86/kvm/ioapic.c
>>>>>> @@ -378,12 +378,15 @@ static void ioapic_write_indirect(struct kvm_ioapic *ioapic, u32 val)
>>>>>>  		if (e->fields.delivery_mode == APIC_DM_FIXED) {
>>>>>>  			struct kvm_lapic_irq irq;
>>>>>>  
>>>>>> -			irq.shorthand = APIC_DEST_NOSHORT;
>>>>>>  			irq.vector = e->fields.vector;
>>>>>>  			irq.delivery_mode = e->fields.delivery_mode << 8;
>>>>>> -			irq.dest_id = e->fields.dest_id;
>>>>>>  			irq.dest_mode =
>>>>>>  			    kvm_lapic_irq_dest_mode(!!e->fields.dest_mode);
>>>>>> +			irq.level = 1;
>>>>> 'level' is bool in struct kvm_lapic_irq but other than that, is there a
>>>>> reason we set it to 'true' here? I understand that any particular
>>>>> setting is likely better than random
>>>> Yes, that is the only reason which I had in my mind while doing this change.
>>>> I was not particularly sure about the value, so I copied what ioapic_serivce()
>>>> is doing.
>>> Do you think I should skip setting this here?
>>>
>> Personally, i'd initialize it to 'false': usualy, if something is not
>> properly initialized it's either 0 or garbage)
>
> I think that's true, initializing it to 'false' might make more sense.
> Any other concerns or comments that I can improve?
>

Please add the missing space to the 'Fixes' tag:

Fixes: 7ee30bc132c6 ("KVM: x86: deliver KVM IOAPIC scan request to target vCPUs")

and with that and irq.level initialized to 'false' feel free to add

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

tag. Thanks!


>>
>>>>>  and it should actually not be used
>>>>> without setting it first but still?
>>>>>
>>>>>> +			irq.trig_mode = e->fields.trig_mode;
>>>>>> +			irq.shorthand = APIC_DEST_NOSHORT;
>>>>>> +			irq.dest_id = e->fields.dest_id;
>>>>>> +			irq.msi_redir_hint = false;
>>>>>>  			bitmap_zero(&vcpu_bitmap, 16);
>>>>>>  			kvm_bitmap_or_dest_vcpus(ioapic->kvm, &irq,
>>>>>>  						 &vcpu_bitmap);

-- 
Vitaly

