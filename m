Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C140BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938D9208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="gcEdN6MO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgCaSfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:35:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38284 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgCaSft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:35:49 -0400
Received: by mail-pl1-f193.google.com with SMTP id w3so8439937plz.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 11:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=gpozJM30UMUeBqF42G+Q1xZ6EH+m2FBOCfWDSz6ubV4=;
        b=gcEdN6MO2lrllAbjavG13EpK8TvOW6tpaKB24cx7orULwToRmZSMqxjy396tUOGQ+h
         10LrpuwyCCYZEOs8QUkS7TQ0K/AgvOkY96cwBPhTFLnw4pCoti5cU/riIGnePE5V19Uw
         sFE2z7IkmuCFqWG7vFUxB8o1I+VLgBDB0v2aCl9eo0hVSmFXJGapdRqlE161s10+SovV
         ry6iDXy1IvZSHlz+esIkAbIJuWGCpaEAerT0ocQ6td+o5fLP0jtKuvO6G7jiA3t15eHw
         8TRO0rWuzc3v3+dbrn/HWpVDl50/e7LPooiMRGQMNZDumOhrKWf7/3E9vEgK/C7ZlEf8
         AiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=gpozJM30UMUeBqF42G+Q1xZ6EH+m2FBOCfWDSz6ubV4=;
        b=GpAaxDCZ8JzeEfOpi5dWToeDS64WEBV+ZPTyREmxXfr5ICdhqQr7To61HqYA3xHNy2
         k33bAEUFully1bxGxIT6v6NliiY/Q6UhnCggrfiV9iP4PauxlS054xFwCVSJXoWIpIrl
         saEHQLAyVhJps3poLMtjn7qEd7isPxFvryTGrneXjcDxKbkdWSda1wEjOmgVwZPtIxzv
         PEfhgWwhzd7tihJ6m/lsOuF/Fxhlbs2ZfdgVkWzdQbwU6G9qd/suq9+cUGwdyE/Z9LUF
         ZfaVV8YD0W05FOyBX+buSiZ0RECJNQeXU9d16fS3isFY5li+Z0khV1CojoC2uck38QTH
         8NZg==
X-Gm-Message-State: AGi0Pub+85PRBP2mbWa+HTzktM6rpdyNYTip5iaH9mAgpKrqm70LDlaf
        MitMcCMRmM4Cxftl6Mrm7SztFdJEI2g=
X-Google-Smtp-Source: APiQypIoJKj9iSSWlAXJsCa4ODsoSGuSWZLzYZP/8m+Ca7gtEKTwNwqB5O9lzdvIuClsylswo/3BrQ==
X-Received: by 2002:a17:902:9f95:: with SMTP id g21mr5310159plq.66.1585679747715;
        Tue, 31 Mar 2020 11:35:47 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
        by smtp.gmail.com with ESMTPSA id i2sm12765883pfr.203.2020.03.31.11.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 11:35:47 -0700 (PDT)
Date:   Tue, 31 Mar 2020 11:35:47 -0700 (PDT)
X-Google-Original-Date: Tue, 31 Mar 2020 11:34:57 PDT (-0700)
Subject:     Re: [PATCH v11 00/11] Add support for SBI v0.2 and CPU hotplug
In-Reply-To: <20200318011144.91532-1-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, anup@brainfault.org, gary@garyguo.net,
        greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        han_mao@c-sky.com, rppt@linux.ibm.com, nickhu@andestech.com,
        Paul Walmsley <paul.walmsley@sifive.com>, tglx@linutronix.de,
        vincent.chen@sifive.com, zong.li@sifive.com, bmeng.cn@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-c3553b26-6593-4b77-9531-b8be7668adee@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Mar 2020 18:11:33 PDT (-0700), Atish Patra wrote:
> The Supervisor Binary Interface(SBI) specification[1] now defines a
> base extension that provides extendability to add future extensions
> while maintaining backward compatibility with previous versions.
> The new version is defined as 0.2 and older version is marked as 0.1.

While 0.2 isn't official, I don't think we got any comments on 0.2-rc1 so let's
just go ahead and release it.  I'm hoping to send my PR at the end of the week,
I'll be sure to tag 0.2 before then -- things are still a bit of a mess here
due to the internet issues, but I've got a bunch of networking gear coming this
week so hopefully it'll get better...

Thanks for this!

>
> This series adds following features to RISC-V Linux.
> 1. Adds support for SBI v0.2
> 2. A Unified calling convention implementation between 0.1 and 0.2.
> 3. SBI Hart state management extension (HSM)
> 4. Ordered booting of harts
> 4. CPU hotplug
>
> Dependencies:
> The support for SBI v0.2 and HSM extension is already available in OpenSBI
> master.
>
> [1] https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc
>
> The patches are also available in following github repositery.
>
> Linux Kernel: https://github.com/atishp04/linux/tree/sbi_v0.2_v11
>
> Patches 1-5 implements the SBI v0.2 and unified calling convention.
> Patches 6-7 adds a cpu_ops method that allows different booting protocols
> dynamically.
> Patches 9-10 adds HSM extension and ordered hart booting support.
> Patche  11 adds cpu hotplug support.
>
> Changes v10->v11:
> 1. Addressed few nitpick comments.
> 2. Dropped plic patch as it is taken through IRQ tree.
>
> Changes from v9->10:
> 1. Minor copyright fixes.
> 2. Renaming of HSM extension definitions to match the spec.
>
> Changes from v8->v9:
> 1. Added a sliding window hart base method to support larger hart masks.
> 2. Added a callback to disable interrupts when cpu go offline.
> 3. Made the HSM extension series more modular.
>
> Changes from v7-v8:
> 1. Refactored to code to have modular cpu_ops calls.
> 2. Refactored HSM extension from sbi.c to cpu_ops_sbi.c.
> 3. Fix plic driver to handle cpu hotplug.
>
> Changes from v6-v7:
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
> RISC-V: Export SBI error to linux error mapping function
> RISC-V: Add SBI HSM extension definitions
> RISC-V: Add supported for ordered booting method using HSM
> RISC-V: Support cpu hotplug
>
> arch/riscv/Kconfig                   |  19 +-
> arch/riscv/include/asm/cpu_ops.h     |  46 +++
> arch/riscv/include/asm/sbi.h         | 195 +++++----
> arch/riscv/include/asm/smp.h         |  24 ++
> arch/riscv/kernel/Makefile           |   6 +
> arch/riscv/kernel/cpu-hotplug.c      |  87 ++++
> arch/riscv/kernel/cpu_ops.c          |  46 +++
> arch/riscv/kernel/cpu_ops_sbi.c      | 115 ++++++
> arch/riscv/kernel/cpu_ops_spinwait.c |  43 ++
> arch/riscv/kernel/head.S             | 179 +++++----
> arch/riscv/kernel/sbi.c              | 575 ++++++++++++++++++++++++++-
> arch/riscv/kernel/setup.c            |  24 +-
> arch/riscv/kernel/smpboot.c          |  53 ++-
> arch/riscv/kernel/traps.c            |   2 +-
> arch/riscv/kernel/vmlinux.lds.S      |   5 +-
> 15 files changed, 1249 insertions(+), 170 deletions(-)
> create mode 100644 arch/riscv/include/asm/cpu_ops.h
> create mode 100644 arch/riscv/kernel/cpu-hotplug.c
> create mode 100644 arch/riscv/kernel/cpu_ops.c
> create mode 100644 arch/riscv/kernel/cpu_ops_sbi.c
> create mode 100644 arch/riscv/kernel/cpu_ops_spinwait.c
