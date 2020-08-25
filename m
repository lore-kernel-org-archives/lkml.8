Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BEDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1050620706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbgHYHXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:23:31 -0400
Received: from smtprelay0111.hostedemail.com ([216.40.44.111]:49874 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729301AbgHYHXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 03:23:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id A6AA31DE9;
        Tue, 25 Aug 2020 07:23:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: birth38_1b1524a2705a
X-Filterd-Recvd-Size: 2937
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 07:23:27 +0000 (UTC)
Message-ID: <6972ee8f4bd9d19c137e2526fae53cf4379f4499.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Warn if trace_printk and friends are called
From:   Joe Perches <joe@perches.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Date:   Tue, 25 Aug 2020 00:23:26 -0700
In-Reply-To: <20200825150942.1.I723c43c155f02f726c97501be77984f1e6bb740a@changeid>
References: <20200825150942.1.I723c43c155f02f726c97501be77984f1e6bb740a@changeid>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-25 at 15:09 +0800, Nicolas Boichat wrote:
> trace_printk is meant as a debugging tool, and should not be
> compiled into production code without specific debug Kconfig
> options enabled, or source code changes, as indicated by the
> warning that shows up on boot if any trace_printk is called:
>  **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
>  **                                                      **
>  ** trace_printk() being used. Allocating extra memory.  **
>  **                                                      **
>  ** This means that this is a DEBUG kernel and it is     **
>  ** unsafe for production use.                           **
> 
> Let's warn developers when they try to submit such a change.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
> 
> See also extensive discussion under this thread:
> https://lkml.org/lkml/2020/8/20/244
> 
> This seems to be the simplest way to try to reduce the number
> of trace_printk that make it into the kernel.

I don't have a real objection, just some nits.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -4272,6 +4272,14 @@ sub process {
>  			     "Prefer dev_$level(... to dev_printk(KERN_$orig, ...\n" . $herecurr);
>  		}
>  
> +# trace_printk should not be used in production code.
> +		if ($line =~ /\b(trace_printk|trace_puts|ftrace_vprintk)\s*\(/) {
> +			my $func = $1;
> +
> +			WARN("TRACE_PRINTK",
> +			     "Do not use $func() in production code (this can be ignored if built only behind a debug config option).\n" . $herecurr);

You don't need to do an assign, you could use $1 directly.
I think 'built only behind' could be "building only with'.
No periods before the newline either.

> +		}
> +
>  # ENOSYS means "bad syscall nr" and nothing else.  This will have a small
>  # number of false positives, but assembly files are not checked, so at
>  # least the arch entry code will not trigger this warning.

