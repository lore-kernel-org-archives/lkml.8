Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18BAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A9F320738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LapND8sO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbgFVSBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:01:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57786 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730046AbgFVSBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592848910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EiPE/eywHM8Zlh7BqbyFgYnaqP2KFeRz5sUsSupRbV4=;
        b=LapND8sO7FclfJ1RNrt/YIeiOmBCL+6K1h2vaEXk1eqK/e/oYXbM60G160mA2unzoECWHG
        d9mBU0LDPP1W+UVSYx7OPXaXNGhhEZJm6CkHGsJsNCu5/ckUuz7ovx9+g7WH33l8cdm1gw
        d/QBvN7rnwr4Y0uiE09mVwu1CBNOhEg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-5BBtAU7yNJOmbneYzdf6rA-1; Mon, 22 Jun 2020 14:01:48 -0400
X-MC-Unique: 5BBtAU7yNJOmbneYzdf6rA-1
Received: by mail-wr1-f72.google.com with SMTP id i10so7451355wrn.21
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EiPE/eywHM8Zlh7BqbyFgYnaqP2KFeRz5sUsSupRbV4=;
        b=MfYYNoirMqdUw/xVOtj1eGmhNrf9agzMjjh5lj53VIRWgZsgtsI5cGPK4dYatXZ1Sf
         02BuOsfHzJhZf6HMQIYvDcgbQEUzcxTGqFS8URpI6oWVFDTZGx5CdmTPYmBIly93v7ZE
         V2jT+8l5Fve4UiU9KF/A3SDCdCrj9StHK+hGtlWCCrPF894ff+KTFGwB1BcRFqAe2JjD
         l55BgNGPojqux4TQvS8elBGW74FM4R7EKkGkHfKVvvS6LOgrzEpcQp4abiNHpXjxGyjC
         bmagarcp6TsYfriluoLjViPMLvWKUVpMi46hEyZCSmQlCrZzyzINWenvryLqwY3yc/qK
         3gQA==
X-Gm-Message-State: AOAM531Gf9Ql1cXchrIY5r5d7qMpdkpLyznLV1wDWhJ+gtLpW6t1RpKL
        jglLRv71PLUZRT7YiPKgltaxdutWvQzjhsUUjh2MVrgY06t4FO+GLVFdD598oVP6rCbHu+c34ks
        gCGMn2jVMctkvtBO3KxiM82Om
X-Received: by 2002:adf:e80a:: with SMTP id o10mr20912742wrm.185.1592848907194;
        Mon, 22 Jun 2020 11:01:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywKtN0A+o5NJL2EDMhmcg7QtC83uSGVNvOTAksFhKv0w2PvIEBb39TCc2Fpd4C2r7Vr0waSA==
X-Received: by 2002:adf:e80a:: with SMTP id o10mr20912729wrm.185.1592848906985;
        Mon, 22 Jun 2020 11:01:46 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id c5sm380556wmb.24.2020.06.22.11.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 11:01:46 -0700 (PDT)
Subject: Re: [PATCH v2 00/11] KVM: Support guest MAXPHYADDR < host MAXPHYADDR
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Mohammed Gamal <mgamal@redhat.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, babu.moger@amd.com
References: <20200619153925.79106-1-mgamal@redhat.com>
 <5a52fd65-e1b2-ca87-e923-1d5ac167cfb9@amd.com>
 <52295811-f78a-46c5-ff9e-23709ba95a3d@redhat.com>
 <0d1acded-93a4-c1fa-b8f8-cfca9e082cd1@amd.com>
 <40ac43a1-468f-24d5-fdbf-d012bdae49ed@redhat.com>
 <c89bda4a-2db9-6cb1-8b01-0a6e69694f43@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4ed45f38-6a31-32ab-cec7-baade67a8c1b@redhat.com>
Date:   Mon, 22 Jun 2020 20:01:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <c89bda4a-2db9-6cb1-8b01-0a6e69694f43@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/20 19:57, Tom Lendacky wrote:
>>> In bare-metal, there's no guarantee a CPU will report all the faults in a
>>> single PF error code. And because of race conditions, software can never
>>> rely on that behavior. Whenever the OS thinks it has cured an error, it
>>> must always be able to handle another #PF for the same access when it
>>> retries because another processor could have modified the PTE in the
>>> meantime.
>> I agree, but I don't understand the relation to this patch.  Can you
>> explain?
>
> I guess I'm trying to understand why RSVD has to be reported to the guest
> on a #PF (vs an NPF) when there's no guarantee that it can receive that
> error code today even when guest MAXPHYADDR == host MAXPHYADDR. That would
> eliminate the need to trap #PF.

That's an interesting observation!  But do processors exist where either:

1) RSVD doesn't win over all other bits, assuming no race conditions

2) A/D bits can be clobbered in a page table entry that has reserved
bits set?

Running the x86/access.flat testcase from kvm-unit-tests on bare metal
suggests that all existing processors do neither of the above.

In particular, the second would be a showstopper on AMD.

Paolo

