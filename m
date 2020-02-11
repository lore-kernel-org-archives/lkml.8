Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533C6C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7C92086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgBKN5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:57:30 -0500
Received: from foss.arm.com ([217.140.110.172]:46418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728564AbgBKN52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:57:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C768030E;
        Tue, 11 Feb 2020 05:57:27 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 909D33F68F;
        Tue, 11 Feb 2020 05:57:25 -0800 (PST)
Subject: Re: [PATCH v7 00/11] add support for Clang's Shadow Call Stack
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
From:   James Morse <james.morse@arm.com>
Message-ID: <63517cff-4bd6-bb6c-9a54-23de4f5fbb4a@arm.com>
Date:   Tue, 11 Feb 2020 13:57:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200128184934.77625-1-samitolvanen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sami,

On 28/01/2020 18:49, Sami Tolvanen wrote:
> This patch series adds support for Clang's Shadow Call Stack
> (SCS) mitigation, which uses a separately allocated shadow stack
> to protect against return address overwrites. More information
> can be found here:
> 
>   https://clang.llvm.org/docs/ShadowCallStack.html
> 
> SCS provides better protection against traditional buffer
> overflows than CONFIG_STACKPROTECTOR_*, but it should be noted
> that SCS security guarantees in the kernel differ from the ones
> documented for user space. The kernel must store addresses of
> shadow stacks used by inactive tasks and interrupt handlers in
> memory, which means an attacker capable reading and writing
> arbitrary memory may be able to locate them and hijack control
> flow by modifying shadow stacks that are not currently in use.
> 
> SCS is currently supported only on arm64, where the compiler
> requires the x18 register to be reserved for holding the current
> task's shadow stack pointer.

I found I had to add:
| KBUILD_CFLAGS := $(filter-out -ffixed-x18 $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))

to drivers/firmware/efi/libstub/Makefile, to get this going.
I don't think there is much point supporting SCS for the EFIstub, its already isolated
from the rest of the kernel's C code by the __efistub symbol prefix machinery, and trying
to use it would expose us to buggy firmware at a point we can't handle it!

I can send a patch if its easier for you,


Thanks,

James
