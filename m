Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2297C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CDB2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgBKN5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:57:35 -0500
Received: from foss.arm.com ([217.140.110.172]:46444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729986AbgBKN5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:57:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CB6431B;
        Tue, 11 Feb 2020 05:57:32 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 541BF3F68F;
        Tue, 11 Feb 2020 05:57:30 -0800 (PST)
Subject: Re: [PATCH v7 11/11] arm64: scs: add shadow stacks for SDEI
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200128184934.77625-1-samitolvanen@google.com>
 <20200128184934.77625-12-samitolvanen@google.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <dbb090ae-d1ec-cb1a-0710-e1d3cfe762b9@arm.com>
Date:   Tue, 11 Feb 2020 13:57:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200128184934.77625-12-samitolvanen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sami,

On 28/01/2020 18:49, Sami Tolvanen wrote:
> This change adds per-CPU shadow call stacks for the SDEI handler.
> Similarly to how the kernel stacks are handled, we add separate shadow
> stacks for normal and critical events.

Reviewed-by: James Morse <james.morse@arm.com>
Tested-by: James Morse <james.morse@arm.com>


> diff --git a/arch/arm64/kernel/scs.c b/arch/arm64/kernel/scs.c
> index eaadf5430baa..dddb7c56518b 100644
> --- a/arch/arm64/kernel/scs.c
> +++ b/arch/arm64/kernel/scs.c

> +static int scs_alloc_percpu(unsigned long * __percpu *ptr, int cpu)
> +{
> +	unsigned long *p;
> +
> +	p = __vmalloc_node_range(PAGE_SIZE, SCS_SIZE,
> +				 VMALLOC_START, VMALLOC_END,
> +				 GFP_SCS, PAGE_KERNEL,
> +				 0, cpu_to_node(cpu),
> +				 __builtin_return_address(0));

(What makes this arch specific? arm64 has its own calls like this for the regular vmap
stacks because it plays tricks with the alignment. Here the alignment requirement comes
from the core SCS code... Would another architecture implement these
scs_alloc_percpu()/scs_free_percpu() differently?)


Thanks,

James
