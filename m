Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1EFC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 16:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3DB420738
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 16:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQc8MInT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgEWQeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 12:34:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23623 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728234AbgEWQe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 12:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590251668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HuZzbZkGqE+3pTQ3powlX9CzpAalpjRkp2uqWJb6cGs=;
        b=HQc8MInTWc6HQnnxpS66TeZoO8j1Lqjv7YoyyRZfFtHfFbMRwOBlU4o2kcXrKEhZ+4dQxc
        z455D5i4HLnTeph3HN6QS2qs8OUrdw8HTpK3VvchnUPCLfxR1bM7bNVvJHn7CLvUV+8NYC
        MrdnRMMmz61bT+xh50E0Xc05uEGQdf0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-lDWbfcN1OGS2iKT009cYgA-1; Sat, 23 May 2020 12:34:21 -0400
X-MC-Unique: lDWbfcN1OGS2iKT009cYgA-1
Received: by mail-ej1-f71.google.com with SMTP id ci7so3516441ejb.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 09:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HuZzbZkGqE+3pTQ3powlX9CzpAalpjRkp2uqWJb6cGs=;
        b=ABdlMljV4IeJORYW1ocY5EdJyQQ0Zu2BHu6sTXssQrM9PzflCyC423EwvpjK8xdvH5
         2qJ5xF9tb4PKdgJiBQQNET649IfPHz/lrrgxpGaw+fMKS9ohGJbE0enKN8Ep29lTHYmN
         vSSEyehTaPwGw9i/fCPhgcP/njFTFIqhZYWhTm6NZtitNWlAtMFx475llgKPOT7BFwEd
         GmE35XPHNksrtYGFY1WTz+aUGgq6VAHCiAWm93kQ4LUqlNykj8+8RrRXl2wwqp2e3Sc4
         zCSQeOAbs7rsrdB02zf6x0IZBiKk1eAPk5WiRTeOoZk75Ca+wm7uQKwX6rehdy1zFan2
         wh3Q==
X-Gm-Message-State: AOAM533Xucyu5hUMq36PYwuNhVUqh9204lf6z17bNFwvn31Qf6VoIxI1
        2mX8M0KLG0WdSuUPJqGPlIIUln4wz4NVqq0z2eL7zH7CkZxVQZ90SMSk6q66sK5R42vTahBXX98
        AnlDmuF4X4nZxoeqy5nLftBhx
X-Received: by 2002:a17:906:63c9:: with SMTP id u9mr13178575ejk.487.1590251660272;
        Sat, 23 May 2020 09:34:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7dhtvhIMSi54iwS+CUxrxgAY6k5WRmLc4pl9vgr9H/PwlkHIpt/cYv0rq9eje8EQckB2j8Q==
X-Received: by 2002:a17:906:63c9:: with SMTP id u9mr13178556ejk.487.1590251659992;
        Sat, 23 May 2020 09:34:19 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f5sm11154367edj.1.2020.05.23.09.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 09:34:18 -0700 (PDT)
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
In-Reply-To: <20200521183832.GB46035@redhat.com>
References: <20200511164752.2158645-1-vkuznets@redhat.com> <20200511164752.2158645-3-vkuznets@redhat.com> <20200521183832.GB46035@redhat.com>
Date:   Sat, 23 May 2020 18:34:17 +0200
Message-ID: <87sgfq8vau.fsf@vitty.brq.redhat.com>
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
>
> Hi Vitaly,
>
> Given we are redoing it, can we convert "reason" into a flag instead
> and use bit 0 for signalling "page not present" Then rest of the 31
> bits can be used for other purposes. I potentially want to use one bit to
> signal error (if it is known at the time of injecting #PF).

Yes, I think we can do that. The existing KVM_PV_REASON_PAGE_READY and
KVM_PV_REASON_PAGE_NOT_PRESENT are mutually exclusive and can be
converted to flags (we'll only have KVM_PV_REASON_PAGE_NOT_PRESENT in
use when this series is merged).

>
>> -	__u8 pad[60];
>> +	__u32 pageready_token;
>> +	__u8 pad[56];
>
> Given token is 32 bit, for returning error in "page ready" type messages,
> I will probably use padding bytes and create pagready_flag and use one
> of the bits to signal error.

In case we're intended to pass more data in synchronous notifications,
shall we leave some blank space after 'flags' ('reason' previously) and
before 'token'?

-- 
Vitaly

