Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EF0C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BFA24654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="n11qcP5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgBSVsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:48:55 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55020 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgBSVsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:48:54 -0500
Received: by mail-pj1-f68.google.com with SMTP id dw13so638215pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 13:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=AOhz8QcqBZYxBnkS4JC5UcwkKNrAjj9kGy5U7owfufY=;
        b=n11qcP5owjGZESxSC7UwPHy//Xzxsh2otTflrr2ChRBc5fMm4EuzDlNVh+tLX9BB6Y
         DTk4GmTkRAgUIvdx1XqgsBQUE9qLhDazNfa4KwCMFio35tgOkCnZkCzeM+K1ZM0COD7u
         7BVihgh+2NKL4AHTM5h3q/Kry35aagnUVWwxaIM+oZJ6aSuozV25V5haGhuiL/t1pc1h
         HM4rANQdezyieemXeda/f0olhBFumhVXKZPBMtlNEL3wMyamz5hi4lHhKg0mfsMaDyCh
         W/GSg5iWr49GLBeAUcHpwRXje9qcdJ5dDj99QpQouv3bXSBMKxAl9h4wUpDVvLsX0kxK
         h3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=AOhz8QcqBZYxBnkS4JC5UcwkKNrAjj9kGy5U7owfufY=;
        b=KQhhOV932ys5TqAymmSIPfW8pCgUTmDFZo0ODJwNrrzIENaomM32gFt8pppooIh62L
         gyrwn8Xk077tDImscNLqqMiV+kiIa/GIqm/pPbg947BapfY+12+IleQQqNLxHhALZBaW
         27J0+/Q8MCZR3b7t7vrFl4QkZU+YwOa6irq3W+6weF+B2OM+/a7z6TzukXEd6w/bn1Nc
         Lq+D4M38I5uzhRFlP6xmxVZdP3irvMRz0nSU1SlPHAdZI43rt+TAfknM+TUUwTjO5+9+
         sRTV5SHIzTrdYS79n4uWTqvsEC28NZpuBOcSNjTEcMcaCK/aKxERp84ttR4vLdqC7/3J
         saYg==
X-Gm-Message-State: APjAAAUC1y66M8L7NjsWMjznQEuvReCSynTOQkRpliHgGuPPWwTj565D
        YUf/Wcs/eWWS5IBsHl4lo7RDDDfoiJnwXA==
X-Google-Smtp-Source: APXvYqxFfOEzNRyuV/Q4LmhnFCMD3M9WLLxpC7krlSRJJZbFtm9glhWNwGG2gL/QbWxd8y3+x+oFVg==
X-Received: by 2002:a17:90a:bd01:: with SMTP id y1mr11070977pjr.129.1582148931986;
        Wed, 19 Feb 2020 13:48:51 -0800 (PST)
Received: from localhost ([2620:15c:2d1:206:90e1:f7be:ea84:7f6a])
        by smtp.gmail.com with ESMTPSA id y18sm608890pfe.19.2020.02.19.13.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 13:48:51 -0800 (PST)
Date:   Wed, 19 Feb 2020 13:48:51 -0800 (PST)
X-Google-Original-Date: Wed, 19 Feb 2020 13:48:47 PST (-0800)
Subject:     Re: [PATCH v8 00/11] Add support for SBI v0.2 and CPU hotplug
In-Reply-To: <20200212014822.28684-1-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, allison@lohutok.net, anup@brainfault.org,
        bp@suse.de, daniel.lezcano@linaro.org, ebiederm@xmission.com,
        geert@linux-m68k.org, heiko.carstens@de.ibm.com,
        jason@lakedaemon.net, keescook@chromium.org,
        linux-riscv@lists.infradead.org, han_mao@c-sky.com,
        Mark Zyngier <maz@kernel.org>, m.szyprowski@samsung.com,
        mpe@ellerman.id.au, rppt@linux.ibm.com,
        Paul Walmsley <paul.walmsley@sifive.com>, tglx@linutronix.de,
        vincent.chen@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-4031b042-7e16-4ff2-91a7-10747042e983@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2020 17:48:11 PST (-0800), Atish Patra wrote:
> The Supervisor Binary Interface(SBI) specification[1] now defines a
> base extension that provides extendability to add future extensions
> while maintaining backward compatibility with previous versions.
> The new version is defined as 0.2 and older version is marked as 0.1.
>
> This series adds support v0.2 and a unified calling convention
> implementation between 0.1 and 0.2. It also add other SBI v0.2
> functionality defined in [2]. The base support for SBI v0.2 is already
> available in OpenSBI v0.5. It also adds SBI HSM extension and cpu-hotplug
> support for RISC-V which requires additional patches[3] in OpenSBI.

Now that 0.2-rc1 has been tagged we should really start to get this into shape
to merge this.  My biggest worry is being able to put together a kernel that
can boot on both 0.1 and 0.2 SBIs, with the hart lottery being my major worry
there.  I just skimmed this, but I was expected to see something like 

    diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
    index 271860fc2c3f..849ba75959ba 100644
    --- a/arch/riscv/kernel/head.S
    +++ b/arch/riscv/kernel/head.S
    @@ -187,6 +187,7 @@ relocate:
     	la a3, .Lsecondary_park
     	csrw CSR_TVEC, a3
     
    +#ifdef CONFIG_SBI_V01
     	slli a3, a0, LGREG
     	la a1, __cpu_up_stack_pointer
     	la a2, __cpu_up_task_pointer
    @@ -212,7 +213,10 @@ relocate:
     #endif
     
     	tail smp_callin
    -#endif
    +#else /* !CONFIG_SBI_V01 */
    +	pr_warn("multiple harts booted an SBI v0.2+ only kernel");
    +#endif /* CONFIG_SBI_V01 */
    +#endif /* CONFIG_SMP */
     
     END(_start)
 
but I don't.  Is there something else doing this?

> [1] https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc
> [2] https://github.com/riscv/riscv-sbi-doc/pull/27
> [3] http://lists.infradead.org/pipermail/opensbi/2020-January/001050.html
>
> The patches are also available in following github repositery.
>
> OpenSBI     : https://github.com/atishp04/opensbi/tree/sbi_hsm_v1
> Linux Kernel: https://github.com/atishp04/linux/tree/sbi_v0.2_v8
>
> Changes from v7->v8:
> 1. Refactored to code to have modular cpu_ops calls.
> 2. Refactored HSM extension from sbi.c to cpu_ops_sbi.c.
> 3. Fix plic driver to handle cpu hotplug.
>
> Changes from v6->v7:
> 1. Rebased on v5.5
> 2. Fixed few compilation issues for !CONFIG_SMP and !CONFIG_RISCV_SBI
> 3. Added SBI HSM extension
> 4. Add CPU hotplug support
>
> Changes from v5->v6
> 1. Fixed few compilation issues around config.
> 2. Fixed hart mask generation issues for RFENCE & IPI extensions.
>
> Changes from v4->v5
> 1. Fixed few minor comments related to static & inline.
> 2. Make sure that every patch is boot tested individually.
>
> Changes from v3->v4.
> 1. Rebased on for-next.
> 2. Fixed issuses with checkpatch --strict.
> 3. Unfied all IPI/fence related functions.
> 4. Added Hfence related SBI calls.
>
> Changes from v2->v3.
> 1. Moved v0.1 extensions to a new config.
> 2. Added support for relacement extensions of v0.1 extensions.
>
> Changes from v1->v2
> 1. Removed the legacy calling convention.
> 2. Moved all SBI related calls to sbi.c.
> 3. Moved all SBI related macros to uapi.
>
> Atish Patra (11):
> RISC-V: Mark existing SBI as 0.1 SBI.
> RISC-V: Add basic support for SBI v0.2
> RISC-V: Add SBI v0.2 extension definitions
> RISC-V: Introduce a new config for SBI v0.1
> RISC-V: Implement new SBI v0.2 extensions
> RISC-V: Move relocate and few other functions out of __init
> RISC-V: Add cpu_ops and modify default booting method
> RISC-V: Add SBI HSM extension
> RISC-V: Add supported for ordered booting method using HSM
> irqchip/sifive-plic: Initialize the plic handler when cpu comes online
> RISC-V: Support cpu hotplug
>
> arch/riscv/Kconfig                   |  19 +-
> arch/riscv/include/asm/cpu_ops.h     |  46 +++
> arch/riscv/include/asm/sbi.h         | 194 ++++++----
> arch/riscv/include/asm/smp.h         |  24 ++
> arch/riscv/kernel/Makefile           |   6 +
> arch/riscv/kernel/cpu-hotplug.c      |  87 +++++
> arch/riscv/kernel/cpu_ops.c          |  48 +++
> arch/riscv/kernel/cpu_ops_sbi.c      | 113 ++++++
> arch/riscv/kernel/cpu_ops_spinwait.c |  42 +++
> arch/riscv/kernel/head.S             | 179 +++++----
> arch/riscv/kernel/sbi.c              | 524 ++++++++++++++++++++++++++-
> arch/riscv/kernel/setup.c            |  24 +-
> arch/riscv/kernel/smpboot.c          |  56 +--
> arch/riscv/kernel/traps.c            |   2 +-
> arch/riscv/kernel/vmlinux.lds.S      |   5 +-
> drivers/irqchip/irq-sifive-plic.c    |  34 +-
> include/linux/cpuhotplug.h           |   1 +
> 17 files changed, 1227 insertions(+), 177 deletions(-)
> create mode 100644 arch/riscv/include/asm/cpu_ops.h
> create mode 100644 arch/riscv/kernel/cpu-hotplug.c
> create mode 100644 arch/riscv/kernel/cpu_ops.c
> create mode 100644 arch/riscv/kernel/cpu_ops_sbi.c
> create mode 100644 arch/riscv/kernel/cpu_ops_spinwait.c
