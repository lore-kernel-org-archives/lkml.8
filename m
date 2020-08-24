Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0F5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3229820738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ax2mL3p3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgHXS5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgHXS5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:57:48 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51A8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:57:47 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id b9so5815466oiy.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MPucIPCHpwX6Bmh4YO5fRSV0Dn46Pt3wZbjUIXrC1hQ=;
        b=ax2mL3p3PeTYQEQ/OIlwLBRIpVmZ0zSoroj/pMHcJf0c/JMUnNjBNrFdFd3Yl4AdgZ
         Y581dRsZuzhftzdplAoRvVpnnhZhWkALQw3Sym+GHzD1MUuHEQKqucLdNBNH0JN99l70
         GuywBwTgMolo+BDGqCsljUQMKoYK+KLrOzAs1ohAFdDkJwK4g7h/b8hRlKRaK+I9DC9/
         9RXFcZOGEM7T2iIJQAQs57oWJrUYveZ4xY29oYtoJiPLkvfVfMtf7vmsSeWcP4FhEqRy
         jgKhYQ1vNUX+HfUHpU8qv9E66lDdJlDmedmZF2Ijkj+y1JOOHBCX5mAdLNsag/oNeBWC
         btRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MPucIPCHpwX6Bmh4YO5fRSV0Dn46Pt3wZbjUIXrC1hQ=;
        b=TQHv56jd0HmgGmRbkuWtTcMXT3p0LKm0ZSCrzN7ppO4vrJ7pjOESqdMJRAQSccnBv0
         6inRQYf2OOR/TXrzgxs0EhiyDjRleWgj0AkXYK4qFKg9AHDom6aTavdAdmaLbHFuOhOg
         T9QynbGpU+LDFWmKgm6/3DE52k99rUppbaCrCV8H/5p7tsaQZ6cppJimKBLT6NHyFOHi
         SmnNHmJoTqtDPtiejm6/sYg6adqkp5fc17D2q+uOdzHgIYzgqGwkrncfM96dGaZDu7Et
         6gCeuin0uNeqvA6zlmF613tc449Hobp5O7Ao6AFfY4PtSkJWe+HlcmH43Un3piv9gg7x
         VmIQ==
X-Gm-Message-State: AOAM533dMdzHzA37mQNz7RMV5rv0uHmzIf77j8IoZBTGi5uOJTXQ0oC2
        y01O1Iz2xS4NpvaxI959j339s38+w6mVruRjPlVwlA==
X-Google-Smtp-Source: ABdhPJxXgm1gvFikO0/gwgEgRKtqeJpdMtjhdu4kpc01sdOJdUVy5IKgIlHK+wpjF36VXFvsUVJqbsXbj6mkzmsnBL8=
X-Received: by 2002:aca:b942:: with SMTP id j63mr504688oif.28.1598295466852;
 Mon, 24 Aug 2020 11:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200401081348.1345307-1-vkuznets@redhat.com> <CALMp9eROXAOg_g=R8JRVfywY7uQXzBtVxKJYXq0dUcob-BfR-g@mail.gmail.com>
 <20200822034046.GE4769@sjchrist-ice>
In-Reply-To: <20200822034046.GE4769@sjchrist-ice>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 24 Aug 2020 11:57:35 -0700
Message-ID: <CALMp9eRHh9KXO12k4GaoenSJazFnSaN68FTVxOGhE9Mxw-hf2A@mail.gmail.com>
Subject: Re: [PATCH] KVM: VMX: fix crash cleanup when KVM wasn't used
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 8:40 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Thu, Aug 20, 2020 at 01:08:22PM -0700, Jim Mattson wrote:
> > On Wed, Apr 1, 2020 at 1:13 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> > > ---
> > >  arch/x86/kvm/vmx/vmx.c | 12 +++++++-----
> > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > index 3aba51d782e2..39a5dde12b79 100644
> > > --- a/arch/x86/kvm/vmx/vmx.c
> > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > @@ -2257,10 +2257,6 @@ static int hardware_enable(void)
> > >             !hv_get_vp_assist_page(cpu))
> > >                 return -EFAULT;
> > >
> > > -       INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
> > > -       INIT_LIST_HEAD(&per_cpu(blocked_vcpu_on_cpu, cpu));
> > > -       spin_lock_init(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
> > > -
> > >         r = kvm_cpu_vmxon(phys_addr);
> > >         if (r)
> > >                 return r;
> > > @@ -8006,7 +8002,7 @@ module_exit(vmx_exit);
> > >
> > >  static int __init vmx_init(void)
> > >  {
> > > -       int r;
> > > +       int r, cpu;
> > >
> > >  #if IS_ENABLED(CONFIG_HYPERV)
> > >         /*
> > > @@ -8060,6 +8056,12 @@ static int __init vmx_init(void)
> > >                 return r;
> > >         }
> > >
> > > +       for_each_possible_cpu(cpu) {
> > > +               INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
> > > +               INIT_LIST_HEAD(&per_cpu(blocked_vcpu_on_cpu, cpu));
> > > +               spin_lock_init(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
> > > +       }
> >
> > Just above this chunk, we have:
> >
> > r = vmx_setup_l1d_flush(vmentry_l1d_flush_param);
> > if (r) {
> >         vmx_exit();
> > ...
> >
> > If we take that early exit, because vmx_setup_l1d_flush() fails, we
> > won't initialize loaded_vmcss_on_cpu. However, vmx_exit() calls
> > kvm_exit(), which calls on_each_cpu(hardware_disable_nolock, NULL, 1).
> > Hardware_disable_nolock() then calls kvm_arch_hardware_disable(),
> > which calls kvm_x86_ops.hardware_disable() [the vmx.c
> > hardware_disable()], which calls vmclear_local_loaded_vmcss().
> >
> > I believe that vmclear_local_loaded_vmcss() will then try to
> > dereference a NULL pointer, since per_cpu(loaded_vmcss_on_cpu, cpu) is
> > uninitialzed.
>
> I agree the code is a mess (kvm_init() and kvm_exit() included), but I'm
> pretty sure hardware_disable_nolock() is guaranteed to be a nop as it's
> impossible for kvm_usage_count to be non-zero if vmx_init() hasn't
> finished.

Unless I'm missing something, there's no check for a non-zero
kvm_usage_count on this path. There is such a check in
hardware_disable_all_nolock(), but not in hardware_disable_nolock().
