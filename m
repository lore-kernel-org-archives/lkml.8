Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97A8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80B35207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hi+jKuFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgFQLiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 07:38:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37303 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726879AbgFQLiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592393886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oS2sHeOWkDi5/NnXrNwUVCA9Ew0qnl4Cg+hQYeorxVM=;
        b=hi+jKuFXEx7wcmDZxxEWD6G0Vfl0Ama/z523llu6qHix6K94zWGwVdk8TIz+K7KaKmNl+s
        8Spv6CYdFhKuWoq5Cz2LHl7zYgkED1fRpN1VPrA6urIhQ6jxQDw2x8Y+0TwZv08GdOQRg4
        EuFCvfMs9++FCC6CB/NMHOGqZ96XsBs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-m2dfZQHAO5KuHX4b0HuHNA-1; Wed, 17 Jun 2020 07:38:04 -0400
X-MC-Unique: m2dfZQHAO5KuHX4b0HuHNA-1
Received: by mail-ej1-f71.google.com with SMTP id op14so898132ejb.15
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 04:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=oS2sHeOWkDi5/NnXrNwUVCA9Ew0qnl4Cg+hQYeorxVM=;
        b=slrMPy+iDDEZWYN/dMEin/bbZ9f4ai7htN94ieZ7WEDKYGNJKfm1yefxq7qigolWnJ
         VQ/5Czt4D9tf0pmaaRwiYcT07O/CweCacBgWw9Yx7U936SbBJvJOSOhw8iR20iEEq901
         ZJl95gDaH0Q+6bLw+WLoLlHRku1+B5kc98XoxZr2Jh2238bp0ztq+L/mN9hy3W8hKs9P
         YV2L4Ut11vjXmwMyoMMEuBUL5XPtGBkGCAV4oTWQxk2FzNuTdgRth1VWq1vYxmjOo8WF
         m5BV+9ad2KqiJTzRGV2MVYWSs8LlBaQX5psivTzQHWPqDbcXdMzvnCUdS9xI7UrGpsdq
         qubA==
X-Gm-Message-State: AOAM531Zp9Ay+K84j7S7VtdH5v43pOR2rXXBxZevbuii8Pf70dEfgFXW
        vrPP3huiRE1g6SMd9VUgdEnAfEhCRaMuxGrumLn9beMIzX2Y0qbGisUfCf0BlLZMlyGsP4FAi9X
        DuBeanNZlziBJsU6CWxjagD8Y
X-Received: by 2002:a05:6402:1512:: with SMTP id f18mr7008261edw.101.1592393883362;
        Wed, 17 Jun 2020 04:38:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJArYTpIQqF0kcPvSiZNCMpM4scmG/Pu1RYbyYqnZ4Pb4T9s1BJXq1/3aoKfzT/Ftt5o3QDg==
X-Received: by 2002:a05:6402:1512:: with SMTP id f18mr7008246edw.101.1592393883098;
        Wed, 17 Jun 2020 04:38:03 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id v5sm11829338edl.51.2020.06.17.04.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 04:38:02 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Like Xu <like.xu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: SVM: drop MSR_IA32_PERF_CAPABILITIES from emulated MSRs
In-Reply-To: <CALMp9eQ1qe4w5FojzgsUHKpD=zXqen_D6bBg4-vfHa03BdomGA@mail.gmail.com>
References: <20200616161427.375651-1-vkuznets@redhat.com> <CALMp9eSWXGQkOOzSrALfZDMj5JHSH=CsK1wKfdj2x2jtV4XJsw@mail.gmail.com> <87366vhscx.fsf@vitty.brq.redhat.com> <CALMp9eQ1qe4w5FojzgsUHKpD=zXqen_D6bBg4-vfHa03BdomGA@mail.gmail.com>
Date:   Wed, 17 Jun 2020 13:38:01 +0200
Message-ID: <87wo45hqhy.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Mattson <jmattson@google.com> writes:

> On Tue, Jun 16, 2020 at 9:45 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> Jim Mattson <jmattson@google.com> writes:
>>
>> > On Tue, Jun 16, 2020 at 9:14 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> >>
>> >> state_test/smm_test selftests are failing on AMD with:
>> >> "Unexpected result from KVM_GET_MSRS, r: 51 (failed MSR was 0x345)"
>> >>
>> >> MSR_IA32_PERF_CAPABILITIES is an emulated MSR indeed but only on Intel,
>> >> make svm_has_emulated_msr() skip it so it is not returned by
>> >> KVM_GET_MSR_INDEX_LIST.
>> >
>> > Do we need to support this MSR under SVM for cross-vendor migration?
>> > Or, have we given up on that?
>>
>> To be honest I'm not sure about the status of cross-vendor migration in
>> general and PMU implications in particular, hope Paolo/Sean can shed
>> some light. In this particular case my shallow understanding is that
>> MSR_IA32_PERF_CAPABILITIES has only one known feature bit which unlocks
>> an MSR range with additional counters. If the feature bit is not set
>> this, I guess, can easily be migrated (basically, let's allow writing
>> '0' there on AMD and return '0' on read). But what if the feature was
>> enabled? We'll have to support the new MSR range and do something with
>> it after migration (run intel_pmu in fully emulated mode?).
>>
>> Anyway, the immediate issue I'm trying to fix here is: whatever is
>> returned by KVM_GET_MSR_INDEX_LIST can be successfully queried with
>> KVM_GET_MSRS as some userspaces count on that.
>
> That's a nice property. Is it documented somewhere?
>

Hm, good question.

Documentation/virt/kvm/api.rst says:

"KVM_GET_MSR_INDEX_LIST returns the guest msrs that are supported.  The list
varies by kvm version and host processor, but does not change otherwise.

[...]

KVM_GET_MSR_FEATURE_INDEX_LIST returns the list of MSRs that can be passed
to the KVM_GET_MSRS system ioctl.  This lets userspace probe host capabilities
and processor features that are exposed via MSRs (e.g., VMX capabilities)."

Side note: MSR_IA32_PERF_CAPABILITIES can be returned by both
KVM_GET_MSR_INDEX_LIST and KVM_GET_MSR_FEATURE_INDEX_LIST as we have it
both as an emulated MSR filtered by kvm_x86_ops.has_emulated_msr() and
a feature msr filtered by kvm_x86_ops.get_msr_feature(). But the later
is a whitelist so MSR_IA32_PERF_CAPABILITIES won't appear on AMD and the
promise "can be passed to the KVM_GET_MSRS" is kept.

For KVM_GET_MSR_INDEX_LIST, the promise is "guest msrs that are
supported" and I'm not exactly sure what this means. Personally, I see
no point in returning MSRs which can't be read with KVM_GET_MSRS (as
this also means the guest can't read them) and KVM selftests seem to
rely on that (vcpu_save_state()) but this is not a documented feature.

> Reviewed-by: Jim Mattson <jmattson@google.com>
>

Thanks!

-- 
Vitaly

