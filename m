Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5FCC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31996208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597406220;
	bh=hkpf/361hnS8vR6XPC1zBp4odiSk8ry8EEsr8Lr4bWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CBFl+0G/vBNR+Wiv7wROLzPjZPfNewAaUytwy7TAjZKtM9Kc2cbUhOpKfodeqz1/j
	 PrpKouy5IlAkjekJCSs9ALt31HTy7eOlzg74q4Spb+CRzrD8H8Ses/xLrooOyT5lpf
	 xVG79pTNfAeJGCfCUneLhrXwQeRyW0Rc+xn7J7jE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgHNL47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:56:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbgHNL45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:56:57 -0400
Received: from quaco.ghostprotocols.net (177.207.136.251.dynamic.adsl.gvt.net.br [177.207.136.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1177F2087D;
        Fri, 14 Aug 2020 11:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597406217;
        bh=hkpf/361hnS8vR6XPC1zBp4odiSk8ry8EEsr8Lr4bWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MhYFmMmTIMdh7RUwKBPRYU9OKkFP6e+UC6pobd+PVuasUyc2Q/D9wxuZ/94Xmembz
         5GL9DkdtjvTeXQUwepFo/ETQDZhNly4BKWbJV6v5/HXOdsAEsTvu2Ao4mhH3VF+Fxe
         2Lb3vuAoquryaLGPghwteznnM02i9qlx41cr8laY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 199124097F; Fri, 14 Aug 2020 08:56:55 -0300 (-03)
Date:   Fri, 14 Aug 2020 08:56:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 05/18] perf ftrace: show trace column header
Message-ID: <20200814115655.GU13995@kernel.org>
References: <20200808023141.14227-1-changbin.du@gmail.com>
 <20200808023141.14227-6-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200808023141.14227-6-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Aug 08, 2020 at 10:31:28AM +0800, Changbin Du escreveu:
> This makes perf-ftrace display column header before printing trace.
> 
>   $ sudo perf ftrace
>   # tracer: function
>   #
>   # entries-in-buffer/entries-written: 0/0   #P:8
>   #
>   #            TASK-PID     CPU#   TIMESTAMP  FUNCTION
>   #              | |         |       |         |
>              <...>-9246  [006]  10726.262760: mutex_unlock <-rb_simple_write
>              <...>-9246  [006]  10726.262764: __fsnotify_parent <-vfs_write
>              <...>-9246  [006]  10726.262765: fsnotify <-vfs_write
>              <...>-9246  [006]  10726.262766: __sb_end_write <-vfs_write
>              <...>-9246  [006]  10726.262767: fpregs_assert_state_consistent <-do_syscall_64

We have:

  # perf report -h header
  
   Usage: perf report [<options>]
  
          --header          Show data header.
          --header-only     Show only data header.
  
  #

So perhaps we should have those as well, in the 'ftrace' case one would
perhaps want to use --no-header, for instance, to do some scripting
parsing just the trace lines.

- Arnaldo
 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/builtin-ftrace.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index a3a4f4be9dde..39c694be2b71 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -435,6 +435,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  	fcntl(trace_fd, F_SETFL, O_NONBLOCK);
>  	pollfd.fd = trace_fd;
>  
> +	/* display column headers */
> +	read_tracing_file_to_stdout("trace");
> +
>  	if (write_tracing_file("tracing_on", "1") < 0) {
>  		pr_err("can't enable tracing\n");
>  		goto out_close_fd;
> -- 
> 2.25.1
> 

-- 

- Arnaldo
