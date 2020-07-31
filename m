Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3393C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 890792177B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732433AbgGaOiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 10:38:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728613AbgGaOiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 10:38:02 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3D5622B3F;
        Fri, 31 Jul 2020 14:38:01 +0000 (UTC)
Date:   Fri, 31 Jul 2020 10:38:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 1/3] lib/vsprintf: Replace hidden BUILD_BUG_ON() with
 static_assert()
Message-ID: <20200731103800.36a412eb@oasis.local.home>
In-Reply-To: <20200731123145.22357-1-andriy.shevchenko@linux.intel.com>
References: <20200731123145.22357-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jul 2020 15:31:43 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> First of all, there is no compile time check for the SMALL
> to be ' ' (0x20, i.e. space). Second, for ZEROPAD the check
> is hidden in the code.
> 
> For better maintenance replace BUILD_BUG_ON() with static_assert()
> for ZEROPAD and move it closer to the definition. While at it,
> introduce check for SMALL.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/vsprintf.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 31a674dd2674..8a8ac7ce0289 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -381,6 +381,9 @@ int num_to_str(char *buf, int size, unsigned long long num, unsigned int width)
>  #define SMALL	32		/* use lowercase in hex (must be 32 == 0x20) */
>  #define SPECIAL	64		/* prefix hex with "0x", octal with "0" */
>  
> +static_assert(ZEROPAD + ' ' == '0');

I would have it match the comment above:

static_assert(ZEROPAD == ('0' - ' '));

But other than that:

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> +static_assert(SMALL == ' ');
> +
>  enum format_type {
>  	FORMAT_TYPE_NONE, /* Just a string part */
>  	FORMAT_TYPE_WIDTH,
> @@ -507,7 +510,7 @@ char *number(char *buf, char *end, unsigned long long num,
>  	/* zero or space padding */
>  	if (!(spec.flags & LEFT)) {
>  		char c = ' ' + (spec.flags & ZEROPAD);
> -		BUILD_BUG_ON(' ' + ZEROPAD != '0');
> +
>  		while (--field_width >= 0) {
>  			if (buf < end)
>  				*buf = c;

