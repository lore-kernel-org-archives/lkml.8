Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B215C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 08:16:05 +0000 (UTC)
X-Greylist: delayed 92 seconds by postgrey-1.34 at mail.kernel.org; Mon, 13 Apr 2020 08:16:05 UTC
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGwj1OzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072722063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: from vger.kernel.org (unknown [23.128.96.19])
	by mail.kernel.org (Postfix) with ESMTP id 072722063A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 08:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgDMIOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 04:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbgDMIO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 04:14:29 -0400
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1409C00860B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 01:14:28 -0700 (PDT)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D0C02063A;
        Mon, 13 Apr 2020 08:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586765668;
        bh=S1uzV7rJA7mG2Czqx5LTcsRZRwgWhACzqDUvTanYx3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gGwj1OzFcHMFY6IW+dgpJ7bUzH/3y8Oq8M7q611QC1H6MO6lzk0lvNg4ofU9igPst
         2TOufAkN2hTxbDYv2BXFW48BA3a4DLYEzyjfvLmsAU7M/MJ2M3NojGij3wkcmntuFr
         XuGgr7h0S1nrb+c8+CmEk9oeHwIVJL/iD3noL0i0=
Date:   Mon, 13 Apr 2020 10:14:26 +0200
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
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v3] Add kernel config option for tweaking kernel behavior.
Message-ID: <20200413081426.GA2791586@kroah.com>
References: <20200413063317.7164-1-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413063317.7164-1-penguin-kernel@I-love.SAKURA.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 03:33:17PM +0900, Tetsuo Handa wrote:
> Existing kernel config options are defined based on "whether you want to
> enable this module/feature or not". And such granularity is sometimes
> too rough-grained for fuzzing tools which try to find bugs inside each
> module/feature.
> 
> While syzkaller (one of fuzzing tools) is finding many bugs, sometimes
> syzkaller examines stupid operations. Some examples of such operations
> are: changing console loglevel which in turn makes it impossible to get
> kernel messages when a crash happens, freezing filesystems which in turn
> causes khungtaskd to needlessly complain, programmatically sending
> Ctrl-Alt-Del which in turn causes the system to needlessly reboot.
> Currently we prevent syzkaller from examining stupid operations by
> blacklisting syscall arguments and/or disabling whole functionality
> using existing kernel config options. But such approach is difficult to
> maintain and needlessly prevents fuzzers from testing kernel code. [1]
> 
> We want fuzzers to test as much coverage as possible while we want
> fuzzers not to try stupid operations. To achieve this goal, we want
> cooperation from kernel side, and build-time branching (i.e. kernel
> config options) will be the simplest and the most reliable.
> 
> Therefore, this patch introduces a kernel config option which allows
> selecting fine-grained kernel config options for tweaking kernel's
> behavior. Each fine-grained kernel config option will be added by future
> patches. For ease of management, grouping kernel config options for
> allowing e.g. syzkaller to select all fine-grained kernel config options
> which e.g. syzkaller wants would be added by future patches.
> 
> [1] https://lkml.kernel.org/r/CACT4Y+a6KExbggs4mg8pvoD554PcDqQNW4sM15X-tc=YONCzYw@mail.gmail.com
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> ---
>  lib/Kconfig.debug | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> Changes since v2 ( https://lkml.kernel.org/r/20200307135822.3894-1-penguin-kernel@I-love.SAKURA.ne.jp ):
>   Reduce the role of this kernel config option from "enable everything
>   which would be useful for fuzz testing" to "simply serve as a gate for
>   hiding individual kernel config option", for we should use individual
>   kernel config option for tweaking individual kernel behavior.
> 
> Changes since v1 ( https://lkml.kernel.org/r/20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp ):
>   Drop users of this kernel config option.
>   Update patch description.
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 50c1f5f08e6f..a7c3ebc21428 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2223,4 +2223,15 @@ config HYPERV_TESTING
>  
>  endmenu # "Kernel Testing and Coverage"
>  
> +menuconfig TWEAK_KERNEL_BEHAVIOR
> +	bool "Tweak kernel behavior"
> +	help
> +	  Saying Y here allows modifying kernel behavior via kernel
> +	  config options which will become visible by selecting this
> +	  config option.

This "help" text really only says "say Y here to allow for some config
options".  It doesn't explain what these are for, or why anyone would
select them, or what type of options are here at all.

I don't see how this option, by just looking at it, relates to your goal
of doing things to make fuzzers' lives easier.

thanks,

greg k-h
