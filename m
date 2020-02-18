Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4E1C34033
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D992621D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFVTVD96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgBRJvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:51:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39574 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726449AbgBRJvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582019472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f6S3H9Q+xCWLQbxsvGz1L63SOHDRI/P/SP31mReQZeM=;
        b=fFVTVD96ILzvaAGFmzTJ7rWlP6Y6hYqUTFL90AwJKT2Bh8M3yRvvpaw2wb4jNmmk5xbmm9
        7kmkd99TvUO90STINX2f5UfthJnhG0doLBn8YcszYn/GeN0JX87pLPEljqsa1qbC/fsvHr
        G7uy6mYoMR3py9ewrdfFLfYA+HmULQM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-XkBS2qtUPQKkUtoTSFTt0A-1; Tue, 18 Feb 2020 04:51:10 -0500
X-MC-Unique: XkBS2qtUPQKkUtoTSFTt0A-1
Received: by mail-wr1-f70.google.com with SMTP id j4so10518530wrs.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 01:51:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=f6S3H9Q+xCWLQbxsvGz1L63SOHDRI/P/SP31mReQZeM=;
        b=ORDUJ513NsB+6rhe8/3o+I+gx6i2h/XZykmwp8V4J2K/rJfKtU2ppqFRfU+L9e63PL
         1M0jr4uiNDeJEEpuvMpB6XFQW5Pxe+8UqtWy29bNlfDHZ+/K+2za8INC1yrnoH8jT5gf
         NfmaOpcWnGUsLR3xhTCKC+bgeBT9v31sBhBAAaCeBo8qKQAHdo1PW0sxC9n88KThQAj4
         EnLnttzgLTKLlIFHjgUjsLDxrZ+Gb2GTQo7iAEVk3ogEgHeR9o9nTtLJjkNQyMrcpuO5
         woKz9PCRQ7jMUa20iI01BbUFT9/ELuBvafpwJpJBkSsBOGi9yMVaWHHFbkVtJh1Nqwwq
         FvWA==
X-Gm-Message-State: APjAAAWFLrogG8n6vz4F0epcTfOyHQJWbB+O7EmiiZJdb0uM/xOs1o/L
        gXuYbTqv/61fkxSbyPDJIpf4uCG/C9lJ6CSZlM4Bzm8PCAO/EhviUAaEIlRF8oWvuZhaErDR6Jr
        IDASrkEXYPXikyA5nyqUVNO7O
X-Received: by 2002:adf:ef92:: with SMTP id d18mr26767552wro.234.1582019469076;
        Tue, 18 Feb 2020 01:51:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqzbsVWsC/clpUSMI+QxchpdxgMAvfJu1v5ks+QAVdg84JW43xe6pTbomJpPHIiBlicc26MBfg==
X-Received: by 2002:adf:ef92:: with SMTP id d18mr26767533wro.234.1582019468906;
        Tue, 18 Feb 2020 01:51:08 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e16sm5329978wrs.73.2020.02.18.01.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 01:51:08 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>,
        "pbonzini\@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar\@redhat.com" <rkrcmar@redhat.com>,
        "sean.j.christopherson\@intel.com" <sean.j.christopherson@intel.com>,
        "wanpengli\@tencent.com" <wanpengli@tencent.com>,
        "jmattson\@google.com" <jmattson@google.com>,
        "joro\@8bytes.org" <joro@8bytes.org>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "mingo\@redhat.com" <mingo@redhat.com>,
        "bp\@alien8.de" <bp@alien8.de>, "hpa\@zytor.com" <hpa@zytor.com>
Subject: Re: [PATCH] KVM: x86: don't notify userspace IOAPIC on edge-triggered interrupt EOI
In-Reply-To: <edf7454be5a743928cbc1bec5dce238d@huawei.com>
References: <edf7454be5a743928cbc1bec5dce238d@huawei.com>
Date:   Tue, 18 Feb 2020 10:51:07 +0100
Message-ID: <8736b89qb8.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linmiaohe <linmiaohe@huawei.com> writes:

> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
>>linmiaohe <linmiaohe@huawei.com> writes:
>>
>>> @@ -417,7 +417,7 @@ void kvm_scan_ioapic_routes(struct kvm_vcpu *vcpu,
>>>  
>>>  			kvm_set_msi_irq(vcpu->kvm, entry, &irq);
>>>  
>>> -			if (irq.level &&
>>> +			if (irq.trig_mode &&
>>>  			    kvm_apic_match_dest(vcpu, NULL, APIC_DEST_NOSHORT,
>>>  						irq.dest_id, irq.dest_mode))
>>>  				__set_bit(irq.vector, ioapic_handled_vectors);
>>
>>Assuming Radim's comment (13db77347db1) is correct, the change in
>>3159d36ad799 looks wrong and your patch restores the status quo. Actually, kvm_set_msi_irq() always sets irq->level = 1 so checking it is pointless.
>>
>>Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>
> Thanks for review.
>
>>
>> (but it is actually possible that there's a buggy userspace out there which expects EOI notifications; we won't find out unless we try to fix the bug).
>>
>
> Yeh, there may be a buggy userspace hidden from this unexpected EOI notifications. It may not be worth enough to fix it as we may spend many time
> to catch the bug.
> Perhaps we should only remove the pointless checking of irq->level for cleanup. :)

I'm feeling brave so in case nobody expresses any particular concerns
let's just fix it :-)

-- 
Vitaly

