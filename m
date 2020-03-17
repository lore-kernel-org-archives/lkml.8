Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE55C0044D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 01:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D621E20679
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 01:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgCQBjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 21:39:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgCQBjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 21:39:03 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FF412051A;
        Tue, 17 Mar 2020 01:39:02 +0000 (UTC)
Date:   Mon, 16 Mar 2020 21:39:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shreyas Joshi <Shreyas.Joshi@biamp.com>
Cc:     "pmladek@suse.com" <pmladek@suse.com>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "shreyasjoshi15@gmail.com" <shreyasjoshi15@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20200316213900.6b1eb594@oasis.local.home>
In-Reply-To: <MN2PR17MB31979437E605257461AC003DFCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
References: <20200309052915.858-1-shreyas.joshi@biamp.com>
        <MN2PR17MB31979437E605257461AC003DFCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Mar 2020 01:34:43 +0000
Shreyas Joshi <Shreyas.Joshi@biamp.com> wrote:

Hi Shreyas!

> If uboot passes a blank string to console_setup then it results in a trashed memory.
> Ultimately, the kernel crashes during freeing up the memory. This fix checks if there is a blank parameter being passed to console_setup from uboot.
> In case it detects that the console parameter is blank then it doesn't setup the serial device and it gracefully exits.

Please line wrap you commit messages to at most 75 characters.

> 
> Signed-off-by: Shreyas Joshi <shreyas.joshi@biamp.com>
> ---
>  kernel/printk/printk.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c index ad4606234545..e9ad730991e0 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2165,7 +2165,10 @@ static int __init console_setup(char *str)
>  	char buf[sizeof(console_cmdline[0].name) + 4]; /* 4 for "ttyS" */
>  	char *s, *options, *brl_options = NULL;
>  	int idx;
> -
> +	if (str[0] == 0) {
> +		console_loglevel = 0;
> +		return 1;

Hmm, I wonder if this should produce a warning :-/

-- Steve

> +	}
>  	if (_braille_console_setup(&str, &brl_options))
>  		return 1;
>  
> --
> 2.20.1

