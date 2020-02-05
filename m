Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2656BC35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE57B2072B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwK7gQWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgBEN1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 08:27:02 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36225 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgBEN1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 08:27:00 -0500
Received: by mail-ot1-f68.google.com with SMTP id j20so1902087otq.3;
        Wed, 05 Feb 2020 05:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2iTmjWroM0axQMfNXSTY4B+Vwm8DbZJfE7GwGUvjpyQ=;
        b=NwK7gQWqLfS/JUcGRZD+ikHP6oDzawbpGi52vOScViy7NpUb95lXZ/qUrSo13MJZuk
         5/yZgqQKnkk0cMi5K7k1nZ3Jkn32nXwG8KZDA4HzCX1QzJqELzGfLhg1RjDGNfa9+j16
         2WgZ5TU6eDlgZr1yrAB0vtYMLNBqb/QSpHhDJA1FB9nSMkk+3OGgHseBOnZn6Ydg8Lvg
         vJrmPR0nsLR7TIHrGo1+7I32n8wSUO3gmaXbvmBTsVMwTUQjtr/3fgwqRRomCz40+hgs
         alg9cOYWy3/bXhMOq/p+kABPeatiwUrS7yeF9cVyPolffFTFyh/K1iyMZI+aP89YauAq
         +bTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2iTmjWroM0axQMfNXSTY4B+Vwm8DbZJfE7GwGUvjpyQ=;
        b=WzjJo3ZViRdjrUhgzA7oeCBf1SGXCNRCCJ9KureROJrZQPPHo18zB3pA77vKxRCZwT
         z+A8Kg9eqGYSsv/2rSUIL3X4EzQGtdmNIj+EyyPJExj0q9rcKIRv3unG4BZE28Hd1wLd
         GYDAlY786hvEl8b6q/HyOUzeKAOMVRzLN9RuYt/54OXpHDTCxAHCy+Dztc/8G3KeqxKG
         g2ZpktZeNZbw+LkIWJMoztrUJ00bLX+5hCgaK+KHhTKpoUPdvZzWikzSNZZALEuBuZ4P
         eyPlj6Zf3laI8MRkD5ux9fImxkfUZWPRq6qfL7HslJSDSkxDMJ1+WqwEFat7ihUO3mM+
         0AKg==
X-Gm-Message-State: APjAAAWHS8fTBYZ6AoMYZ7dW4PAac1C4nVqxgojfVWRas28V8tTn8eFz
        gHd7VcvG+QmzCP5OBPNQRT7VHNOGuiBi7mZIToU=
X-Google-Smtp-Source: APXvYqx1Uo1av+7UTImzpbx3g3+rhU7G9l4tWB7NjhIpKmc4Fdg2DC7DGxSh2/aVlTgjwCfxuKVENTDYA5D3HTry98k=
X-Received: by 2002:a05:6830:231d:: with SMTP id u29mr26656265ote.185.1580909219503;
 Wed, 05 Feb 2020 05:26:59 -0800 (PST)
MIME-Version: 1.0
References: <CANRm+CwwYoSLeA3Squp-_fVZpmYmxEfqOB+DGoQN4Y_iMT347w@mail.gmail.com>
 <878slio6hp.fsf@vitty.brq.redhat.com> <CANRm+CzkN9oYf4UqWYp2SHFii02=pvVLbW4oNkLmPan7ZroDZA@mail.gmail.com>
 <874kw6o1ve.fsf@vitty.brq.redhat.com>
In-Reply-To: <874kw6o1ve.fsf@vitty.brq.redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Wed, 5 Feb 2020 21:26:48 +0800
Message-ID: <CANRm+CwgJ07i3O_-DpvDMaVSGThX7Ymwuty9rBm5Sc2wiuV-bw@mail.gmail.com>
Subject: Re: [PATCH] KVM: Pre-allocate 1 cpumask variable per cpu for both pv
 tlb and pv ipis
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Feb 2020 at 22:36, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Wanpeng Li <kernellwp@gmail.com> writes:
>
> >>
> >> Honestly, I'd simplify the check in kvm_alloc_cpumask() as
> >>
> >> if (!kvm_para_available())
> >>         return;
> >>
> >> and allocated masks for all other cases.
> >
> > This will waste the memory if pv tlb and pv ipis are not exposed which
> > are the only users currently.
> >
>
> My assumption is that the number of cases where we a) expose KVM b)
> don't expose IPIs and PV-TLB and c) care about 1 cpumask per cpu is
> relatively low. Ok, let's at least have a function for
>
>         if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
>             !kvm_para_has_hint(KVM_HINTS_REALTIME) &&
>             kvm_para_has_feature(KVM_FEATURE_STEAL_TIME))
>
> as we now check it twice: in kvm_alloc_cpumask() and kvm_guest_init(),
> something like pv_tlb_flush_supported(). We can also do
> pv_ipi_supported() and probably others for consistency.

Will do.

    Wanpeng
