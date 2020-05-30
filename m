Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A91BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 02:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3295F20707
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 02:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dffCavqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgE3CI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 22:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgE3CI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 22:08:26 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCEBC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 19:08:25 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t8so3832179ilm.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 19:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WPmaAyijbZRcdnCDAzIdmftbmv7QF44NJaDAxY23DL4=;
        b=dffCavqiDYn5M+lBLNQ6T7a04SmV9z755BGFbZDfyEqsCLZiM8bgDBn14b0m5Ou2O0
         y7JrTwcvbluc1IzBgtQQV3atlx15fFkXvP+Oc0Tr4OSw3DnTrhm3pJTj04xR3QHZLkSo
         xa2JpPsQwA4XI9sTiG4q6fYH1ibXgmg39fnYGLVDiIJ07zDGMRHaw0T/hdMp3AWTkinr
         QLGWFWH4Ec9OgUHnnDUWgDeDrV83aiF/8G3YUgZRIPE1EYOb6+XToEp8vOpaWdOL7l0n
         63Us23g017swm+mRV+ojJWZz/EyyRvSmWNRDeqjjv4eT9BcQMUTwbbadvYK5PHyQCP6p
         bZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WPmaAyijbZRcdnCDAzIdmftbmv7QF44NJaDAxY23DL4=;
        b=ouTWpgIhhDdVqo16KlgkmcOhhJJY6nyOQ59hIf64aYNJ8dobllnt/8x6QRi4RYSpqd
         8Jant9VtVBkgbeSzRD7MyQvAlxyAzH2b9nnZ+nlvL2v3Mo4ofFG33kE75cffUZdZ+e95
         9jTFyofnIIlQCFaM8sjkSVU7wcuI3TXVDmX9VX5EPjobubqlS3FMZZ/5GehmvhyfGrCJ
         xc4yu1OZUfblO+MGmjLk4KhuY3lYfjgU+dnYNYoec/DU6ptAf55mU2SZR0Flha8oz3hd
         nvn2RXcrZ7rMpS1b5klcpYsBU1W3bJZU+6+/jT5DTT4OctssqLC4MRDQGKwEsqFJ524f
         rKEw==
X-Gm-Message-State: AOAM531ddyY9TODERrJbD+B1GMsLsyb+hFHKxwE27skqctq49GKEgqNC
        5V7Hc2vLVc5CtFt+4X7XcXbI9samf4KOUbTGNIGJzA==
X-Google-Smtp-Source: ABdhPJzQLPvKvFtxSJpo0NMt91IPWVc2aHICrA/25fG0J4C9CLGA1vx885sW3B2jt+uaANVqHdN2+IKq8BzFs4gs+Ok=
X-Received: by 2002:a92:a113:: with SMTP id v19mr10062469ili.110.1590804504597;
 Fri, 29 May 2020 19:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588711355.git.ashish.kalra@amd.com> <4ff020b446baa06037136ceeb1e66d4eba8ad492.1588711355.git.ashish.kalra@amd.com>
In-Reply-To: <4ff020b446baa06037136ceeb1e66d4eba8ad492.1588711355.git.ashish.kalra@amd.com>
From:   Steve Rutherford <srutherford@google.com>
Date:   Fri, 29 May 2020 19:07:48 -0700
Message-ID: <CABayD+dJF2YX7hB+=Vtt9qHXs__axH14Mnbs=5u_hDhnRUdXVA@mail.gmail.com>
Subject: Re: [PATCH v8 13/18] KVM: x86: Introduce new KVM_FEATURE_SEV_LIVE_MIGRATION
 feature & Custom MSR.
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@suse.de>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 2:19 PM Ashish Kalra <Ashish.Kalra@amd.com> wrote:
>
> From: Ashish Kalra <ashish.kalra@amd.com>
>
> Add new KVM_FEATURE_SEV_LIVE_MIGRATION feature for guest to check
> for host-side support for SEV live migration. Also add a new custom
> MSR_KVM_SEV_LIVE_MIG_EN for guest to enable the SEV live migration
> feature.
>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  Documentation/virt/kvm/cpuid.rst     |  5 +++++
>  Documentation/virt/kvm/msr.rst       | 10 ++++++++++
>  arch/x86/include/uapi/asm/kvm_para.h |  5 +++++
>  arch/x86/kvm/svm/sev.c               | 14 ++++++++++++++
>  arch/x86/kvm/svm/svm.c               | 16 ++++++++++++++++
>  arch/x86/kvm/svm/svm.h               |  2 ++
>  6 files changed, 52 insertions(+)
>
> diff --git a/Documentation/virt/kvm/cpuid.rst b/Documentation/virt/kvm/cpuid.rst
> index 01b081f6e7ea..0514523e00cd 100644
> --- a/Documentation/virt/kvm/cpuid.rst
> +++ b/Documentation/virt/kvm/cpuid.rst
> @@ -86,6 +86,11 @@ KVM_FEATURE_PV_SCHED_YIELD        13          guest checks this feature bit
>                                                before using paravirtualized
>                                                sched yield.
>
> +KVM_FEATURE_SEV_LIVE_MIGRATION    14          guest checks this feature bit before
> +                                              using the page encryption state
> +                                              hypercall to notify the page state
> +                                              change
> +
>  KVM_FEATURE_CLOCSOURCE_STABLE_BIT 24          host will warn if no guest-side
>                                                per-cpu warps are expeced in
>                                                kvmclock
> diff --git a/Documentation/virt/kvm/msr.rst b/Documentation/virt/kvm/msr.rst
> index 33892036672d..7cd7786bbb03 100644
> --- a/Documentation/virt/kvm/msr.rst
> +++ b/Documentation/virt/kvm/msr.rst
> @@ -319,3 +319,13 @@ data:
>
>         KVM guests can request the host not to poll on HLT, for example if
>         they are performing polling themselves.
> +
> +MSR_KVM_SEV_LIVE_MIG_EN:
> +        0x4b564d06
> +
> +       Control SEV Live Migration features.
> +
> +data:
> +        Bit 0 enables (1) or disables (0) host-side SEV Live Migration feature.
> +        Bit 1 enables (1) or disables (0) support for SEV Live Migration extensions.
> +        All other bits are reserved.
> diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
> index 2a8e0b6b9805..d9d4953b42ad 100644
> --- a/arch/x86/include/uapi/asm/kvm_para.h
> +++ b/arch/x86/include/uapi/asm/kvm_para.h
> @@ -31,6 +31,7 @@
>  #define KVM_FEATURE_PV_SEND_IPI        11
>  #define KVM_FEATURE_POLL_CONTROL       12
>  #define KVM_FEATURE_PV_SCHED_YIELD     13
> +#define KVM_FEATURE_SEV_LIVE_MIGRATION 14
>
>  #define KVM_HINTS_REALTIME      0
>
> @@ -50,6 +51,7 @@
>  #define MSR_KVM_STEAL_TIME  0x4b564d03
>  #define MSR_KVM_PV_EOI_EN      0x4b564d04
>  #define MSR_KVM_POLL_CONTROL   0x4b564d05
> +#define MSR_KVM_SEV_LIVE_MIG_EN        0x4b564d06
>
>  struct kvm_steal_time {
>         __u64 steal;
> @@ -122,4 +124,7 @@ struct kvm_vcpu_pv_apf_data {
>  #define KVM_PV_EOI_ENABLED KVM_PV_EOI_MASK
>  #define KVM_PV_EOI_DISABLED 0x0
>
> +#define KVM_SEV_LIVE_MIGRATION_ENABLED                 (1 << 0)
> +#define KVM_SEV_LIVE_MIGRATION_EXTENSIONS_SUPPORTED    (1 << 1)
> +
>  #endif /* _UAPI_ASM_X86_KVM_PARA_H */
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index c0d7043a0627..6f69c3a47583 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -1469,6 +1469,17 @@ int svm_page_enc_status_hc(struct kvm *kvm, unsigned long gpa,
>         return 0;
>  }
>
> +void sev_update_migration_flags(struct kvm *kvm, u64 data)
> +{
> +       struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
> +
> +       if (!sev_guest(kvm))
> +               return;
> +
> +       if (data & KVM_SEV_LIVE_MIGRATION_ENABLED)
> +               sev->live_migration_enabled = true;
> +}
> +
>  int svm_get_page_enc_bitmap(struct kvm *kvm,
>                                    struct kvm_page_enc_bitmap *bmap)
>  {
> @@ -1481,6 +1492,9 @@ int svm_get_page_enc_bitmap(struct kvm *kvm,
>         if (!sev_guest(kvm))
>                 return -ENOTTY;
>
> +       if (!sev->live_migration_enabled)
> +               return -EINVAL;
> +
>         gfn_start = bmap->start_gfn;
>         gfn_end = gfn_start + bmap->num_pages;
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 442adbbb0641..a99f5457f244 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -2633,6 +2633,9 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>                 svm->msr_decfg = data;
>                 break;
>         }
> +       case MSR_KVM_SEV_LIVE_MIG_EN:
> +               sev_update_migration_flags(vcpu->kvm, data);
> +               break;
>         case MSR_IA32_APICBASE:
>                 if (kvm_vcpu_apicv_active(vcpu))
>                         avic_update_vapic_bar(to_svm(vcpu), data);
> @@ -3493,6 +3496,19 @@ static void svm_cpuid_update(struct kvm_vcpu *vcpu)
>         svm->nrips_enabled = kvm_cpu_cap_has(X86_FEATURE_NRIPS) &&
>                              guest_cpuid_has(&svm->vcpu, X86_FEATURE_NRIPS);
>
> +        /*
> +         * If SEV guest then enable the Live migration feature.
> +         */
> +        if (sev_guest(vcpu->kvm)) {
> +              struct kvm_cpuid_entry2 *best;
> +
> +              best = kvm_find_cpuid_entry(vcpu, KVM_CPUID_FEATURES, 0);
> +              if (!best)
> +                      return;
> +
> +              best->eax |= (1 << KVM_FEATURE_SEV_LIVE_MIGRATION);
> +        }
> +
>         if (!kvm_vcpu_apicv_active(vcpu))
>                 return;
>
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index fd99e0a5417a..77f132a6fead 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -65,6 +65,7 @@ struct kvm_sev_info {
>         int fd;                 /* SEV device fd */
>         unsigned long pages_locked; /* Number of pages locked */
>         struct list_head regions_list;  /* List of registered regions */
> +       bool live_migration_enabled;
>         unsigned long *page_enc_bmap;
>         unsigned long page_enc_bmap_size;
>  };
> @@ -494,5 +495,6 @@ int svm_unregister_enc_region(struct kvm *kvm,
>  void pre_sev_run(struct vcpu_svm *svm, int cpu);
>  int __init sev_hardware_setup(void);
>  void sev_hardware_teardown(void);
> +void sev_update_migration_flags(struct kvm *kvm, u64 data);
>
>  #endif
> --
> 2.17.1
>

Reviewed-by: Steve Rutherford <srutherford@google.com>
