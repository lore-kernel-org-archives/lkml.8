Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4EDC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008C12074F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586263190;
	bh=XH9zJ5yiY4ifu82bYHdYQnEITGn7FUESKDANa29ms9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dIfpNG8AJQlrv/ozAsUrwTh827ckp/YZcLVDI0uuCGvYfKnIRLbGjJukNWfNsMdF7
	 STreQeoxYlBJWOiooXa8neo7CIq/ghXwGMS/2uX9kBR5EuWUhS6jRWHtlHRziqVbEO
	 6+kv+EARDB+HOaj1Sul6nCKyOzLJnbkOWC7HF+Uw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgDGMjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 08:39:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728146AbgDGMjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 08:39:48 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1559720719;
        Tue,  7 Apr 2020 12:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586263187;
        bh=XH9zJ5yiY4ifu82bYHdYQnEITGn7FUESKDANa29ms9s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C+QFbXk1Ff9ofGt7Aqur1WzmVUFJGLVDKaZhqxSqZhwwlRq7VK1z2aYbUoUtI2p46
         Zp5fUZgaMgpayWcschM9P8F/CsNJhcNkAnK32UY6LADBFODw2xT3hCnzIwJEUkE3pC
         qP4jIB/c/adUI/RV91N8NRfROJGiSAmoKHKFkLoQ=
Date:   Tue, 7 Apr 2020 21:39:43 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <andi@firstfloor.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: perf probe + uprobes missing events
Message-Id: <20200407213943.3a92e040d4ce30dc55e9aa1f@kernel.org>
In-Reply-To: <20200406145356.GA32649@kernel.org>
References: <20200406145356.GA32649@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Mon, 6 Apr 2020 11:53:56 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Masami,
> 
> 	I'm trying to use 'perf probe' to debug 'perf test', but I'm not
> getting repeatable results, take a look:
> 
> I'm trying to figure out which expresssions are _really_ being tested
> byu the 'perf test expr' testcase, so I added a probe to the
> expr__parse() routine, asking for the expr string to be printed:
> 
> [root@five ~]# perf probe -x ~/bin/perf -L expr__parse
> <expr__parse@/home/acme/git/perf/tools/perf/util/expr.c:0>
>       0  int expr__parse(double *final_val, struct expr_parse_ctx *ctx, const char *expr, int runtime)
>       1  {
>       2         return __expr__parse(final_val, ctx, expr, EXPR_PARSE, runtime) ? -1 : 0;
>       3  }
> 
>          static bool
>          already_seen(const char *val, const char *one, const char **other,
> 
> [root@five ~]#
> 
> [root@five ~]# perf probe -x ~/bin/perf expr__parse expr:string
> Target program is compiled without optimization. Skipping prologue.
> Probe on address 0x5cb11b to force probing at the function entry.
> 
> Added new event:
>   probe_perf:expr__parse (on expr__parse in /home/acme/bin/perf with expr:string)
> 
> You can now use it in all perf tools, such as:
> 
> 	perf record -e probe_perf:expr__parse -aR sleep 1
> 
> [root@five ~]#

Hmm, These operation looks good to me. However,

> 
> [root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
>  7: Simple expression parser                              : Ok
>      0.000 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1")
>      0.015 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO+BAR")
>      0.018 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(BAR/2)%2")
>      0.020 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1 - -4")
>      0.023 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(FOO-1)*2 + (BAR/2)%2 - -4")
>      0.026 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 | 1")
>      0.029 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 & 1")
>      0.031 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "min(1,2) + 1")
>      0.034 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "max(1,2) + 1")
>      0.036 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1 if 3*4 else 0")
>      0.039 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO/0")
>      0.041 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "BAR/")
> [root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
>  7: Simple expression parser                              : Ok
>      0.000 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1")
>      0.021 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO+BAR")
>      0.025 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(BAR/2)%2")
>      0.029 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1 - -4")
>      0.033 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(FOO-1)*2 + (BAR/2)%2 - -4")
>      0.041 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 | 1")
>      0.044 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 & 1")
> [root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
>  7: Simple expression parser                              : Ok
>      0.000 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1")
>      0.020 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO+BAR")
>      0.025 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(BAR/2)%2")
>      0.029 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1 - -4")
>      0.032 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(FOO-1)*2 + (BAR/2)%2 - -4")
>      0.037 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 | 1")
>      0.040 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 & 1")
>      0.043 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "min(1,2) + 1")
>      0.046 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "max(1,2) + 1")
>      0.049 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1 if 3*4 else 0")
>      0.053 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO/0")
>      0.056 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "BAR/")
> [root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
>  7: Simple expression parser                              : Ok
> [root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
>  7: Simple expression parser                              : Ok
> [root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
>  7: Simple expression parser                              : Ok
> [root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
>  7: Simple expression parser                              : Ok
> [root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
>  7: Simple expression parser                              : Ok
>      0.000 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1")
>      0.014 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO+BAR")
>      0.017 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(BAR/2)%2")
>      0.021 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1 - -4")
>      0.024 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(FOO-1)*2 + (BAR/2)%2 - -4")
>      0.030 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 | 1")
>      0.032 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 & 1")
>      0.035 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "min(1,2) + 1")
>      0.038 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "max(1,2) + 1")
>      0.040 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1 if 3*4 else 0")
>      0.044 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO/0")
>      0.046 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "BAR/")
> [root@five ~]#

Strange. This seems bug in uprobes. Did you try to enable ftrace event
and dump ftrace trace buffer for each time?
Also, it may help if you dump the /sys/kernel/debug/tracing/uprobe_profile.
It may indicate how many times the probe is hit and missed.

OK, I'll also try to reproduce it.

Thank you,

> 
> 
> Do you have any idea why that happens?
> 
> - Arnaldo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
