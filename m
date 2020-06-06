Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CD7C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A01FD20723
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvuzJmYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgFFOh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 10:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgFFOh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 10:37:28 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FA7C03E96A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 07:37:28 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a127so6357174pfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 07:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E1Fv+s5L2F/uAnknDc396R1kc5K7SHvRSPFaa7r0VFU=;
        b=rvuzJmYOJDTv0MkjZegUyK7QbqlrXkrOg9GtGVZJqHBSK3dy30tJoTKLQsBLJsDLT5
         OIPzGrUFieVpKy2qgtP1KkKMVaOZpH3M2o4/cWC4+nFVTb9PgAKEtvV6431Lu7afhhCv
         4kAD/JMDvvR0uGEoT9lH86qfTgF2TZDkTbV/SfZGvejnPDA6nEFvQop2sn3nPVQ2X6+8
         29/AUie7rpsRRBjSbXwzxkpy5rFREgLh0L2S4pj/Bi1sE8ySvifiBOcwnbItbA6he8ke
         9YFMoayxHfJsa+q1IuWGIamyqJUWYUuC3xoPBSTOhAasZxWgL4QxnlbFE8X4IE9Q7wp0
         8riQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E1Fv+s5L2F/uAnknDc396R1kc5K7SHvRSPFaa7r0VFU=;
        b=ml6edQIvW79YsqKeLma9ZD6lEbj/tJf71kkUjD1uJE0+goq6ngOABEKKmasIMepCU3
         A2FzY/xBx9x0d/oouNOe+zZbUrBpmoB6W/QfnL5XOzwvcMkXPMR4jVW7+6TZ2R4RUiUx
         a+D1Mk4Puv3ECY9RxIZ/1dWg4ULrWk28n0L68fJ58j+NchnDTWIHsx33X85prAGUb+Ml
         lCCSgWaR3fYUTL/A8FYJUJ49yY+QgeYZAVXHmx4xzzI8Xyq9ddLoJbwU03JhVpiepefL
         47OxzfB9i00X2Aa1iR26h2YHBrx0t42X8Va8a25YtZuT0ogfJokRjyBtOd4F15yhTdc+
         tLrg==
X-Gm-Message-State: AOAM533fc7nTx3O3nrBqs3VPRoVJdwjvXQk6MhRYT7mIsrBidrYI/Ikx
        tb/1yHgpSFTp9l3g7gbp6bA=
X-Google-Smtp-Source: ABdhPJxbYIZgWC6Y9A6NpEYf3wb9yXChpOi8xvZTUOB1E+gDsgeRDItzuMgmV3WUpctdoYzhuSVsew==
X-Received: by 2002:a63:d652:: with SMTP id d18mr13998597pgj.164.1591454247770;
        Sat, 06 Jun 2020 07:37:27 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id cm13sm10911911pjb.5.2020.06.06.07.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 07:37:26 -0700 (PDT)
Date:   Sat, 6 Jun 2020 22:37:17 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/19] perf ftrace: show trace column header
Message-ID: <20200606143717.pxtjbx5hrpuwp4hs@mail.google.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-16-changbin.du@gmail.com>
 <20200520211101.GD32678@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520211101.GD32678@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 06:11:01PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, May 10, 2020 at 11:06:24PM +0800, Changbin Du escreveu:
> > This makes perf-ftrace display column header before printing trace.
> 
> [acme@five perf]$ perf report -h header
> 
>  Usage: perf report [<options>]
> 
>         --header          Show data header.
>         --header-only     Show only data header.
> 
> [acme@five perf]$
> 
> Perhaps there is value in --header-only to show the default that will be
> setup when using some set of options.
> 
Arnaldo, what is the '--header-only' option used for? As for ftrace, the header
format is different for different trace options.

> - Arnaldo
> 
> > $ sudo perf ftrace
> > \# tracer: function
> > \#
> > \# entries-in-buffer/entries-written: 0/0   #P:8
> > \#
> > \#           TASK-PID     CPU#   TIMESTAMP  FUNCTION
> > \#              | |         |       |         |
> >            <...>-9246  [006]  10726.262760: mutex_unlock <-rb_simple_write
> >            <...>-9246  [006]  10726.262764: __fsnotify_parent <-vfs_write
> >            <...>-9246  [006]  10726.262765: fsnotify <-vfs_write
> >            <...>-9246  [006]  10726.262766: __sb_end_write <-vfs_write
> >            <...>-9246  [006]  10726.262767: fpregs_assert_state_consistent <-do_syscall_64
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/perf/builtin-ftrace.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index 64c22f367ba2..0b39b6a88026 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -614,6 +614,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >  	fcntl(trace_fd, F_SETFL, O_NONBLOCK);
> >  	pollfd.fd = trace_fd;
> >  
> > +	/* display column headers */
> > +	read_tracing_file_to_stdout("trace");
> > +
> >  	if (write_tracing_file("tracing_on", "1") < 0) {
> >  		pr_err("can't enable tracing\n");
> >  		goto out_close_fd;
> > -- 
> > 2.25.1
> > 
> 
> -- 
> 
> - Arnaldo

-- 
Cheers,
Changbin Du
