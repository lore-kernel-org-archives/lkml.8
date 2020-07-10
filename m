Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00957C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEAFA20767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1vmIKp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgGJJ1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:27:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27020 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726288AbgGJJ1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594373265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/KCNOjvhcmN9tHZIJ5geCf/PPeLc9q3ydsQmHFPRwbs=;
        b=C1vmIKp+0eE9a2C9h8KMEcTC7bgZ8gfm63FFTKCVRQ+vpOYuWX8UbBFL8qPiqGfADtbFyF
        lO76561LIOVgEhoPx7z1n/pZTOyZjEKUSEFV48+NF+7Ve8rRze8vYQVRFaPtQ1M0Tokbs6
        LmFX975EtoFjqSS5nVLPDM+6YydvUKE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-t8IdKv8IMNih35SmaC2R7A-1; Fri, 10 Jul 2020 05:27:43 -0400
X-MC-Unique: t8IdKv8IMNih35SmaC2R7A-1
Received: by mail-wm1-f72.google.com with SMTP id g138so5972946wme.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/KCNOjvhcmN9tHZIJ5geCf/PPeLc9q3ydsQmHFPRwbs=;
        b=QfxHKZ2O9mbbvSjUH89YM3DGSM3WLvSeqtmbf5lhUKAxHvngJ9lGsxWz8iqhITay4E
         jVPkRvObCZuTuZupoasi3bRgV4cog/9am5sUwRsBWUao3WvjuUjPhRWJggufODFbHSsP
         ufUtyZPC6JsqJRGkOgMtARWsvHKMyanHI4Nx34sXGq+XOZe3F56W6A9qGolNn9DK94NL
         dQwhkJ2igAEJ9AkSwvLpQJFPMw8dXslwHVaakgbmWYxejSUGE8cC6YIZhS6CxjH7zkVw
         UAoQJfjK9Q0Ca3EezqnDWui1KYm/L6bc9QfrxIJFXGIK5k+nGpclxyj5Ep8rk1wbZn2Z
         8EFg==
X-Gm-Message-State: AOAM531RgIHsPwhL7KYZn/KdvXdeuszjksKoAw6VzUGpinzTlJztl8xB
        gYJgA1H64bXRKdzpo5yBj2PXi+n0JubBvsJNq34fa1M+kxMYYyxhw/UaD07Vo36T6RCMEqDwJ68
        uwAQhA7fC51KWwtP67T0epcnu
X-Received: by 2002:a1c:4804:: with SMTP id v4mr4247194wma.139.1594373262594;
        Fri, 10 Jul 2020 02:27:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPF0u9Z6v9ZPKyb3nZ/etss6BBCtK5QCsw/TY8+VEZaQcKuN1hFqj++yJ+ryUN2sEckplufg==
X-Received: by 2002:a1c:4804:: with SMTP id v4mr4247185wma.139.1594373262370;
        Fri, 10 Jul 2020 02:27:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id t4sm9089741wmf.4.2020.07.10.02.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 02:27:41 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: nVMX: fixes for preemption timer migration
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Makarand Sonare <makarandsonare@google.com>,
        Jim Mattson <jmattson@google.com>
References: <20200709172801.2697-1-pbonzini@redhat.com>
 <20200710090530.evy5ezrhnskywbt2@steredhat>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <311c1b21-82fb-396b-382e-d4caca0cb691@redhat.com>
Date:   Fri, 10 Jul 2020 11:27:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200710090530.evy5ezrhnskywbt2@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/20 11:05, Stefano Garzarella wrote:
> Hi Paolo,
> 
> On Thu, Jul 09, 2020 at 01:28:01PM -0400, Paolo Bonzini wrote:
>> Commit 850448f35aaf ("KVM: nVMX: Fix VMX preemption timer migration",
>> 2020-06-01) accidentally broke nVMX live migration from older version
>> by changing the userspace ABI.  Restore it and, while at it, ensure
>> that vmx->nested.has_preemption_timer_deadline is always initialized
>> according to the KVM_STATE_VMX_PREEMPTION_TIMER_DEADLINE flag.
>>
>> Cc: Makarand Sonare <makarandsonare@google.com>
>> Fixes: 850448f35aaf ("KVM: nVMX: Fix VMX preemption timer migration")
>> Reviewed-by: Jim Mattson <jmattson@google.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> v1->v2: coding style [Jim]
>>
>>  arch/x86/include/uapi/asm/kvm.h | 5 +++--
>>  arch/x86/kvm/vmx/nested.c       | 1 +
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
>> index 17c5a038f42d..0780f97c1850 100644
>> --- a/arch/x86/include/uapi/asm/kvm.h
>> +++ b/arch/x86/include/uapi/asm/kvm.h
>> @@ -408,14 +408,15 @@ struct kvm_vmx_nested_state_data {
>>  };
>>  
>>  struct kvm_vmx_nested_state_hdr {
>> -	__u32 flags;
>>  	__u64 vmxon_pa;
>>  	__u64 vmcs12_pa;
>> -	__u64 preemption_timer_deadline;
>>  
>>  	struct {
>>  		__u16 flags;
>>  	} smm;
>> +
>> +	__u32 flags;
>> +	__u64 preemption_timer_deadline;
>>  };
>>  
> 
> Should we update also Documentation/virt/kvm/api.rst to be consistent?

Yes, of course.  Thanks for pointing it out.

Paolo

