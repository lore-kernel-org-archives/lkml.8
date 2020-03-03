Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A9CC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D7F20863
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMFIc0CL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgCCJ2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:28:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25394 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728049AbgCCJ2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583227686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JawvsztqURHUMrivAZK9itm+6zuMO8VTLICNdnI7dxo=;
        b=hMFIc0CLGIWvyEMhAvtDytMosd8AHGgA2I9YUdZtQsGEu6eqEDBQcUuXU5MRCBWiYHLxVX
        GCB6HpBs78v99997mZSeKdDsW6RhbzMy7XFkNYfKR1A2GweLWMySM2KBHhafaNrpnTqWQm
        0A5YG50M8EtIdAtyM4SmiTi52W1YxkU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-eSL3z9yoN5CjaJRzZsY-5A-1; Tue, 03 Mar 2020 04:28:04 -0500
X-MC-Unique: eSL3z9yoN5CjaJRzZsY-5A-1
Received: by mail-wr1-f71.google.com with SMTP id m13so964855wrw.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 01:28:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JawvsztqURHUMrivAZK9itm+6zuMO8VTLICNdnI7dxo=;
        b=EXitnmR9b7FuhCZM+1Fa0odjj5dWovsbuVI2OEKgwQIRkQxcDDLXMXTkO/LUJM/UJL
         GnSBHmWxtXQMHn3uuTu283TzZ+sFSQPWjK2OC1G93nH2+m7+iIMrAjYpyj75r9ee9bMi
         iSXQVuN4vBJLBMEPwkSGOfRV/EciIQ4rxMazrLDynohVYFlrSTDYwasEy5khNZgjW77g
         lUmCGbuPm/HYyedyo55ylTNoHx+XAQZ6wTvNuU0PScC2V/uZErcWDqKChxGK4Itzy5dk
         lKjnkhb6KnSVtHo2fi3JXeN5azWoRUGNnMyMfBrrM6/3+lx2M8Wz1O6o/dse+3qjf7Ky
         7E7w==
X-Gm-Message-State: ANhLgQ2jelGq83EX2KLHJmYaMrBd9xL5/xuqD11j9yYQkRYCNuWALaU+
        5mhCIKk8tGZDVHGpKitr3RQSb0Gj81xYInWXx/x1IxwGFn+l4M98voPqu0EiiD2uhsnA21vvmMf
        SnSqq0MPIxf2RE22pbX8tC5Mi
X-Received: by 2002:a5d:68ce:: with SMTP id p14mr3888598wrw.315.1583227683197;
        Tue, 03 Mar 2020 01:28:03 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsJpUVTnRWkgQAQclEelI+BOvdB7TqEFgh/PbQcMZ6SzEsdA+mGSHrg8PNex6myJcsME0a9aA==
X-Received: by 2002:a5d:68ce:: with SMTP id p14mr3888556wrw.315.1583227682873;
        Tue, 03 Mar 2020 01:28:02 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:4c52:2f3b:d346:82de? ([2001:b07:6468:f312:4c52:2f3b:d346:82de])
        by smtp.gmail.com with ESMTPSA id a6sm3075433wmh.32.2020.03.03.01.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 01:28:02 -0800 (PST)
Subject: Re: [PATCH v3 0/7] KVM: x86/mmu: nVMX: 5-level paging cleanup and
 enabling
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200303020240.28494-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <748ad2db-f2da-d177-7ec8-54523465e64a@redhat.com>
Date:   Tue, 3 Mar 2020 10:28:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303020240.28494-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/20 03:02, Sean Christopherson wrote:
> Clean up MMU code related to 5 level paging, expose 5-level EPT to L1, and
> additional clean up on top (mostly renames of functions/variables that
> caused me no end of confusion when trying to figure out what was broken
> at various times).
> 
> v3:
>   - Dropped fixes for existing 5-level bugs (merged for 5.6).
>   - Use get_guest_pgd() instead of get_guest_cr3_or_eptp(). [Paolo]
>   - Add patches to fix MMU role calculation to play nice with 5-level
>     paging without requiring additional CR4.LA_57 bit.
> 
> v2:
>   - Increase the nested EPT array sizes to accomodate 5-level paging in
>     the patch that adds support for 5-level nested EPT, not in the bug
>     fix for 5-level shadow paging.
> 
> Sean Christopherson (7):
>   KVM: x86/mmu: Don't drop level/direct from MMU role calculation
>   KVM: x86/mmu: Drop kvm_mmu_extended_role.cr4_la57 hack
>   KVM: nVMX: Allow L1 to use 5-level page walks for nested EPT
>   KVM: nVMX: Rename nested_ept_get_cr3() to nested_ept_get_eptp()
>   KVM: nVMX: Rename EPTP validity helper and associated variables
>   KVM: x86/mmu: Rename kvm_mmu->get_cr3() to ->get_guest_pgd()
>   KVM: nVMX: Drop unnecessary check on ept caps for execute-only
> 
>  arch/x86/include/asm/kvm_host.h |  3 +-
>  arch/x86/include/asm/vmx.h      | 12 +++++++
>  arch/x86/kvm/mmu/mmu.c          | 59 +++++++++++++++++----------------
>  arch/x86/kvm/mmu/paging_tmpl.h  |  4 +--
>  arch/x86/kvm/svm.c              |  2 +-
>  arch/x86/kvm/vmx/nested.c       | 52 ++++++++++++++++++-----------
>  arch/x86/kvm/vmx/nested.h       |  4 +--
>  arch/x86/kvm/vmx/vmx.c          |  3 +-
>  arch/x86/kvm/x86.c              |  2 +-
>  9 files changed, 82 insertions(+), 59 deletions(-)
> 

Queued, thanks.  I have a cleanup on top to unify set_cr3 and
set_tdp_cr3, which I'll post after testing it.

Paolo

