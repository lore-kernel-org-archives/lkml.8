Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FC4C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 961C520735
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHD89EcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgEDJUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 05:20:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55987 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727930AbgEDJUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 05:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588584003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PXKefhyNsVrqhbSaw0uWJPXnOxnNca0tzq80MmeMsgs=;
        b=OHD89EcN3g5SVUY58hcKs1OwMJMdGDZjxmmZ7T0XCesH3kw94nnvrGxGehJLH8GihR1T2u
        w4/ZjpkqJ2Hy7ngyGD8ur+o99glxCfp5aScpfarH1TAAtscWyAOeTxA+wG2BErxVDwhR6g
        eQ7DYMWJk1/DZYN6SXetQLqy6bJ267s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-vNVwR_DjMJCLNNweDWbWZA-1; Mon, 04 May 2020 05:19:59 -0400
X-MC-Unique: vNVwR_DjMJCLNNweDWbWZA-1
Received: by mail-wm1-f69.google.com with SMTP id f128so4551209wmf.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 02:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PXKefhyNsVrqhbSaw0uWJPXnOxnNca0tzq80MmeMsgs=;
        b=P4T/wNHr7I3WQ7js26gKMRSMAsbn0flWIs74c4X/tjVbTxm5kov9aBSi2QvVUM28eX
         RPrXYr41M3IvH63RGqTVMm129hrVa+eq7CYL4cGfFmqM+fqEWPREtwgeuvGQg+69Zfui
         n2MazTZh2FNNyngmWymMwWmKipscM6OFSASYsg2ZwRlKga/pdCwsQuPcKlTa5iU8GKSZ
         xiS+4ggLf/lEVYyREtFJtf27SRxOSFRM9c+kIb3CVXQXWxj2Q3mlK2uyIGCSRlZAQ7hB
         5c8eObmawDdajisIMDGsrWjWcGQiT0kfjn8WMSpZsOQvwSS4vD3+cUkWJv4Lu32qxFPC
         rDCg==
X-Gm-Message-State: AGi0PuZF4tcRk7uM+cmQElnWaAQl68Jlw1SWxRgkCyEq5rqrfnGMZWAi
        9tHlfr4w7Z2MvitgUpwg3afvkI0eQG7ktnAG/6c3ef9srAToNFJfwFd2P2/4kZW167NH31xW05s
        hcGyWg4iLhgB2fePlFyfFQKP2
X-Received: by 2002:adf:afd6:: with SMTP id y22mr3795460wrd.417.1588583998718;
        Mon, 04 May 2020 02:19:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypKuG6PVHUr7bVaMOUCUhOEqyeRNEbOObtw4ZSVEKStgyvWMt+cncD9RnxxusPFv0UBIOXqGKQ==
X-Received: by 2002:adf:afd6:: with SMTP id y22mr3795438wrd.417.1588583998478;
        Mon, 04 May 2020 02:19:58 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
        by smtp.gmail.com with ESMTPSA id i74sm18070472wri.49.2020.05.04.02.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 02:19:57 -0700 (PDT)
Subject: Re: [PATCH v2] kvm: ioapic: Introduce arch-specific check for lazy
 update EOI mechanism
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     rkrcmar@redhat.com, joro@8bytes.org, jon.grimm@amd.com,
        borisvk@bstnet.org
References: <1588411495-202521-1-git-send-email-suravee.suthikulpanit@amd.com>
 <e09f0be9-6a2f-a8ee-3a96-c8ffdf3add3f@redhat.com>
 <fd2529b7-66f9-fd4e-d071-a38d01e4b61c@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a78c88fa-5d2b-1329-9200-922e1c95e730@redhat.com>
Date:   Mon, 4 May 2020 11:19:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <fd2529b7-66f9-fd4e-d071-a38d01e4b61c@amd.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/20 08:31, Suravee Suthikulpanit wrote:
>>
>>
>> The re-entrancy happens because the irq state is the OR of
>> the interrupt state and the resamplefd state.  That is, we don't
>> want to show the state as 0 until we've had a chance to set the
>> resamplefd.  But if the interrupt has _not_ gone low then we get an
>> infinite loop.
> 
> I'm not too familiar w/ the resamplefd.  I must have missed this part.
> Could you please point out to me where the OR logic is?

It's because kvm_ioapic_set_irq gets the actual state of the interrupt
line from __kvm_irq_line_state before calling ioapic_set_irq.

>> But in the case of level-triggered interrupts the VMEXIT already
>> happens because TMR is set; only edge-triggered interrupts need
>> the lazy invocation of the ack notifier.  
> 
> For AVIC, EOI write for level-triggered would have also be trapped.

Yes, I was talking about AVIC only there.

> And yes, edge-triggered needs lazy ack notifier.
> 
>> So this should be the fix:
>>
>> diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
>> index 7668fed1ce65..ca2d73cd00a3 100644
>> --- a/arch/x86/kvm/ioapic.c
>> +++ b/arch/x86/kvm/ioapic.c
>> @@ -225,12 +225,12 @@ static int ioapic_set_irq(struct kvm_ioapic
>> *ioapic, unsigned int irq,
>>       }
>>         /*
>> -     * AMD SVM AVIC accelerate EOI write and do not trap,
>> -     * in-kernel IOAPIC will not be able to receive the EOI.
>> +     * AMD SVM AVIC accelerate EOI write iff the interrupt is level
>> +     * triggered, in-kernel IOAPIC will not be able to receive the EOI.
> 
> Actually, it should be "AMD SVM AVIC accelerate EOI write iff the
> interrupt is _edge_ triggered".

Of course, thanks.

Paolo

