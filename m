Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666F3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3452720671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgERMQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 08:16:04 -0400
Received: from foss.arm.com ([217.140.110.172]:39374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbgERMQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 08:16:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C67C3106F;
        Mon, 18 May 2020 05:16:03 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39DE73F305;
        Mon, 18 May 2020 05:16:01 -0700 (PDT)
Date:   Mon, 18 May 2020 13:15:58 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@am.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com
Subject: Re: [PATCH 5/6] scs: Remove references to asm/scs.h from core code
Message-ID: <20200518121558.GF1957@C02TD0UTHF1T.local>
References: <20200515172756.27185-1-will@kernel.org>
 <20200515172756.27185-6-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515172756.27185-6-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 06:27:55PM +0100, Will Deacon wrote:
> asm/scs.h is no longer needed by the core code, so remove a redundant
> header inclusion and update the stale Kconfig text.
> 
> Signed-off-by: Will Deacon <will@kernel.org>

With the corruption checks moved out of arch code this looks sound to
me, so modulo my comments on the prior patch, assuming we factor that
out:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/Kconfig | 4 ++--
>  kernel/scs.c | 1 -
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 45dfca9a98d3..2e6f843d87c4 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -537,8 +537,8 @@ config ARCH_SUPPORTS_SHADOW_CALL_STACK
>  	bool
>  	help
>  	  An architecture should select this if it supports Clang's Shadow
> -	  Call Stack, has asm/scs.h, and implements runtime support for shadow
> -	  stack switching.
> +	  Call Stack and implements runtime support for shadow stack
> +	  switching.
>  
>  config SHADOW_CALL_STACK
>  	bool "Clang Shadow Call Stack"
> diff --git a/kernel/scs.c b/kernel/scs.c
> index faf0ecd7b893..222a7a9ad543 100644
> --- a/kernel/scs.c
> +++ b/kernel/scs.c
> @@ -10,7 +10,6 @@
>  #include <linux/scs.h>
>  #include <linux/slab.h>
>  #include <linux/vmstat.h>
> -#include <asm/scs.h>
>  
>  static struct kmem_cache *scs_cache;
>  
> -- 
> 2.26.2.761.g0e0b3e54be-goog
> 
