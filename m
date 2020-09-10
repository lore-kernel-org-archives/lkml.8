Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C872CC2D0A8
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87E2520BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599704042;
	bh=YEfWR7IEaqpfFI93JDRFeAj2BOIyU5cOkPCI9C/TtrM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=XRgJKdOKxmW+J71WYqk7qug4kfXpwBJk7MbCrA4T8+YL6ah0JTUhtfBG5R2bokZ66
	 4+r9+hFtfifvgVqKhS3unUuUB92hCERLDYeVdFzYpyHf0VvPgiUJAePmwvwgJAp6ew
	 /2rnTCPBTsYk30ybbwqL9hKywZmGY1TS1OUVv3PE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgIJCNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:13:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730293AbgIJCFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:05:30 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A20E22208;
        Thu, 10 Sep 2020 00:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599698967;
        bh=YEfWR7IEaqpfFI93JDRFeAj2BOIyU5cOkPCI9C/TtrM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tmmKd3yHd58nbE9ocQ5k/aIp8qRZXpLBtS0FOw4HyBRApEWn4ol78gscrpe66XFgH
         avoRg+gmM2VxlWpWt/p0GSIxo/c3KBLwerCB/17nWWPjp/zPltr4yB/SSHfrVrUCrE
         /tXojWCMkETu0nBQUkIid9e9nS/3CWv+k62Y+tb0=
Date:   Thu, 10 Sep 2020 09:49:23 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2 4/6] tracing/kprobes: Support perf-style return probe
Message-Id: <20200910094923.42a09f8f75f84cdbeac743c8@kernel.org>
In-Reply-To: <159894703070.1478826.15755889933157654537.stgit@devnote2>
References: <159894698993.1478826.2813843560314595660.stgit@devnote2>
        <159894703070.1478826.15755889933157654537.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  1 Sep 2020 16:57:10 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Support perf-style return probe ("SYMBOL%return") in kprobe events.
> This will allow boot-time tracing user to define a return probe event.
> 

Hmm, I think I should add this for uprobe event too.
I'll update the series.

Thank you,

> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_kprobe.c |   21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index aefb6065b508..391361b67c8f 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -709,6 +709,18 @@ static inline void sanitize_event_name(char *name)
>  			*name = '_';
>  }
>  
> +static inline bool split_return_suffix(char *symbol)
> +{
> +	char *p = strchr(symbol, '%');
> +
> +	if (p && !strcmp(p, "%return")) {
> +		*p = '\0';
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int trace_kprobe_create(int argc, const char *argv[])
>  {
>  	/*
> @@ -717,6 +729,9 @@ static int trace_kprobe_create(int argc, const char *argv[])
>  	 *      p[:[GRP/]EVENT] [MOD:]KSYM[+OFFS]|KADDR [FETCHARGS]
>  	 *  - Add kretprobe:
>  	 *      r[MAXACTIVE][:[GRP/]EVENT] [MOD:]KSYM[+0] [FETCHARGS]
> +	 *    Or
> +	 *      p:[GRP/]EVENT] [MOD:]KSYM[+0]%return [FETCHARGS]
> +	 *
>  	 * Fetch args:
>  	 *  $retval	: fetch return value
>  	 *  $stack	: fetch stack address
> @@ -746,7 +761,6 @@ static int trace_kprobe_create(int argc, const char *argv[])
>  	switch (argv[0][0]) {
>  	case 'r':
>  		is_return = true;
> -		flags |= TPARG_FL_RETURN;
>  		break;
>  	case 'p':
>  		break;
> @@ -804,12 +818,17 @@ static int trace_kprobe_create(int argc, const char *argv[])
>  		symbol = kstrdup(argv[1], GFP_KERNEL);
>  		if (!symbol)
>  			return -ENOMEM;
> +
> +		is_return = split_return_suffix(symbol) || is_return;
> +
>  		/* TODO: support .init module functions */
>  		ret = traceprobe_split_symbol_offset(symbol, &offset);
>  		if (ret || offset < 0 || offset > UINT_MAX) {
>  			trace_probe_log_err(0, BAD_PROBE_ADDR);
>  			goto parse_error;
>  		}
> +		if (is_return)
> +			flags |= TPARG_FL_RETURN;
>  		if (kprobe_on_func_entry(NULL, symbol, offset))
>  			flags |= TPARG_FL_FENTRY;
>  		if (offset && is_return && !(flags & TPARG_FL_FENTRY)) {
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
