Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDDBC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E271620722
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZO/CUUt3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbgEKPE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:04:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47096 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728556AbgEKPE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589209497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i4Ig4HI/b6UTo4vh74jJARXfF3GtCKRDYqpoZAgLyzg=;
        b=ZO/CUUt39SUoLLU71tzBniQDof2GCndso55vmfRvK/11no6djii1+iIEPN5Yz/mwkap7QX
        VdrARVZyw42mbDxwdwPDTAmX5HkzKt9Qag2EOaJ4HFKelUqu7+tk+W7hVkJN8/Ac7w5Hiv
        gEi7/COgYlqebuq8yKX06zt0FY5cX/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-YgUEhLcnPyiFzc62lCEqmA-1; Mon, 11 May 2020 11:04:51 -0400
X-MC-Unique: YgUEhLcnPyiFzc62lCEqmA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7781418FF664;
        Mon, 11 May 2020 15:04:49 +0000 (UTC)
Received: from sandy.ghostprotocols.net (unknown [10.3.128.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A91357834B;
        Mon, 11 May 2020 15:04:47 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 5723B1E1; Mon, 11 May 2020 12:04:43 -0300 (BRT)
Date:   Mon, 11 May 2020 12:04:43 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: Re: [PATCH 7/8] perf record: Introduce --switch-output-event
Message-ID: <20200511150443.GB9116@redhat.com>
References: <20200429131106.27974-1-acme@kernel.org>
 <20200429131106.27974-8-acme@kernel.org>
 <CAP-5=fWX4V6gzma_NeWh-niUqMq8vDXU77p9zQZKF6wSP0BPbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWX4V6gzma_NeWh-niUqMq8vDXU77p9zQZKF6wSP0BPbQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 29, 2020 at 10:25:52AM -0700, Ian Rogers escreveu:
> On Wed, Apr 29, 2020 at 6:14 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > Now we can use it with --overwrite to have a flight recorder mode that
> > gets snapshot requests from arbitrary events that are processed in the
> > side band thread together with the PERF_RECORD_BPF_EVENT processing.
> >
> > Example:
> >
> > To collect scheduler events until a recvmmsg syscall happens, system
> > wide:
> >
> >   [root@five a]# rm -f perf.data.2020042717*
> >   [root@five a]# perf record --overwrite -e sched:*switch,syscalls:*recvmmsg --switch-output-event syscalls:sys_enter_recvmmsg
> >   [ perf record: dump data: Woken up 1 times ]
> >   [ perf record: Dump perf.data.2020042717585458 ]
> >   [ perf record: dump data: Woken up 1 times ]
> >   [ perf record: Dump perf.data.2020042717590235 ]
> >   [ perf record: dump data: Woken up 1 times ]
> >   [ perf record: Dump perf.data.2020042717590398 ]
> >   ^C[ perf record: Woken up 1 times to write data ]
> >   [ perf record: Dump perf.data.2020042717590511 ]
> >   [ perf record: Captured and wrote 7.244 MB perf.data.<timestamp> ]
> >
> > So in the above case we had 3 snapshots, the fourth was forced by
> > control+C:
> >
> >   [root@five a]# ls -la
> >   total 20440
> >   drwxr-xr-x.  2 root root    4096 Apr 27 17:59 .
> >   dr-xr-x---. 12 root root    4096 Apr 27 17:46 ..
> >   -rw-------.  1 root root 3936125 Apr 27 17:58 perf.data.2020042717585458
> >   -rw-------.  1 root root 5074869 Apr 27 17:59 perf.data.2020042717590235
> >   -rw-------.  1 root root 4291037 Apr 27 17:59 perf.data.2020042717590398
> >   -rw-------.  1 root root 7617037 Apr 27 17:59 perf.data.2020042717590511
> >   [root@five a]#
> >
> > One can make this more precise by adding the switch output event to the
> > main -e events list, as since this is done asynchronously, a few events
> > after the signal event will appear in the snapshots, as can be seen
> > with:
> >
> >   [root@five a]# rm -f perf.data.20200427175*
> >   [root@five a]# perf record --overwrite -e sched:*switch,syscalls:*recvmmsg --switch-output-event syscalls:sys_enter_recvmmsg
> >   [ perf record: dump data: Woken up 1 times ]
> >   [ perf record: Dump perf.data.2020042718024203 ]
> >   [ perf record: dump data: Woken up 1 times ]
> >   [ perf record: Dump perf.data.2020042718024301 ]
> >   [ perf record: dump data: Woken up 1 times ]
> >   [ perf record: Dump perf.data.2020042718024484 ]
> >   ^C[ perf record: Woken up 1 times to write data ]
> >   [ perf record: Dump perf.data.2020042718024562 ]
> >   [ perf record: Captured and wrote 7.337 MB perf.data.<timestamp> ]
> >   [root@five a]# perf script -i perf.data.2020042718024203 | tail -15
> >        PacerThread 148586 [005] 122.830729: sched:sched_switch: prev_comm=PacerThread prev_pid=148586...
> >            swapper      0 [000] 122.833588: sched:sched_switch: prev_comm=swapper/0 prev_pid=...
> >     NetworkManager   1251 [000] 122.833619: syscalls:sys_enter_recvmmsg: fd: 0x0000001c, mmsg: 0x7ffe83054a1...
> >            swapper      0 [002] 122.833624: sched:sched_switch: prev_comm=swapper/2 prev_pid=...
> >            swapper      0 [003] 122.833624: sched:sched_switch: prev_comm=swapper/3 prev_pid=...
> >     NetworkManager   1251 [000] 122.833626: syscalls:sys_exit_recvmmsg: 0x1
> >    kworker/3:3-eve 158946 [003] 122.833628: sched:sched_switch: prev_comm=kworker/3:3 prev_pid=15894...
> >            swapper      0 [004] 122.833641: sched:sched_switch: prev_comm=swapper/4 prev_pid=...
> >     NetworkManager   1251 [000] 122.833642: sched:sched_switch: prev_comm=NetworkManage...
> >               perf 228273 [002] 122.833645: sched:sched_switch: prev_comm=perf prev_pid=22827...
> >            swapper      0 [011] 122.833646: sched:sched_switch: prev_comm=swapper/1...
> >            swapper      0 [002] 122.833648: sched:sched_switch: prev_comm=swapper/...
> >    kworker/0:2-eve 207387 [000] 122.833648: sched:sched_switch: prev_comm=kworker/0:2 prev_pid=20738...
> >    kworker/2:3-eve 232038 [002] 122.833652: sched:sched_switch: prev_comm=kworker/2:3 prev_pid=23203...
> >               perf 235825 [003] 122.833653: sched:sched_switch: prev_comm=perf prev_pid=23582...
> >   [root@five a]#
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Song Liu <songliubraving@fb.com>
> > Cc: Wang Nan <wangnan0@huawei.com>
> > Link: http://lore.kernel.org/lkml/20200427211935.25789-8-acme@kernel.org
> > Link: http://lore.kernel.org/lkml/20200428121601.GB2245@kernel.org
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/Documentation/perf-record.txt | 13 ++++++++
> >  tools/perf/builtin-record.c              | 41 +++++++++++++++++++++---
> >  2 files changed, 50 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> > index 6e8b4649307c..561ef55743e2 100644
> > --- a/tools/perf/Documentation/perf-record.txt
> > +++ b/tools/perf/Documentation/perf-record.txt
> > @@ -556,6 +556,19 @@ overhead. You can still switch them on with:
> >
> >    --switch-output --no-no-buildid  --no-no-buildid-cache
> >
> > +--switch-output-event::
> > +Events that will cause the switch of the perf.data file, auto-selecting
> > +--switch-output=signal, the results are similar as internally the side band
> > +thread will also send a SIGUSR2 to the main one.
> 
> I found this paragraph a little hard, perhaps:
> A list of events that when they occur cause the output perf.data file
> to be ended and a new one created. The signal event,
> --switch-output=signal, is auto-selected as SIGUSR2 is used internally
> by the thread monitoring the events.

Good suggestions (the one above and the one at the end of this message),
can you please put those in a formal patch?

Thanks,

- Arnaldo
 
> > +Uses the same syntax as --event, it will just not be recorded, serving only to
> > +switch the perf.data file as soon as the --switch-output event is processed by
> > +a separate sideband thread.
> > +
> > +This sideband thread is also used to other purposes, like processing the
> > +PERF_RECORD_BPF_EVENT records as they happen, asking the kernel for extra BPF
> > +information, etc.
> > +
> >  --switch-max-files=N::
> >
> >  When rotating perf.data with --switch-output, only keep N files.
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index ed2244847400..7a6a89972691 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -87,7 +87,9 @@ struct record {
> >         struct evlist   *evlist;
> >         struct perf_session     *session;
> >         struct evlist           *sb_evlist;
> > +       pthread_t               thread_id;
> >         int                     realtime_prio;
> > +       bool                    switch_output_event_set;
> >         bool                    no_buildid;
> >         bool                    no_buildid_set;
> >         bool                    no_buildid_cache;
> > @@ -1436,6 +1438,13 @@ static int record__synthesize(struct record *rec, bool tail)
> >         return err;
> >  }
> >
> > +static int record__process_signal_event(union perf_event *event __maybe_unused, void *data)
> > +{
> > +       struct record *rec = data;
> > +       pthread_kill(rec->thread_id, SIGUSR2);
> > +       return 0;
> > +}
> > +
> >  static int __cmd_record(struct record *rec, int argc, const char **argv)
> >  {
> >         int err;
> > @@ -1580,12 +1589,24 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
> >                 goto out_child;
> >         }
> >
> > -       if (!opts->no_bpf_event) {
> > -               rec->sb_evlist = evlist__new();
> > +       if (rec->sb_evlist != NULL) {
> > +               /*
> > +                * We get here if --switch-output-event populated the
> > +                * sb_evlist, so associate a callback that will send a SIGUSR2
> > +                * to the main thread.
> > +                */
> > +               evlist__set_cb(rec->sb_evlist, record__process_signal_event, rec);
> > +               rec->thread_id = pthread_self();
> > +       }
> >
> > +       if (!opts->no_bpf_event) {
> >                 if (rec->sb_evlist == NULL) {
> > -                       pr_err("Couldn't create side band evlist.\n.");
> > -                       goto out_child;
> > +                       rec->sb_evlist = evlist__new();
> > +
> > +                       if (rec->sb_evlist == NULL) {
> > +                               pr_err("Couldn't create side band evlist.\n.");
> > +                               goto out_child;
> > +                       }
> >                 }
> >
> >                 if (evlist__add_bpf_sb_event(rec->sb_evlist, &session->header.env)) {
> > @@ -2179,10 +2200,19 @@ static int switch_output_setup(struct record *rec)
> >         };
> >         unsigned long val;
> >
> > +       /*
> > +        * If we're using --switch-output-events, then we imply its
> > +        * --switch-output=signal, as we'll send a SIGUSR2 from the side band
> > +        *  thread to its parent.
> > +        */
> > +       if (rec->switch_output_event_set)
> > +               goto do_signal;
> > +
> >         if (!s->set)
> >                 return 0;
> >
> >         if (!strcmp(s->str, "signal")) {
> > +do_signal:
> >                 s->signal = true;
> >                 pr_debug("switch-output with SIGUSR2 signal\n");
> >                 goto enabled;
> > @@ -2440,6 +2470,9 @@ static struct option __record_options[] = {
> >                           &record.switch_output.set, "signal or size[BKMG] or time[smhd]",
> >                           "Switch output when receiving SIGUSR2 (signal) or cross a size or time threshold",
> >                           "signal"),
> > +       OPT_CALLBACK_SET(0, "switch-output-event", &record.sb_evlist, &record.switch_output_event_set, "switch output event",
> > +                        "switch output event selector. use 'perf list' to list available events",
> 
> Perhaps:
> "A list of events, see 'perf list', that when they occur cause the end
> of one perf.data file and the creation of another"
> 
> Thanks,
> Ian
> 
> > +                        parse_events_option_new_evlist),
> >         OPT_INTEGER(0, "switch-max-files", &record.switch_output.num_files,
> >                    "Limit number of switch output generated files"),
> >         OPT_BOOLEAN(0, "dry-run", &dry_run,
> > --
> > 2.21.1
> >

