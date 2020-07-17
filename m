Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429D6C433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B57720704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgGQRBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:01:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbgGQRB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:01:28 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBD9E207DD;
        Fri, 17 Jul 2020 17:01:26 +0000 (UTC)
Date:   Fri, 17 Jul 2020 13:01:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/17] perf ftrace: add option -t/--tid to filter by
 thread id
Message-ID: <20200717130124.54e85349@oasis.local.home>
In-Reply-To: <20200717132650.i32oovllal22b35i@mail.google.com>
References: <20200711124035.6513-1-changbin.du@gmail.com>
        <20200711124035.6513-4-changbin.du@gmail.com>
        <20200716153630.GD374956@kernel.org>
        <20200717132650.i32oovllal22b35i@mail.google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020 21:26:50 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> On Thu, Jul 16, 2020 at 12:36:30PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Sat, Jul 11, 2020 at 08:40:21PM +0800, Changbin Du escreveu:  
> > > This allows us to trace single thread instead of the whole process.
> > > 
> > > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > > ---
> > >  tools/perf/Documentation/perf-ftrace.txt | 4 ++++
> > >  tools/perf/builtin-ftrace.c              | 2 ++
> > >  2 files changed, 6 insertions(+)
> > > 
> > > diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> > > index d79560dea19f..e204bf6d50d8 100644
> > > --- a/tools/perf/Documentation/perf-ftrace.txt
> > > +++ b/tools/perf/Documentation/perf-ftrace.txt
> > > @@ -38,6 +38,10 @@ OPTIONS
> > >  --pid=::
> > >  	Trace on existing process id (comma separated list).
> > >  
> > > +-t::
> > > +--tid=::
> > > +	Trace on existing thread id (comma separated list).
> > > +  
> > 
> > 
> > Humm, I just  tried:
> > 
> > [root@five ~]# yes > /dev/null &
> > [1] 18265
> > [root@five ~]# perf ftrace --tid 18265
> > ^C[root@five ~]#
> > 
> > After waiting for a while, nothing, what am I doing wrong?
> >  
> I got it wrong. Currently ftrace only can filter by pid. If the pid is not
> the main thread it won't work.

Wait what?

The "pid" for ftrace is really a "task id" which is a thread id.

[root@bxtest ~]# yes > /dev/null &
[1] 6799
[root@bxtest ~]# trace-cmd record -e all -P 6799
Hit Ctrl^C to stop recording
^CCPU 0: 3573031 events lost
CPU0 data recorded at offset=0x838000
    627675136 bytes in size
CPU1 data recorded at offset=0x25ed1000
    0 bytes in size
CPU2 data recorded at offset=0x25ed1000
    0 bytes in size
CPU3 data recorded at offset=0x25ed1000
    0 bytes in size
CPU4 data recorded at offset=0x25ed1000
    0 bytes in size
CPU5 data recorded at offset=0x25ed1000
    0 bytes in size
CPU6 data recorded at offset=0x25ed1000
    0 bytes in size
CPU7 data recorded at offset=0x25ed1000
    0 bytes in size
[root@bxtest ~]# trace-cmd report | head 
CPU 1 is empty
CPU 2 is empty
CPU 3 is empty
CPU 4 is empty
CPU 5 is empty
CPU 6 is empty
CPU 7 is empty
cpus=8
             yes-6799  [000] 67825.580902: sys_exit:             NR 1 = 8192
             yes-6799  [000] 67825.580903: sys_exit_write:       0x2000


What's different about tid vs pid?

-- Steve



> 
> So this patch makes no sense. will drop this.
> 
