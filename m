Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDA2C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14ED2072B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lftlN0YN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgANIaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 03:30:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38485 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgANIaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 03:30:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so11216305wrh.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 00:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e3nJMNyQkRtEjdVgCzBtNOhrTK9Iwh6sRszLOAZjqV8=;
        b=lftlN0YN81jg+wU6o3PcZ1f6aB05s504QexQgbl6VotS/qHC/jZwzm+AFVg6KUDmL3
         AyvTSo/9IV0yZm2dYQH+VeZuGJPBaaJYcu+uJMXSFgVl/MCHWBh0Hamsf9/3NqrttRii
         5E885wk++DjZKUtMt0Tj/q4ZsQbhrlzB6wD5g+u73IVROhjOpB1fUmu5K6D5NrCOLkSO
         Jq+Up8kkeYGJArUbcZctgJGp0Cj+PXA86bv80SyOBGaCxxhqhLWKPwcf6d2LQYJbdH8P
         hNlgBLfTysnwDX5UxMwR0wkGZk4VGIDK6hLFPnqc4/zAI7V5zk8DnOIjcrFAwo5E3lXW
         TijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e3nJMNyQkRtEjdVgCzBtNOhrTK9Iwh6sRszLOAZjqV8=;
        b=PwkPzNNPeHXsTNRoEo42EC4omKxlYTXUN7gsuHqxdwpGmsyDec0wDKYNm3qdFwdSNf
         kxPuOQOKNFYN5P5B7gmkWcN7rKX7UHz9StXR2aSsEZqiqzMM9PLmqMsnWsiPvFoqXfeC
         bP8E7YSH1kG6wUmxKlO9olF0tu/T2Sfwc8bg13uACkoNBCfZZ51CfD7tz9wCSPej+zD6
         vGvRbaFYoYpzd0GUMo2ExVwmmZxN0vRYgOH/5VZM+HcnGCHybSmC3xoB5auBVsuJ3YXW
         j7kxpV4FqWCBGJp481uxyAfvpd3gwC6GF3z7ugkIVtSAeIHxFwikGnyf4z7anxB/03zt
         Ys4g==
X-Gm-Message-State: APjAAAWP3Eg7cyFr95gogFetM5AGnkpzBQ24bf7OMAgyLhMfhUdDsJZJ
        tpyUWULK0Udmcx4YloSmF41UpDvUfE1fHykvdIE9RQ==
X-Google-Smtp-Source: APXvYqwyaD8rx5KGxPXA7tMRPkvwrH/FIPWObNwSRAE6tAohM/fc3nWDL/OOZzuG/nAMcBddoz4i8mSstsea6HYgdUs=
X-Received: by 2002:a5d:5345:: with SMTP id t5mr24518975wrv.0.1578990616356;
 Tue, 14 Jan 2020 00:30:16 -0800 (PST)
MIME-Version: 1.0
References: <20200113233023.928028-1-suzuki.poulose@arm.com>
In-Reply-To: <20200113233023.928028-1-suzuki.poulose@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 14 Jan 2020 09:30:05 +0100
Message-ID: <CAKv+Gu96ObCumQmsc_O=7-AkfTghe7KZEjrsaSpWU0jnDFiv4w@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] arm64: Fix support for no FP/SIMD
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 at 00:30, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> This series fixes the support for systems without FP/SIMD unit.
>
> We detect the absence of FP/SIMD after the SMP cpus are brought
> online (i.e, SYSTEM scope). This means, we allow a hotplugged
> CPU to boot successfully even if it doesn't have the FP/SIMD
> when we have decided otherwise at boot and have now advertised
> the ELF HWCAP for the userspace. Fix this by turning this to a
> BOOT_RESTRICTED_CPU_LOCAL feature to allow the detection of the
> feature the very moment a CPU turns up without FP/SIMD and also
> prevent a conflict after SMP boot.
>
> The COMPAT ELF_HWCAPs were statically set to indicate the
> availability of VFP. Make it dynamic to set the appropriate
> bits.
>
> Also, some of the early kernel threads (including init) could run
> with their TIF_FOREIGN_FPSTATE flag set which might be inherited
> by applications forked by them (e.g, modprobe from initramfs).
> Now, if we detect the absence of FP/SIMD we stop clearing the
> TIF flag in fpsimd_restore_current_state(). This could cause
> the applications stuck in do_notify_resume() looping forever
> to clear the flag. Fix this by clearing the TIF flag in
> fpsimd_restore_current_state() for the tasks that may
> have it set.
>
> This series also categorises the functions dealing with fpsimd
> into two :
>
>  - Call permitted with missing FP/SIMD support. But we bail
>    out early in the function. This is for functions exposed
>    to the generic kernel code.
>
>  - Calls not permitted with missing FP/SIMD support. These
>    are functions which deal with the CPU/Task FP/SIMD registers
>    and/or meta-data. The callers must check for the support
>    before invoking them.
>
> See the last patch in the series for details.
>
> Also make sure that the SVE is initialised where supported,
> before the FP/SIMD is used by the kernel.
>
> Tested with debian armel initramfs and rootfs. The arm64 doesn't
> have a soft-float ABI, thus haven't tested it with 64bit userspace.
>
> Applies on linux-aarch64 for-next/core
>
> Changes since v2:
>  - Rebase on to for-next/core, resolved conflict with the E0PD
>    handling changes
>  - Address comments from Catalin
>      - Remove warnings from static functions
>      - Add WARN_ON in may_use_simd() if called before initializing
>        capabilities.
>  - Add "active" hook for FP regset
>  - Remove dangerous WARN_ON from KVM, replaced with an additional
>    check to make sure that the FP/SIMD is always trapped.
>  - Added tags from Catalin, Marc
>
> Suzuki K Poulose (7):
>   arm64: Introduce system_capabilities_finalized() marker
>   arm64: fpsimd: Make sure SVE setup is complete before SIMD is used
>   arm64: cpufeature: Fix the type of no FP/SIMD capability
>   arm64: cpufeature: Set the FP/SIMD compat HWCAP bits properly
>   arm64: ptrace: nofpsimd: Fail FP/SIMD regset operations
>   arm64: signal: nofpsimd: Handle fp/simd context for signal frames
>   arm64: nofpsmid: Handle TIF_FOREIGN_FPSTATE flag cleanly
>

For the series,

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>


>  arch/arm64/include/asm/cpufeature.h |  5 +++
>  arch/arm64/include/asm/kvm_host.h   |  2 +-
>  arch/arm64/include/asm/simd.h       |  8 +++-
>  arch/arm64/kernel/cpufeature.c      | 67 +++++++++++++++++++----------
>  arch/arm64/kernel/fpsimd.c          | 30 +++++++++++--
>  arch/arm64/kernel/process.c         |  2 +-
>  arch/arm64/kernel/ptrace.c          | 21 +++++++++
>  arch/arm64/kernel/signal.c          |  6 ++-
>  arch/arm64/kernel/signal32.c        |  4 +-
>  arch/arm64/kvm/hyp/switch.c         | 10 ++++-
>  10 files changed, 121 insertions(+), 34 deletions(-)
>
> --
> 2.24.1
>
