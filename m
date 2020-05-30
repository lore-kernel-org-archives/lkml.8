Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1EFC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 02:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CBCB20707
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 02:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MbSXwiYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgE3CIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 22:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728715AbgE3CIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 22:08:40 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AA2C08C5C9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 19:08:40 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t8so3832484ilm.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 19:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ftdjrlHvaYC20sQ3K9w73i/hjP0UjC8uFxImsgB2/2M=;
        b=MbSXwiYo4Mwlrx0tkQitGLm050rTRjsN7DTIYMfj0/MboEVg2Hpeiz6tdVH+YbY4Y2
         lfG80Fx1hqDOv4LnXw0mnb3TZ5yXeKtH+T2+OF6GbJcR2BJp92tloXOaet3WJoSnf73o
         xUftZ2YFAYJmcjCmkX4Id1Q4jeYOpXbrPhJfSpqpbF/sbSn8EQrNGOQ8oawT1kGE5rsM
         e0n4AZg+jAIQbGaOEfNIrSTOXwLqYphLn6wE6I/JDErJ3RIkO0mvQx0pZUA87LgZy5CQ
         eQ9TmYwgtSW9KgYVgMVhbF/RmYf1xPeyqDf5B1hz3VV34iia6o8YOjLfOl1EHQTRnTha
         Gl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ftdjrlHvaYC20sQ3K9w73i/hjP0UjC8uFxImsgB2/2M=;
        b=eGOxwbY9896w8wc/seg3YvHJjLIjgszPm3BbqdYFXILELlE0N15Uy1jSD5hIwXmUo2
         +CSyW/iIYCswFjrqp5F0tmt1WMANRBCbvjVJU5AiR+gSwaip5kvAf0gPh3omGTKj/YJx
         WNWSCFr/4Y/WLe21yBViVg56W2qYsZApwKHNxDDN7EdilPFdxwLjwWjYYazmx0pcD7QC
         xZmsIxJBWAZnnvoBUs1wJb/C1+/P2gAGkhu0QcshFXkIdPbfdg7q3CE4M1hoBHCPcs3+
         irjSXJNEY4MQdNbc2BqRiqLR6W3Qpda6O8+6AGNC/qCt+sTgbh21qk/2I+Sdo1CpAbEg
         GvYg==
X-Gm-Message-State: AOAM5302j4PepkoCzj6vq6WEscvJEzEpIv8i6HlOaVqiDH6FJdsAj4sM
        i2YsnvE4LPxHLTIO+fyQXSfyP+s3Hpoz8xz4wAxcYA==
X-Google-Smtp-Source: ABdhPJwrAt4xJo3hDT+wuwe/3per5bNi4NM8c3HEFlDQO4AWFvMckdoJpIdbYR0fozlWHL+KfP7cEbdOvDUOcMwCE/Y=
X-Received: by 2002:a92:914d:: with SMTP id t74mr9813539ild.182.1590804519646;
 Fri, 29 May 2020 19:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588711355.git.ashish.kalra@amd.com> <939af9274e47bb106f49b0154fd4222dd23e7f6d.1588711355.git.ashish.kalra@amd.com>
In-Reply-To: <939af9274e47bb106f49b0154fd4222dd23e7f6d.1588711355.git.ashish.kalra@amd.com>
From:   Steve Rutherford <srutherford@google.com>
Date:   Fri, 29 May 2020 19:08:03 -0700
Message-ID: <CABayD+eSCAAfrcgod3OpEJ9puOdcUPDCCwsk=xmoxpk0yXTDxQ@mail.gmail.com>
Subject: Re: [PATCH v8 15/18] KVM: x86: Add guest support for detecting and
 enabling SEV Live Migration feature.
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

On Tue, May 5, 2020 at 2:20 PM Ashish Kalra <Ashish.Kalra@amd.com> wrote:
>
> From: Ashish Kalra <ashish.kalra@amd.com>
>
> The guest support for detecting and enabling SEV Live migration
> feature uses the following logic :
>
>  - kvm_init_plaform() checks if its booted under the EFI
>
>    - If not EFI,
>
>      i) check for the KVM_FEATURE_CPUID
>
>      ii) if CPUID reports that migration is support then issue wrmsrl
>          to enable the SEV migration support
>
>    - If EFI,
>
>      i) Check the KVM_FEATURE_CPUID.
>
>      ii) If CPUID reports that migration is supported, then reads the UEFI enviroment variable which
>          indicates OVMF support for live migration.
>
>      iii) If variable is set then wrmsr to enable the SEV migration support.
>
> The EFI live migration check is done using a late_initcall() callback.
>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/include/asm/mem_encrypt.h | 11 ++++++
>  arch/x86/kernel/kvm.c              | 62 ++++++++++++++++++++++++++++++
>  arch/x86/mm/mem_encrypt.c          | 11 ++++++
>  3 files changed, 84 insertions(+)
>
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index 848ce43b9040..d10e92ae5ca1 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -20,6 +20,7 @@
>
>  extern u64 sme_me_mask;
>  extern bool sev_enabled;
> +extern bool sev_live_mig_enabled;
>
>  void sme_encrypt_execute(unsigned long encrypted_kernel_vaddr,
>                          unsigned long decrypted_kernel_vaddr,
> @@ -42,6 +43,8 @@ void __init sme_enable(struct boot_params *bp);
>
>  int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size);
>  int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
> +void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages,
> +                                           bool enc);
>
>  /* Architecture __weak replacement functions */
>  void __init mem_encrypt_init(void);
> @@ -55,6 +58,7 @@ bool sev_active(void);
>  #else  /* !CONFIG_AMD_MEM_ENCRYPT */
>
>  #define sme_me_mask    0ULL
> +#define sev_live_mig_enabled   false
>
>  static inline void __init sme_early_encrypt(resource_size_t paddr,
>                                             unsigned long size) { }
> @@ -76,6 +80,8 @@ static inline int __init
>  early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0; }
>  static inline int __init
>  early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
> +static inline void __init
> +early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages, bool enc) {}
>
>  #define __bss_decrypted
>
> @@ -102,6 +108,11 @@ static inline u64 sme_get_me_mask(void)
>         return sme_me_mask;
>  }
>
> +static inline bool sev_live_migration_enabled(void)
> +{
> +       return sev_live_mig_enabled;
> +}
> +
>  #endif /* __ASSEMBLY__ */
>
>  #endif /* __X86_MEM_ENCRYPT_H__ */
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 6efe0410fb72..4b29815de873 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -24,6 +24,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/nmi.h>
>  #include <linux/swait.h>
> +#include <linux/efi.h>
>  #include <asm/timer.h>
>  #include <asm/cpu.h>
>  #include <asm/traps.h>
> @@ -403,6 +404,53 @@ static inline void __set_percpu_decrypted(void *ptr, unsigned long size)
>         early_set_memory_decrypted((unsigned long) ptr, size);
>  }
>
> +#ifdef CONFIG_EFI
> +static bool setup_kvm_sev_migration(void)
> +{
> +       efi_char16_t efi_Sev_Live_Mig_support_name[] = L"SevLiveMigrationEnabled";
> +       efi_guid_t efi_variable_guid = MEM_ENCRYPT_GUID;
> +       efi_status_t status;
> +       unsigned long size;
> +       bool enabled;
> +
> +       if (!sev_live_migration_enabled())
> +               return false;
> +
> +       size = sizeof(enabled);
> +
> +       if (!efi_enabled(EFI_RUNTIME_SERVICES)) {
> +               pr_info("setup_kvm_sev_migration: no efi\n");
> +               return false;
> +       }
> +
> +       /* Get variable contents into buffer */
> +       status = efi.get_variable(efi_Sev_Live_Mig_support_name,
> +                                 &efi_variable_guid, NULL, &size, &enabled);
> +
> +       if (status == EFI_NOT_FOUND) {
> +               pr_info("setup_kvm_sev_migration: variable not found\n");
> +               return false;
> +       }
> +
> +       if (status != EFI_SUCCESS) {
> +               pr_info("setup_kvm_sev_migration: get_variable fail\n");
> +               return false;
> +       }
> +
> +       if (enabled == 0) {
> +               pr_info("setup_kvm_sev_migration: live migration disabled in OVMF\n");
> +               return false;
> +       }
> +
> +       pr_info("setup_kvm_sev_migration: live migration enabled in OVMF\n");
> +       wrmsrl(MSR_KVM_SEV_LIVE_MIG_EN, KVM_SEV_LIVE_MIGRATION_ENABLED);
> +
> +       return true;
> +}
> +
> +late_initcall(setup_kvm_sev_migration);
> +#endif
> +
>  /*
>   * Iterate through all possible CPUs and map the memory region pointed
>   * by apf_reason, steal_time and kvm_apic_eoi as decrypted at once.
> @@ -725,6 +773,20 @@ static void __init kvm_apic_init(void)
>
>  static void __init kvm_init_platform(void)
>  {
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +       if (sev_active() &&
> +           kvm_para_has_feature(KVM_FEATURE_SEV_LIVE_MIGRATION)) {
> +               printk(KERN_INFO "KVM enable live migration\n");
> +               sev_live_mig_enabled = true;
> +               /*
> +                * If not booted using EFI, enable Live migration support.
> +                */
> +               if (!efi_enabled(EFI_BOOT))
> +                       wrmsrl(MSR_KVM_SEV_LIVE_MIG_EN,
> +                              KVM_SEV_LIVE_MIGRATION_ENABLED);
> +       } else
> +               printk(KERN_INFO "KVM enable live migration feature unsupported\n");
> +#endif
>         kvmclock_init();
>         x86_platform.apic_post_init = kvm_apic_init;
>  }
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index c9800fa811f6..f54be71bc75f 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -46,6 +46,8 @@ EXPORT_SYMBOL_GPL(sev_enable_key);
>
>  bool sev_enabled __section(.data);
>
> +bool sev_live_mig_enabled __section(.data);
> +
>  /* Buffer used for early in-place encryption by BSP, no locking needed */
>  static char sme_early_buffer[PAGE_SIZE] __initdata __aligned(PAGE_SIZE);
>
> @@ -204,6 +206,9 @@ static void set_memory_enc_dec_hypercall(unsigned long vaddr, int npages,
>         unsigned long sz = npages << PAGE_SHIFT;
>         unsigned long vaddr_end, vaddr_next;
>
> +       if (!sev_live_migration_enabled())
> +               return;
> +
>         vaddr_end = vaddr + sz;
>
>         for (; vaddr < vaddr_end; vaddr = vaddr_next) {
> @@ -374,6 +379,12 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
>         return early_set_memory_enc_dec(vaddr, size, true);
>  }
>
> +void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages,
> +                                       bool enc)
> +{
> +       set_memory_enc_dec_hypercall(vaddr, npages, enc);
> +}
> +
>  /*
>   * SME and SEV are very similar but they are not the same, so there are
>   * times that the kernel will need to distinguish between SME and SEV. The
> --
> 2.17.1
>


Reviewed-by: Steve Rutherford <srutherford@google.com>
