Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07582C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC99020721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590067091;
	bh=ZJljZ6uIPIG3RU+2rBIuSdZVriwJ3EuVoA0eA8WQd10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HlsRUBWruG73r3O8e04NUkxlrMHpBPIad82mUIsTmUifhABAHtjvtAZILIH01s4W3
	 ctd/Pxs0De6JnDdQjUKYd710rcQkw7Vgw/fHkPUpKlV9rCfX+H9KwVCKRu+hp+RvY6
	 Ss6IdNopuR6RkiKGgpkd3le8vezL/rmeyE7tBHeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgEUNSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:18:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbgEUNSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:18:10 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8A6B206B6;
        Thu, 21 May 2020 13:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590067089;
        bh=ZJljZ6uIPIG3RU+2rBIuSdZVriwJ3EuVoA0eA8WQd10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MM5SHFs056yrBmf0QOycZMj8E/xE+B4HWHcEsMq10W3tp4EBHP8mQPZ+qgRSmg8xa
         l+W2c5utrU+hhQAspz1oBoWsKHc3ZPN9Ns+pRn6Nz+ig4QNZSkoHBTYrr2ZIKRpX82
         zERKldt5Wuj4aOzId/i3A0kTvsLu28NuEq8c9a0I=
Date:   Thu, 21 May 2020 14:18:04 +0100
From:   Will Deacon <will@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, clang-built-linux@googlegroups.com,
        bp@alien8.de
Subject: Re: [PATCH -tip v2 03/11] kcsan: Support distinguishing volatile
 accesses
Message-ID: <20200521131803.GA6608@willie-the-truck>
References: <20200521110854.114437-1-elver@google.com>
 <20200521110854.114437-4-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521110854.114437-4-elver@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 01:08:46PM +0200, Marco Elver wrote:
> In the kernel, volatile is used in various concurrent context, whether
> in low-level synchronization primitives or for legacy reasons. If
> supported by the compiler, we will assume that aligned volatile accesses
> up to sizeof(long long) (matching compiletime_assert_rwonce_type()) are
> atomic.
> 
> Recent versions Clang [1] (GCC tentative [2]) can instrument volatile
> accesses differently. Add the option (required) to enable the
> instrumentation, and provide the necessary runtime functions. None of
> the updated compilers are widely available yet (Clang 11 will be the
> first release to support the feature).
> 
> [1] https://github.com/llvm/llvm-project/commit/5a2c31116f412c3b6888be361137efd705e05814
> [2] https://gcc.gnu.org/pipermail/gcc-patches/2020-April/544452.html
> 
> This patch allows removing any explicit checks in primitives such as
> READ_ONCE() and WRITE_ONCE().
> 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v2:
> * Reword Makefile comment.
> ---
>  kernel/kcsan/core.c    | 43 ++++++++++++++++++++++++++++++++++++++++++
>  scripts/Makefile.kcsan |  5 ++++-
>  2 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index a73a66cf79df..15f67949d11e 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -789,6 +789,49 @@ void __tsan_write_range(void *ptr, size_t size)
>  }
>  EXPORT_SYMBOL(__tsan_write_range);
>  
> +/*
> + * Use of explicit volatile is generally disallowed [1], however, volatile is
> + * still used in various concurrent context, whether in low-level
> + * synchronization primitives or for legacy reasons.
> + * [1] https://lwn.net/Articles/233479/
> + *
> + * We only consider volatile accesses atomic if they are aligned and would pass
> + * the size-check of compiletime_assert_rwonce_type().
> + */
> +#define DEFINE_TSAN_VOLATILE_READ_WRITE(size)                                  \
> +	void __tsan_volatile_read##size(void *ptr)                             \
> +	{                                                                      \
> +		const bool is_atomic = size <= sizeof(long long) &&            \
> +				       IS_ALIGNED((unsigned long)ptr, size);   \
> +		if (IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS) && is_atomic)      \
> +			return;                                                \
> +		check_access(ptr, size, is_atomic ? KCSAN_ACCESS_ATOMIC : 0);  \
> +	}                                                                      \
> +	EXPORT_SYMBOL(__tsan_volatile_read##size);                             \
> +	void __tsan_unaligned_volatile_read##size(void *ptr)                   \
> +		__alias(__tsan_volatile_read##size);                           \
> +	EXPORT_SYMBOL(__tsan_unaligned_volatile_read##size);                   \
> +	void __tsan_volatile_write##size(void *ptr)                            \
> +	{                                                                      \
> +		const bool is_atomic = size <= sizeof(long long) &&            \
> +				       IS_ALIGNED((unsigned long)ptr, size);   \
> +		if (IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS) && is_atomic)      \
> +			return;                                                \
> +		check_access(ptr, size,                                        \
> +			     KCSAN_ACCESS_WRITE |                              \
> +				     (is_atomic ? KCSAN_ACCESS_ATOMIC : 0));   \
> +	}                                                                      \
> +	EXPORT_SYMBOL(__tsan_volatile_write##size);                            \
> +	void __tsan_unaligned_volatile_write##size(void *ptr)                  \
> +		__alias(__tsan_volatile_write##size);                          \
> +	EXPORT_SYMBOL(__tsan_unaligned_volatile_write##size)
> +
> +DEFINE_TSAN_VOLATILE_READ_WRITE(1);
> +DEFINE_TSAN_VOLATILE_READ_WRITE(2);
> +DEFINE_TSAN_VOLATILE_READ_WRITE(4);
> +DEFINE_TSAN_VOLATILE_READ_WRITE(8);
> +DEFINE_TSAN_VOLATILE_READ_WRITE(16);

Having a 16-byte case seems a bit weird to me, but I guess clang needs this
for some reason?

Will
