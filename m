Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E72C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38DFD20709
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpkDJW7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgERKwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 06:52:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27210 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726270AbgERKwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589799144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6etE4P814prTdAG6YmglpAvqIzxrG1O+ArxaHFuKwGY=;
        b=hpkDJW7PThmsZm7SY8LXck2K5fYdSKqE7d4zLjivA3VtaGBDkt6KzBgu55MjgPELzaTUUU
        clBl1VX4/foNsf9UAWzEOxWiHOyVloE6mRoTHT/hRIWR2m7u7vd5gh24Zyjbn1HmhbHRrP
        v6/3IN9wXPB4ZReneVH8V4auOyKjCTY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-FDn_NJcTOsOMFsVCkqK2TQ-1; Mon, 18 May 2020 06:52:22 -0400
X-MC-Unique: FDn_NJcTOsOMFsVCkqK2TQ-1
Received: by mail-wr1-f70.google.com with SMTP id l12so5496724wrw.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 03:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6etE4P814prTdAG6YmglpAvqIzxrG1O+ArxaHFuKwGY=;
        b=KOA+Khm/OlDRFfl8ORonW5357HbzBimsheIa6C6TS+w5xdPPPoyStPJhXhWe671Aon
         Sf7E9M7ivrvfbmDGn+665c0qoBOV9DNnqpb9OOQhF9Ke9F/nszwaHYzeIfzT+xojTB0X
         11fsdIOzwqDIiPJ7gf3mrHKCh3xJtyUu5dLBt6NKPrGlLTi0BpVIFk1NmV4rArivoYYD
         afNPtgM/9eTI6UP2MS8QSrR576a5O1uUDbb7svLUrR1y2zLqN2sXWfa1YiTLqZ1PV1LU
         H7cYqROxopc8zI7zJ1CyMV6/gdH8N7NXTgTDDx+tn+qH2L1/6c1TWxyQZL2cPcHx6ITm
         84fA==
X-Gm-Message-State: AOAM533QYBC+Zc338dOTQq6b7mye2LAMRH2JrkI0nLQUL1xB48sx7qDA
        R2516g0H6YKj+IBSlrS3eVh5SQht10ychMCIFzcy8Qe7p1/IDDfNfEPndLAmii9sSNahJTCybFr
        YDhesBD67KUSmgi/uOLzAsSq/
X-Received: by 2002:a1c:ed08:: with SMTP id l8mr13772259wmh.169.1589799141177;
        Mon, 18 May 2020 03:52:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytY+OY8SU0qlgwqpmffxW1RD+bJcmh79enNAQOBf29svzbfpZJVco9mYAFQmBpYmuSBeDn5A==
X-Received: by 2002:a1c:ed08:: with SMTP id l8mr13772237wmh.169.1589799140990;
        Mon, 18 May 2020 03:52:20 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.90.67])
        by smtp.gmail.com with ESMTPSA id q14sm16485527wrc.66.2020.05.18.03.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 03:52:20 -0700 (PDT)
Subject: Re: [PATCH 0/3] KVM: x86: kvm_init_msr_list() cleanup
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200218234012.7110-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f630dc53-61db-71fb-d868-cb8eb70f504d@redhat.com>
Date:   Mon, 18 May 2020 12:52:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200218234012.7110-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/20 00:40, Sean Christopherson wrote:
> Three cleanup patches in kvm_init_msr_list() and related code.
> 
> Note, these were previously posted as the first three patches of larger
> series[*] that mutated into an entirely different beast, which is how they
> have been reviewed by Vitaly despite being v1.
> 
> [*] https://patchwork.kernel.org/cover/11357065/
> 
> Sean Christopherson (3):
>   KVM: x86: Remove superfluous brackets from case statement
>   KVM: x86: Take an unsigned 32-bit int for has_emulated_msr()'s index
>   KVM: x86: Snapshot MSR index in a local variable when processing lists
> 
>  arch/x86/include/asm/kvm_host.h |  2 +-
>  arch/x86/kvm/svm.c              |  2 +-
>  arch/x86/kvm/vmx/vmx.c          |  2 +-
>  arch/x86/kvm/x86.c              | 26 +++++++++++++++-----------
>  4 files changed, 18 insertions(+), 14 deletions(-)
> 

Queued (better late than never).

Paolo

