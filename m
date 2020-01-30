Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EBCC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9431F2051A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgA3PEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:04:31 -0500
Received: from foss.arm.com ([217.140.110.172]:54128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbgA3PEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 10:04:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA19731B;
        Thu, 30 Jan 2020 07:04:29 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C43C3F68E;
        Thu, 30 Jan 2020 07:04:28 -0800 (PST)
Subject: Re: [PATCH v2 4/6] Documentation: arm64: document support for the AMU
 extension
To:     Ionela Voinescu <ionela.voinescu@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        sudeep.holla@arm.com, dietmar.eggemann@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, ggherdovich@suse.cz,
        vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
References: <20191218182607.21607-1-ionela.voinescu@arm.com>
 <20191218182607.21607-5-ionela.voinescu@arm.com>
From:   Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Message-ID: <c9f80a08-7f0d-59e9-eb90-466b1314e1f1@arm.com>
Date:   Thu, 30 Jan 2020 15:04:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191218182607.21607-5-ionela.voinescu@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ionela,

On 18/12/2019 18:26, Ionela Voinescu wrote:
> The activity monitors extension is an optional extension introduced
> by the ARMv8.4 CPU architecture.
> 
> Add initial documentation for the AMUv1 extension:
>   - arm64/amu.txt: AMUv1 documentation
>   - arm64/booting.txt: system registers initialisation
>   - arm64/cpu-feature-registers.txt: visibility to userspace

We have stopped adding "invisible" fields to the list. So, you
can drop the changes to cpu-feature-registers.txt.

> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---
>   Documentation/arm64/amu.rst                   | 107 ++++++++++++++++++
>   Documentation/arm64/booting.rst               |  14 +++
>   Documentation/arm64/cpu-feature-registers.rst |   2 +
>   Documentation/arm64/index.rst                 |   1 +
>   4 files changed, 124 insertions(+)
>   create mode 100644 Documentation/arm64/amu.rst
> 
> diff --git a/Documentation/arm64/amu.rst b/Documentation/arm64/amu.rst
> new file mode 100644
> index 000000000000..62a6635522e1
> --- /dev/null
> +++ b/Documentation/arm64/amu.rst
> @@ -0,0 +1,107 @@
> +=======================================================
> +Activity Monitors Unit (AMU) extension in AArch64 Linux
> +=======================================================
> +
> +Author: Ionela Voinescu <ionela.voinescu@arm.com>
> +
> +Date: 2019-09-10
> +
> +This document briefly describes the provision of Activity Monitors Unit
> +support in AArch64 Linux.
> +
> +
> +Architecture overview
> +---------------------
> +
> +The activity monitors extension is an optional extension introduced by the
> +ARMv8.4 CPU architecture.
> +
> +The activity monitors unit, implemented in each CPU, provides performance
> +counters intended for system management use. The AMU extension provides a
> +system register interface to the counter registers and also supports an
> +optional external memory-mapped interface.
> +
> +Version 1 of the Activity Monitors architecture implements a counter group
> +of four fixed and architecturally defined 64-bit event counters.
> +  - CPU cycle counter: increments at the frequency of the CPU.
> +  - Constant counter: increments at the fixed frequency of the system
> +    clock.
> +  - Instructions retired: increments with every architecturally executed
> +    instruction.
> +  - Memory stall cycles: counts instruction dispatch stall cycles caused by
> +    misses in the last level cache within the clock domain.
> +
> +When in WFI or WFE these counters do not increment.
> +
> +The Activity Monitors architecture provides space for up to 16 architected
> +event counters. Future versions of the architecture may use this space to
> +implement additional architected event counters.
> +
> +Additionally, version 1 implements a counter group of up to 16 auxiliary
> +64-bit event counters.
> +
> +On cold reset all counters reset to 0.
> +
> +
> +Basic support
> +-------------
> +
> +The kernel can safely run a mix of CPUs with and without support for the
> +activity monitors extension.


  Therefore, when CONFIG_ARM64_AMU_EXTN is
> +selected we unconditionally enable the capability to allow any late CPU
> +(secondary or hotplugged) to detect and use the feature.
> +
> +When the feature is detected on a CPU, a per-CPU variable (amu_feat) is
> +set, but this does not guarantee the correct functionality of the
> +counters, only the presence of the extension.

nit: I would rather omit the implementation details (esp variable names)
in the documentation. It may become a pain to keep this in sync with the
code changes. You could simply mention, "we keep track of the 
availability of the feature" per CPU. If someone wants to figure out
how, they can always read the code.

> +
> +Firmware (code running at higher exception levels, e.g. arm-tf) support is
> +needed to:
> + - Enable access for lower exception levels (EL2 and EL1) to the AMU
> +   registers.
> + - Enable the counters. If not enabled these will read as 0.
> + - Save/restore the counters before/after the CPU is being put/brought up
> +   from the 'off' power state.
> +
> +When using kernels that have this configuration enabled but boot with
> +broken firmware the user may experience panics or lockups when accessing
> +the counter registers. Even if these symptoms are not observed, the
> +values returned by the register reads might not correctly reflect reality.
> +Most commonly, the counters will read as 0, indicating that they are not
> +enabled. If proper support is not provided in firmware it's best to disable
> +CONFIG_ARM64_AMU_EXTN.

For the sake of one kernel runs everywhere, do we need some other
mechanism to disable the AMU. e.g kernel parameter to disable amu
at runtime ?

> diff --git a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
> index 5d78a6f5b0ae..a3f1a47b6f1c 100644
> --- a/Documentation/arm64/booting.rst
> +++ b/Documentation/arm64/booting.rst
> @@ -248,6 +248,20 @@ Before jumping into the kernel, the following conditions must be met:
>       - HCR_EL2.APK (bit 40) must be initialised to 0b1
>       - HCR_EL2.API (bit 41) must be initialised to 0b1
>   
> +  For CPUs with Activity Monitors Unit v1 (AMUv1) extension present:
> +  - If EL3 is present:
> +    CPTR_EL3.TAM (bit 30) must be initialised to 0b0
> +    CPTR_EL2.TAM (bit 30) must be initialised to 0b0
> +    AMCNTENSET0_EL0 must be initialised to 0b1111
> +    AMCNTENSET1_EL0 must be initialised to a platform specific value
> +    having 0b1 set for the corresponding bit for each of the auxiliary
> +    counters present.
> +  - If the kernel is entered at EL1:
> +    AMCNTENSET0_EL0 must be initialised to 0b1111
> +    AMCNTENSET1_EL0 must be initialised to a platform specific value
> +    having 0b1 set for the corresponding bit for each of the auxiliary
> +    counters present.
> +
>   The requirements described above for CPU mode, caches, MMUs, architected
>   timers, coherency and system registers apply to all CPUs.  All CPUs must
>   enter the kernel in the same exception level.
> diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
> index b6e44884e3ad..4770ae54032b 100644
> --- a/Documentation/arm64/cpu-feature-registers.rst
> +++ b/Documentation/arm64/cpu-feature-registers.rst
> @@ -150,6 +150,8 @@ infrastructure:
>        +------------------------------+---------+---------+
>        | DIT                          | [51-48] |    y    |
>        +------------------------------+---------+---------+
> +     | AMU                          | [47-44] |    n    |
> +     +------------------------------+---------+---------+

As mentioned above, please drop it.


Suzuki
