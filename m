Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC24C47259
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 466B320757
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgEENJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:09:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbgEENJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:09:15 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CD652073B;
        Tue,  5 May 2020 13:09:14 +0000 (UTC)
Date:   Tue, 5 May 2020 09:09:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org, mingo@redhat.com, mhiramat@kernel.org,
        joel@joelfernandes.org, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests/ftrace: mark irqsoff_tracer.tc test as
 unresolved if the test module does not exist
Message-ID: <20200505090912.7114f420@gandalf.local.home>
In-Reply-To: <20200505101445.27063-1-po-hsu.lin@canonical.com>
References: <20200505101445.27063-1-po-hsu.lin@canonical.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


You keep forgetting to Cc Shuah's other email.

On Tue,  5 May 2020 18:14:45 +0800
Po-Hsu Lin <po-hsu.lin@canonical.com> wrote:

> The UNRESOLVED state is much more apporiate than the UNSUPPORTED state
> for the absence of the test module, as it matches "test was set up
> incorrectly" situation in the README file.
> 
> A possible scenario is that the function was enabled (supported by the
> kernel) but the module was not installed properly, in this case we
> cannot call this as UNSUPPORTED.
> 
> This change also make it consistent with other module-related tests
> in ftrace.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Shuah,

Can you take this after Masami gives his ack (if he does that is).

Thanks,

-- Steve

> 
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>  .../testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
> index cbd1743..2b82c80e 100644
> --- a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
> +++ b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
> @@ -17,7 +17,14 @@ unsup() { #msg
>      exit_unsupported
>  }
>  
> -modprobe $MOD || unsup "$MOD module not available"
> +unres() { #msg
> +    reset_tracer
> +    rmmod $MOD || true
> +    echo $1
> +    exit_unresolved
> +}
> +
> +modprobe $MOD || unres "$MOD module not available"
>  rmmod $MOD
>  
>  grep -q "preemptoff" available_tracers || unsup "preemptoff tracer not enabled"

