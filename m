Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B29C4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D236E20838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNL4sjC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgBZO4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:56:00 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33030 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726063AbgBZO4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582728959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fojZvLFP2Jo0NZ519XOD4dNh0bZ+gliF+8E6KslGYjA=;
        b=jNL4sjC3L8n9CA2AYoEk9lLEYDMveZGcFiC5QHJrzFJbkeNmxZoqs5JsC8oOG27Fb0MhCz
        G3A2KWjei64lj0ukHnESo6MPTfs0R3JNP+K3+tycHi0BIyuQdQ7+sozuG0mMBpw1ci6ynE
        SlK68lTEiLjav3IQ0Om0NlHJ/lSrCnM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-Sbbvt-jjMTudwm6EAQcQLw-1; Wed, 26 Feb 2020 09:55:58 -0500
X-MC-Unique: Sbbvt-jjMTudwm6EAQcQLw-1
Received: by mail-wr1-f70.google.com with SMTP id z1so1588406wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 06:55:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fojZvLFP2Jo0NZ519XOD4dNh0bZ+gliF+8E6KslGYjA=;
        b=n1db+c1kPWTt9m83nh3mKLwOfj3/tnxXIVmNHyfSJu7AdybFDNbVIVXN1efiCUbo/P
         M7vUwuOIIeodgAFkVRNeWwzFOoS7/R5HTnvQoVfOL7aWKU2vIKEp65JX53mIX2bsuiHY
         fNMyFufGuF9gBd2qPzqaL8bQE4Az/ce9WyFdQUvaSu61by50RrjJH0H7Y/g5cZGfmrvV
         sPTO1VSPz+Z9Cj1m0PHyBgClrUbdHj0Q9hrkc1Lm34vWCQCcPaceh6RF+g1fFHZldVhh
         f7GRVQZXuSx1yOGoruWRk70mWi+YiL+sGA34gIbFUoihJu/NDC2pXujjVdLtei65f4gx
         ikMg==
X-Gm-Message-State: APjAAAUXL45399yfEOqhxfeAKZzTxbVXFl86YiVZqPdq533c4oAHHM11
        KzocZT9U/Bzz5NoNxImj6/c8wdMu/sO8tFg+PhxWEhkAT6TvwTWBRYmdtsYNTC6uIATgCExQHsc
        J041XfbWawQviWFZNy9rxcmy0
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr6238747wmi.51.1582728956952;
        Wed, 26 Feb 2020 06:55:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqzJF+v50o12fLqZ9qUKolYQX8x00JcZR0zCo7Dv+ZRryekuLYXWmSUoEu+PcKGHBmDxzTkTcg==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr6238717wmi.51.1582728956677;
        Wed, 26 Feb 2020 06:55:56 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b10sm3342471wrt.90.2020.02.26.06.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 06:55:55 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 58/61] KVM: x86/mmu: Configure max page level during hardware setup
In-Reply-To: <20200225210149.GH9245@linux.intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-59-sean.j.christopherson@intel.com> <87blpmlobr.fsf@vitty.brq.redhat.com> <20200225210149.GH9245@linux.intel.com>
Date:   Wed, 26 Feb 2020 15:55:55 +0100
Message-ID: <87k149jt38.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Tue, Feb 25, 2020 at 03:43:36PM +0100, Vitaly Kuznetsov wrote:
>> Sean Christopherson <sean.j.christopherson@intel.com> writes:
>> 
>> > Configure the max page level during hardware setup to avoid a retpoline
>> > in the page fault handler.  Drop ->get_lpage_level() as the page fault
>> > handler was the last user.
>> > @@ -6064,11 +6064,6 @@ static void svm_set_supported_cpuid(struct kvm_cpuid_entry2 *entry)
>> >  	}
>> >  }
>> >  
>> > -static int svm_get_lpage_level(void)
>> > -{
>> > -	return PT_PDPE_LEVEL;
>> > -}
>> 
>> I've probably missed something but before the change, get_lpage_level()
>> on AMD was always returning PT_PDPE_LEVEL, but after the change and when
>> NPT is disabled, we set max_page_level to either PT_PDPE_LEVEL (when
>> boot_cpu_has(X86_FEATURE_GBPAGES)) or PT_DIRECTORY_LEVEL
>> (otherwise). This sounds like a change) unless we think that
>> boot_cpu_has(X86_FEATURE_GBPAGES) is always true on AMD.
>
> It looks like a functional change, but isn't.  kvm_mmu_hugepage_adjust()
> caps the page size used by KVM's MMU at the minimum of ->get_lpage_level()
> and the host's mapping level.  Barring an egregious bug in the kernel MMU,
> the host page tables will max out at PT_DIRECTORY_LEVEL (2mb) unless
> boot_cpu_has(X86_FEATURE_GBPAGES) is true.
>
> In other words, this is effectively a "documentation" change.  I'll figure
> out a way to explain this in the changelog...
>
>         max_level = min(max_level, kvm_x86_ops->get_lpage_level());
>         for ( ; max_level > PT_PAGE_TABLE_LEVEL; max_level--) {
>                 linfo = lpage_info_slot(gfn, slot, max_level);
>                 if (!linfo->disallow_lpage)
>                         break;
>         }
>
>         if (max_level == PT_PAGE_TABLE_LEVEL)
>                 return PT_PAGE_TABLE_LEVEL;
>
>         level = host_pfn_mapping_level(vcpu, gfn, pfn, slot);
>         if (level == PT_PAGE_TABLE_LEVEL)
>                 return level;
>
>         level = min(level, max_level); <---------

Ok, I see (I believe):

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

It would've helped me a bit if kvm_configure_mmu() was written the
following way:

void kvm_configure_mmu(bool enable_tdp, int tdp_page_level)
{
        tdp_enabled = enable_tdp;

	if (boot_cpu_has(X86_FEATURE_GBPAGES))
                max_page_level = PT_PDPE_LEVEL;
        else
                max_page_level = PT_DIRECTORY_LEVEL;

        if (tdp_enabled)
		max_page_level = min(tdp_page_level, max_page_level);
}

(we can't have cpu_has_vmx_ept_1g_page() and not
boot_cpu_has(X86_FEATURE_GBPAGES), right?)

But this is certainly just a personal preference, feel free to ignore)

-- 
Vitaly

