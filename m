Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0B9C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4079620675
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fGuHm0I/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgBLMcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:32:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25669 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727640AbgBLMcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581510725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jFhBtgSX0/7uUXEHu3xDi09Duj0eAVawgfKR4aU8SAY=;
        b=fGuHm0I/3TF2njitMa76wN27CuXNV4/uXq3oLtwW75lNibyCAd6qWxlHocSBCdkbUOgeXb
        cr7u6a9l2q3QGpt8zDpB3+845Ns/bA+auY+6y34KKmk/Ty2KNq6ZLxnHTYP8Rz4fdoUkbk
        MnKiuhlwIBRWNL9ZXzWOgI9hZjlQRb8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-ihRKIlqtOEqyqolRnIoX4A-1; Wed, 12 Feb 2020 07:32:03 -0500
X-MC-Unique: ihRKIlqtOEqyqolRnIoX4A-1
Received: by mail-wm1-f72.google.com with SMTP id a189so665125wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 04:32:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jFhBtgSX0/7uUXEHu3xDi09Duj0eAVawgfKR4aU8SAY=;
        b=l5dT6oLqJrZP//GGGapAP4zYpT3fVobBjmSr+TTviYcn7/pCEoc+QzgCmf+/Zgll5N
         Iu6I7JjOmt+lakRjQFdhNqTqnMD8wbz4ExW8jKKRa6T9xX2/ED5GzQLXpj4UX4OlOEi0
         lVBcRaufKK6MkvumHUEFQwZ1IcYANS5HUyvNUzA7MK5nnQ9c6kVl3cly29LyvHvrSnXi
         UVfax3sAc2eZ46+mYxsDq1GmuYqyk5/KhpJAmXBUs2dNXfb3s2n1VSvAbH0oUf5RF5JK
         U0K64bdc4+PpXzG1BABeutlPSHQqNcreB+IkqjCf6T5Y7BI0HKdEqTJsIHY0vXZFIdxF
         OdHA==
X-Gm-Message-State: APjAAAU3b26JMMeKmALJ/pG35rxAVIpvKBnfxQDWhamUSs8CkAm8SNR6
        JMl5w64Gqtn97dMkRf3w8rFTV2fJCY0wPDN+BkN4X1uME7IvBVAMt1uSQyCIvGA9PHYrSbKxYim
        GcNXj0nqZ+Ui1/5N+k+9NHNFR
X-Received: by 2002:a5d:6886:: with SMTP id h6mr15144938wru.154.1581510721846;
        Wed, 12 Feb 2020 04:32:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqybL8KNyituH0wLu6xowOVQevPeXsPTUSxO/YMHGX038NBFDetmNWKvBDmZgdVL2znEi+z6BQ==
X-Received: by 2002:a5d:6886:: with SMTP id h6mr15144913wru.154.1581510721587;
        Wed, 12 Feb 2020 04:32:01 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:652c:29a6:517b:66d9? ([2001:b07:6468:f312:652c:29a6:517b:66d9])
        by smtp.gmail.com with ESMTPSA id l15sm453755wrv.39.2020.02.12.04.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 04:32:01 -0800 (PST)
Subject: Re: [PATCH][next] KVM: x86: remove redundant WARN_ON check of an
 unsigned less than zero
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Colin King <colin.king@canonical.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200207231813.786224-1-colin.king@canonical.com>
 <20200208004722.GB15581@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <21975038-ae1a-50a1-7fa0-38a1445abe8d@redhat.com>
Date:   Wed, 12 Feb 2020 13:32:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200208004722.GB15581@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/20 01:47, Sean Christopherson wrote:
> On Fri, Feb 07, 2020 at 11:18:13PM +0000, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The check cpu->hv_clock.system_time < 0 is redundant since system_time
>> is a u64 and hence can never be less than zero. Remove it.
>>
>> Addresses-Coverity: ("Macro compares unsigned to 0")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  arch/x86/kvm/x86.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index fbabb2f06273..d4967ac47e68 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -2448,7 +2448,6 @@ static int kvm_guest_time_update(struct kvm_vcpu *v)
>>  	vcpu->hv_clock.tsc_timestamp = tsc_timestamp;
>>  	vcpu->hv_clock.system_time = kernel_ns + v->kvm->arch.kvmclock_offset;
>>  	vcpu->last_guest_tsc = tsc_timestamp;
>> -	WARN_ON(vcpu->hv_clock.system_time < 0);
> 
> Don't know this code well, but @kernel_ns and @v->kvm->arch.kvmclock_offset
> are both s64, so maybe this was intended and/or desirable?
> 
> 	WARN_ON((s64)vcpu->hv_clock.system_time < 0);

Yes, that's related to the bugfix where kvmclock would get negative.  I
queued the patch with the (s64) cast added.  Thanks to both of you!

Paolo

