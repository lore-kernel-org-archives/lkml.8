Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E13C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E549207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUW46T93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgERLSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:18:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57800 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726511AbgERLS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589800707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dxiBECMHFAplzz2KB29O/LRSLdFzNsUzEToTKNWFHYs=;
        b=eUW46T93VkiC7R+amKrbtMahqRVngVEEy7NCjcLTwIaFF6hl3o/muVUkrQWm/PWGAE5Rat
        0rntisd6pV10bmYbtUTI2DhJn4M/OGlTg6C7UPFbgOS10N6zHoYxoD4A/UKmaRV0BhJB3E
        IdXMtTdeV/w0239qat405Y+OIXuFA3k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-lkLFea2iO5awSQ3VwJLJOw-1; Mon, 18 May 2020 07:18:26 -0400
X-MC-Unique: lkLFea2iO5awSQ3VwJLJOw-1
Received: by mail-wm1-f72.google.com with SMTP id o8so2180411wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 04:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dxiBECMHFAplzz2KB29O/LRSLdFzNsUzEToTKNWFHYs=;
        b=Jn+JaMb74FIsArLATj7GEnjl5qDNObIcGcqws6cG7HKT4n1V9oDiAzrAhfAoqaejOP
         XlvbgjeYAF4MMHN1Mj8DlLxYnw9RkqT0VeoW8PkJvYMvmOE9lnJwxELa+IGjpktmiQJf
         mBiQaJxEYvAIH+SmdFeaMUEDCRR2TfyQbf1FAy0eG539G8Sh78ZsFRyk0/O+416GMfNU
         nFTYLTUhDZrVj3JNXZMNZjvLmgcFCZbddsd//VaCI15L2xJulJ9bKvLcq+BTsGb90htf
         J07qmbZJ5DY2u6EqpmpRVU78hHGjRGnYQHGnh5/ii348kyQeK6U18gEuBFStdIYjmE49
         FtLg==
X-Gm-Message-State: AOAM533ttQdBwddjVbzA35zzHIS8uVEgQLwyf2uxCT28faBtmKo2Khn+
        0pBfEpJoyvJlnOlSNRqcPOa03zTEc+Gj5S0c8KALwoJKwgfw2C9h+U5C5imSWxDWgt5bJ6eeO7v
        EqAv5HrcXhHRA6EP9QJTOTO4R
X-Received: by 2002:adf:f786:: with SMTP id q6mr19058401wrp.120.1589800705063;
        Mon, 18 May 2020 04:18:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNLwMrbe3B5c0qaCQ/YjHTYYnwcj/Jnv2tH5S7lfJMD5adLyh8g16sr+0JKvnyuDSUcvQdGA==
X-Received: by 2002:adf:f786:: with SMTP id q6mr19058368wrp.120.1589800704864;
        Mon, 18 May 2020 04:18:24 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.90.67])
        by smtp.gmail.com with ESMTPSA id r2sm16417514wrg.84.2020.05.18.04.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 04:18:24 -0700 (PDT)
Subject: Re: [PATCH 0/2] Expose KVM API to Linux Kernel
To:     Anastassios Nanos <ananos@nubificus.co.uk>,
        Marc Zyngier <maz@kernel.org>
Cc:     kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <cover.1589784221.git.ananos@nubificus.co.uk>
 <c1124c27293769f8e4836fb8fdbd5adf@kernel.org>
 <CALRTab90UyMq2hMxCdCmC3GwPWFn2tK_uKMYQP2YBRcHwzkEUQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <760e0927-d3a7-a8c6-b769-55f43a65e095@redhat.com>
Date:   Mon, 18 May 2020 13:18:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CALRTab90UyMq2hMxCdCmC3GwPWFn2tK_uKMYQP2YBRcHwzkEUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/20 10:45, Anastassios Nanos wrote:
> Being in the kernel saves us from doing unneccessary mode switches.
> Of course there are optimizations for handling I/O on QEMU/KVM VMs
> (virtio/vhost), but essentially what happens is removing mode-switches (and
> exits) for I/O operations -- is there a good reason not to address that
> directly? a guest running in the kernel exits because of an I/O request,
> which gets processed and forwarded directly to the relevant subsystem *in*
> the kernel (net/block etc.).

In high-performance configurations, most of the time virtio devices are
processed in another thread that polls on the virtio rings.  In this
setup, the rings are configured to not cause a vmexit at all; this has
much smaller latency than even a lightweight (kernel-only) vmexit,
basically corresponding to writing an L1 cache line back to L2.

Paolo

