Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A370C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A8E82080D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592498085;
	bh=eVyEMYcH3w0tu/t9tmx43Zd823558bcJbUdQrBCBp4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dqQr3MHiMP7PBSckvyZY2GzXJLidVISVH0kSNonAYlkTWLLHBnFrJ61mGy6+iQOWf
	 yU4qCz/RVaAND9GTUehfL/9Vit+ztYdKScwtr4hJbku0QpBK1FExYN4ZFVxgtxFUco
	 4fM8Jlozudw6Vj0/ibXwU71+Ee3OiF1VQG/mi9Z0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgFRQen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:34:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbgFRQem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 12:34:42 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3A5F2080D;
        Thu, 18 Jun 2020 16:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592498082;
        bh=eVyEMYcH3w0tu/t9tmx43Zd823558bcJbUdQrBCBp4c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HvgtGquIIepvj2gQkKFmCpbCeAgAeeIo7rCFhFWj26c+6IajL8BvAWaMt/UCkLjBj
         Vtdzg6b/vnsNPFtyukEyPsuxiiDQ5nOPcGjyj1C4NTiv/RWhz9FGbzBk2HXK3F60XQ
         aftQCISswXvKXTI+OuS8zmbSzVxSrPM211c2bCl0=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jlxUu-004EIo-A4; Thu, 18 Jun 2020 17:34:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 18 Jun 2020 17:34:40 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, android-kvm@google.com,
        kernel-team@android.com
Subject: Re: [PATCH v3 03/15] arm64: kvm: Add build rules for separate nVHE
 object files
In-Reply-To: <20200618122537.9625-4-dbrazdil@google.com>
References: <20200618122537.9625-1-dbrazdil@google.com>
 <20200618122537.9625-4-dbrazdil@google.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <09976ea31931481f4e00d627dc5e06fe@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, will@kernel.org, catalin.marinas@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 2020-06-18 13:25, David Brazdil wrote:
> Add new folder arch/arm64/kvm/hyp/nvhe and a Makefile for building code 
> that
> runs in EL2 under nVHE KVM.
> 
> Compile each source file into a `.hyp.tmp.o` object first, then prefix 
> all
> its symbols with "__kvm_nvhe_" using `objcopy` and produce a `.hyp.o`.
> Suffixes were chosen so that it would be possible for VHE and nVHE to 
> share
> some source files, but compiled with different CFLAGS. nVHE build rules 
> add
> -D__KVM_NVHE_HYPERVISOR__.
> 
> The nVHE ELF symbol prefix is added to kallsyms.c as ignored. EL2-only 
> symbols
> will never appear in EL1 stack traces.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/kernel/image-vars.h   | 12 +++++++++++
>  arch/arm64/kvm/hyp/Makefile      |  2 +-
>  arch/arm64/kvm/hyp/nvhe/Makefile | 35 ++++++++++++++++++++++++++++++++
>  scripts/kallsyms.c               |  1 +
>  4 files changed, 49 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/kvm/hyp/nvhe/Makefile
> 
> diff --git a/arch/arm64/kernel/image-vars.h 
> b/arch/arm64/kernel/image-vars.h
> index be0a63ffed23..f32b406e90c0 100644
> --- a/arch/arm64/kernel/image-vars.h
> +++ b/arch/arm64/kernel/image-vars.h
> @@ -51,4 +51,16 @@ __efistub__ctype		= _ctype;
> 
>  #endif
> 
> +#ifdef CONFIG_KVM
> +
> +/*
> + * KVM nVHE code has its own symbol namespace prefixed by __kvm_nvhe_, 
> to
> + * isolate it from the kernel proper. The following symbols are 
> legally
> + * accessed by it, therefore provide aliases to make them linkable.
> + * Do not include symbols which may not be safely accessed under 
> hypervisor
> + * memory mappings.
> + */
> +
> +#endif /* CONFIG_KVM */
> +
>  #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
> diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
> index 5d8357ddc234..5f4f217532e0 100644
> --- a/arch/arm64/kvm/hyp/Makefile
> +++ b/arch/arm64/kvm/hyp/Makefile
> @@ -6,7 +6,7 @@
>  ccflags-y += -fno-stack-protector -DDISABLE_BRANCH_PROFILING \
>  		$(DISABLE_STACKLEAK_PLUGIN)
> 
> -obj-$(CONFIG_KVM) += hyp.o
> +obj-$(CONFIG_KVM) += hyp.o nvhe/
>  obj-$(CONFIG_KVM_INDIRECT_VECTORS) += smccc_wa.o
> 
>  hyp-y := vgic-v3-sr.o timer-sr.o aarch32.o vgic-v2-cpuif-proxy.o 
> sysreg-sr.o \
> diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile 
> b/arch/arm64/kvm/hyp/nvhe/Makefile
> new file mode 100644
> index 000000000000..7d64235dba62
> --- /dev/null
> +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for Kernel-based Virtual Machine module, HYP/nVHE part
> +#
> +
> +asflags-y := -D__KVM_NVHE_HYPERVISOR__
> +ccflags-y := -D__KVM_NVHE_HYPERVISOR__ -fno-stack-protector \
> +	     -DDISABLE_BRANCH_PROFILING $(DISABLE_STACKLEAK_PLUGIN)
> +
> +obj-y :=
> +
> +obj-y := $(patsubst %.o,%.hyp.o,$(obj-y))
> +extra-y := $(patsubst %.hyp.o,%.hyp.tmp.o,$(obj-y))
> +
> +$(obj)/%.hyp.tmp.o: $(src)/%.c FORCE
> +	$(call if_changed_rule,cc_o_c)
> +$(obj)/%.hyp.tmp.o: $(src)/%.S FORCE
> +	$(call if_changed_rule,as_o_S)
> +$(obj)/%.hyp.o: $(obj)/%.hyp.tmp.o FORCE
> +	$(call if_changed,hypcopy)
> +
> +quiet_cmd_hypcopy = HYPCOPY $@
> +      cmd_hypcopy = $(OBJCOPY) --prefix-symbols=__kvm_nvhe_ $< $@
> +
> +# KVM nVHE code is run at a different exception code with a different 
> map, so
> +# compiler instrumentation that inserts callbacks or checks into the 
> code may
> +# cause crashes. Just disable it.
> +GCOV_PROFILE	:= n
> +KASAN_SANITIZE	:= n
> +UBSAN_SANITIZE	:= n
> +KCOV_INSTRUMENT	:= n
> +
> +# Skip objtool checking for this directory because nVHE code is 
> compiled with
> +# non-standard build rules.
> +OBJECT_FILES_NON_STANDARD := y
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 6dc3078649fa..0096cd965332 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -109,6 +109,7 @@ static bool is_ignored_symbol(const char *name, 
> char type)
>  		".LASANPC",		/* s390 kasan local symbols */
>  		"__crc_",		/* modversions */
>  		"__efistub_",		/* arm64 EFI stub namespace */
> +		"__kvm_nvhe_",		/* arm64 non-VHE KVM namespace */
>  		NULL
>  	};

I guess that one of the first use of this __KVM_NVHE_HYPERVISOR__
flag could be the has_vhe() predicate: if you're running the nVHE
code, you are *guaranteed* not to use VHE at all.

Something like:

diff --git a/arch/arm64/include/asm/virt.h 
b/arch/arm64/include/asm/virt.h
index 5051b388c654..b2cb8fce43dd 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -85,10 +85,8 @@ static inline bool is_kernel_in_hyp_mode(void)

  static __always_inline bool has_vhe(void)
  {
-	if (cpus_have_final_cap(ARM64_HAS_VIRT_HOST_EXTN))
-		return true;
-
-	return false;
+	return (__is_defined(__KVM_NVHE_HYPERVISOR__) &&
+		cpus_have_final_cap(ARM64_HAS_VIRT_HOST_EXTN));
  }

  #endif /* __ASSEMBLY__ */

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
