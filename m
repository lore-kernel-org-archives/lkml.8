Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5226CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6A39206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589400141;
	bh=11+NwsuEwZLSZ28dwjw8cleHyZ7yoUPnIjIVHyFlXTk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=yFZNXZrASQavQO7Dry2r9wZJl4400YHPfZJj+L8n+TvnW5KWvooxciVz5NzTTboXg
	 8hw8c3KaIxZdQZrZnAnZeQlqLNEfG8iSiCrpbqdCHNtNh3VgdR/3Ppvi1xjH6UONg+
	 Js45Cf5V4GVyxdDJZyXfFEuziBYRv3PHoLNERzvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390778AbgEMUCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 16:02:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733135AbgEMUCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 16:02:19 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9A59205ED;
        Wed, 13 May 2020 20:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589400139;
        bh=11+NwsuEwZLSZ28dwjw8cleHyZ7yoUPnIjIVHyFlXTk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=oZX6W3Z4Hjo/CTI+8u7h4Osjqks/9XTQEDwXqHFaILnzPyHu7nj9OCSmbYtMIZEMZ
         WXeXMsMXPJ/kFXC0egp86f7XuUfvUI1+fqN8mXB8GtWb9WSRKZuXQttBF2Zssfz4tQ
         jHHkoOxDKPWI1sdDiSzLEXm3JLmbU0wRlxQfZabc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 005D5352352C; Wed, 13 May 2020 13:02:18 -0700 (PDT)
Date:   Wed, 13 May 2020 13:02:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] [v2] ubsan, kcsan: don't combine sanitizer with kcov on
 clang
Message-ID: <20200513200218.GA25892@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CANpmjNPCZ2r9V7t50_yy+F_-roBWJdiQWgmvvcqTFxzdzOwKhg@mail.gmail.com>
 <20200507162617.2472578-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507162617.2472578-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 06:25:31PM +0200, Arnd Bergmann wrote:
> Clang does not allow -fsanitize-coverage=trace-{pc,cmp} together
> with -fsanitize=bounds or with ubsan:
> 
> clang: error: argument unused during compilation: '-fsanitize-coverage=trace-pc' [-Werror,-Wunused-command-line-argument]
> clang: error: argument unused during compilation: '-fsanitize-coverage=trace-cmp' [-Werror,-Wunused-command-line-argument]
> 
> To avoid the warning, check whether clang can handle this correctly
> or disallow ubsan and kcsan when kcov is enabled.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=45831
> Link: https://lore.kernel.org/lkml/20200505142341.1096942-1-arnd@arndb.de
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied for v5.9 and pushed, thank you!

							Thanx, Paul

> ---
> v2: this implements Marco's suggestion to check what the compiler
> actually supports, and references the bug report I now opened.
> 
> Let's wait for replies on that bug report before this gets applied,
> in case the feedback there changes the conclusion.
> ---
>  lib/Kconfig.kcsan | 11 +++++++++++
>  lib/Kconfig.ubsan | 11 +++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> index ea28245c6c1d..a7276035ca0d 100644
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -3,9 +3,20 @@
>  config HAVE_ARCH_KCSAN
>  	bool
>  
> +config KCSAN_KCOV_BROKEN
> +	def_bool KCOV && CC_HAS_SANCOV_TRACE_PC
> +	depends on CC_IS_CLANG
> +	depends on !$(cc-option,-Werror=unused-command-line-argument -fsanitize=thread -fsanitize-coverage=trace-pc)
> +	help
> +	  Some versions of clang support either KCSAN and KCOV but not the
> +	  combination of the two.
> +	  See https://bugs.llvm.org/show_bug.cgi?id=45831 for the status
> +	  in newer releases.
> +
>  menuconfig KCSAN
>  	bool "KCSAN: dynamic data race detector"
>  	depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN
> +	depends on !KCSAN_KCOV_BROKEN
>  	select STACKTRACE
>  	help
>  	  The Kernel Concurrency Sanitizer (KCSAN) is a dynamic
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index 929211039bac..a5ba2fd51823 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -26,9 +26,20 @@ config UBSAN_TRAP
>  	  the system. For some system builders this is an acceptable
>  	  trade-off.
>  
> +config UBSAN_KCOV_BROKEN
> +	def_bool KCOV && CC_HAS_SANCOV_TRACE_PC
> +	depends on CC_IS_CLANG
> +	depends on !$(cc-option,-Werror=unused-command-line-argument -fsanitize=bounds -fsanitize-coverage=trace-pc)
> +	help
> +	  Some versions of clang support either UBSAN or KCOV but not the
> +	  combination of the two.
> +	  See https://bugs.llvm.org/show_bug.cgi?id=45831 for the status
> +	  in newer releases.
> +
>  config UBSAN_BOUNDS
>  	bool "Perform array index bounds checking"
>  	default UBSAN
> +	depends on !UBSAN_KCOV_BROKEN
>  	help
>  	  This option enables detection of directly indexed out of bounds
>  	  array accesses, where the array size is known at compile time.
> -- 
> 2.26.0
> 
