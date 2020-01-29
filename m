Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEC3C35246
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 14:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7369820732
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 14:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgA2OWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 09:22:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgA2OWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 09:22:02 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97FC420716;
        Wed, 29 Jan 2020 14:22:01 +0000 (UTC)
Date:   Wed, 29 Jan 2020 09:22:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] tracing: Add new testcases for hist trigger
 parsing errors
Message-ID: <20200129092200.2200db5e@gandalf.local.home>
In-Reply-To: <62ec58d9aca661cde46ba678e32a938427945e9e.1561743018.git.zanussi@kernel.org>
References: <cover.1561743018.git.zanussi@kernel.org>
        <62ec58d9aca661cde46ba678e32a938427945e9e.1561743018.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jun 2019 12:40:23 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> Add a testcase ensuring that the tracing error_log correctly displays
> hist trigger parsing errors.

Hi Tom,

I noticed that I never applied these patches (just did), but I also
notice that this test case fails.

Can you have a look on my ftrace/core branch:

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git

Thanks,

-- Steve

> 
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  .../test.d/trigger/trigger-hist-syntax-errors.tc   | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-syntax-errors.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-syntax-errors.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-syntax-errors.tc
> new file mode 100644
> index 000000000000..d44087a2f3d1
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-syntax-errors.tc
> @@ -0,0 +1,32 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: event trigger - test histogram parser errors
> +
> +if [ ! -f set_event -o ! -d events/kmem ]; then
> +    echo "event tracing is not supported"
> +    exit_unsupported
> +fi
> +
> +if [ ! -f events/kmem/kmalloc/trigger ]; then
> +    echo "event trigger is not supported"
> +    exit_unsupported
> +fi
> +
> +if [ ! -f events/kmem/kmalloc/hist ]; then
> +    echo "hist trigger is not supported"
> +    exit_unsupported
> +fi
> +
> +[ -f error_log ] || exit_unsupported
> +
> +check_error() { # command-with-error-pos-by-^
> +    ftrace_errlog_check 'hist:kmem:kmalloc' "$1" 'events/kmem/kmalloc/trigger'
> +}
> +
> +check_error 'hist:keys=common_pid:vals=bytes_req:sort=common_pid,^junk'	# INVALID_SORT_FIELD
> +check_error 'hist:keys=common_pid:vals=bytes_req:^sort='		# EMPTY_ASSIGNMENT
> +check_error 'hist:keys=common_pid:vals=bytes_req:^sort=common_pid,'	# EMPTY_SORT_FIELD
> +check_error 'hist:keys=common_pid:vals=bytes_req:sort=common_pid.^junk'	# INVALID_SORT_MODIFIER
> +check_error 'hist:keys=common_pid:vals=bytes_req,bytes_alloc:^sort=common_pid,bytes_req,bytes_alloc'	# TOO_MANY_SORT_FIELDS
> +
> +exit 0

