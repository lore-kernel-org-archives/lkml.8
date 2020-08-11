Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6593C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 10:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7980D20756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 10:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgHKKxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 06:53:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:41820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728326AbgHKKxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 06:53:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D8A7AAB3E;
        Tue, 11 Aug 2020 10:54:13 +0000 (UTC)
Date:   Tue, 11 Aug 2020 12:53:52 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-embedded@vger.kernel.org
Subject: Re: [PATCH v2 2/2] init/Kconfig: Increase default log buffer size
 from 128 KB to 512 KB
Message-ID: <20200811105352.GG6215@alley>
References: <20200811092924.6256-1-pmenzel@molgen.mpg.de>
 <20200811092924.6256-2-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811092924.6256-2-pmenzel@molgen.mpg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-08-11 11:29:24, Paul Menzel wrote:
> Commit f17a32e97e (let LOG_BUF_SHIFT default to 17) from 2008 was the
> last time, the the default log buffer size bump was increased.
> 
> Machines have evolved, and on current hardware, enough memory is
> present, and some devices have over 200 PCI devices, like a two socket
> Skylake-E server, resulting a lot of lines.
> 
> Therefore, increase the default from 128 KB to 512 KB. Anyone, with
> limited memory, can still lower it.
> 
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -681,9 +681,9 @@ config IKHEADERS
>  	  kheaders.ko is built which can be loaded on-demand to get access to headers.
>  
>  config LOG_BUF_SHIFT
> -	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)"
> +	int "Kernel log buffer size (17 => 128KB, 19 => 512KB)"
>  	range 12 25
> -	default 17
> +	default 19
>  	depends on PRINTK
>  	help
>  	  Select the minimal kernel log buffer size as a power of 2.

Honestly, I do not have experience with changing the defaults. People
hacking small devices might complain. Well, this can be solved
by increasing the default only when BASE_FULL is set.

I am personally fine with increasing the default when BASE_FULL
is set. The amount of messages is growing over time because of
increasing complexity of both the hardware and software.
Fortunately also the amount of available memory is growing.

Well, this should get discussed in wider audience. Adding some
people into CC.

JFYI, it started with report of lost messages, see
https://lore.kernel.org/lkml/264bfbae-122d-9c41-59ea-6413f91bd866@molgen.mpg.de/

Best Regards,
Petr
