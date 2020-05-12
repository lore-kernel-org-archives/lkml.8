Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86164C2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB7B20752
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOk0P5kZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbgELPkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:40:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58186 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726055AbgELPkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589298016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qHJhLSvmzDJvwVRUhszC3qq4if//lbINiNMHGbHJsBw=;
        b=QOk0P5kZqE2W8UY8widPlQp6o3Zz+0ZPPDhZ++j5P1WuFoNVQsvM20o5Z7E127ydMNLUUa
        XIgj/pPDHQFpszNSP01gGezI3aa1HkKbuAcNtZrkD5+pLXh6t7jEALM/M6SndXg+N3BwCJ
        kWDTs3P9EK/KIt/WwIWMRiZcON3izak=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-pgwbrK2dOCqJ3yUuRmxtGA-1; Tue, 12 May 2020 11:40:15 -0400
X-MC-Unique: pgwbrK2dOCqJ3yUuRmxtGA-1
Received: by mail-wm1-f71.google.com with SMTP id q5so10120854wmc.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 08:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qHJhLSvmzDJvwVRUhszC3qq4if//lbINiNMHGbHJsBw=;
        b=XXAXQ3q7luGwWSXX9tM6QUgte6mftqFCUZb0BYze3HLKKG7yS96rLpgcHs2jGhwp2E
         fr7wwityI/deGxvDgrxh5ok+llmq/BBwKlBgH+RsoZtvft/VThK5oHho6kdc9rZbEMaW
         QkCbo5JzkzFXVSMAvfAkh394LCmJN0wLjX0afYYVLKrKfq6WN1uIzOIxkAp/GNrIfmSC
         ZffBtOaRp/XeXRxVxBnxkcm74UmyY9LGJ9kJqcxq9tyu5lpxBcfwgScwt4oC1qz0FKqu
         RNqfKHJZZ5pWupJzzWFBsZwcdXXl92yf0eGCZr9pPrkEAzrdg/xO37s/1CDj4PTIf1cr
         PcvQ==
X-Gm-Message-State: AGi0PuYwGX8NkLGG6t4QZlhQo2xFPtOZdZcjGL6fyR44fT17x4KQHCsS
        8DePVy0NEC3HkjfAj08uw6fcmp+QU73IHCiFT7q1z5bGfLi88+V4XBFSgLL3qoPDGHXWMTbRZNu
        9ibMzlUNuyK+9WioE7BZR9ruZ
X-Received: by 2002:a1c:1b96:: with SMTP id b144mr13782022wmb.6.1589298013492;
        Tue, 12 May 2020 08:40:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypK9DWujqHjyyO1W7grzCj6wLKVxRNg7V630n99xKGBE4NpxBOqdNCckqre61dpYKkyjL3du1g==
X-Received: by 2002:a1c:1b96:: with SMTP id b144mr13781994wmb.6.1589298013202;
        Tue, 12 May 2020 08:40:13 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id z11sm22913653wro.48.2020.05.12.08.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 08:40:12 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Gavin Shan <gshan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] KVM: x86: extend struct kvm_vcpu_pv_apf_data with token info
In-Reply-To: <20200512152709.GB138129@redhat.com>
References: <20200511164752.2158645-1-vkuznets@redhat.com> <20200511164752.2158645-3-vkuznets@redhat.com> <20200512152709.GB138129@redhat.com>
Date:   Tue, 12 May 2020 17:40:10 +0200
Message-ID: <87o8qtmaat.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@redhat.com> writes:

> On Mon, May 11, 2020 at 06:47:46PM +0200, Vitaly Kuznetsov wrote:
>> Currently, APF mechanism relies on the #PF abuse where the token is being
>> passed through CR2. If we switch to using interrupts to deliver page-ready
>> notifications we need a different way to pass the data. Extent the existing
>> 'struct kvm_vcpu_pv_apf_data' with token information for page-ready
>> notifications.
>> 
>> The newly introduced apf_put_user_ready() temporary puts both reason
>> and token information, this will be changed to put token only when we
>> switch to interrupt based notifications.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/include/uapi/asm/kvm_para.h |  3 ++-
>>  arch/x86/kvm/x86.c                   | 17 +++++++++++++----
>>  2 files changed, 15 insertions(+), 5 deletions(-)
>> 
>> diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
>> index 2a8e0b6b9805..e3602a1de136 100644
>> --- a/arch/x86/include/uapi/asm/kvm_para.h
>> +++ b/arch/x86/include/uapi/asm/kvm_para.h
>> @@ -113,7 +113,8 @@ struct kvm_mmu_op_release_pt {
>>  
>>  struct kvm_vcpu_pv_apf_data {
>>  	__u32 reason;
>> -	__u8 pad[60];
>> +	__u32 pageready_token;
>
> How about naming this just "token". That will allow me to deliver error
> as well. pageready_token name seems to imply that this will always be
> successful with page being ready.
>
> And reason will tell whether page could successfully be ready or
> it was an error. And token will help us identify the task which
> is waiting for the event.

I added 'pageready_' prefix to make it clear this is not used for 'page
not present' notifications where we pass token through CR2. (BTW
'reason' also becomes a misnomer because we can only see
'KVM_PV_REASON_PAGE_NOT_PRESENT' there.)

I have no strong opinion, can definitely rename this to 'token' and add
a line to the documentation to re-state that this is not used for type 1
events.

-- 
Vitaly

