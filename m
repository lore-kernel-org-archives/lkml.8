Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1B5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A51E92065F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594912876;
	bh=SXeEMoJ/59zvaGyG5fnb27yUwa2EZ1WO9ZcP62J6ujo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nIisSwiQNfToHjmF8bi4Em0m6e1toeof9Sz5eZj6qDqCi52o7iXd4KCpE2OjohKqn
	 b+ARd+C4aPnWWl6jreLsA9PIqCJ7eItcISPX733UumXJkBCFLaDvabVI/fRoaDSoIq
	 GkNICQqtccd1XIcnOCbOxW6dIKUxP4oboNcUrsfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgGPPVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:21:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728415AbgGPPVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:21:14 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE0C72063A;
        Thu, 16 Jul 2020 15:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594912873;
        bh=SXeEMoJ/59zvaGyG5fnb27yUwa2EZ1WO9ZcP62J6ujo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bt6/QE2Cq7xV7GYgHJIG0jK5xwg3TLMAaEKPmbPnjManCQo187yMHa43vsfPrUpN/
         3zKfM9q05T/IIT06d7PtfXOWlDRD++FSuzh480g4oH+e6cPc1mVUVTjIxmX+iG9c37
         arxYTfBwNbEDPyhCQDC0tRHxzkukxlGOi7pgQQNc=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DF362403C7; Thu, 16 Jul 2020 12:21:11 -0300 (-03)
Date:   Thu, 16 Jul 2020 12:21:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 02/17] perf ftrace: add option '-F/--funcs' to list
 available functions
Message-ID: <20200716152111.GB373728@kernel.org>
References: <20200711124035.6513-1-changbin.du@gmail.com>
 <20200711124035.6513-3-changbin.du@gmail.com>
 <CAM9d7cjdMQzt6RXOnugoZ77Psu4Y=j9w07quxvtWqo0XagxL6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjdMQzt6RXOnugoZ77Psu4Y=j9w07quxvtWqo0XagxL6A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 13, 2020 at 10:49:40AM +0900, Namhyung Kim escreveu:
> Hello,
> 
> On Sat, Jul 11, 2020 at 9:42 PM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > This adds an option '-F/--funcs' to list all available functions to trace,
> > which is read from tracing file 'available_filter_functions'.
> >
> > $ sudo ./perf ftrace -F | head
> > trace_initcall_finish_cb
> > initcall_blacklisted
> > do_one_initcall
> > do_one_initcall
> > trace_initcall_start_cb
> > run_init_process
> > try_to_run_init_process
> > match_dev_by_label
> > match_dev_by_uuid
> > rootfs_init_fs_context
> >
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> >
> > ---
> > v2: option name '-l/--list-functions' -> '-F/--funcs'
> > ---
> >  tools/perf/Documentation/perf-ftrace.txt |  4 +++
> >  tools/perf/builtin-ftrace.c              | 43 ++++++++++++++++++++++++
> >  2 files changed, 47 insertions(+)
> >
> > diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> > index 952e46669168..d79560dea19f 100644
> > --- a/tools/perf/Documentation/perf-ftrace.txt
> > +++ b/tools/perf/Documentation/perf-ftrace.txt
> > @@ -30,6 +30,10 @@ OPTIONS
> >  --verbose=::
> >          Verbosity level.
> >
> > +-F::
> > +--funcs::
> > +        List all available functions to trace.
> > +
> >  -p::
> >  --pid=::
> >         Trace on existing process id (comma separated list).
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index 5f53da87040d..244cc8e6bd60 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -32,6 +32,7 @@ struct perf_ftrace {
> >         struct evlist           *evlist;
> >         struct target           target;
> >         const char              *tracer;
> > +       bool                    list_avail_functions;
> >         struct list_head        filters;
> >         struct list_head        notrace;
> >         struct list_head        graph_funcs;
> > @@ -127,6 +128,43 @@ static int append_tracing_file(const char *name, const char *val)
> >         return __write_tracing_file(name, val, true);
> >  }
> >
> > +static int read_tracing_file_to_stdout(const char *name)
> > +{
> > +       char buf[4096];
> > +       char *file;
> > +       int fd;
> > +       int ret = -1;
> > +
> > +       file = get_tracing_file(name);
> > +       if (!file) {
> > +               pr_debug("cannot get tracing file: %s\n", name);
> > +               return -1;
> > +       }
> > +
> > +       fd = open(file, O_RDONLY);
> > +       if (fd < 0) {
> > +               pr_debug("cannot open tracing file: %s: %s\n",
> > +                        name, str_error_r(errno, buf, sizeof(buf)));
> > +               goto out;
> > +       }
> > +
> > +       /* read contents to stdout */
> > +       while (true) {
> > +               int n = read(fd, buf, sizeof(buf));
> > +               if (n <= 0)
> > +                       goto out_close;
> > +               if (fwrite(buf, n, 1, stdout) != 1)
> > +                       goto out_close;
> > +       }
> > +       ret = 0;
> 
> As I said before, there's no break in the loop above
> so the ret can never be 0.

Yeah, this is clearly wrong, that ret = 0 will never be reached.

- Arnaldo
 
> Thanks
> Namhyung
> 
> > +
> > +out_close:
> > +       close(fd);
> > +out:
> > +       put_tracing_file(file);
> > +       return ret;
> > +}
> > +
> >  static int reset_tracing_cpu(void);
> >  static void reset_tracing_filters(void);
> >
> > @@ -301,6 +339,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >         signal(SIGCHLD, sig_handler);
> >         signal(SIGPIPE, sig_handler);
> >
> > +       if (ftrace->list_avail_functions)
> > +               return read_tracing_file_to_stdout("available_filter_functions");
> > +
> >         if (reset_tracing_files(ftrace) < 0) {
> >                 pr_err("failed to reset ftrace\n");
> >                 goto out;
> > @@ -470,6 +511,8 @@ int cmd_ftrace(int argc, const char **argv)
> >         const struct option ftrace_options[] = {
> >         OPT_STRING('t', "tracer", &ftrace.tracer, "tracer",
> >                    "tracer to use: function or function_graph (This option is deprecated)"),
> > +       OPT_BOOLEAN('F', "funcs", &ftrace.list_avail_functions,
> > +                   "Show available functions to filter"),
> >         OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
> >                    "trace on existing process id"),
> >         OPT_INCR('v', "verbose", &verbose,
> > --
> > 2.25.1
> >

-- 

- Arnaldo
