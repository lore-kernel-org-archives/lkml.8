Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370AFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0689B20767
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GWkyDewu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgGIRXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgGIRXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:23:34 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B62C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 10:23:34 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id e18so2684570ilr.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 10:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QfbeKlIO0rvmOmH/fXg5wm5BC2aAKsXNn27bZMELkkA=;
        b=GWkyDewuHzKA6IQtYRZQUeIzpZj+ZYxSI0F9LmC/PLWYgpBkO48MXGFg9nUoAhQ+HE
         lbVLBP1zDndsm/GU4u8AnwOO4A0FDbAGqJBRuZPNqXGY05ivRZ9Kk1YTTUtnPMJJWt38
         4avyd4g6Pp+Z3U1xBwmEz1bTTp1Gfy8s86LnXvR4Hxp/HlSjLpg/sJa/yziKWDT6EMdU
         qjJvc48zjau7NB7HLZbiGDp/ZNZGn7foAYWVkA+kMfVTHetM9Isf1+2ZHNupi4kkkK2E
         CiCgKcROUwb5G5PDtlBGKtgqbS3j9wc0OIhEa/zmgNkXSGJCFODMLImqOGeX69nNY4Kc
         aecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QfbeKlIO0rvmOmH/fXg5wm5BC2aAKsXNn27bZMELkkA=;
        b=NyMFTmTlyg56tOsNQ8+xeP88a9RN9/YJr/h8AEyYcn+ivp2spxqOUuiQOJOImD34al
         /DSr6W+znZuJBym+LLMJppVnIpP5roJWShAMdUZNKj4wkVkAnvVhkzpOstOrk81J61kt
         Lt1Od2T/B4OEcvx9hdHwMcT3SB40NXai/DEU082i+gkBMIyqAG8C2SltoxZXW1GJXl2b
         gfJib+5gbaVyqKa/K0SFS2fWg61p+jmFg9w5mWsUksyRkWRI+Jnhsu07qAkMpQ/rK/41
         82MLqQryuUkI1dtby5qLrjkeClc1BycN1Fdr1URGd3p0UUgtPxv4rJPvAnZpJbYBt9ha
         lC6Q==
X-Gm-Message-State: AOAM530H9xEFJNFteDbH2ejutLniqK9vJECw/GK9Y0xdifNBGBizNYBr
        RhDa8xagRk+TCsZUuX6qlZH8toKrMto/pAGp4iXbwQ==
X-Google-Smtp-Source: ABdhPJxhne2a9Tt91XzKX0hagSjCEcPUtArkiZmCTZopZHelGOPqa4XeWF0QSnjLMvk6qhXghfoSYfwGlrRGITvvG+M=
X-Received: by 2002:a92:c989:: with SMTP id y9mr38849091iln.108.1594315413474;
 Thu, 09 Jul 2020 10:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200709171507.1819-1-pbonzini@redhat.com>
In-Reply-To: <20200709171507.1819-1-pbonzini@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 9 Jul 2020 10:23:22 -0700
Message-ID: <CALMp9eQPqUUDzzkdHbq05VPFfgm=fP4O6=47ZV7q5eOEVNFPXQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: fixes for preemption timer migration
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, Bandan Das <bsd@redhat.com>,
        Makarand Sonare <makarandsonare@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 10:15 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Commit 850448f35aaf ("KVM: nVMX: Fix VMX preemption timer migration",
> 2020-06-01) accidentally broke nVMX live migration from older version
> by changing the userspace ABI.  Restore it and, while at it, ensure
> that vmx->nested.has_preemption_timer_deadline is always initialized
> according to the KVM_STATE_VMX_PREEMPTION_TIMER_DEADLINE flag.
>
> Cc: Makarand Sonare <makarandsonare@google.com>
> Fixes: 850448f35aaf ("KVM: nVMX: Fix VMX preemption timer migration")
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/include/uapi/asm/kvm.h | 5 +++--
>  arch/x86/kvm/vmx/nested.c       | 3 ++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
> index 17c5a038f42d..0780f97c1850 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -408,14 +408,15 @@ struct kvm_vmx_nested_state_data {
>  };
>
>  struct kvm_vmx_nested_state_hdr {
> -       __u32 flags;
>         __u64 vmxon_pa;
>         __u64 vmcs12_pa;
> -       __u64 preemption_timer_deadline;
>
>         struct {
>                 __u16 flags;
>         } smm;
> +
> +       __u32 flags;
> +       __u64 preemption_timer_deadline;
>  };
>
>  struct kvm_svm_nested_state_data {
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index b26655104d4a..3fc2411edc92 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -6180,7 +6180,8 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
>                 vmx->nested.has_preemption_timer_deadline = true;
>                 vmx->nested.preemption_timer_deadline =
>                         kvm_state->hdr.vmx.preemption_timer_deadline;
> -       }
> +       } else
> +               vmx->nested.has_preemption_timer_deadline = false;

Doesn't the coding standard require braces around the else clause?

Reviewed-by: Jim Mattson <jmattson@google.com>
