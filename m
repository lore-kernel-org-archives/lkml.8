Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACE2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4E4A20722
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbgGFQI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:08:27 -0400
Received: from foss.arm.com ([217.140.110.172]:52620 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729367AbgGFQI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 12:08:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89E3E1FB;
        Mon,  6 Jul 2020 09:08:25 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6AF23F68F;
        Mon,  6 Jul 2020 09:08:22 -0700 (PDT)
Date:   Mon, 6 Jul 2020 17:08:20 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matt Turner <mattst88@gmail.com>, kernel-team@android.com,
        Marco Elver <elver@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-arm-kernel@lists.infradead.org,
        Richard Henderson <rth@twiddle.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-alpha@vger.kernel.org
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when
 CLANG_LTO=y
Message-ID: <20200706160820.GC10992@arm.com>
References: <20200630173734.14057-1-will@kernel.org>
 <20200630173734.14057-19-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630173734.14057-19-will@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 06:37:34PM +0100, Will Deacon wrote:
> When building with LTO, there is an increased risk of the compiler
> converting an address dependency headed by a READ_ONCE() invocation
> into a control dependency and consequently allowing for harmful
> reordering by the CPU.
> 
> Ensure that such transformations are harmless by overriding the generic
> READ_ONCE() definition with one that provides acquire semantics when
> building with LTO.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/rwonce.h   | 63 +++++++++++++++++++++++++++++++
>  arch/arm64/kernel/vdso/Makefile   |  2 +-
>  arch/arm64/kernel/vdso32/Makefile |  2 +-
>  3 files changed, 65 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/include/asm/rwonce.h
> 
> diff --git a/arch/arm64/include/asm/rwonce.h b/arch/arm64/include/asm/rwonce.h
> new file mode 100644
> index 000000000000..515e360b01a1
> --- /dev/null
> +++ b/arch/arm64/include/asm/rwonce.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020 Google LLC.
> + */
> +#ifndef __ASM_RWONCE_H
> +#define __ASM_RWONCE_H
> +
> +#ifdef CONFIG_CLANG_LTO
> +
> +#include <linux/compiler_types.h>
> +#include <asm/alternative-macros.h>
> +
> +#ifndef BUILD_VDSO
> +
> +#ifdef CONFIG_AS_HAS_LDAPR
> +#define __LOAD_RCPC(sfx, regs...)					\
> +	ALTERNATIVE(							\
> +		"ldar"	#sfx "\t" #regs,				\

^ Should this be here?  It seems that READ_ONCE() will actually read
twice... even if that doesn't actually conflict with the required
semantics of READ_ONCE(), it looks odd.

Making a direct link between LTO and the memory model also seems highly
spurious (as discussed in the other subthread) so can we have a comment
explaining the reasoning?

> +		".arch_extension rcpc\n"				\
> +		"ldapr"	#sfx "\t" #regs,				\
> +	ARM64_HAS_LDAPR)
> +#else
> +#define __LOAD_RCPC(sfx, regs...)	"ldar" #sfx "\t" #regs
> +#endif /* CONFIG_AS_HAS_LDAPR */

[...]

Cheers
---Dave
