Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249A7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E910D20CC7
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593779760;
	bh=tL3CENMyMSVhcnuZZSAH3vg2XT4EA/QiHNOa1OKF+Co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LQnEGdJ3QxM078h8lTm3qi3866shKE02CeYc4qHv5NjQ28OooO3KQayY8NocuR5HI
	 PXocmkIcH58tefYQ168FFCIUuglLTmTqF3h1BIhiDip7ZcpB/DH/npqxom+V0i5BOm
	 1Aa0SCkpC+zBRjPvT0838g7ZPhvJRtUPeRpGmF+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgGCMf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 08:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgGCMf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 08:35:57 -0400
Received: from quaco.ghostprotocols.net (unknown [179.162.131.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B17C120782;
        Fri,  3 Jul 2020 12:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593779757;
        bh=tL3CENMyMSVhcnuZZSAH3vg2XT4EA/QiHNOa1OKF+Co=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U1v1esYl4bZsVqCg1P1m9wHjIWH+ytQux5tZ4Vv8UBJ1GGc3CNRIFOEbCBF0GOxQg
         Hv+q65nvcxBVfP3xrZE2oKbtsyhL5WHpd6Hc0GmH6M82Q4sa+Kh92ROkzfulcQAqqr
         t0vwrH6ZYHHFywIVtR6V0yPzZ4VOW5dwrQLxHpTQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 584A3405FF; Fri,  3 Jul 2020 09:35:53 -0300 (-03)
Date:   Fri, 3 Jul 2020 09:35:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 07/15] perf ftrace: show trace column header
Message-ID: <20200703123553.GH1320@kernel.org>
References: <20200627133654.64863-1-changbin.du@gmail.com>
 <20200627133654.64863-8-changbin.du@gmail.com>
 <CAM9d7cgSniMTtFY4Mn9=M_C15cQSk4=YtaqZvAzj53brqed3hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgSniMTtFY4Mn9=M_C15cQSk4=YtaqZvAzj53brqed3hw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 03, 2020 at 03:20:15PM +0900, Namhyung Kim escreveu:
> On Sat, Jun 27, 2020 at 10:38 PM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > This makes perf-ftrace display column header before printing trace.
> >
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
> 
> You'd better indent the example output by 2 spaces to prevent
> the # signs commented out.

Yes, all examples need to be two spaces to the right, to avoid things
like that.

- Arnaldo
 
> Thanks
> Namhyung
> 
> 
> >
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/perf/builtin-ftrace.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index e45496012611..686d744d5025 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -430,6 +430,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >         fcntl(trace_fd, F_SETFL, O_NONBLOCK);
> >         pollfd.fd = trace_fd;
> >
> > +       /* display column headers */
> > +       read_tracing_file_to_stdout("trace");
> > +
> >         if (!ftrace->initial_delay) {
> >                 if (write_tracing_file("tracing_on", "1") < 0) {
> >                         pr_err("can't enable tracing\n");
> > --
> > 2.25.1
> >

-- 

- Arnaldo
