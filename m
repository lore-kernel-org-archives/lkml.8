Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D888C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FABE20746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IROxAEXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgCMQTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 12:19:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27223 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726526AbgCMQTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584116345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sel3wVVn/IDeCE+QRafOTlr+Thswa40aMpw5w3+KcLk=;
        b=IROxAEXErlIl5DNDh2Twpk3yEoneuS6eIgWO0dFP5i/v3haUShW0N6HdFPWesHBrCLTNDB
        ifr7RmJtP3jwVnvMFkEbK/oX/DtSEfQBKu+C/oFPkN4WqSCZeV2f6ni9JC8NlK9z/g9l/M
        Kl8jTR/6XS2T2wNpHCa4EpYlNOIfMbQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-y_R9BHpyOiy7fbXI63_6og-1; Fri, 13 Mar 2020 12:19:01 -0400
X-MC-Unique: y_R9BHpyOiy7fbXI63_6og-1
Received: by mail-wm1-f71.google.com with SMTP id a11so1241999wmm.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 09:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Sel3wVVn/IDeCE+QRafOTlr+Thswa40aMpw5w3+KcLk=;
        b=ELuZyI45qS9xi4uE6ODwtUV2qWBuJYJ3/zvgdumVIgU58fieFB1U0mrc1KFD8vYD+G
         9blSLqxeaLLOqHzGPoONcO7X8nJssKnDVyX28xyiTAajYL+sAif2NlgdshfROwU7Gg5w
         fM4d/ZlRBflp2RdwEgbbmDwhG3QrSDFmnPdaN+YfxzK8qs4SFZodaEvhaY2brEIGqDOg
         wy6wtnKjms+iBaXK7833jAaIPcdzE6MNJLAd4fZXm67HPUggzk3bJU5aDb7LlkIcs9YX
         uTpWXyiIcPp4R0bKS0eQ5EEbXmqwqy8LBVTOP5xLUdcMAZ1Ry4GO/S4gJB0LQ8HgmF3j
         sxdg==
X-Gm-Message-State: ANhLgQ0AdKH4bMzi7rHY27COGGgulsIFfd6Yt4fGuRLZeoPqafFbbMNg
        Cr3h0PGQaD1of0Ji360lMBHj5RMKO8inDFwwZT/ftb+x2qsBhWoiwoRRpQK1gYieAOv0HD/Dq3A
        ASbGJ+rMzZQiJgWz9gEe/EUWS
X-Received: by 2002:adf:ed86:: with SMTP id c6mr19564263wro.53.1584116340759;
        Fri, 13 Mar 2020 09:19:00 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsGhDC76TPw20+jcWR7sr1cQhX4ivcMb3Es6OrPp3gMT65NEoJZYv9aGV9+66ubHLDl22s7Eg==
X-Received: by 2002:adf:ed86:: with SMTP id c6mr19564241wro.53.1584116340535;
        Fri, 13 Mar 2020 09:19:00 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w67sm13566135wmb.41.2020.03.13.09.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 09:18:59 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mtosatti@redhat.com, sean.j.christopherson@intel.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        pbonzini@redhat.com, peterx@redhat.com
Subject: Re: [Patch v2] KVM: x86: Initializing all kvm_lapic_irq fields in ioapic_write_indirect
In-Reply-To: <e20e4fb5-247c-a029-e09f-49f83f2f9d1a@redhat.com>
References: <1584105384-4864-1-git-send-email-nitesh@redhat.com> <871rpwpesg.fsf@vitty.brq.redhat.com> <29c41f43-a8c6-3d72-8647-d46782094524@redhat.com> <e20e4fb5-247c-a029-e09f-49f83f2f9d1a@redhat.com>
Date:   Fri, 13 Mar 2020 17:18:59 +0100
Message-ID: <87v9n8mdn0.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nitesh Narayan Lal <nitesh@redhat.com> writes:

> On 3/13/20 9:38 AM, Nitesh Narayan Lal wrote:
>> On 3/13/20 9:25 AM, Vitaly Kuznetsov wrote:
>>> Nitesh Narayan Lal <nitesh@redhat.com> writes:
>>>
>>>> Previously all fields of structure kvm_lapic_irq were not initialized
>>>> before it was passed to kvm_bitmap_or_dest_vcpus(). Which will cause
>>>> an issue when any of those fields are used for processing a request.
>>>> For example not initializing the msi_redir_hint field before passing
>>>> to the kvm_bitmap_or_dest_vcpus(), may lead to a misbehavior of
>>>> kvm_apic_map_get_dest_lapic(). This will specifically happen when the
>>>> kvm_lowest_prio_delivery() returns TRUE due to a non-zero garbage
>>>> value of msi_redir_hint, which should not happen as the request belongs
>>>> to APIC fixed delivery mode and we do not want to deliver the
>>>> interrupt only to the lowest priority candidate.
>>>>
>>>> This patch initializes all the fields of kvm_lapic_irq based on the
>>>> values of ioapic redirect_entry object before passing it on to
>>>> kvm_bitmap_or_dest_vcpus().
>>>>
>>>> Fixes: 7ee30bc132c6("KVM: x86: deliver KVM IOAPIC scan request to target vCPUs")
>>>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
>>>> ---
>>>>  arch/x86/kvm/ioapic.c | 7 +++++--
>>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
>>>> index 7668fed..3a8467d 100644
>>>> --- a/arch/x86/kvm/ioapic.c
>>>> +++ b/arch/x86/kvm/ioapic.c
>>>> @@ -378,12 +378,15 @@ static void ioapic_write_indirect(struct kvm_ioapic *ioapic, u32 val)
>>>>  		if (e->fields.delivery_mode == APIC_DM_FIXED) {
>>>>  			struct kvm_lapic_irq irq;
>>>>  
>>>> -			irq.shorthand = APIC_DEST_NOSHORT;
>>>>  			irq.vector = e->fields.vector;
>>>>  			irq.delivery_mode = e->fields.delivery_mode << 8;
>>>> -			irq.dest_id = e->fields.dest_id;
>>>>  			irq.dest_mode =
>>>>  			    kvm_lapic_irq_dest_mode(!!e->fields.dest_mode);
>>>> +			irq.level = 1;
>>> 'level' is bool in struct kvm_lapic_irq but other than that, is there a
>>> reason we set it to 'true' here? I understand that any particular
>>> setting is likely better than random
>> Yes, that is the only reason which I had in my mind while doing this change.
>> I was not particularly sure about the value, so I copied what ioapic_serivce()
>> is doing.
>
> Do you think I should skip setting this here?
>

Personally, i'd initialize it to 'false': usualy, if something is not
properly initialized it's either 0 or garbage)

>>>  and it should actually not be used
>>> without setting it first but still?
>>>
>>>> +			irq.trig_mode = e->fields.trig_mode;
>>>> +			irq.shorthand = APIC_DEST_NOSHORT;
>>>> +			irq.dest_id = e->fields.dest_id;
>>>> +			irq.msi_redir_hint = false;
>>>>  			bitmap_zero(&vcpu_bitmap, 16);
>>>>  			kvm_bitmap_or_dest_vcpus(ioapic->kvm, &irq,
>>>>  						 &vcpu_bitmap);

-- 
Vitaly

