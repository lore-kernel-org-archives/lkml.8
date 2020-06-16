Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D17C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B64F62071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgMiILcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbgFPQpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:45:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34380 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728861AbgFPQpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592325939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ismgysJfJe2CLrWL0LmeWKazpTxHaimsQwhtZ2Vt0UQ=;
        b=RgMiILcIe4EGx+WqBbTbUoY6NL/JWFeeQ6DTQDDsyt7kj7KtEG/pIAc4F50CImoRgBR5gk
        ByXnFiPJwvyuN8ve+CJuWDrIAXUBc4iq22SksnRg6l1sEeqvl91tHqXO71I+cx4OkD68R8
        G8hQYDAl0dTeCLAn5b8xEIAzmQ3jAq8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-aSX_muJuN7eLMWsYc4sC6Q-1; Tue, 16 Jun 2020 12:45:37 -0400
X-MC-Unique: aSX_muJuN7eLMWsYc4sC6Q-1
Received: by mail-ej1-f72.google.com with SMTP id z21so9603492ejl.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:45:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ismgysJfJe2CLrWL0LmeWKazpTxHaimsQwhtZ2Vt0UQ=;
        b=obEsvfMGZhNlMUuxqfpg3M6vTEZVn63IJe5JggCpKjww92BdeYd/ppE+5QsYaqGSxt
         nbE3HTqR9Xx/ze1CUA8udNsoD2KH1DmvD1zgRGFolgeTIEgAZTLIZOykmJUVZCm7oQ0b
         kY1CuAFIxFlGi7St14nZEwoKt8v/OvQFDUTZVcKCR/ODI9pQ5euvWScm8KAdlu/VjY5k
         pMPX4Q1WjV2NLrDZ5ozxqmKR7NjAqCkPyoclnCCbeiByb7hwJ6DpHwVuVsAQef4UyPhl
         tcOC+x3LGZahRZpoTlAUCD20+9M4sQzNIOMmgLSDxFh0wVtKdxXaxswLoNL66+PwvNTm
         9k3A==
X-Gm-Message-State: AOAM533BU7tjsqqCn1CP+uQBkmHfSe2aoCG1VaPOyDT1MFrA3k+rj4Ug
        v1aXv63LPRaWJLmR1FMorQ5SWOIgbPrVN471H0LMRB3KAnMj2MsNopSYxz0aoETm2QWZPOUZvn1
        p2c4eLz4h8ycMdVbv+EhhKBLl
X-Received: by 2002:a50:fd05:: with SMTP id i5mr3314283eds.79.1592325936098;
        Tue, 16 Jun 2020 09:45:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDneB8f/xDlNMJMpcox0nyWfsNpeZIDOB7EkaXqbs8xOHs3NkFJkjWLLuMBH+YlLczpJyl+w==
X-Received: by 2002:a50:fd05:: with SMTP id i5mr3314262eds.79.1592325935901;
        Tue, 16 Jun 2020 09:45:35 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id ce25sm10365363edb.45.2020.06.16.09.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 09:45:35 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Like Xu <like.xu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: SVM: drop MSR_IA32_PERF_CAPABILITIES from emulated MSRs
In-Reply-To: <CALMp9eSWXGQkOOzSrALfZDMj5JHSH=CsK1wKfdj2x2jtV4XJsw@mail.gmail.com>
References: <20200616161427.375651-1-vkuznets@redhat.com> <CALMp9eSWXGQkOOzSrALfZDMj5JHSH=CsK1wKfdj2x2jtV4XJsw@mail.gmail.com>
Date:   Tue, 16 Jun 2020 18:45:34 +0200
Message-ID: <87366vhscx.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Mattson <jmattson@google.com> writes:

> On Tue, Jun 16, 2020 at 9:14 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> state_test/smm_test selftests are failing on AMD with:
>> "Unexpected result from KVM_GET_MSRS, r: 51 (failed MSR was 0x345)"
>>
>> MSR_IA32_PERF_CAPABILITIES is an emulated MSR indeed but only on Intel,
>> make svm_has_emulated_msr() skip it so it is not returned by
>> KVM_GET_MSR_INDEX_LIST.
>
> Do we need to support this MSR under SVM for cross-vendor migration?
> Or, have we given up on that?

To be honest I'm not sure about the status of cross-vendor migration in
general and PMU implications in particular, hope Paolo/Sean can shed
some light. In this particular case my shallow understanding is that
MSR_IA32_PERF_CAPABILITIES has only one known feature bit which unlocks
an MSR range with additional counters. If the feature bit is not set
this, I guess, can easily be migrated (basically, let's allow writing
'0' there on AMD and return '0' on read). But what if the feature was
enabled? We'll have to support the new MSR range and do something with
it after migration (run intel_pmu in fully emulated mode?).

Anyway, the immediate issue I'm trying to fix here is: whatever is
returned by KVM_GET_MSR_INDEX_LIST can be successfully queried with
KVM_GET_MSRS as some userspaces count on that.

-- 
Vitaly

