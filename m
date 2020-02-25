Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A82C35E0D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F832082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KlT+x8YC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbgBYRt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:49:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58810 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgBYRt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=IRtFS9VLFS8gr7o6xWn6bt+VZwExjER1OxHDff1IBDA=; b=KlT+x8YCl5N0AMNDHUX0Az1D3P
        oSXhzjEtosduGbo/e/1dwO8HseTKpKXH62ZJp3jSfyHLUWO+OaspWcHeSG2XgoxjNMwRsE6d4xqCK
        r0el3pQnf+rz+218El6wkkFqBL5QAAi3DJo9ElXcFZwxJZu8eNtcplyxSW+b17N+WCI5stEaztzoE
        UejYjw9M37WhY4mwgRkxzLXqnmnCRlatPh/k3f2PUMdlb1CP5lUQ2sX0plf1M2zKFLk0/j2xRj0DN
        PwVhIIY3/X2LHqLppXoNgzrZ0SrAkKXjTdcCdqQvVJ+57sJPqD44agf+X8a1+U0Eq0UlXm2KPdu8v
        EG7JqY2A==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6eKk-0007zA-KK; Tue, 25 Feb 2020 17:49:26 +0000
Subject: Re: [PATCH] bootconfig: Fix CONFIG_BOOTTIME_TRACING dependency issue
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200225220551.d9a409bc04b77cdf48eae3ea@kernel.org>
 <158264140162.23842.11237423518607465535.stgit@devnote2>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c9604764-bd0f-67e9-56c8-fb6ffaf9b430@infradead.org>
Date:   Tue, 25 Feb 2020 09:49:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <158264140162.23842.11237423518607465535.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 6:36 AM, Masami Hiramatsu wrote:
> Since commit d8a953ddde5e ("bootconfig: Set CONFIG_BOOT_CONFIG=n by
> default") also changed the CONFIG_BOOTTIME_TRACING to select
> CONFIG_BOOT_CONFIG to show the boot-time tracing on the menu,
> it introduced wrong dependencies with BLK_DEV_INITRD as below.
> 
> WARNING: unmet direct dependencies detected for BOOT_CONFIG
>   Depends on [n]: BLK_DEV_INITRD [=n]
>   Selected by [y]:
>   - BOOTTIME_TRACING [=y] && TRACING_SUPPORT [=y] && FTRACE [=y] && TRACING [=y]
> 
> This makes the CONFIG_BOOT_CONFIG selects CONFIG_BLK_DEV_INITRD to
> fix this error and make CONFIG_BOOTTIME_TRACING=n by default, so
> that both boot-time tracing and boot configuration off but those
> appear on the menu list.
> 
> Fixes: d8a953ddde5e ("bootconfig: Set CONFIG_BOOT_CONFIG=n by default")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Hi,
I'm no fan of "select", but this does fix the kconfig warnings and
build errors that I have reported.  Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

> ---
>  init/Kconfig         |    2 +-
>  kernel/trace/Kconfig |    1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index a84e7aa89a29..8b4c3e8c05ea 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1217,7 +1217,7 @@ endif
>  
>  config BOOT_CONFIG
>  	bool "Boot config support"
> -	depends on BLK_DEV_INITRD
> +	select BLK_DEV_INITRD
>  	help
>  	  Extra boot config allows system admin to pass a config file as
>  	  complemental extension of kernel cmdline when booting.
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 795c3e02d3f1..402eef84c859 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -145,7 +145,6 @@ config BOOTTIME_TRACING
>  	bool "Boot-time Tracing support"
>  	depends on TRACING
>  	select BOOT_CONFIG
> -	default y
>  	help
>  	  Enable developer to setup ftrace subsystem via supplemental
>  	  kernel cmdline at boot time for debugging (tracing) driver
> 


-- 
~Randy

