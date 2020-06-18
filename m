Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD5AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D60207D8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YA7SsuUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgFRNWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:22:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37591 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726940AbgFRNWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592486519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IrGlZfeq1ulUHocq8AnjSLbU7gwN1WZOemxSJQXMZqQ=;
        b=YA7SsuUnTn2kqTVIDZ1ZZZ6AbgDyo2n/XtZO9Ejmu5UO+wKbPLpU+/i0XK2Xuwmteqbxr1
        9DFeknN4rmm7J/LFXY8mr8HJBlgXjvAx/b2STyjPMoXFu0nlKmhdTToG1Tf5gy5RgPLYlm
        qRUTpxwqcNPpbb/Y2M9+BIGLQ1PIV+A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-eTVsuw61NF6N7ON21_d5kw-1; Thu, 18 Jun 2020 09:21:58 -0400
X-MC-Unique: eTVsuw61NF6N7ON21_d5kw-1
Received: by mail-wm1-f70.google.com with SMTP id r1so2576319wmh.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 06:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IrGlZfeq1ulUHocq8AnjSLbU7gwN1WZOemxSJQXMZqQ=;
        b=GeJt4BRSo1yJxJHEtoDjuy/PBd+4Stp2tqy+l6FOFq6Wzze+4TMZrmszSxqVskUJXR
         mfCBRkiQgxFhJk5PAyW325biAkBAeZ0umrvEwz+gqNilrYugxo5300wkZH8m/vM9ZjXb
         SOBE82SdNFKo3nmHEwrDMQ/Hl2AM7pbYmEZENqqWGwilZCj79xmVK0Z+TYs3s3JODEtJ
         iAvxpnRV3JCST/7MKzDesG4n0rBDN6TK8lt97ALH+zBcJokUAowrHBGmv0Tem0ZrK/lD
         0aVNfoZQdKua5PXnoduUhCG6wMaj+ycz7YSf91hD20yAp8JhWHBWYvee6RlVTsn9OMUi
         ItQQ==
X-Gm-Message-State: AOAM530Vbi6e6aeJVtzXtzWk2gSxjfVWEGEVqctaP7gJOcSSlIHAF/xn
        6Nnrtu6y45xl/+NaS5D+kBnO+F1yF/xQPrJnE2fykmqhRnWJR3YC0kdICfoxkDMPTTCp5Hn9dPq
        AA5lFQ/w4IxXHBmzAjhRbNa56
X-Received: by 2002:a1c:2b86:: with SMTP id r128mr4262218wmr.13.1592486516886;
        Thu, 18 Jun 2020 06:21:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymxwdYQWvQbXE8ARnQo904uTYfAl6mm/1E4F5nzGGAimPob6Q2xh4UUsh6Qsvjdqh+1rgImA==
X-Received: by 2002:a1c:2b86:: with SMTP id r128mr4262202wmr.13.1592486516680;
        Thu, 18 Jun 2020 06:21:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e1d2:138e:4eff:42cb? ([2001:b07:6468:f312:e1d2:138e:4eff:42cb])
        by smtp.gmail.com with ESMTPSA id d9sm3490622wre.28.2020.06.18.06.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 06:21:56 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: SVM: emulate MSR_IA32_PERF_CAPABILITIES
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Like Xu <like.xu@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20200618111328.429931-1-vkuznets@redhat.com>
 <adc8b307-4ec4-575f-ff94-c9b820189fb1@redhat.com>
 <87ftash6ui.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8e3b2eef-b4f1-01cc-e033-c1ece70bd7db@redhat.com>
Date:   Thu, 18 Jun 2020 15:21:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87ftash6ui.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/20 14:54, Vitaly Kuznetsov wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 18/06/20 13:13, Vitaly Kuznetsov wrote:
>>> state_test/smm_test selftests are failing on AMD with:
>>> "Unexpected result from KVM_GET_MSRS, r: 51 (failed MSR was 0x345)"
>>>
>>> MSR_IA32_PERF_CAPABILITIES is an emulated MSR on Intel but it is not
>>> known to AMD code, emulate it there too (by returning 0 and allowing
>>> userspace to write 0). This way the code is better prepared to the
>>> eventual appearance of the feature in AMD hardware.
>>>
>>> Fixes: 27461da31089 ("KVM: x86/pmu: Support full width counting")
>>> Suggested-by: Jim Mattson <jmattson@google.com>
>>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>>> ---
>>>  arch/x86/kvm/svm/pmu.c | 29 ++++++++++++++++++++++++++++-
>>>  1 file changed, 28 insertions(+), 1 deletion(-)
>> This is okay and I'll apply it, but it would be even better to move the
>> whole handling of the MSR to common x86 code.
> I thought about that but intel_pmu_set_msr() looks at
> vmx_get_perf_capabilities(), we'll need to abstract this somehow.

Indeed, you could use kvm_get_msr_feature for that.

Paolo

