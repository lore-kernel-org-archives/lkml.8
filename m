Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA35EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 876C2204EA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593757230;
	bh=drv3cW96o+M2dW4bK+ubCTGx/ycpAvvggUk3cHTkfIQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mSewMsZJMlpoN/wQ/ouQ5O1Qrkys4GXhnSic6MEnV1Pon35pkpMf7Z0Cz5/U4G2/y
	 /Ic6MUMmnPQdeVDxKlfztQwtapjF0J9s8MiXIjrZGWS30kNwx3y44jM4wRxW6ga4cI
	 nzl+Hs4bXs6EO+KPRW3cQ8gUmeEgOPe3gasuPGt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgGCGU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 02:20:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37631 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgGCGU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 02:20:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id o2so32552035wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 23:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TKEHFmW5PoKwUEizfUZ1NRPfkPR7fHNgTYGl98X6WEs=;
        b=R9S3TO1Ji+XPB5uFGukX8Tly5LAOReSNIQNRAvFLjoGaDNiFDDTi8vM/re78aj1mLf
         BwBwxAUgxVyh9wDcn7dqdrGy0E8UvEMVhQvpEpkg2zhnLGiKy7z2MR3ImKb9rzFBNaNt
         FtHU4pZAyWZnEsM8i4ndGZkBK6QsDn27H2NVBgiRLqJQ+lXduNBHwyuWmwdRwasohCV7
         Tyhx3Hq9R2gWT4soVH4HGRKH6qYDYbirU1IJZnqBOUUDHpgL0rMYEKWX5dLCbZOaTjbU
         Xq3ku1ElXISYQL2QmL9xVNv8CtYpS3I4NWydxy3EIN7AyIVAfyc4AdgKxRYrTiXcKMEi
         IqCA==
X-Gm-Message-State: AOAM532GP2ogq9xuA2ZdkVTqzQfvfn+hp3UReikugvd6/RuILnpir3+l
        PY9zWakN/bL6EftFJVmzC+c6NZG4A9aIAP9iG08=
X-Google-Smtp-Source: ABdhPJznbbh73QjvNOcdAp0OnOsSmx2LmdX7bpQlU4BIbZ3Q6JxEb0Dw+OA1BQdUJF/TpzIu7DQ04qSgiqgy0wmidUI=
X-Received: by 2002:a1c:6308:: with SMTP id x8mr36575458wmb.92.1593757226326;
 Thu, 02 Jul 2020 23:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200627133654.64863-1-changbin.du@gmail.com> <20200627133654.64863-8-changbin.du@gmail.com>
In-Reply-To: <20200627133654.64863-8-changbin.du@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 3 Jul 2020 15:20:15 +0900
Message-ID: <CAM9d7cgSniMTtFY4Mn9=M_C15cQSk4=YtaqZvAzj53brqed3hw@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] perf ftrace: show trace column header
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 10:38 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> This makes perf-ftrace display column header before printing trace.
>
> $ sudo perf ftrace
> \# tracer: function
> \#
> \# entries-in-buffer/entries-written: 0/0   #P:8
> \#
> \#           TASK-PID     CPU#   TIMESTAMP  FUNCTION
> \#              | |         |       |         |
>            <...>-9246  [006]  10726.262760: mutex_unlock <-rb_simple_write
>            <...>-9246  [006]  10726.262764: __fsnotify_parent <-vfs_write
>            <...>-9246  [006]  10726.262765: fsnotify <-vfs_write
>            <...>-9246  [006]  10726.262766: __sb_end_write <-vfs_write
>            <...>-9246  [006]  10726.262767: fpregs_assert_state_consistent <-do_syscall_64

You'd better indent the example output by 2 spaces to prevent
the # signs commented out.

Thanks
Namhyung


>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/builtin-ftrace.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index e45496012611..686d744d5025 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -430,6 +430,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>         fcntl(trace_fd, F_SETFL, O_NONBLOCK);
>         pollfd.fd = trace_fd;
>
> +       /* display column headers */
> +       read_tracing_file_to_stdout("trace");
> +
>         if (!ftrace->initial_delay) {
>                 if (write_tracing_file("tracing_on", "1") < 0) {
>                         pr_err("can't enable tracing\n");
> --
> 2.25.1
>
