Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF04C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956712187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WlyYWetZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgAOSHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:07:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31856 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729126AbgAOSHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579111674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7fID6vInRHrxtlo5QRMU7VPDyUEFXJHaww3fjUHk7ZA=;
        b=WlyYWetZ0IwXHVLEwnqwOiPLIFytcnB5KJOzfEaQncJKAKCoJ1wAkKh5kcXsKknkH/ASgc
        UR8vuFcjS/RyLshqWph+tja8UfBMj9klyUirZYSWvusAM7r1fQcodSUYL0vRlcWhawtLsz
        skRNS8X0GHz9SJPOewTFU6lVqjGLUsQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-YyZxsGXrPauJoErqysFj4g-1; Wed, 15 Jan 2020 13:07:53 -0500
X-MC-Unique: YyZxsGXrPauJoErqysFj4g-1
Received: by mail-wr1-f72.google.com with SMTP id f15so8363629wrr.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 10:07:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7fID6vInRHrxtlo5QRMU7VPDyUEFXJHaww3fjUHk7ZA=;
        b=Ukz9id36lk376+tMvDOqTrvAsS/clVGA4OP8/4TDZf1SNvlMDUtKw0LilQ3CdKiOwl
         vgJGnzEsJpn3vc2PnZlUSKrW9JopaLH79lLFj9sKsLmKPc6XwN6ONioxk7KYseyM4JfX
         c3kpTwuCj4lbp7bb7MmycpxwogWjF/GhYjtsEoDNnqi71Pao92QkGp8o/+MRC0OJOvhR
         e2MYeIwjE2FrttqO5AO96earRA6zX+LiFusZp0kf1wK1jJfFkRWf0bIyvmDSoD+YWjRP
         VlWS4Q72ulSbP7tL0hmEB8ehRW4fVzGtJXnpePWH00ovRLA05XJd26517a9eWbarcq/K
         QX9A==
X-Gm-Message-State: APjAAAWIfiIwg2U+kOjAWS9SleRfF8MMuPQ1vJpqH4U7de/YTMTbteJu
        tTieb2VisR1Uj3CKJzfQ/cFH7xylRy4HDDx/sqig6CbrvRNC93EvhLkyc/kgnL81FpeDk81WG56
        aa02Mfbp0iD+BfuR2zmFBvCBA
X-Received: by 2002:a05:600c:1003:: with SMTP id c3mr1208977wmc.120.1579111671873;
        Wed, 15 Jan 2020 10:07:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqys82Zum91O5UUcdGXuiZO+7mBL0scxKfEu+8BKC4UyeYAh+0xj3070ENwDj1Okibs0XoRj2A==
X-Received: by 2002:a05:600c:1003:: with SMTP id c3mr1208948wmc.120.1579111671658;
        Wed, 15 Jan 2020 10:07:51 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:436:e17d:1fd9:d92a? ([2001:b07:6468:f312:436:e17d:1fd9:d92a])
        by smtp.gmail.com with ESMTPSA id s65sm773973wmf.48.2020.01.15.10.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 10:07:47 -0800 (PST)
Subject: Re: [PATCH v2 0/5] KVM: x86: X86_FEATURE bit() cleanup
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191217213242.11712-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d53bd488-b871-47c4-c65c-4c231eff3cf9@redhat.com>
Date:   Wed, 15 Jan 2020 19:07:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191217213242.11712-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/19 22:32, Sean Christopherson wrote:
> Small series to add build-time protections on reverse CPUID lookup (and
> other usages of bit()), and to rename the misleading-generic bit() helper
> to something that better conveys its purpose.
> 
> I don't love emulator changes in patch 1 as adding one-off helpers is a
> bit silly, but IMO it's the lesser of two evils, e.g. adding dedicated
> helpers is arguably less error prone than manually encoding a CPUID
> lookup, and the helpers approach avoids having to include cpuid.h in the
> emulator code.
> 
> v2:
>   - Rework the assertions to use the reverse_cpuid table instead of
>     using the last cpufeatures word (which was not at all intuitive).
> 
> Sean Christopherson (5):
>   KVM: x86: Add dedicated emulator helpers for querying CPUID features
>   KVM: x86: Move bit() helper to cpuid.h
>   KVM: x86: Add CPUID_7_1_EAX to the reverse CPUID table
>   KVM: x86: Expand build-time assertion on reverse CPUID usage
>   KVM: x86: Refactor and rename bit() to feature_bit() macro
> 
>  arch/x86/include/asm/kvm_emulate.h |  4 +++
>  arch/x86/kvm/cpuid.c               |  5 ++--
>  arch/x86/kvm/cpuid.h               | 41 +++++++++++++++++++++++++----
>  arch/x86/kvm/emulate.c             | 21 +++------------
>  arch/x86/kvm/svm.c                 |  4 +--
>  arch/x86/kvm/vmx/vmx.c             | 42 +++++++++++++++---------------
>  arch/x86/kvm/x86.c                 | 18 +++++++++++++
>  arch/x86/kvm/x86.h                 |  5 ----
>  8 files changed, 87 insertions(+), 53 deletions(-)
> 

Queued, thanks.

Paolo

