Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119CCC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E31AB20721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="in72ZRbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbgEDRWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:22:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33232 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729549AbgEDRWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JzrHLa4yO9piUrvMC3ds7g4OpEiv0B4QEcZSD2qDkrA=;
        b=in72ZRbDtsc6KqcR9RlxJlHC3Hc+b8rrQKFPMlHg48tZf4tnn9XDcw+Qf0Pt8OaCl8/Cx3
        5U/YKzkWkCxPjKQRoRdZ65v1qL2USzlOLIdIFKID7hvCtEdeKv8vpWJ0quJkbbzR2rtAZm
        8To5OCb1z3/0ARWNMXnEtw9ErwCRPOE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-MfsjiLnVMKm08yjsIfNOfA-1; Mon, 04 May 2020 13:22:40 -0400
X-MC-Unique: MfsjiLnVMKm08yjsIfNOfA-1
Received: by mail-wr1-f72.google.com with SMTP id h12so186485wrr.19
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 10:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JzrHLa4yO9piUrvMC3ds7g4OpEiv0B4QEcZSD2qDkrA=;
        b=RQdD4JuHnv559O/f4OpVZQi7vT6l+vEwPxHthfdmFB32sS60LcNt7d+Ki+bWuvipUS
         UwteBqfZ/dg1QQ60unxWESHt4wPXWvAS0a+B098XBomAltq/TaYjqs+SHJX+lRx4rOan
         GyBDy3T40bYsq+ERPZ5RT7cAJfj3o58pKLhVjNFCNiNiOciETxC2INzEeMCWdBdTsW+p
         TRp8WHeyfwZKsX4uTUPU3GMTZTQBjxWZc4rFlLC9FQ7RAEabtOZFit8Gp3Kl4tTqajUO
         PPLUwtX5YCqXgu/K9+E53EExYYrV1F5bd+Y8EPC7rDDTjRJxwlbG75T8L3wRpvZmMyEn
         W3ow==
X-Gm-Message-State: AGi0PuYIXoIKz+xHjqPhf1iXZLvk7qz30zv3b0Hw6rUxG4cGmbe3ELws
        jDwD+Sm8XVHuvKGSrJ5DN4faYfJtuBdF5bNZtT0181h8PQqULUyBd2FxN9JJzCGv9cO1n/xak9c
        nRKmZnXfL+SFSiWocvxvK0AvN
X-Received: by 2002:a1c:2e91:: with SMTP id u139mr15337111wmu.18.1588612958981;
        Mon, 04 May 2020 10:22:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ7AQYoylVQUK+fEXTNONUM6fSyUA1uFiuC72Sdv+Lm4wvXk2jFjHoC4mb2iB4Rn3OzXU/kzA==
X-Received: by 2002:a1c:2e91:: with SMTP id u139mr15337091wmu.18.1588612958716;
        Mon, 04 May 2020 10:22:38 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
        by smtp.gmail.com with ESMTPSA id v131sm141677wmb.19.2020.05.04.10.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 10:22:38 -0700 (PDT)
Subject: Re: [PATCH v4 0/7] KVM: VMX: Tscdeadline timer emulation fastpath
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Haiwei Li <lihaiwei@tencent.com>
References: <1588055009-12677-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8f7fd1b1-51c5-29a4-cfce-5ebe51a486cf@redhat.com>
Date:   Mon, 4 May 2020 19:22:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1588055009-12677-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/20 08:23, Wanpeng Li wrote:
> IPI and Timer cause the main vmexits in cloud environment observation, 
> after single target IPI fastpath, let's optimize tscdeadline timer 
> latency by introducing tscdeadline timer emulation fastpath, it will 
> skip various KVM related checks when possible. i.e. after vmexit due 
> to tscdeadline timer emulation, handle it and vmentry immediately 
> without checking various kvm stuff when possible. 
> 
> Testing on SKX Server.
> 
> cyclictest in guest(w/o mwait exposed, adaptive advance lapic timer is default -1):
> 
> 5540.5ns -> 4602ns       17%
> 
> kvm-unit-test/vmexit.flat:
> 
> w/o avanced timer:
> tscdeadline_immed: 3028.5  -> 2494.75  17.6%
> tscdeadline:       5765.7  -> 5285      8.3%
> 
> w/ adaptive advance timer default -1:
> tscdeadline_immed: 3123.75 -> 2583     17.3%
> tscdeadline:       4663.75 -> 4537      2.7%
> 
> Tested-by: Haiwei Li <lihaiwei@tencent.com>
> Cc: Haiwei Li <lihaiwei@tencent.com>
> 
> v3 -> v4:
>  * fix bad indentation
>  * rename CONT_RUN to REENTER_GUEST
>  * rename kvm_need_cancel_enter_guest to kvm_vcpu_exit_request
>  * rename EXIT_FASTPATH_CONT_RUN to EXIT_FASTPATH_REENTER_GUEST 
>  * introduce EXIT_FASTPATH_NOP 
>  * don't squish several stuffs to one patch
>  * REENTER_GUEST be introduced with its first usage
>  * introduce __handle_preemption_timer subfunction
> 
> v2 -> v3:
>  * skip interrupt notify and use vmx_sync_pir_to_irr before each cont_run
>  * add from_timer_fn argument to apic_timer_expired
>  * remove all kinds of duplicate codes
> 
> v1 -> v2:
>  * move more stuff from vmx.c to lapic.c
>  * remove redundant checking
>  * check more conditions to bail out CONT_RUN
>  * not break AMD
>  * not handle LVTT sepecial
>  * cleanup codes
> 
> Wanpeng Li (7):
>   KVM: VMX: Introduce generic fastpath handler
>   KVM: X86: Enable fastpath when APICv is enabled
>   KVM: X86: Introduce more exit_fastpath_completion enum values
>   KVM: X86: Introduce kvm_vcpu_exit_request() helper
>   KVM: VMX: Optimize posted-interrupt delivery for timer fastpath
>   KVM: X86: TSCDEADLINE MSR emulation fastpath
>   KVM: VMX: Handle preemption timer fastpath
> 
>  arch/x86/include/asm/kvm_host.h |  3 ++
>  arch/x86/kvm/lapic.c            | 18 +++++++----
>  arch/x86/kvm/svm/svm.c          | 11 ++++---
>  arch/x86/kvm/vmx/vmx.c          | 66 +++++++++++++++++++++++++++++++++--------
>  arch/x86/kvm/x86.c              | 44 ++++++++++++++++++++-------
>  arch/x86/kvm/x86.h              |  3 +-
>  virt/kvm/kvm_main.c             |  1 +
>  7 files changed, 110 insertions(+), 36 deletions(-)
> 

Queued all except 2, pending testing (and understanding the rationale
behind patch 2).  I will post separately my version of patch 3.

Thanks,

Paolo

