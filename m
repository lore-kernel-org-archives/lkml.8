Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADA0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D420207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hR8BP/i1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgHTUIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 16:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgHTUIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 16:08:35 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9180C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 13:08:34 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id n128so3010264oif.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 13:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GpwFgamWVqMs1v/sOEpIYQQxMEuzWGAMmLZ6OgISKjw=;
        b=hR8BP/i1JBmlB1LmQQlCWmfRR0GJ9aYCx7yH/mjonES133wZQVlrqzfUFWRknPJ3VO
         /lbl4Pz1/2091MNHFqE9FWJhAH/NIZsnd5rHDBlS2hxr30JymZmf2d65AlVyME8mvWII
         C2zPQSZWBYNaE+V063+hhHkSXf16+iXEn3CmAYQOxxNBXJa3tJ8GfiTdfyGqcsBSKJaA
         O5nkoC+SSbwKi9wqnedJKOR6OPjfwqDWWLK8YEolJWZVEXjCvFEjPQUVTs29/xgdpUTF
         r6k0DgH96GCug2xxFeSAHNCoGTRVJAxCZN9scJqPepL3mhCjhAA49jn0RhPFh0lgJEVr
         fmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GpwFgamWVqMs1v/sOEpIYQQxMEuzWGAMmLZ6OgISKjw=;
        b=A0IBnWbdYyjf3NKF/W/a3rxnde53nDv2z2ceny5AR3iYAJKRTfGzLDWpIDb8+1xlxz
         Kggno8z7XzlJxWl8/81KrwFoLsp70EDvM6RetWxhFpOuNz7ulDBeA9w79h0Jne/NO6XI
         j0yJ8bWHC/SHKHAmax+9CxGtYWPJjVhS49x0CuJgCZVJeoepNMZrnCrgId+tn5KbRww1
         WzZTDvvFJkadENYnssou1Jo8Prp3lkZMTmHGMuGqaxtiXxWqH6rLA++ElziB9ruR/ef8
         3v0OUyEKeTvP9JivPFoyN8WrIiaBTyp0cW68i+K+QB+Fr1OhHNJNBR8Vl4PrvusWoZfD
         6C7A==
X-Gm-Message-State: AOAM533L0cfoL4sC/YVDdkjy/tvadrv5Nz9Tmm8lS6x1Kno+SpM7bM8c
        /yz6q8MgdB6FbHZY8/FDj4ljothKLUraj3aqGJU4wg==
X-Google-Smtp-Source: ABdhPJxLujXsofK2hMWnUp1gfJMtqP5I7r3Zv2lLxYgVvsnyUj3yNq2asg7InuIn65oLgHoB6hORdloRnSe+gpmBZrQ=
X-Received: by 2002:aca:670b:: with SMTP id z11mr60431oix.6.1597954113907;
 Thu, 20 Aug 2020 13:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200401081348.1345307-1-vkuznets@redhat.com>
In-Reply-To: <20200401081348.1345307-1-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 20 Aug 2020 13:08:22 -0700
Message-ID: <CALMp9eROXAOg_g=R8JRVfywY7uQXzBtVxKJYXq0dUcob-BfR-g@mail.gmail.com>
Subject: Re: [PATCH] KVM: VMX: fix crash cleanup when KVM wasn't used
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 1:13 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> If KVM wasn't used at all before we crash the cleanup procedure fails with
>  BUG: unable to handle page fault for address: ffffffffffffffc8
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 23215067 P4D 23215067 PUD 23217067 PMD 0
>  Oops: 0000 [#8] SMP PTI
>  CPU: 0 PID: 3542 Comm: bash Kdump: loaded Tainted: G      D           5.6.0-rc2+ #823
>  RIP: 0010:crash_vmclear_local_loaded_vmcss.cold+0x19/0x51 [kvm_intel]
>
> The root cause is that loaded_vmcss_on_cpu list is not yet initialized,
> we initialize it in hardware_enable() but this only happens when we start
> a VM.
>
> Previously, we used to have a bitmap with enabled CPUs and that was
> preventing [masking] the issue.
>
> Initialized loaded_vmcss_on_cpu list earlier, right before we assign
> crash_vmclear_loaded_vmcss pointer. blocked_vcpu_on_cpu list and
> blocked_vcpu_on_cpu_lock are moved altogether for consistency.
>
> Fixes: 31603d4fc2bb ("KVM: VMX: Always VMCLEAR in-use VMCSes during crash with kexec support")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 3aba51d782e2..39a5dde12b79 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2257,10 +2257,6 @@ static int hardware_enable(void)
>             !hv_get_vp_assist_page(cpu))
>                 return -EFAULT;
>
> -       INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
> -       INIT_LIST_HEAD(&per_cpu(blocked_vcpu_on_cpu, cpu));
> -       spin_lock_init(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
> -
>         r = kvm_cpu_vmxon(phys_addr);
>         if (r)
>                 return r;
> @@ -8006,7 +8002,7 @@ module_exit(vmx_exit);
>
>  static int __init vmx_init(void)
>  {
> -       int r;
> +       int r, cpu;
>
>  #if IS_ENABLED(CONFIG_HYPERV)
>         /*
> @@ -8060,6 +8056,12 @@ static int __init vmx_init(void)
>                 return r;
>         }
>
> +       for_each_possible_cpu(cpu) {
> +               INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
> +               INIT_LIST_HEAD(&per_cpu(blocked_vcpu_on_cpu, cpu));
> +               spin_lock_init(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
> +       }

Just above this chunk, we have:

r = vmx_setup_l1d_flush(vmentry_l1d_flush_param);
if (r) {
        vmx_exit();
...

If we take that early exit, because vmx_setup_l1d_flush() fails, we
won't initialize loaded_vmcss_on_cpu. However, vmx_exit() calls
kvm_exit(), which calls on_each_cpu(hardware_disable_nolock, NULL, 1).
Hardware_disable_nolock() then calls kvm_arch_hardware_disable(),
which calls kvm_x86_ops.hardware_disable() [the vmx.c
hardware_disable()], which calls vmclear_local_loaded_vmcss().

I believe that vmclear_local_loaded_vmcss() will then try to
dereference a NULL pointer, since per_cpu(loaded_vmcss_on_cpu, cpu) is
uninitialzed.

>  #ifdef CONFIG_KEXEC_CORE
>         rcu_assign_pointer(crash_vmclear_loaded_vmcss,
>                            crash_vmclear_local_loaded_vmcss);
> --
> 2.25.1
>
