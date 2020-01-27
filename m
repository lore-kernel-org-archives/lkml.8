Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BADC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 16:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2399224676
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 16:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgA0Qre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 11:47:34 -0500
Received: from foss.arm.com ([217.140.110.172]:46968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgA0Qre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 11:47:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A9A331B;
        Mon, 27 Jan 2020 08:47:33 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3545F3F67D;
        Mon, 27 Jan 2020 08:47:31 -0800 (PST)
Subject: Re: [PATCH v2 4/6] Documentation: arm64: document support for the AMU
 extension
To:     Ionela Voinescu <ionela.voinescu@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        suzuki.poulose@arm.com, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, ggherdovich@suse.cz,
        vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
References: <20191218182607.21607-1-ionela.voinescu@arm.com>
 <20191218182607.21607-5-ionela.voinescu@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <b63b6f10-22c8-79be-cc97-08484874bd62@arm.com>
Date:   Mon, 27 Jan 2020 16:47:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191218182607.21607-5-ionela.voinescu@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/2019 18:26, Ionela Voinescu wrote:
> +Basic support
> +-------------
> +
> +The kernel can safely run a mix of CPUs with and without support for the
> +activity monitors extension. Therefore, when CONFIG_ARM64_AMU_EXTN is
> +selected we unconditionally enable the capability to allow any late CPU
> +(secondary or hotplugged) to detect and use the feature.
> +
> +When the feature is detected on a CPU, a per-CPU variable (amu_feat) is
> +set, but this does not guarantee the correct functionality of the
> +counters, only the presence of the extension.
> +
> +Firmware (code running at higher exception levels, e.g. arm-tf) support is
> +needed to:
> + - Enable access for lower exception levels (EL2 and EL1) to the AMU
> +   registers.
> + - Enable the counters. If not enabled these will read as 0.

Just to make sure I understand - if AMUs are physically present but not
enabled by FW, we'll still
- see them as implemented in ID_AA64PFR0_EL1.AMU
- see some counters as available with e.g. AMCGCR_ELO.CG0NC > 0

But reading some AMEVCNTR<g><n> will return 0?

> + - Save/restore the counters before/after the CPU is being put/brought up
> +   from the 'off' power state.
> +
> +When using kernels that have this configuration enabled but boot with
> +broken firmware the user may experience panics or lockups when accessing
> +the counter registers.

Yikes

> Even if these symptoms are not observed, the
> +values returned by the register reads might not correctly reflect reality.
> +Most commonly, the counters will read as 0, indicating that they are not
> +enabled. If proper support is not provided in firmware it's best to disable
> +CONFIG_ARM64_AMU_EXTN.
> +

I haven't seen something that would try to catch this on the kernel side.
Can we try to detect that (e.g. at least one counter returns > 0) in
cpu_amu_enable() and thus not write to the CPU-local 'amu_feat'?

While we're on the topic of detecting broken stuff, what if some CPUs
implement some auxiliary counters that some others don't?

> +The fixed counters of AMUv1 are accessible though the following system
> +register definitions:
> + - SYS_AMEVCNTR0_CORE_EL0
> + - SYS_AMEVCNTR0_CONST_EL0
> + - SYS_AMEVCNTR0_INST_RET_EL0
> + - SYS_AMEVCNTR0_MEM_STALL_EL0
> +
> +Auxiliary platform specific counters can be accessed using
> +SYS_AMEVCNTR1_EL0(n), where n is a value between 0 and 15.
> +
> +Details can be found in: arch/arm64/include/asm/sysreg.h.
> +
> diff --git a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
> index 5d78a6f5b0ae..a3f1a47b6f1c 100644
> --- a/Documentation/arm64/booting.rst
> +++ b/Documentation/arm64/booting.rst
> @@ -248,6 +248,20 @@ Before jumping into the kernel, the following conditions must be met:
>      - HCR_EL2.APK (bit 40) must be initialised to 0b1
>      - HCR_EL2.API (bit 41) must be initialised to 0b1
>  
> +  For CPUs with Activity Monitors Unit v1 (AMUv1) extension present:
> +  - If EL3 is present:
> +    CPTR_EL3.TAM (bit 30) must be initialised to 0b0
> +    CPTR_EL2.TAM (bit 30) must be initialised to 0b0
> +    AMCNTENSET0_EL0 must be initialised to 0b1111

Nit: Or be a superset of the above, right? AIUI v1 only mandates the lower
4 bits to be set. Probably doesn't matter that much...

