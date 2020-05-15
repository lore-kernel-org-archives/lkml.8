Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE349C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3052206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewvuW+p5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgEOIg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 04:36:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40990 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726885AbgEOIg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 04:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589531784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rnCzWC+hepdVJSXgaCkvxN/iLlC4gaqxnaWCmO0365Y=;
        b=ewvuW+p5/0H3LvYLVeKhoLQrY/oTtqexLMSHCkAeKLYCKQesltMyW0l/cha7mzzbNkQ2yM
        MkY4g8s/Ul+5tUV4m5hHd0zC0pDZuKwORziYUTIFLOnW3/mDd41JSmr4Qm8xi+3/Uf4tc2
        Cp5SF/PXCVWIhSuDxZgLmC0u49eg1ec=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-64juvt5hNxeFH1K6U-ab3A-1; Fri, 15 May 2020 04:36:23 -0400
X-MC-Unique: 64juvt5hNxeFH1K6U-ab3A-1
Received: by mail-wr1-f69.google.com with SMTP id i9so837377wrx.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 01:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=rnCzWC+hepdVJSXgaCkvxN/iLlC4gaqxnaWCmO0365Y=;
        b=lKf2HHaXVqHkEW6Bzwbb1Y3pUk9bfThw4hh0TsK7suQo5z7/qa5gty6QH/4vf8mW2u
         DmPjb7xdU8YtIp6zI3xVcIs8hFcQz7JgS1WfTBywVn8LJ0YFYzyueOjg6zjOTmfkdyB8
         SlpANSOwQSdtcHM6YGEgVjynO5LPCD2qS/5Z9Jn53+46SG39+7FoPOggu2lBZdzH1GMJ
         YrxpdkB7K+U/BmQ49CeY6MhP7qEwBd7Dm+ztEpJNN0N7Kaq4eLC+5O0KTwWaEYTBraHp
         0SKihPlbZ/ztnCbkK2LCemomUSyNVONAyr+HATtShXVfxNf2Ogr+kSOADOJG0b7Qn97/
         8nJQ==
X-Gm-Message-State: AOAM532Bf7b1S2l7RS9Nl7ZkRKbROCBpGCTee/inrVIFLBkvOutfc7QA
        mA9QhZTlro6LTNcT4DOcxzpt1ksMPh01EYbXAi4vApxMaXBL27/6BANZS8PdR4JpgN/n6FQSC9U
        NnoWYYb7KhIWX1Fk0vQEH3y0q
X-Received: by 2002:adf:94c2:: with SMTP id 60mr2956818wrr.366.1589531781835;
        Fri, 15 May 2020 01:36:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwliq3q2MSh4hgu9dzVJHOMoWpDZHdQyryAZ8K6gfNKKYlAhOV2RGpxC9VHi80inuvkjj1wgA==
X-Received: by 2002:adf:94c2:: with SMTP id 60mr2956801wrr.366.1589531781585;
        Fri, 15 May 2020 01:36:21 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b145sm2650206wme.41.2020.05.15.01.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 01:36:20 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Tsirkin <mst@redhat.com>,
        Julia Suvorova <jsuvorov@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, x86@kernel.org
Subject: Re: [PATCH RFC 4/5] KVM: x86: aggressively map PTEs in KVM_MEM_ALLONES slots
In-Reply-To: <20200514194624.GB15847@linux.intel.com>
References: <20200514180540.52407-1-vkuznets@redhat.com> <20200514180540.52407-5-vkuznets@redhat.com> <20200514194624.GB15847@linux.intel.com>
Date:   Fri, 15 May 2020 10:36:19 +0200
Message-ID: <87ftc1wq64.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Thu, May 14, 2020 at 08:05:39PM +0200, Vitaly Kuznetsov wrote:
>> All PTEs in KVM_MEM_ALLONES slots point to the same read-only page
>> in KVM so instead of mapping each page upon first access we can map
>> everything aggressively.
>> 
>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/mmu/mmu.c         | 20 ++++++++++++++++++--
>>  arch/x86/kvm/mmu/paging_tmpl.h | 23 +++++++++++++++++++++--
>>  2 files changed, 39 insertions(+), 4 deletions(-)
>> 
>> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
>> index 3db499df2dfc..e92ca9ed3ff5 100644
>> --- a/arch/x86/kvm/mmu/mmu.c
>> +++ b/arch/x86/kvm/mmu/mmu.c
>> @@ -4154,8 +4154,24 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
>>  		goto out_unlock;
>>  	if (make_mmu_pages_available(vcpu) < 0)
>>  		goto out_unlock;
>> -	r = __direct_map(vcpu, gpa, write, map_writable, max_level, pfn,
>> -			 prefault, is_tdp && lpage_disallowed);
>> +
>> +	if (likely(!(slot->flags & KVM_MEM_ALLONES) || write)) {
>
> The 'write' check is wrong.  More specifically, patch 2/5 is missing code
> to add KVM_MEM_ALLONES to memslot_is_readonly().  If we end up going with
> an actual kvm_allones_pg backing, writes to an ALLONES memslots should be
> handled same as writes to RO memslots; MMIO occurs but no MMIO spte is
> created.
>

Missed that, thanks!

>> +		r = __direct_map(vcpu, gpa, write, map_writable, max_level, pfn,
>> +				 prefault, is_tdp && lpage_disallowed);
>> +	} else {
>> +		/*
>> +		 * KVM_MEM_ALLONES are 4k only slots fully mapped to the same
>> +		 * readonly 'allones' page, map all PTEs aggressively here.
>> +		 */
>> +		for (gfn = slot->base_gfn; gfn < slot->base_gfn + slot->npages;
>> +		     gfn++) {
>> +			r = __direct_map(vcpu, gfn << PAGE_SHIFT, write,
>> +					 map_writable, max_level, pfn, prefault,
>> +					 is_tdp && lpage_disallowed);
>
> IMO this is a waste of memory and TLB entries.  Why not treat the access as
> the MMIO it is and emulate the access with a 0xff return value?  I think
> it'd be a simple change to have __kvm_read_guest_page() stuff 0xff, i.e. a
> kvm_allones_pg wouldn't be needed.  I would even vote to never create an
> MMIO SPTE.  The guest has bigger issues if reading from a PCI hole is
> performance sensitive.

You're trying to defeat the sole purpose of the feature :-) I also saw
the option you suggest but Michael convinced me we should go further.

The idea (besides memory waste) was that the time we spend on PCI scan
during boot is significant. Unfortunatelly, I don't have any numbers but
we can certainly try to get them. With this feature (AFAIU) we're not
aiming at 'classic' long-living VMs but rather at something like Kata
containers/FaaS/... where boot time is crucial.

>
> Regarding memory, looping wantonly on __direct_map() will eventually trigger
> the BUG_ON() in mmu_memory_cache_alloc().  mmu_topup_memory_caches() only
> ensures there are enough objects available to map a single translation, i.e.
> one entry per level, sans the root[*].
>
> [*] The gorilla math in mmu_topup_memory_caches() is horrendously misleading,
>     e.g. the '8' pages is really 2*(ROOT_LEVEL - 1), but the 2x part has been
>     obsolete for the better part of a decade, and the '- 1' wasn't actually
>     originally intended or needed, but is now required because of 5-level
>     paging.  I have the beginning of a series to clean up that mess; it was
>     low on my todo list because I didn't expect anyone to be mucking with
>     related code :-)

I missed that too but oh well, this is famous KVM MMU, I should't feel
that bad about it :-) Thanks for your review!

>
>> +			if (r)
>> +				break;
>> +		}
>> +	}
>

-- 
Vitaly

