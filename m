Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D807EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C6B82074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dd7z9JGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgFIJy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 05:54:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21367 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727001AbgFIJyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 05:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591696492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4yqpZC69FI9gfC+3ZDTxgZNyTtJNF2wwb7CnB1Vobyk=;
        b=Dd7z9JGamnkzFthispxNEjdJwIwwU1SHhP6GI0RYsHaxHsHrTIR+6MgmdgIPMPQYpi6WvZ
        4lHrcMZtMTt4cq675xV7UOrwGShR0T4nOfXtRwR1Q/VA2xSn1INqeEsxmWqh5CISQGXdWC
        7Hj54Ao30fVMz7dHAV9iQZlcflxV6cM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-2o-3CtaaOx6H27whwkdRXw-1; Tue, 09 Jun 2020 05:54:51 -0400
X-MC-Unique: 2o-3CtaaOx6H27whwkdRXw-1
Received: by mail-wm1-f70.google.com with SMTP id p24so544424wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 02:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4yqpZC69FI9gfC+3ZDTxgZNyTtJNF2wwb7CnB1Vobyk=;
        b=Raexe1Smfl+sT9/04wolSrGJ79JDeHO86Ls4nRZRdl7JtHPDc0PkLndvJ5vDUqXNxE
         FhwcRXFKWra/jYXRcKzuoQr7XRboTdeEkr/OLvFEt3KqwXoJuWR/5l0nkAteS9kn7wZB
         DAxF1XKNY98Q0/+utsjsc/IRLakRdzWm5spUJmeedIZMOJsjEMZvvFMdeT3ZTx20wka5
         uq85o7Yobl548maTozUO6OuFdEsdPXJCWzlXTJzHm4ChXRqeX8ynvBjH5dyEap8d7U5o
         Lfp2EEcQOdRsZ4Hjzyo/Ed78/hP8udOHjv58TgMKsTDefAoS8pris10tDpxCf5P++BmI
         4wbA==
X-Gm-Message-State: AOAM531aij/dkg2o+oEbNFIodcd48fzOxxApL1u9skvQbauCH8zzfqit
        uMmIgOkoJar1114yDcVfSeUUYjT03XL6Xu6VoaIZJlgEX0KvLNoZiIyd1HR1FL4IAdjx88A5FBe
        VoQrEj6//rP12lF/r8bzGfrEy
X-Received: by 2002:adf:f389:: with SMTP id m9mr3289940wro.195.1591696489740;
        Tue, 09 Jun 2020 02:54:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwl0kF/fkynjmNqHsGFKgOWSXyai8zIz0vLEr3hLbMZc+5nW7Wqt4YcdTtmSjLLOFi4GirwgQ==
X-Received: by 2002:adf:f389:: with SMTP id m9mr3289924wro.195.1591696489503;
        Tue, 09 Jun 2020 02:54:49 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.172.168])
        by smtp.gmail.com with ESMTPSA id l1sm2957773wrb.31.2020.06.09.02.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 02:54:48 -0700 (PDT)
Subject: Re: [PATCH] KVM: selftests: Ignore KVM 5-level paging support for
 VM_MODE_PXXV48_4K
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergio Perez Gonzalez <sergio.perez.gonzalez@intel.com>,
        Adriana Cervantes Jimenez <adriana.cervantes.jimenez@intel.com>,
        Peter Xu <peterx@redhat.com>
References: <20200528021530.28091-1-sean.j.christopherson@intel.com>
 <ed65de29-a07a-f424-937e-38576e740de7@redhat.com>
 <20200608181658.GD8223@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d6a3de35-f4de-9ae9-4467-cadaf679482d@redhat.com>
Date:   Tue, 9 Jun 2020 11:54:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200608181658.GD8223@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/20 20:16, Sean Christopherson wrote:
> On Thu, May 28, 2020 at 01:55:44PM +0200, Paolo Bonzini wrote:
>> On 28/05/20 04:15, Sean Christopherson wrote:
>>> Explicitly set the VA width to 48 bits for the x86_64-only PXXV48_4K VM
>>> mode instead of asserting the guest VA width is 48 bits.  The fact that
>>> KVM supports 5-level paging is irrelevant unless the selftests opt-in to
>>> 5-level paging by setting CR4.LA57 for the guest.  The overzealous
>>> assert prevents running the selftests on a kernel with 5-level paging
>>> enabled.
>>>
>>> Incorporate LA57 into the assert instead of removing the assert entirely
>>> as a sanity check of KVM's CPUID output.
>>>
>>> Fixes: 567a9f1e9deb ("KVM: selftests: Introduce VM_MODE_PXXV48_4K")
>>> Reported-by: Sergio Perez Gonzalez <sergio.perez.gonzalez@intel.com>
>>> Cc: Adriana Cervantes Jimenez <adriana.cervantes.jimenez@intel.com>
>>> Cc: Peter Xu <peterx@redhat.com>
>>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>>> ---
>>>  tools/testing/selftests/kvm/lib/kvm_util.c | 11 +++++++++--
>>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
>>> index c9cede5c7d0de..74776ee228f2d 100644
>>> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
>>> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
>>> @@ -195,11 +195,18 @@ struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
>>>  	case VM_MODE_PXXV48_4K:
>>>  #ifdef __x86_64__
>>>  		kvm_get_cpu_address_width(&vm->pa_bits, &vm->va_bits);
>>> -		TEST_ASSERT(vm->va_bits == 48, "Linear address width "
>>> -			    "(%d bits) not supported", vm->va_bits);
>>> +		/*
>>> +		 * Ignore KVM support for 5-level paging (vm->va_bits == 57),
>>> +		 * it doesn't take effect unless a CR4.LA57 is set, which it
>>> +		 * isn't for this VM_MODE.
>>> +		 */
>>> +		TEST_ASSERT(vm->va_bits == 48 || vm->va_bits == 57,
>>> +			    "Linear address width (%d bits) not supported",
>>> +			    vm->va_bits);
>>>  		pr_debug("Guest physical address width detected: %d\n",
>>>  			 vm->pa_bits);
>>>  		vm->pgtable_levels = 4;
>>> +		vm->va_bits = 48;
>>>  #else
>>>  		TEST_FAIL("VM_MODE_PXXV48_4K not supported on non-x86 platforms");
>>>  #endif
>>>
>>
>> Queued, thnaks.
>>
>> Paolo
> 
> Looks like this one also got lost in the 5.7 -> 5.8 transition.
> 

Indeed, added back to the queue now.

Paolo

