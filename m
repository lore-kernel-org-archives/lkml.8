Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662FCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41C44206EB
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOhvjgyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404688AbgFYMXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:23:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27285 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404508AbgFYMXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 08:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593087781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IIlCDhNXpuEM1XOmKAIdxZeWNRlYXHDJyHbMKlrYpqM=;
        b=TOhvjgyMGtgNVPK3FNh5iPndnPk/SvboiENDoAZOlCGVbWO82LbD+J95cjiMqiMnjTjhjG
        yLaDxRQ4IGJcLaVyWdD0jIQ1dBfMbNhJg7rxeAGA5b6LrDXm0GoOAWeeHg8uZdmwtXxVl1
        EGj/WKOrAUrQaiiWpp/QTZkIlFxkg2g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-j6K6ZRSDP_a7e5HK6KO5dg-1; Thu, 25 Jun 2020 08:22:59 -0400
X-MC-Unique: j6K6ZRSDP_a7e5HK6KO5dg-1
Received: by mail-wm1-f69.google.com with SMTP id t145so6932881wmt.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 05:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IIlCDhNXpuEM1XOmKAIdxZeWNRlYXHDJyHbMKlrYpqM=;
        b=EPlegIrFz4RIpkP73VUZr66elLasInjl3Xkr2x5RP0tBTPiR3aHzg9gHsTYpYnHQBR
         1rPQqM2eDJXzlvtFRlDlQPzMP5mteZNWngzQtx69zEyGNvvgl+yKK6NiSvwqvzCrVLqx
         EVudlHaAe7nb5YArukgnTOaJ6DeeIrjkRr7z2pJGpmdTwNdmws33+QLM+BcSvnizl1Fu
         7yZF4AfEYsuE/LxsaRyL+PMetrD/mycNK5Ql/wt7+UXVxQGBjHkUK0UJT2sUAaV8kUQh
         xONfY5rc+x9/Pv7pTXanp+kvKztEvsfik+vJX9HsApwz541heP+Gs16hmgRl3WAD42/g
         ikww==
X-Gm-Message-State: AOAM530AVllBxMRRg1YJAAHwt++JJ8IJyEIcmsN7x91WJWgx0FNw38b/
        DZBmhpPvksWHd/pas9u2rNJAFHWY/hE0tGv5Av3Z+pkbSHBW9OHOM9d+fWdqJAv6mmPtkyn1+E8
        jEta7fzgz4lj0KWeN7qRShRM/
X-Received: by 2002:a1c:dcc2:: with SMTP id t185mr3289186wmg.91.1593087778121;
        Thu, 25 Jun 2020 05:22:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyT6zssfCFX3oMvkQEexRiemlhI7sv150sohXM20lTIZ6oWHBW8BZGggektIBSGSg/1XsqFkw==
X-Received: by 2002:a1c:dcc2:: with SMTP id t185mr3289165wmg.91.1593087777890;
        Thu, 25 Jun 2020 05:22:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:91d0:a5f0:9f34:4d80? ([2001:b07:6468:f312:91d0:a5f0:9f34:4d80])
        by smtp.gmail.com with ESMTPSA id n17sm18831145wrs.2.2020.06.25.05.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 05:22:57 -0700 (PDT)
Subject: Re: [PATCH 0/4] KVM: SVM: Code move follow-up
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
References: <20200625080325.28439-1-joro@8bytes.org>
 <87r1u3cwvd.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2dd04a8d-774b-b384-a423-fc7fcbd32b2b@redhat.com>
Date:   Thu, 25 Jun 2020 14:22:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87r1u3cwvd.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/20 11:34, Vitaly Kuznetsov wrote:
> Joerg Roedel <joro@8bytes.org> writes:
> 
>> From: Joerg Roedel <jroedel@suse.de>
>>
>> Hi,
>>
>> here is small series to follow-up on the review comments for moving
>> the kvm-amd module code to its own sub-directory. The comments were
>> only about renaming structs and symbols, so there are no functional
>> changes in these patches.
>>
>> The comments addressed here are all from [1].
>>
>> Regards,
>>
>> 	Joerg
>>
>> [1] https://lore.kernel.org/lkml/87d0917ezq.fsf@vitty.brq.redhat.com/
>>

Queued, thanks.

Paolo

> Thank you for the follow-up!
> 
>> Joerg Roedel (4):
>>   KVM: SVM: Rename struct nested_state to svm_nested_state
>>   KVM: SVM: Add vmcb_ prefix to mark_*() functions
>>   KVM: SVM: Add svm_ prefix to set/clr/is_intercept()
>>   KVM: SVM: Rename svm_nested_virtualize_tpr() to
>>     nested_svm_virtualize_tpr()
>>
>>  arch/x86/kvm/svm/avic.c   |   2 +-
>>  arch/x86/kvm/svm/nested.c |   8 +--
>>  arch/x86/kvm/svm/sev.c    |   2 +-
>>  arch/x86/kvm/svm/svm.c    | 138 +++++++++++++++++++-------------------
>>  arch/x86/kvm/svm/svm.h    |  20 +++---
>>  5 files changed, 85 insertions(+), 85 deletions(-)
> 
> Series:
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> 

