Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF40C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 489FA206F7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWnXdG89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbgFRMyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:54:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34015 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726909AbgFRMyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592484890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GFWBe5zShZuKjAbK8diRva50YzmRg/DMEjWSnvAfB8Y=;
        b=OWnXdG892UlbbQHnFU0w0I7x+kwp6YEP/VNn11CjcXoPQ9XR7VAoUBMO0CctO0rwk9zhNB
        SRLffvVcS0yiAZWgdSu+LpP3BafJOkiqBQI53PAUYJfZMebgvzud57l4g5EfUqDtlmf9ce
        rEEkXBGa8BQugFROD6Tj/P9CZNFgURI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-YJrgl8BYNMisk3oMrhsmwg-1; Thu, 18 Jun 2020 08:54:49 -0400
X-MC-Unique: YJrgl8BYNMisk3oMrhsmwg-1
Received: by mail-ed1-f72.google.com with SMTP id x24so2229855edl.20
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=GFWBe5zShZuKjAbK8diRva50YzmRg/DMEjWSnvAfB8Y=;
        b=IpjQ0EPNuciO6AAWuu2OyodXJ+iXbpgHL/7z5YDQYiF4Zz3Ju3H9BbCCyBSUdESHpa
         OQ5C5uInXmT/acwkiykEcTlaVVv+LJgsOtIg2R6OoGxdF8cDkt4802W6WGzELZ8vsw/B
         ADpOVovZENpNW7qUCSBmU5g435A5WePny3dX2yQ9qZQAlYPloVMgKT3ZwzmxGH5Bulgt
         feqEF266m7ekn08HmhgtQLBqmWcN00MCMsQ2xBjxSgFdDJ3w3gFsxugrkPl7TIXEaBGo
         RE3G5NhRfkcOyvJD32zPYdnWfrzJj3JSCyPe9DCLfoGynt8KZfiRS4ZFQ1Not17kQHzs
         S+dg==
X-Gm-Message-State: AOAM531e7TX+iNOCdIByDUyC4/1lRGrcRNdF43aCTL63txVpvOqE3xvy
        W0g1AO5R9+70H7nsC8yaLW/3zTagbrzEKYEas4N+ttCLmstlN0D0J5IipTwAYLQcYHOs0tyTj+l
        G2dzuDYtrXUCqVzTYFKFJvLy4
X-Received: by 2002:a17:906:c317:: with SMTP id s23mr3617472ejz.311.1592484887493;
        Thu, 18 Jun 2020 05:54:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRngFvcNIFMCnpL9zk3fKov7ZL02XwX7tWjBgDoozUFRVE2MF9vR2PEm8PRvEU9vHi3nYP+Q==
X-Received: by 2002:a17:906:c317:: with SMTP id s23mr3617452ejz.311.1592484887278;
        Thu, 18 Jun 2020 05:54:47 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id me8sm2255441ejb.28.2020.06.18.05.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 05:54:46 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Like Xu <like.xu@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: SVM: emulate MSR_IA32_PERF_CAPABILITIES
In-Reply-To: <adc8b307-4ec4-575f-ff94-c9b820189fb1@redhat.com>
References: <20200618111328.429931-1-vkuznets@redhat.com> <adc8b307-4ec4-575f-ff94-c9b820189fb1@redhat.com>
Date:   Thu, 18 Jun 2020 14:54:45 +0200
Message-ID: <87ftash6ui.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 18/06/20 13:13, Vitaly Kuznetsov wrote:
>> state_test/smm_test selftests are failing on AMD with:
>> "Unexpected result from KVM_GET_MSRS, r: 51 (failed MSR was 0x345)"
>> 
>> MSR_IA32_PERF_CAPABILITIES is an emulated MSR on Intel but it is not
>> known to AMD code, emulate it there too (by returning 0 and allowing
>> userspace to write 0). This way the code is better prepared to the
>> eventual appearance of the feature in AMD hardware.
>> 
>> Fixes: 27461da31089 ("KVM: x86/pmu: Support full width counting")
>> Suggested-by: Jim Mattson <jmattson@google.com>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/svm/pmu.c | 29 ++++++++++++++++++++++++++++-
>>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> This is okay and I'll apply it, but it would be even better to move the
> whole handling of the MSR to common x86 code.

I thought about that but intel_pmu_set_msr() looks at
vmx_get_perf_capabilities(), we'll need to abstract this somehow.

-- 
Vitaly

