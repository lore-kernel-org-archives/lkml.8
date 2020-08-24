Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA07C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADEF72063A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RzJVZWj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgHXWpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 18:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgHXWpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 18:45:38 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8252C061755
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 15:45:38 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id j19so2291536oor.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 15:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kz/k9wb2FtFBpuN0H9LrQExFH8jcMXPO4pczO7F26a8=;
        b=RzJVZWj2odYP6gj+fnANkDRiVVO5QhynntjYJvZQrziuYBLmg36YoSiEn+/tuSF6+l
         jSWpep4dxnzhgbca667Rpo5Mxk50/9gFQ6tQQBsZdz9Im5PIRnsfTdqdFJtoDKSu3KmC
         GABfjj4dKx0Ga2DUHZLRTUfZ/IE9hSQCBP0tLGFRDLgfEh2eV4Ge8e79ZidlpZso4sq1
         TJeK+3yi4N9NYShqELK6tdREyDCjIj52z0iXQRbLKKyy9oY74rVPBsXko1Y+Xueqw5ao
         0b5zrHgEFx/lPxfBW0oU3vY/nREloWj4xuxW7R/pQZIZY+GrfTpqK+z1MZAkAcyVWd3c
         Zg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kz/k9wb2FtFBpuN0H9LrQExFH8jcMXPO4pczO7F26a8=;
        b=nQC7WinXoOhn39nUZg+OnohzwQrecknZPkn3xPzJcHTw2OrJ9LSK5jqrltcmztCmDX
         VuPIp/jW3Pqw06UvvkQimoqlmVfOKfVvx603l4yFf8sFRchZg+GJZq/GvQrGX1OaeTQh
         Tdeueb3NPtxUXEoTXqH4RtsFpOdAg6Wyiz5aGLP7UrD6hUgQajqD+Qw33llzT+3hESIU
         ucwL3koRaxg+BzttBGEYf1jG6felCZvChNZoc5CqwgXI3zR++h8ZTDlPDkWCMutbiEAn
         Jr5SYJoTXJCId/upnNtEWMYV3py3Zhz52TVK7q1WHJyVASbtXHPtPRGqogrAn/+9MZ+W
         sE9Q==
X-Gm-Message-State: AOAM533KCXw9+03i/WR+THB59wfmzlz7S/e+Hb2HeH82j8WgzH8EoKbh
        UCOcQ6nYJm8Xq6qPYKp9y/Ny9XG13sxwOmUiL2TECA==
X-Google-Smtp-Source: ABdhPJxoitD/PnUJXpPvhw1LOyg4DhZctOdJ0E9ohQPLLvAmBu1DMELY+FzMW8VJkgep9J7crO1jfWH/4BKHIxWQXxw=
X-Received: by 2002:a4a:87c8:: with SMTP id c8mr5196624ooi.81.1598309137774;
 Mon, 24 Aug 2020 15:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200401081348.1345307-1-vkuznets@redhat.com> <CALMp9eROXAOg_g=R8JRVfywY7uQXzBtVxKJYXq0dUcob-BfR-g@mail.gmail.com>
 <20200822034046.GE4769@sjchrist-ice> <CALMp9eRHh9KXO12k4GaoenSJazFnSaN68FTVxOGhE9Mxw-hf2A@mail.gmail.com>
In-Reply-To: <CALMp9eRHh9KXO12k4GaoenSJazFnSaN68FTVxOGhE9Mxw-hf2A@mail.gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 24 Aug 2020 15:45:26 -0700
Message-ID: <CALMp9eS1HusEZvzLShuuuxQnReKgTtunsKLoy+2GMVJAaTrZ7A@mail.gmail.com>
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

On Mon, Aug 24, 2020 at 11:57 AM Jim Mattson <jmattson@google.com> wrote:
>
> On Fri, Aug 21, 2020 at 8:40 PM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
> >
> > On Thu, Aug 20, 2020 at 01:08:22PM -0700, Jim Mattson wrote:
> > > On Wed, Apr 1, 2020 at 1:13 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> > > > ---
> > > >  arch/x86/kvm/vmx/vmx.c | 12 +++++++-----
> > > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > > index 3aba51d782e2..39a5dde12b79 100644
> > > > --- a/arch/x86/kvm/vmx/vmx.c
> > > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > > @@ -2257,10 +2257,6 @@ static int hardware_enable(void)
> > > >             !hv_get_vp_assist_page(cpu))
> > > >                 return -EFAULT;
> > > >
> > > > -       INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
> > > > -       INIT_LIST_HEAD(&per_cpu(blocked_vcpu_on_cpu, cpu));
> > > > -       spin_lock_init(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
> > > > -
> > > >         r = kvm_cpu_vmxon(phys_addr);
> > > >         if (r)
> > > >                 return r;
> > > > @@ -8006,7 +8002,7 @@ module_exit(vmx_exit);
> > > >
> > > >  static int __init vmx_init(void)
> > > >  {
> > > > -       int r;
> > > > +       int r, cpu;
> > > >
> > > >  #if IS_ENABLED(CONFIG_HYPERV)
> > > >         /*
> > > > @@ -8060,6 +8056,12 @@ static int __init vmx_init(void)
> > > >                 return r;
> > > >         }
> > > >
> > > > +       for_each_possible_cpu(cpu) {
> > > > +               INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
> > > > +               INIT_LIST_HEAD(&per_cpu(blocked_vcpu_on_cpu, cpu));
> > > > +               spin_lock_init(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
> > > > +       }
> > >
> > > Just above this chunk, we have:
> > >
> > > r = vmx_setup_l1d_flush(vmentry_l1d_flush_param);
> > > if (r) {
> > >         vmx_exit();
> > > ...
> > >
> > > If we take that early exit, because vmx_setup_l1d_flush() fails, we
> > > won't initialize loaded_vmcss_on_cpu. However, vmx_exit() calls
> > > kvm_exit(), which calls on_each_cpu(hardware_disable_nolock, NULL, 1).
> > > Hardware_disable_nolock() then calls kvm_arch_hardware_disable(),
> > > which calls kvm_x86_ops.hardware_disable() [the vmx.c
> > > hardware_disable()], which calls vmclear_local_loaded_vmcss().
> > >
> > > I believe that vmclear_local_loaded_vmcss() will then try to
> > > dereference a NULL pointer, since per_cpu(loaded_vmcss_on_cpu, cpu) is
> > > uninitialzed.
> >
> > I agree the code is a mess (kvm_init() and kvm_exit() included), but I'm
> > pretty sure hardware_disable_nolock() is guaranteed to be a nop as it's
> > impossible for kvm_usage_count to be non-zero if vmx_init() hasn't
> > finished.
>
> Unless I'm missing something, there's no check for a non-zero
> kvm_usage_count on this path. There is such a check in
> hardware_disable_all_nolock(), but not in hardware_disable_nolock().

However, cpus_hardware_enabled shouldn't have any bits set, so
everything's fine. Nothing to see here, after all.
