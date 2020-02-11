Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B8EC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD846206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbgBKOlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:41:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:39778 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727728AbgBKOlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:41:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CBF29C194;
        Tue, 11 Feb 2020 14:41:35 +0000 (UTC)
Date:   Tue, 11 Feb 2020 15:41:34 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] printk: Fix preferred console selection with
 multiple matches
Message-ID: <20200211144134.fyxxphyr32dkmhsw@pathway.suse.cz>
References: <97dc50d411e10ac8aab1de0376d7a535fea8c60a.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97dc50d411e10ac8aab1de0376d7a535fea8c60a.camel@kernel.crashing.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-02-06 15:02:25, Benjamin Herrenschmidt wrote:
> In the following circumstances, the rule of selecting the console
> corresponding to the last "console=" entry on the command line as
> the preferred console (CON_CONSDEV, ie, /dev/console) fails. This
> is a specific example, but it could happen with different consoles
> that have a similar name aliasing mechanism.
> 
> This tentative fix register_console() to scan first for consoles
> specified on the command line, and only if none is found, to then
> scan for consoles specified by the architecture.
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 17602d7b7ffc..5cf47a7b880c 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2674,8 +2679,13 @@ static int try_enable_new_console(struct console *newcon)
>  	/*
>           * Some consoles, such as pstore and netconsole, can be enabled even
>           * without matching.
> +	 *
> +	 * Note: We only do this test on the !user_specified pass so that such
> +	 * a statically enabled console that isn't user specified gets a chance
> +	 * to have its match() or setup() function called on our second pass
> +	 * through this function.

I had some troubles to part the comment. I wonder if the following is
more clear:

	* Accept pre-enabled consoles only when match() and setup()
	* was called.

And I would do the same check as in the for cycle:

	if (newcon->flags & CON_ENABLED && c->user_specified ==	user_specified)
		return 0;

With the above change:

Reviewed-by: Petr Mladek <pmladek@suse.com>

I could do the change when pushing if you agree and v4 is not needed
for other reasons.

Best Regards,
Petr

PS: JFYI, I am going to look at the 3rd patch tomorrow. I have to go now.
