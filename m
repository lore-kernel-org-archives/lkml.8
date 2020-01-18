Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A207FC32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 20:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D8B246A2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 20:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HeDSDL6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgARUTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 15:19:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39101 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726822AbgARUTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 15:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579378739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8s1OxuZZiXO/EsQ28lb6a+jKGxvbzIA5vL4W1vsX2HI=;
        b=HeDSDL6+9w5c2DtyDYoFGLABt8rLhkJi7RrSjuvP/BXCfSPLi1IaFQteQt/wytcSKUCG52
        hFz3aeN26pkd/8cUhKW6mX3q8KWVkfe7cdaMr1MJHUaosCMzK6Z8SMK5TGLk3p7bfjtI1J
        mf8dFDEba4uhXk99QfQtC9TgIw7DCMI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-692rzIVkNfmgpGCKd-YhWQ-1; Sat, 18 Jan 2020 15:18:58 -0500
X-MC-Unique: 692rzIVkNfmgpGCKd-YhWQ-1
Received: by mail-wr1-f70.google.com with SMTP id y7so12130303wrm.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 12:18:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8s1OxuZZiXO/EsQ28lb6a+jKGxvbzIA5vL4W1vsX2HI=;
        b=UTQsfpcUzptcpfjOZVDQdAN/9JrQ6I3PRBwtVxXwOnIOiq2ps4VMuivVUCFIBPPFBr
         3gPoJgsFiWsor9ruohD0XRC7CXAcZM6Vo1Lo4ZwKh2Fy2jNGg32rYA24dQyE5G8dKJXV
         fn/03v+6irTNrhNsZTTe9MUvAvyQa9hbRKirCNn3g3znyH+iFw0IDEtJu5oLH92tC7/R
         YVHGli5Eatudcm/Z/Hjb84l8JGuHCwZwiC6jRvZIyj17JtufSPyAyr9kXnXNstW/Yb+R
         H54yklX9Z4xrffw9H20OyNPAlXQ0Y5zBV7TjojjuxdT3h+ly2edVWHNZXwEAkoDrwKbM
         yZ6Q==
X-Gm-Message-State: APjAAAUgFtpJihhlWksFkeodTM//gDx0X+5r7lTnGoXZgDslNgCBZSck
        YzM5JRDsiauIBvSOmGVQNT0g8BCAEJ6CWr9Xkxal/H+MyzcfLzyB6bYuGUgZnXXQnK/Jzt7kfiG
        BKwISeiRsx9gm4Q3zRlVgFQUO
X-Received: by 2002:a5d:4204:: with SMTP id n4mr9927831wrq.123.1579378736760;
        Sat, 18 Jan 2020 12:18:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqzJ6VEJStrlRYkO89/JVFRuQdQ28A5gPh1t6q08B4qpAjUpwx2PmKbXlVyg2dvPJEdLBERq1w==
X-Received: by 2002:a5d:4204:: with SMTP id n4mr9927810wrq.123.1579378736465;
        Sat, 18 Jan 2020 12:18:56 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e0d6:d2cd:810b:30a9? ([2001:b07:6468:f312:e0d6:d2cd:810b:30a9])
        by smtp.gmail.com with ESMTPSA id x14sm294070wmj.42.2020.01.18.12.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2020 12:18:55 -0800 (PST)
Subject: Re: [PATCH v2 00/13] KVM: x86: Extend Spectre-v1 mitigation
To:     Marios Pomonis <pomonis@google.com>, rkrcmar@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Finco <nifi@google.com>, Andrew Honig <ahonig@google.com>
References: <20191211204753.242298-1-pomonis@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ac5b982c-fc76-b33e-fc5b-cbf9e94833e5@redhat.com>
Date:   Sat, 18 Jan 2020 21:18:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191211204753.242298-1-pomonis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/19 21:47, Marios Pomonis wrote:
> From: Nick Finco <nifi@google.com>
> 
> This extends the Spectre-v1 mitigation introduced in
> commit 75f139aaf896 ("KVM: x86: Add memory barrier on vmcs field lookup")
> and commit 085331dfc6bb ("x86/kvm: Update spectre-v1 mitigation") in light
> of the Spectre-v1/L1TF combination described here:
> https://xenbits.xen.org/xsa/advisory-289.html
> 
> As reported in the link, an attacker can use the cache-load part of a
> Spectre-v1 gadget to bring memory into the L1 cache, then use L1TF to
> leak the loaded memory. Note that this attack is not fully mitigated by
> core scheduling; firstly when "kvm-intel.vmentry_l1d_flush" is not set
> to "always", an attacker could use L1TF on the same thread that loaded the
> memory values in the cache on paths that do not flush the L1 cache on
> VMEntry. Otherwise, an attacker could perform this attack using a
> collusion of two sibling hyperthreads: one that loads memory values in
> the cache during VMExit handling and another that performs L1TF to leak
> them.
> 
> This patch uses array_index_nospec() to prevent index computations from
> causing speculative loads into the L1 cache. These cases involve a
> bounds check followed by a memory read using the index; this is more
> common than the full Spectre-v1 pattern. In some cases, the index
> computation can be eliminated entirely by small amounts of refactoring.
> 
> Marios Pomonis (13):
>   KVM: x86: Protect x86_decode_insn from Spectre-v1/L1TF attacks
>   KVM: x86: Protect kvm_hv_msr_[get|set]_crash_data() from
>     Spectre-v1/L1TF attacks
>   KVM: x86: Refactor picdev_write() to prevent Spectre-v1/L1TF attacks
>   KVM: x86: Protect ioapic_read_indirect() from Spectre-v1/L1TF attacks
>   KVM: x86: Protect ioapic_write_indirect() from Spectre-v1/L1TF attacks
>   KVM: x86: Protect kvm_lapic_reg_write() from Spectre-v1/L1TF attacks
>   KVM: x86: Protect MSR-based index computations in
>     fixed_msr_to_seg_unit()
>   KVM: x86: Protect MSR-based index computations in pmu.h
>   KVM: x86: Protect MSR-based index computations from Spectre-v1/L1TF
>     attacks in x86.c
>   KVM: x86: Protect memory accesses from Spectre-v1/L1TF attacks in
>     x86.c
>   KVM: x86: Protect exit_reason from being used in Spectre-v1/L1TF
>     attacks
>   KVM: x86: Protect DR-based index computations from Spectre-v1/L1TF
>     attacks
>   KVM: x86: Protect pmu_intel.c from Spectre-v1/L1TF attacks
> 
>  arch/x86/kvm/emulate.c       | 11 ++++--
>  arch/x86/kvm/hyperv.c        | 10 +++--
>  arch/x86/kvm/i8259.c         |  6 ++-
>  arch/x86/kvm/ioapic.c        | 15 +++++---
>  arch/x86/kvm/lapic.c         | 13 +++++--
>  arch/x86/kvm/mtrr.c          |  8 +++-
>  arch/x86/kvm/pmu.h           | 18 +++++++--
>  arch/x86/kvm/vmx/pmu_intel.c | 24 ++++++++----
>  arch/x86/kvm/vmx/vmx.c       | 71 +++++++++++++++++++++---------------
>  arch/x86/kvm/x86.c           | 18 +++++++--
>  10 files changed, 129 insertions(+), 65 deletions(-)
> 

Queued all except patch 10, thanks.

Paolo

