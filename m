Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A5BC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1285920720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAeMY/d+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGJPXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:23:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45597 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726977AbgGJPXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594394586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hVCnQ8dSz5bzqPfVKUA5yGVKNr0A/IBOxZrAZfXjfV4=;
        b=NAeMY/d+jJ5JqEy0p6riS+7XhmmTJcxWSUxdWP4rwrzLJbi3NJ4PdU61Xmh2mLtp/fjGMY
        PA6vQbiT9gOV/7uBfC575Ntt7oTiXuvFh8J6gKCUDlVf/Xxb1lNSWcaIne8JS1bMqQJTh7
        6rzi9GJXB2Z7RhFQSs8CiyG4/Pl3KWs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-EpfglaWmOZSuOehCwgwQEA-1; Fri, 10 Jul 2020 11:23:05 -0400
X-MC-Unique: EpfglaWmOZSuOehCwgwQEA-1
Received: by mail-wr1-f69.google.com with SMTP id e11so6386967wrs.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 08:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hVCnQ8dSz5bzqPfVKUA5yGVKNr0A/IBOxZrAZfXjfV4=;
        b=neohbLCwyhg85AZwmVuhwnKmDo+HA6bll2ck6D31lclOcSx0URFhueMPtfCE2tvPWv
         n/72jVx9NDjNlVbPLh+UtxxDXwVny/1XxuzhdUgyMY+v0xCxeRRxZEMHKP7IpdcgnEOl
         cxZ2ZgIm4OSmb7eSbcZ2pcRSdU/4TmEVRyNDRWeCV0pcYJ5ALzTpeWBY108Y4wYxn263
         JMu/VL7ezuxsdkcMo43tLR/wwFzWcGIZx8QvqA1DKox+Vuym/BWkYT7RYP+ggcyQ+zwk
         D2MCYq/MrTClDORe+O5BB4eQPFsjPoYkdThaGQJT3TqWhKXbqaqD8aBP/meK7uHLo+c7
         CbWw==
X-Gm-Message-State: AOAM5331D7GuKNf9UeiXGJtSWUi75AsAR/vepYUQJQjx1NTILumm2RFz
        Z2tXXIIgNU2of3NYBTwDwWLE7rTe+VVDQoatJ8fr80ZenLrJO15DqaPYbX1L/HyWAz44R5r8P9t
        EcYucJ14EXONi5RMtRS88kkVt
X-Received: by 2002:a5d:538e:: with SMTP id d14mr68529933wrv.21.1594394583423;
        Fri, 10 Jul 2020 08:23:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9ptpqdTBcz0hnt0FWLyQCyrYqXHcZfxjoO54Ukv+e5iAty/J9EaAh2L7CGpLawRB/P9R/Hw==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr68529912wrv.21.1594394583169;
        Fri, 10 Jul 2020 08:23:03 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 69sm10490303wma.16.2020.07.10.08.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 08:23:02 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Like Xu <like.xu@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: SVM: emulate MSR_IA32_PERF_CAPABILITIES
In-Reply-To: <8e3b2eef-b4f1-01cc-e033-c1ece70bd7db@redhat.com>
References: <20200618111328.429931-1-vkuznets@redhat.com> <adc8b307-4ec4-575f-ff94-c9b820189fb1@redhat.com> <87ftash6ui.fsf@vitty.brq.redhat.com> <8e3b2eef-b4f1-01cc-e033-c1ece70bd7db@redhat.com>
Date:   Fri, 10 Jul 2020 17:23:01 +0200
Message-ID: <875zavv1gq.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 18/06/20 14:54, Vitaly Kuznetsov wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> 
>>> On 18/06/20 13:13, Vitaly Kuznetsov wrote:
>>>> state_test/smm_test selftests are failing on AMD with:
>>>> "Unexpected result from KVM_GET_MSRS, r: 51 (failed MSR was 0x345)"
>>>>
>>>> MSR_IA32_PERF_CAPABILITIES is an emulated MSR on Intel but it is not
>>>> known to AMD code, emulate it there too (by returning 0 and allowing
>>>> userspace to write 0). This way the code is better prepared to the
>>>> eventual appearance of the feature in AMD hardware.
>>>>
>>>> Fixes: 27461da31089 ("KVM: x86/pmu: Support full width counting")
>>>> Suggested-by: Jim Mattson <jmattson@google.com>
>>>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>>>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>>>> ---
>>>>  arch/x86/kvm/svm/pmu.c | 29 ++++++++++++++++++++++++++++-
>>>>  1 file changed, 28 insertions(+), 1 deletion(-)
>>> This is okay and I'll apply it, but it would be even better to move the
>>> whole handling of the MSR to common x86 code.
>> I thought about that but intel_pmu_set_msr() looks at
>> vmx_get_perf_capabilities(), we'll need to abstract this somehow.
>
> Indeed, you could use kvm_get_msr_feature for that.
>

Turns out I completely forgot about this patch and just stumbled about
the same issue again. The suggestion to move this to common x86 code
makes perfect sense, I'll be sending v3 shortly.

Thanks!

-- 
Vitaly

