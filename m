Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCD1C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3566A2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="auWH+k94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgCBSmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:42:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49972 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727234AbgCBSmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583174556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6nZFkyEGmcNit7gYHhD2J1/glw8rNRs29/DOfk8LqAE=;
        b=auWH+k94qmGv0CxPLeIi5bYrgvip88V5xcsLIGAVNPn6ulUI1m2gtboHJH7jiWjvq+2TsR
        QhzJNCgKLK3o1dcAvzotDrEix86nx3PilgqgD5OGaa4T6qdesX13XKsLwj4mUSAVbad+uf
        8tVE0fIwsfXao2h5UU5zc9m3G7PNWu8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-nDkDM1RyNUuLcCmMMaRAPQ-1; Mon, 02 Mar 2020 13:42:35 -0500
X-MC-Unique: nDkDM1RyNUuLcCmMMaRAPQ-1
Received: by mail-wm1-f69.google.com with SMTP id o24so60862wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 10:42:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6nZFkyEGmcNit7gYHhD2J1/glw8rNRs29/DOfk8LqAE=;
        b=QbUDuzoYds0KriD+pAOlInLriHHXyVn39MAxQVZnav8EuCY33tGGCQajueyJAu9HdP
         GEEvo/Sfmfo9ZpyvhXtJ/jHa/UsAEltqqRYjDzZAyd/Cukcpai6fXdWGdg15XUv3Tuhx
         eEFdA+hEhHiuwwMHcRLB8aNH1omibRAJ91uXWE1Sqoi36so6AB2Ud+Cwp0Qkim2UkmAk
         M6YeE10SBjHcC++VSoX1a8QHeAxlyxhfynLstwungm24d7kOJa9RgLoVJHshxotDCpeD
         6yt1CXcrz5jiF7D4bWhxkT8sDxF5kRUa6LGE1ie4zpwQjwZ7mPOHh9z7WNsbCSA4OYOK
         wlbw==
X-Gm-Message-State: ANhLgQ0p8Lgc472emG3LN+/QkUhG8pN7McQkhTJlusNp2s6T4Cba40nf
        CSUnfd1NgZOBJXsDH0r3E7ddeI/J3HCeQO87PEmIiW1ze7d7FeK/3WwY3YokijOdKRSTHoQGSS9
        nftxGM0KIjrk1EF0TZ1CAXtKe
X-Received: by 2002:adf:dccb:: with SMTP id x11mr870752wrm.214.1583174554009;
        Mon, 02 Mar 2020 10:42:34 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtIlUFnhvyvv59cDdCKG7b+P9Hle/BB4YizYqxjffgshDK3TzmwPGP72+wVgq4/Dcv41kNI2A==
X-Received: by 2002:adf:dccb:: with SMTP id x11mr870739wrm.214.1583174553703;
        Mon, 02 Mar 2020 10:42:33 -0800 (PST)
Received: from [192.168.178.40] ([151.30.85.6])
        by smtp.gmail.com with ESMTPSA id r19sm394854wmh.26.2020.03.02.10.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 10:42:32 -0800 (PST)
Subject: Re: [PATCH v2 00/13] KVM: x86: Allow userspace to disable the
 emulator
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200218232953.5724-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3ec358a8-859d-9ef1-7392-372d55b28ee4@redhat.com>
Date:   Mon, 2 Mar 2020 19:42:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218232953.5724-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/20 00:29, Sean Christopherson wrote:
> The primary intent of this series is to dynamically allocate the emulator
> and get KVM to a state where the emulator *could* be disabled at some
> point in the future.  Actually allowing userspace to disable the emulator
> was a minor change at that point, so I threw it in.
> 
> Dynamically allocating the emulator shrinks the size of x86 vcpus by
> ~2.5k bytes, which is important because 'struct vcpu_vmx' has once again
> fattened up and squeaked past the PAGE_ALLOC_COSTLY_ORDER threshold.
> Moving the emulator to its own allocation gives us some breathing room
> for the near future, and has some other nice side effects.
> 
> As for disabling the emulator... in the not-too-distant future, I expect
> there will be use cases that can truly disable KVM's emulator, e.g. for
> security (KVM's and/or the guests).  I don't have a strong opinion on
> whether or not KVM should actually allow userspace to disable the emulator
> without a concrete use case (unless there already is a use case?), which
> is why that part is done in its own tiny patch.
> 
> Running without an emulator has been "tested" in the sense that the
> selftests that don't require emulation continue to pass, and everything
> else fails with the expected "emulation error".

I agree with Vitaly that, if we want this, it should be a KVM_ENABLE_CAP
instead.  The first 10 patches are very nice cleanups though so I plan
to apply them (with Vitaly's suggested nits for review) after you answer
the question on patch 10.

Paolo

> 
> v2:
>   - Rebase to kvm/queue, 2c2787938512 ("KVM: selftests: Stop ...")
> 
> Sean Christopherson (13):
>   KVM: x86: Refactor I/O emulation helpers to provide vcpu-only variant
>   KVM: x86: Explicitly pass an exception struct to check_intercept
>   KVM: x86: Move emulation-only helpers to emulate.c
>   KVM: x86: Refactor R/W page helper to take the emulation context
>   KVM: x86: Refactor emulated exception injection to take the emul
>     context
>   KVM: x86: Refactor emulate tracepoint to explicitly take context
>   KVM: x86: Refactor init_emulate_ctxt() to explicitly take context
>   KVM: x86: Dynamically allocate per-vCPU emulation context
>   KVM: x86: Move kvm_emulate.h into KVM's private directory
>   KVM: x86: Shrink the usercopy region of the emulation context
>   KVM: x86: Add helper to "handle" internal emulation error
>   KVM: x86: Add variable to control existence of emulator
>   KVM: x86: Allow userspace to disable the kernel's emulator
> 
>  arch/x86/include/asm/kvm_host.h             |  12 +-
>  arch/x86/kvm/emulate.c                      |  13 +-
>  arch/x86/{include/asm => kvm}/kvm_emulate.h |   9 +-
>  arch/x86/kvm/mmu/mmu.c                      |   1 +
>  arch/x86/kvm/svm.c                          |   5 +-
>  arch/x86/kvm/trace.h                        |  22 +--
>  arch/x86/kvm/vmx/vmx.c                      |  15 +-
>  arch/x86/kvm/x86.c                          | 193 +++++++++++++-------
>  arch/x86/kvm/x86.h                          |  12 +-
>  9 files changed, 183 insertions(+), 99 deletions(-)
>  rename arch/x86/{include/asm => kvm}/kvm_emulate.h (99%)
> 

