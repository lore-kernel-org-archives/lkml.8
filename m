Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0ACAC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3DD82072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgHYPyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:54:53 -0400
Received: from smtprelay0214.hostedemail.com ([216.40.44.214]:40976 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726222AbgHYPyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:54:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 59D7D18224D7E;
        Tue, 25 Aug 2020 15:54:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: board60_4f092392705d
X-Filterd-Recvd-Size: 2978
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 15:54:49 +0000 (UTC)
Message-ID: <9ee753e9d0b4d8fbab431b7f4761c59586f1a3f2.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: Warn if trace_printk and friends are
 called
From:   Joe Perches <joe@perches.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Date:   Tue, 25 Aug 2020 08:54:48 -0700
In-Reply-To: <20200825193600.v2.1.I723c43c155f02f726c97501be77984f1e6bb740a@changeid>
References: <20200825193600.v2.1.I723c43c155f02f726c97501be77984f1e6bb740a@changeid>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-25 at 19:36 +0800, Nicolas Boichat wrote:
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

thanks.

> ---
> See also extensive discussion under this thread:
> https://lkml.org/lkml/2020/8/20/244
> 
> This seems to be the simplest way to try to reduce the number
> of trace_printk that make it into the kernel.
> 
> Changes in v2:
>  - Use $1 directly, fix wording, remove final period.
> 
>  scripts/checkpatch.pl | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 4aa1d9d5e62c5b0..1102aa0ec2f7a05 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -4272,6 +4272,12 @@ sub process {
>  			     "Prefer dev_$level(... to dev_printk(KERN_$orig, ...\n" . $herecurr);
>  		}
>  
> +# trace_printk should not be used in production code.
> +		if ($line =~ /\b(trace_printk|trace_puts|ftrace_vprintk)\s*\(/) {
> +			WARN("TRACE_PRINTK",
> +			     "Do not use $1() in production code (this can be ignored if built only with a debug config option)\n" . $herecurr);
> +		}
> +
>  # ENOSYS means "bad syscall nr" and nothing else.  This will have a small
>  # number of false positives, but assembly files are not checked, so at
>  # least the arch entry code will not trigger this warning.

