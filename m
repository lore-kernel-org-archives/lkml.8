Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F43C18E5B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 06:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B978520838
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 06:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583650337;
	bh=VE4kzEw8U0xydQNpd7yfJiExpQPdL/5wTaZI8b/HqbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wF7j4sfEmLHknBfNM5UwW34SncWXK1sr3AIQ1UsvkRLEdVGtR7Gms6OCJXoh3M666
	 iP5NDVNoImN+YoUvf/LY4R8jCvNIvnllequYwlor5on6siMbf14x+F9bj3vw3jI6EH
	 adGTvCLNLS/OzireS5o7XWLGM7kvSjz4yWHQvkAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgCHGwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 01:52:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:59772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgCHGwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 01:52:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 138A520828;
        Sun,  8 Mar 2020 06:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583650334;
        bh=VE4kzEw8U0xydQNpd7yfJiExpQPdL/5wTaZI8b/HqbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FxJFz6fA6tc68NWhb87kOgtaElB8yHoqOrsuKOkD2crb3NZWe3IxyPmAaPlWW0aND
         NzXhc+pcQqbvpgd12VM6syagRjUNwS8bSxhOVRFd5wOWmiW+QKtTIGM3863CJzYuMD
         KWCNb/iKE9uwS7HVIkZNdt+Wcw2lw+L2QuhpYuTw=
Date:   Sun, 8 Mar 2020 07:52:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v2] Add kernel config option for fuzz testing.
Message-ID: <20200308065211.GD3983392@kroah.com>
References: <20200307135822.3894-1-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307135822.3894-1-penguin-kernel@I-love.SAKURA.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 07, 2020 at 10:58:22PM +0900, Tetsuo Handa wrote:
> While syzkaller is finding many bugs, sometimes syzkaller examines
> stupid operations. Currently we prevent syzkaller from examining
> stupid operations by blacklisting syscall arguments and/or disabling
> whole functionality using existing kernel config options, but it is
> a whack-a-mole approach. We need cooperation from kernel side [1].
> 
> This patch introduces a kernel config option which allows disabling
> only specific operations. This kernel config option should be enabled
> only when building kernels for fuzz testing.
> 
> We discussed possibility of disabling specific operations at run-time
> using some lockdown mechanism [2], but conclusion seems that build-time
> control (i.e. kernel config option) fits better for this purpose.
> Since patches for users of this kernel config option will want a lot of
> explanation [3], this patch provides only kernel config option for them.
> 
> [1] https://github.com/google/syzkaller/issues/1622
> [2] https://lkml.kernel.org/r/CACdnJutc7OQeoor6WLTh8as10da_CN=crs79v3Fp0mJTaO=+yw@mail.gmail.com
> [3] https://lkml.kernel.org/r/20191216163155.GB2258618@kroah.com
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> ---
>  lib/Kconfig.debug | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> Changes since v1:
>   Drop users of this kernel config option.
>   Update patch description.
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 53e786e0a604..e360090e24c5 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2208,4 +2208,14 @@ config HYPERV_TESTING
>  
>  endmenu # "Kernel Testing and Coverage"
>  
> +config KERNEL_BUILT_FOR_FUZZ_TESTING
> +       bool "Build kernel for fuzz testing"
> +       default n

That's always the default, you can leave that.

> +       help

No tabs for the above lines?

> +	 Say N unless you are building kernels for fuzz testing.
> +	 Saying Y here disables several things that legitimately cause
> +	 damage under a fuzzer workload (e.g. copying to arbitrary
> +	 user-specified kernel address, changing console loglevel,
> +	 freezing filesystems).

"cause damage under a fuzzer workload running as root."

And that's the issue here, the fuzzer wants to run as root and then do
things that are known to cause problems (poke at memory locations,
unmount filesystems, etc.)  So you should describe why this is happening
and that it is to be expected :)

thanks,

greg k-h
