Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101B5C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D213920873
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AZL9JD7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgCBV7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:59:22 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39387 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCBV7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 16:59:22 -0500
Received: by mail-io1-f66.google.com with SMTP id h3so1206154ioj.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 13:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k79f6FSLIZMoPc6ba/k7bGFDErimuhlDt9Pf9L3xddw=;
        b=AZL9JD7p/YDPrHNM8z4E+K7pT5oQq2DJHAiq9En9MJZm57Dr7Lf00dy+CUARCwkWPC
         LqpiTVpMTnHiWg4VNCRtcpVa3PKtBU6BxPT2X8j+BDZwaOyK0pkBQUFGGuovoV/HB8pP
         QakYbpf69Sa5ABiWu989LcKKAU4y1rjuT5me69XwvuHXSQVfLxrSx25twnuJq1mZgTzS
         id3f5w5VE2a3wbGiZIGD9FAR6n8OOkRoBWRio/Gs13Dp4agBJfR9OqjbdyD7m2M2521o
         AIEF/dna5OPNo1DT3SJ9c7UBL3XIdAQVU1l6HO426pkTwVgJsWrE29lVktyBa8xNGNHU
         r+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k79f6FSLIZMoPc6ba/k7bGFDErimuhlDt9Pf9L3xddw=;
        b=OEYQ7kNgCLmAos4jcWt7LngXIM86J2yTctZey97f1wfoSr7p9c+MW/GpD+HxoD9nKJ
         g2SP5JRWljNLjcWt5MK1IGM3sRB9+zgSp0IbP8KDQfD/iGq0VbF+JaTTVLBTyy8/IWQy
         VMyhndezv1vnv6aDwwxp4ABJcbTyZdAkBd9k+QlIeWQREQiIzHTtROXXmmBPNi8Hxrzs
         FrCmyXThu06/hzQ6O9bVVVrPSWaTwBUIeJGmCSXuiqOmQamC5QpjYzC2KXfQj8ByN+e4
         tXM91fb9Vk2mVLtAMABbVBdWrUchb/i8hYRAu8R4RVRYCLqegiM3m18f9l5fwBAWylpQ
         Iziw==
X-Gm-Message-State: ANhLgQ3U8sX+T+TCZB+6wZXVOB74MntMOTEKzSvkdAkYxFn6k0yWhVnQ
        LdTUF6wyB6vq6Rp1CSA7AS/EPVRNU7xSWtYKtYP8fg==
X-Google-Smtp-Source: ADFU+vs8yfYVMZQ3ZOiil6p4tNPAfESDiP+gRF625VzibXWQpYgian9xw8Xj/DKzO4rXQgRZHtkyGTpuKnlOnni7tUw=
X-Received: by 2002:a02:cf0f:: with SMTP id q15mr1188331jar.48.1583186361160;
 Mon, 02 Mar 2020 13:59:21 -0800 (PST)
MIME-Version: 1.0
References: <20200302195736.24777-1-sean.j.christopherson@intel.com> <20200302195736.24777-3-sean.j.christopherson@intel.com>
In-Reply-To: <20200302195736.24777-3-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 2 Mar 2020 13:59:10 -0800
Message-ID: <CALMp9eTNY0Wd=Wc=b8xzg0xRYE-ht5m=+cZeEb7nZup6EdYhCg@mail.gmail.com>
Subject: Re: [PATCH 2/6] KVM: x86: Fix CPUID range check for Centaur and
 Hypervisor ranges
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 11:57 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Extend the mask in cpuid_function_in_range() for finding the "class" of
> the function to 0xfffffff00.  While there is no official definition of
> what constitutes a class, e.g. arguably bits 31:16 should be the class
> and bits 15:0 the functions within that class, the Hypervisor logic
> effectively uses bits 31:8 as the class by virtue of checking for
> different bases in increments of 0x100, e.g. KVM advertises its CPUID
> functions starting at 0x40000100 when HyperV features are advertised at
> the default base of 0x40000000.

This convention deserves explicit documentation outside of the commit message.

> Masking against 0x80000000 only handles basic and extended leafs, which
> results in Centaur and Hypervisor range checks being performed against
> the basic CPUID range, e.g. if CPUID.0x40000000.EAX=0x4000000A and there
> is no entry for CPUID.0x40000006, then function 0x40000006 would be
> incorrectly reported as out of bounds.
>
> The bad range check doesn't cause function problems for any known VMM
> because out-of-range semantics only come into play if the exact entry
> isn't found, and VMMs either support a very limited Hypervisor range,
> e.g. the official KVM range is 0x40000000-0x40000001 (effectively no
> room for undefined leafs) or explicitly defines gaps to be zero, e.g.
> Qemu explicitly creates zeroed entries up to the Cenatur and Hypervisor
> limits (the latter comes into play when providing HyperV features).

Does Centaur implement the bizarre Intel behavior for out-of-bound
entries? It seems that if there are Centaur leaves defined, the CPUD
semantics should be those specified by Centaur.

> The bad behavior can be visually confirmed by dumping CPUID output in
> the guest when running Qemu with a stable TSC, as Qemu extends the limit
> of range 0x40000000 to 0x40000010 to advertise VMware's cpuid_freq,
> without defining zeroed entries for 0x40000002 - 0x4000000f.
>
> Fixes: 43561123ab37 ("kvm: x86: Improve emulation of CPUID leaves 0BH and 1FH")
> Cc: Jim Mattson <jmattson@google.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 6be012937eba..c320126e0118 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -993,7 +993,7 @@ static bool cpuid_function_in_range(struct kvm_vcpu *vcpu, u32 function)
>  {
>         struct kvm_cpuid_entry2 *max;
>
> -       max = kvm_find_cpuid_entry(vcpu, function & 0x80000000, 0);
> +       max = kvm_find_cpuid_entry(vcpu, function & 0xffffff00u, 0);

This assumes that CPUID.(function & 0xffffff00):EAX always contains
the maximum input value for the 256-entry range sharing the high 24
bits. I don't believe that convention has ever been established or
documented.

>         return max && function <= max->eax;
>  }
>
> --
> 2.24.1
>
