Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A265EC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 03:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BAA20722
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 03:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+f3VMz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgCOD4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 23:56:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48808 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727646AbgCOD4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 23:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584244564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G7U9eOBxycUxXuaSYt7hoS9gbd47jdv119MFjfE5TZ4=;
        b=M+f3VMz9FU3iWNCBdKmvcKjhmYAEEHBcD0MZfDTBg9+OTKHkQngSJOl+X9wMHb3dayfrQe
        2bLkgAaZDzETJXGmtcCGhaqFz0kb9Vbv1GiORXGYF+7Td6ArDwTyIaM+k5uDvnT39xkRfF
        GyIEdrRBGMGJADzVhCYSdJRRtUytFFs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-xkluNi-zNEqtzXFecVBZ3Q-1; Sat, 14 Mar 2020 07:52:32 -0400
X-MC-Unique: xkluNi-zNEqtzXFecVBZ3Q-1
Received: by mail-wr1-f70.google.com with SMTP id x14so5805796wrv.23
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 04:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G7U9eOBxycUxXuaSYt7hoS9gbd47jdv119MFjfE5TZ4=;
        b=iBsJv2xHL20fHi90TK6FLAP5Ec8hWcYsZl8E18PeDUNvOQ2JuFg6M1NL64LXWnwzyy
         uD3vibH3NfgqxphzZBkJK7kGFZx4HVzo39HvH7/12z5X1kw4a0SwP5BGVUeDwBse4TWe
         w0soMRws6Aoazh0tav7rJcWsKTzqD3khy8BIzYxb1f84VwfgPS1xGAvQp3nBylK8XemB
         +A/VwE6BLglnrXZKQFPOxjGQAatUu/aA5FAew54kQg4rG1S77/7LwRg7IVB4vxFzDIIP
         3svgmyQsU4QG+1n9mAjP1OAjooashfSaZSg48EBpWMUgq5d+0xv1Yqv7NLkTV3tLA4qP
         3MzQ==
X-Gm-Message-State: ANhLgQ2HiVcC8Mizmv0Q1J34nIMKTFbDABU/FlT+/5JWFpDIT3AkVPjo
        ZngFMXjqRDQAKsCIcu+nJYwW28ga0MwlwcgZTUYSilz2HTaNLHVGmCvHs0HjYoWtc5s0h7gwPuE
        kkUhvRI5hBQWEr1IfavGfDyzr
X-Received: by 2002:adf:e3cc:: with SMTP id k12mr19942153wrm.266.1584186751099;
        Sat, 14 Mar 2020 04:52:31 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtbO2E61XdLtXp/96mfvEQSV5mUdgZ8xyNKOMzmTPGn0uJp/s3kNcRw4aIWCJobbf0eDb3gIg==
X-Received: by 2002:adf:e3cc:: with SMTP id k12mr19942136wrm.266.1584186750833;
        Sat, 14 Mar 2020 04:52:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7de8:5d90:2370:d1ac? ([2001:b07:6468:f312:7de8:5d90:2370:d1ac])
        by smtp.gmail.com with ESMTPSA id k126sm21021489wme.4.2020.03.14.04.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2020 04:52:30 -0700 (PDT)
Subject: Re: [PATCH 0/6] KVM: nVMX: propperly handle enlightened vmptrld
 failure conditions
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liran Alon <liran.alon@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>
References: <20200309155216.204752-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1cebb8c1-45f3-4991-f3d9-40cea1be1871@redhat.com>
Date:   Sat, 14 Mar 2020 12:52:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309155216.204752-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/20 16:52, Vitaly Kuznetsov wrote:
> Miaohe Lin noticed that we incorrectly handle enlightened vmptrld failures
> in nested_vmx_run(). Trying to handle errors correctly, I fixed
> a few things:
> - NULL pointer dereference with invalid eVMCS GPAs [PATCH1]
> - moved eVMCS mapping after migration to nested_get_vmcs12_pages() from
>   nested_sync_vmcs12_to_shadow() [PATCH2]
> - added propper nested_vmx_handle_enlightened_vmptrld() error handling
>   [PATCH3]
> - added selftests for incorrect eVMCS revision id and GPA [PATCHes4-6]
> 
> PATCH1 fixes a DoS and thus marked for stable@.
> 
> Vitaly Kuznetsov (6):
>   KVM: nVMX: avoid NULL pointer dereference with incorrect EVMCS GPAs
>   KVM: nVMX: stop abusing need_vmcs12_to_shadow_sync for eVMCS mapping
>   KVM: nVMX: properly handle errors in
>     nested_vmx_handle_enlightened_vmptrld()
>   KVM: selftests: define and use EVMCS_VERSION
>   KVM: selftests: test enlightened vmenter with wrong eVMCS version
>   KVM: selftests: enlightened VMPTRLD with an incorrect GPA
> 
>  arch/x86/kvm/vmx/evmcs.h                      |  7 ++
>  arch/x86/kvm/vmx/nested.c                     | 64 +++++++++++++------
>  tools/testing/selftests/kvm/include/evmcs.h   |  2 +
>  tools/testing/selftests/kvm/lib/x86_64/vmx.c  |  2 +-
>  .../testing/selftests/kvm/x86_64/evmcs_test.c | 25 ++++++--
>  5 files changed, 72 insertions(+), 28 deletions(-)
> 

Queued, thanks.

Paolo

