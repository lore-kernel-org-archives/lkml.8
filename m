Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BB4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B5A4207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVaQKom3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgGIR0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:26:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40272 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727856AbgGIR0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594315570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uFc/trZcRn6id+2Jodje/4+rCQG3ueaY+h99MJwSJZU=;
        b=jVaQKom3M1mgsz0yC/QyibWAjk84mNpyM7WovGIcOHcWi5f9XjnvQu3E+2T+CyRQKKHGKg
        L4jVOwjuYaKBC019plmEUJKxqLHTBceRDTqOTuIQ8jOTZ03o6wBzdqpDWPf8LRIl63ep+P
        htRYpYTJHPn4pIPzHfyN9cHd4ymSU5c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-m9g0hj7INWaITjAPBhqS6w-1; Thu, 09 Jul 2020 13:26:09 -0400
X-MC-Unique: m9g0hj7INWaITjAPBhqS6w-1
Received: by mail-wm1-f70.google.com with SMTP id s134so2836576wme.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 10:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uFc/trZcRn6id+2Jodje/4+rCQG3ueaY+h99MJwSJZU=;
        b=gcLlJ0zljimU1jqkgZlcFGlSVa6g4CfVeXwxwj8QFIgq7Q9AEKO9XT2Uy83uiop8wi
         HiTFDhlx1CGKfI19obXI6hdSLiZCGppSV3bXjJK0l1jOBa9P6FKqiHzd73d1KFdAT4CB
         uBdQb/33pMvRb9O0SmOk2XAMd8SxExl8vnyxszkLtURcG5rBo+6O6k8El0Dfx1icuerg
         Cn5FiT03hIHndY2VLZqgLmX5hWPqaEfKp4LQOvNOA4C4jEilE0nMYvwcIrmltKGHn9nO
         3yjAzL2a5EsYkMaJnht2NKMVBUloxlDTCa0ANfJrd40GB9dSPUPfNRCPLioFhLTkZrlI
         ZvpA==
X-Gm-Message-State: AOAM533PTIXdQVx3lugY0SqAU3BQu1kuNcDQ/+lvzMosYEqXkU76+Nk9
        eQ+Ya8rYKEPGxeQpw146uLg1oOOMJixdLKprTcGIQtRPY8XUsL/1rH/bmpkS54ijdMslsp7XJ6g
        37F5/5kXmYLMAMPHVzJO/WI9W
X-Received: by 2002:a7b:c84d:: with SMTP id c13mr1051779wml.170.1594315567632;
        Thu, 09 Jul 2020 10:26:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKr2j3I2+uMuU511bYBwA2TJY/994OQCwPs1wf2qQXfyG7QJ0FqlNIMtL3R5clnqi7mEo/uA==
X-Received: by 2002:a7b:c84d:: with SMTP id c13mr1051757wml.170.1594315567351;
        Thu, 09 Jul 2020 10:26:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id 26sm5364447wmj.25.2020.07.09.10.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 10:26:06 -0700 (PDT)
Subject: Re: [PATCH] KVM: nVMX: fixes for preemption timer migration
To:     Jim Mattson <jmattson@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, Bandan Das <bsd@redhat.com>,
        Makarand Sonare <makarandsonare@google.com>
References: <20200709171507.1819-1-pbonzini@redhat.com>
 <CALMp9eQPqUUDzzkdHbq05VPFfgm=fP4O6=47ZV7q5eOEVNFPXQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <19db6c02-4835-55ba-410f-a85cc4875c71@redhat.com>
Date:   Thu, 9 Jul 2020 19:26:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eQPqUUDzzkdHbq05VPFfgm=fP4O6=47ZV7q5eOEVNFPXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/20 19:23, Jim Mattson wrote:
> On Thu, Jul 9, 2020 at 10:15 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> Commit 850448f35aaf ("KVM: nVMX: Fix VMX preemption timer migration",
>> 2020-06-01) accidentally broke nVMX live migration from older version
>> by changing the userspace ABI.  Restore it and, while at it, ensure
>> that vmx->nested.has_preemption_timer_deadline is always initialized
>> according to the KVM_STATE_VMX_PREEMPTION_TIMER_DEADLINE flag.
>>
>> Cc: Makarand Sonare <makarandsonare@google.com>
>> Fixes: 850448f35aaf ("KVM: nVMX: Fix VMX preemption timer migration")
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  arch/x86/include/uapi/asm/kvm.h | 5 +++--
>>  arch/x86/kvm/vmx/nested.c       | 3 ++-
>>  2 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
>> index 17c5a038f42d..0780f97c1850 100644
>> --- a/arch/x86/include/uapi/asm/kvm.h
>> +++ b/arch/x86/include/uapi/asm/kvm.h
>> @@ -408,14 +408,15 @@ struct kvm_vmx_nested_state_data {
>>  };
>>
>>  struct kvm_vmx_nested_state_hdr {
>> -       __u32 flags;
>>         __u64 vmxon_pa;
>>         __u64 vmcs12_pa;
>> -       __u64 preemption_timer_deadline;
>>
>>         struct {
>>                 __u16 flags;
>>         } smm;
>> +
>> +       __u32 flags;
>> +       __u64 preemption_timer_deadline;
>>  };
>>
>>  struct kvm_svm_nested_state_data {
>> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
>> index b26655104d4a..3fc2411edc92 100644
>> --- a/arch/x86/kvm/vmx/nested.c
>> +++ b/arch/x86/kvm/vmx/nested.c
>> @@ -6180,7 +6180,8 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
>>                 vmx->nested.has_preemption_timer_deadline = true;
>>                 vmx->nested.preemption_timer_deadline =
>>                         kvm_state->hdr.vmx.preemption_timer_deadline;
>> -       }
>> +       } else
>> +               vmx->nested.has_preemption_timer_deadline = false;
> 
> Doesn't the coding standard require braces around the else clause?

Yes, indeed.

Paolo

> Reviewed-by: Jim Mattson <jmattson@google.com>
> 

