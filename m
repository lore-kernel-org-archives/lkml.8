Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A131C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44644214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GV97lfgr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgAOSFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:05:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29407 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728921AbgAOSFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:05:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579111522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c69WbVq5j2P1XNGy+IhxAunAcPYacDdAW3b2A1FRx4E=;
        b=GV97lfgr3eoyaBcEpsLAyyLhL9Wzt6kwi6DQAKaOMsetcpy5F+8Jkdh2IAcO6UBFRSoAdA
        GZ24m+bEmGf4IfqAvByEt0YLUrA1wje4VvJ5r3wivREHQxoCfEzCtQrmhqdSRO0aAy5XZB
        xy8FwiSDwb0m4E037rlv0JfxS6ABj5c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-B4IZPcH8MBqsvBBrl6b06g-1; Wed, 15 Jan 2020 13:05:19 -0500
X-MC-Unique: B4IZPcH8MBqsvBBrl6b06g-1
Received: by mail-wr1-f71.google.com with SMTP id t3so8221930wrm.23
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 10:05:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c69WbVq5j2P1XNGy+IhxAunAcPYacDdAW3b2A1FRx4E=;
        b=tTNz3K4jX15BtuVETeZmKUycv9wZ4APlSprvMpXTGsEzYmeTe+EAwTKE4gfLnX7YTS
         lhKL1EovAdtYhop90GxJ1xQn8Ws2kec6txao/U0rbc9tWx9CwahPIygG8Vwv980nHXdO
         hcRxDhz/4RtY+67rCMBzZFbdpb7BSCCWkfKPW6l+H6SrWbRyAF4Dg/C5Xnk7rVSB4NqK
         o2hwCuLD/lhKK3y9gqPNyUvx9iz9qbI1jAfze1/SGA6d2Bx245MY9zXu9RgYwCd82g5C
         oBgdyf449rz/Vf85hdYDiPLONN5XIEYVUzJ74UmA4H37a23KUilWlzqFmtjb5DCyiWSP
         ANiw==
X-Gm-Message-State: APjAAAWdL2tPZYQ7VVvmT3uH/AO1AYH4yddPWTqizo1QRetRwCWkJMWR
        LiwHri75mMGAUFcqzqU4zdp75j6DgidB+Qc8hs1Y31YsPwQ2zkhNtpPZDQaNfrxDsFn4fy1grC5
        48tSnUxT0RQC3MYpiVARN0Zlf
X-Received: by 2002:a1c:7918:: with SMTP id l24mr1242907wme.125.1579111517301;
        Wed, 15 Jan 2020 10:05:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqwhZlrV31iytYOe/i6rKaJ0a5p5+NIIM2FKS1E+7bLOwxTRHWKblRQPEorgppp4hxakTRh1tA==
X-Received: by 2002:a1c:7918:: with SMTP id l24mr1242868wme.125.1579111517074;
        Wed, 15 Jan 2020 10:05:17 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:436:e17d:1fd9:d92a? ([2001:b07:6468:f312:436:e17d:1fd9:d92a])
        by smtp.gmail.com with ESMTPSA id z123sm905364wme.18.2020.01.15.10.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 10:05:16 -0800 (PST)
Subject: Re: [PATCH 0/4] KVM: x86: Add checks on host-reserved cr4 bits
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jun Nakajima <jun.nakajima@intel.com>
References: <20191210224416.10757-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c7a9237-14fd-ff66-0c28-e979f7f7edd6@redhat.com>
Date:   Wed, 15 Jan 2020 19:05:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191210224416.10757-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/19 23:44, Sean Christopherson wrote:
> KVM currently doesn't incorporate the platform's capabilities in its cr4
> reserved bit checks and instead checks only whether KVM is aware of the
> feature in general and whether or not userspace has advertised the feature
> to the guest.
> 
> Lack of checking allows userspace/guest to set unsupported bits in cr4.
> For the most part, setting unsupported bits will simply cause VM-Enter to
> fail.  The one existing exception is OSXSAVE, which is conditioned on host
> support as checking only guest_cpuid_has() would result in KVM attempting
> XSAVE, leading to faults and WARNs.
> 
> 57-bit virtual addressing has introduced another case where setting an
> unsupported bit (cr4.LA57) can induce a fault in the host.  In the LA57
> case, userspace can set the guest's cr4.LA57 by advertising LA57 support
> via CPUID and abuse the bogus cr4.LA57 to effectively bypass KVM's
> non-canonical address check, ultimately causing a #GP when VMX writes
> the guest's bogus address to MSR_KERNEL_GS_BASE during VM-Enter.
> 
> Given that the best case scenario is a failed VM-Enter, there's no sane
> reason to allow setting unsupported bits in cr4.  Fix the LA57 bug by not
> allowing userspace or the guest to set cr4 bits that are not supported
> by the platform.
> 
> Sean Christopherson (4):
>   KVM: x86: Don't let userspace set host-reserved cr4 bits
>   KVM: x86: Ensure all logical CPUs have consistent reserved cr4 bits
>   KVM: x86: Drop special XSAVE handling from guest_cpuid_has()
>   KVM: x86: Add macro to ensure reserved cr4 bits checks stay in sync
> 
>  arch/x86/kvm/cpuid.h   |  4 ---
>  arch/x86/kvm/svm.c     |  1 +
>  arch/x86/kvm/vmx/vmx.c |  1 +
>  arch/x86/kvm/x86.c     | 65 +++++++++++++++++++++++++++++-------------
>  4 files changed, 47 insertions(+), 24 deletions(-)
> 

Queued, thanks.

Paolo

