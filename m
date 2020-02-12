Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C6AC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D97E2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVvzM/FA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgBLMDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:03:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39812 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725874AbgBLMDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581508982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k5zs83apuRL6HAt6DNxSJuwbz4meI2rzv8ad7JsjUkQ=;
        b=WVvzM/FAtyKRRclBJpUteZTimCShwrfRKPo3uA3rQKNhpUhxkKqaAYeIgvczk8MHBbAgzO
        GimnbaxD6a7KwKz3Ru+nM0xHFLINdKpBB8K9HZThE3pLHg7d8O/EywxCAaptqUFmzkBx50
        m7hs1LBfsigd/LSffFtwWemnHozqUbQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-2tYOPylONRK6KVNe0YSQeg-1; Wed, 12 Feb 2020 07:03:01 -0500
X-MC-Unique: 2tYOPylONRK6KVNe0YSQeg-1
Received: by mail-wr1-f69.google.com with SMTP id s13so712552wrb.21
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 04:03:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k5zs83apuRL6HAt6DNxSJuwbz4meI2rzv8ad7JsjUkQ=;
        b=fsMkauOCwIKdb2tbNmlS0rGSvBpFsPt0PRhTq/wZZhvGnXM5OQpbs/A4tIi3411wF8
         cU2bEowr35wWv9dzpnjPHF3oVDOLbG1YfEeaB0OJTy5KPsMIP/S/JaYy1XGDgz+MkQVk
         7rSbW6cWMXTWZZwiTfN2EKvrPVIQtU0+IXEAR0w4OiVPgzP2YNgBZTy52x6TJoAc4imT
         7iFxaZlY5kPP5omPWLaYTzmewoP5FnvxyZSmDVr269Jbz2LPSqBqk53hBf74T5H+UxBr
         LelFvMLipgRG7tAXNu/gWv7j+CVwwPPGpBLX2FTuy/j5sJyDCZp72ZKfj5VGRPpHv2+G
         58GA==
X-Gm-Message-State: APjAAAX13YKEpU69Cd+EU22TaTW8vIML8wVdtPMTFnjuhK5C9hi3ahiu
        dyYjfM0ocdBVdwkBUBokLiQHuqP+4qMsxZ1ncdlvivagsbeH0Be/QE36Ghcg0cKa6NoMpetW2rj
        nhiOE/j3s4V25bHT7ClL7gA6Z
X-Received: by 2002:a05:600c:2190:: with SMTP id e16mr12474049wme.84.1581508979957;
        Wed, 12 Feb 2020 04:02:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqzkIv46akQrCda26rlO+E5SmKedUSHb3K89g/Qq7NOJVb0l558n0tRXJYn+nI0vQShjUJMrxA==
X-Received: by 2002:a05:600c:2190:: with SMTP id e16mr12474026wme.84.1581508979720;
        Wed, 12 Feb 2020 04:02:59 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:652c:29a6:517b:66d9? ([2001:b07:6468:f312:652c:29a6:517b:66d9])
        by smtp.gmail.com with ESMTPSA id 59sm427906wre.29.2020.02.12.04.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 04:02:57 -0800 (PST)
Subject: Re: [PATCH v2 0/7] KVM: x86/mmu: nVMX: 5-level paging fixes and
 enabling
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200207173747.6243-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e3ade6f7-071a-3825-9097-4c0f1a3f4676@redhat.com>
Date:   Wed, 12 Feb 2020 13:03:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200207173747.6243-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/20 18:37, Sean Christopherson wrote:
> Two fixes for 5-level paging bugs with a 100% fatality rate, a patch to
> enable 5-level EPT in L1, and additional clean up on top (mostly renames
> of functions/variables that caused me no end of confusion when trying to
> figure out what was broken).
> 
> Tested fixed kernels at L0, L1 and L2, with most combinations of EPT,
> shadow paging, 4-level and 5-level.  EPT kvm-unit-tests runs clean in L0.
> Patches for kvm-unit-tests incoming to play nice with 5-level nested EPT.
> 
> Ideally patches 1 and 2 would get into 5.6, 5-level paging is quite
> broken without them.
> 
> v2:
>   - Increase the nested EPT array sizes to accomodate 5-level paging in
>     the patch that adds support for 5-level nested EPT, not in the bug
>     fix for 5-level shadow paging.
> 
> Sean Christopherson (7):
>   KVM: nVMX: Use correct root level for nested EPT shadow page tables
>   KVM: x86/mmu: Fix struct guest_walker arrays for 5-level paging
>   KVM: nVMX: Allow L1 to use 5-level page walks for nested EPT
>   KVM: nVMX: Rename nested_ept_get_cr3() to nested_ept_get_eptp()
>   KVM: nVMX: Rename EPTP validity helper and associated variables
>   KVM: x86/mmu: Rename kvm_mmu->get_cr3() to ->get_guest_cr3_or_eptp()
>   KVM: nVMX: Drop unnecessary check on ept caps for execute-only
> 
>  arch/x86/include/asm/kvm_host.h |  2 +-
>  arch/x86/include/asm/vmx.h      | 12 +++++++
>  arch/x86/kvm/mmu/mmu.c          | 35 ++++++++++----------
>  arch/x86/kvm/mmu/paging_tmpl.h  |  6 ++--
>  arch/x86/kvm/svm.c              | 10 +++---
>  arch/x86/kvm/vmx/nested.c       | 58 ++++++++++++++++++++-------------
>  arch/x86/kvm/vmx/nested.h       |  4 +--
>  arch/x86/kvm/vmx/vmx.c          |  2 ++
>  arch/x86/kvm/x86.c              |  2 +-
>  9 files changed, 79 insertions(+), 52 deletions(-)
> 

Queued 1-2-4-5-7 (for 5.6), thanks!

Paolo

