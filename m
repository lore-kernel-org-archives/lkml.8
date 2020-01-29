Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C640CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43BB2070E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgA2NYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 08:24:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:52764 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgA2NYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 08:24:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5D416AC46;
        Wed, 29 Jan 2020 13:24:28 +0000 (UTC)
Date:   Wed, 29 Jan 2020 14:24:27 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] console: Drop double check for console_drivers
 being non-NULL
Message-ID: <20200129132427.bg774jfgbvm33s5w@pathway.suse.cz>
References: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
 <20200127114719.69114-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127114719.69114-2-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-01-27 13:47:16, Andy Shevchenko wrote:
> There is no need to explicitly check for console_drivers to be non-NULL
> since for_each_console() does this.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Nice catch.

Reviewed-by: Petr Mladek <pmladek@suse.com>

There is a candidate for another patch, see the note below.

> ---
> v3: no changes
>  kernel/printk/printk.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index fada22dc4ab6..51337ed426e0 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2653,18 +2650,17 @@ void register_console(struct console *newcon)
>  	struct console_cmdline *c;
>  	static bool has_preferred;
>  
> -	if (console_drivers)
> -		for_each_console(bcon)
> -			if (WARN(bcon == newcon,
> -					"console '%s%d' already registered\n",
> -					bcon->name, bcon->index))
> -				return;
> +	for_each_console(bcon) {
> +		if (WARN(bcon == newcon, "console '%s%d' already registered\n",
> +					 bcon->name, bcon->index))
> +			return;
> +	}
>  
>  	/*
>  	 * before we register a new CON_BOOT console, make sure we don't
>  	 * already have a valid console
>  	 */
> -	if (console_drivers && newcon->flags & CON_BOOT) {
> +	if (newcon->flags & CON_BOOT) {
>  		/* find the last or real console */

Note: This comment is misleading. I would just remove it.

>  		for_each_console(bcon) {
>  			if (!(bcon->flags & CON_BOOT)) {

Best Regards,
Petr
