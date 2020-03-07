Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BDFC10F26
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 10:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD4F2073C
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 10:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgCGKJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 05:09:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55353 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgCGKJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 05:09:15 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jAWOM-000531-Gg; Sat, 07 Mar 2020 11:09:10 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id D9EB8104088; Sat,  7 Mar 2020 11:09:09 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/kvm: Disable KVM_ASYNC_PF_SEND_ALWAYS
In-Reply-To: <25d5c6de22cabf6a4ecb44ce077f33aa5f10b4d4.1583547371.git.luto@kernel.org>
References: <25d5c6de22cabf6a4ecb44ce077f33aa5f10b4d4.1583547371.git.luto@kernel.org>
Date:   Sat, 07 Mar 2020 11:09:09 +0100
Message-ID: <87o8t8a33u.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:

> The ABI is broken and we cannot support it properly.  Turn it off.
>
> If this causes a meaningful performance regression for someone, KVM
> can introduce an improved ABI that is supportable.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/kernel/kvm.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 93ab0cbd304e..71f9f39f93da 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -318,11 +318,16 @@ static void kvm_guest_cpu_init(void)
>  
>  		pa = slow_virt_to_phys(this_cpu_ptr(&apf_reason));
>  
> -#ifdef CONFIG_PREEMPTION
> -		pa |= KVM_ASYNC_PF_SEND_ALWAYS;
> -#endif
>  		pa |= KVM_ASYNC_PF_ENABLED;
>  
> +		/*
> +		 * We do not set KVM_ASYNC_PF_SEND_ALWAYS.  With the current
> +		 * KVM paravirt ABI, if an async page fault occurs on an early
> +		 * memory access in the normal (sync) #PF path or in an NMI
> +		 * that happens early in the #PF code, the combination of CR2
> +		 * and the APF reason field will be corrupted.

I don't think this can happen. In both cases IF == 0 and that async
(think host side) page fault will be completely handled on the
host. There is no injection happening in such a case ever. If it does,
then yes the host side implementation is buggered, but AFAICT this is
not the case.

See also my reply in the other thread:

  https://lore.kernel.org/r/87r1y4a3gw.fsf@nanos.tec.linutronix.de

Thanks,

        tglx
