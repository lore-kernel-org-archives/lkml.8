Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8771EC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3572077D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0rqw87B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgCYNGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:06:05 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36680 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgCYNGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 09:06:04 -0400
Received: by mail-qt1-f195.google.com with SMTP id m33so2021512qtb.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 06:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5sVbz0QFF1TQYNaY+eDh6mNaQ7m/dm6ngpTVWacY4wM=;
        b=M0rqw87Boy6b7q3BcCDjpwDel7R8qsz/fVp3X0Ug8icfGpeu5pA7TMOXXQqTpPIw3+
         XAGI3oIShHFoC/dO55y6WTWOGL0WOvgjO0LPDR5SOilg0QxneQTXz8id2ilF5nRrDsvr
         jd4OZcu22FIDdMCEema94rLjF2dbv8BSTorh3qwK7G9eI0/2BQbg1LJueEG1z64LoPLV
         BPdUYj+fVmt/p5brkJ2fWibvNwrEYdXYaYAt3yAhLPGnXo5LRlAN5HQ0phqYkaru/422
         eJxQ0LPddZArMABpLyC0q30jwja1pCa4f/zRJOKSr2DTCMHlxrWNiXRjR5GE0xQR7nff
         I8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5sVbz0QFF1TQYNaY+eDh6mNaQ7m/dm6ngpTVWacY4wM=;
        b=Zv0aM8Ka4UnL5YLXMoKdRzHLDEIUuHHMjNlGPrzs6DNMWCauBe5y4MswltFkVStBbO
         XB4FzSS1WXvs6FjG1tq37fiJFy4mBIYxmejj8/IFKLfMnwjkbRCZRsHvRjWnpMqrEMgT
         blu+3aIMJqkXFwJcnOItcE0f75BFND5fnkGn9JyhbRYRbqdzMWfQU208MST50Ja7lvU0
         GXHAhx1sCKRaEe5TbkPYTfhBOK+0chK7u4bMKi8rnr+hgwf5RGIWbvgJQGiHnCBraMf+
         TmNLQOwF4tGilr4roETy23HFZChyLsH2mGQrYRArDhd7F8fooNlncDGa9FBODEejQoqf
         UtrA==
X-Gm-Message-State: ANhLgQ2dtpl+LA7h5pkf3tjnTBfnUHfKJJ/MQcCwv++JrgPd8NMiRl4N
        Er/DNs7s1sLqBm8CRFXwZ0KEeYkM
X-Google-Smtp-Source: ADFU+vtiKB2tu9lhXF89YE9TKcwymfNripbgArmLVaqfX+PssUV/vJtreC8ZuE8UiivixinpC2L4Eg==
X-Received: by 2002:ac8:312e:: with SMTP id g43mr2871983qtb.360.1585141550985;
        Wed, 25 Mar 2020 06:05:50 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id j20sm2658187qke.44.2020.03.25.06.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 06:05:50 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1AB4D40F77; Wed, 25 Mar 2020 10:05:48 -0300 (-03)
Date:   Wed, 25 Mar 2020 10:05:48 -0300
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCHSET 0/9] perf: Improve cgroup profiling (v6)
Message-ID: <20200325130548.GA14102@kernel.org>
References: <20200325124536.2800725-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325124536.2800725-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 25, 2020 at 09:45:27PM +0900, Namhyung Kim escreveu:
> Hello,
> 
> This work is to improve cgroup profiling in perf.  Currently it only
> supports profiling tasks in a specific cgroup and there's no way to
> identify which cgroup the current sample belongs to.  So I added
> PERF_SAMPLE_CGROUP to add cgroup id into each sample.  It's a 64-bit
> integer having file handle of the cgroup.  And kernel also generates
> PERF_RECORD_CGROUP event for new groups to correlate the cgroup id and
> cgroup name (path in the cgroup filesystem).  The cgroup id can be
> read from userspace by name_to_handle_at() system call so it can
> synthesize the CGROUP event for existing groups.

Thanks for the refresh, I'll test this today and all going well push to
Ingo soon,

- Arnaldo
 
> So why do we want this?  Systems running a large number of jobs in
> different cgroups want to profiling such jobs precisely. This includes
> container hosting systems widely used today. Currently perf supports
> namespace tracking but the systems may not use (cgroup) namespace for
> their jobs. Also it'd be more intuitive to see cgroup names (as
> they're given by user or sysadmin) rather than numeric
> cgroup/namespace id even if they use the namespaces.
> 
> From Stephane Eranian:
> > In data centers you care about attributing samples to a job not such
> > much to a process.  A job may have multiple processes which may come
> > and go. The cgroup on the other hand stays around for the entire
> > lifetime of the job. It is much easier to map a cgroup name to a
> > particular job than it is to map a pid back to a job name,
> > especially for offline post-processing.
> 
> Note that this only works for "perf_event" cgroups (obviously) so if
> users are still using cgroup-v1 interface, they need to have same
> hierarchy for subsystem(s) want to profile with it.
> 
>  * Changes from v5:
>   - add ACKs for the kernel changes
>   - fix sort column alignment when no cgroup is available
> 
>  * Changes from v4:
>   - use CONFIG_CGROUP_PERF
>   - move cgroup tree to perf_env
>   - move cgroup fs utility function to tools/lib/api/fs
>   - use a local buffer and check its size for cgroup systhesis
> 
>  * Changes from v3:
>   - staticize perf_event_cgroup()
>   - fix sample parsing test
> 
>  * Changes from v2:
>   - remove path_len from cgroup_event
>   - bail out if kernel doesn't support cgroup sampling
>   - add some description in the Kconfig
> 
>  * Changes from v1:
>   - use new cgroup id (= file handle)
> 
> The code is available at perf/cgroup-v6 branch in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> 
> The testing result looks something like this:
> 
>   [root@qemu build]# ./perf record --all-cgroups ./cgtest
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.009 MB perf.data (150 samples) ]
>   
>   [root@qemu build]# ./perf report -s cgroup,comm --stdio
>   # To display the perf.data header info, please use --header/--header-only options.
>   #
>   #
>   # Total Lost Samples: 0
>   #
>   # Samples: 150  of event 'cpu-clock:pppH'
>   # Event count (approx.): 37500000
>   #
>   # Overhead  cgroup      Command
>   # ........  ..........  .......
>   #
>       32.00%  /sub/cgrp2  looper2
>       28.00%  /sub/cgrp1  looper1
>       25.33%  /sub        looper0
>        4.00%  /           cgtest 
>        4.00%  /sub        cgtest 
>        3.33%  /sub/cgrp2  cgtest 
>        2.67%  /sub/cgrp1  cgtest 
>        0.67%  /           looper0
> 
> 
> The test program (cgtest) follows.
> 
> Thanks,
> Namhyung
> 
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Li Zefan <lizefan@huawei.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> 
> 
> -------8<-----------------------------------------8<----------------
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <sched.h>
> #include <errno.h>
> #include <sys/stat.h>
> #include <sys/wait.h>
> #include <sys/prctl.h>
> #include <sys/mount.h>
> 
> char cgbase[] = "/sys/fs/cgroup/perf_event";
> 
> void mkcgrp(char *name) {
>   char buf[256];
> 
>   snprintf(buf, sizeof(buf), "%s%s", cgbase, name);
>   if (mkdir(buf, 0755) < 0)
>     perror("mkdir");
> }
> 
> void rmcgrp(char *name) {
>   char buf[256];
> 
>   snprintf(buf, sizeof(buf), "%s%s", cgbase, name);
>   if (rmdir(buf) < 0)
>     perror("rmdir");
> }
> 
> void setcgrp(char *name) {
>   char buf[256];
>   int fd;
> 
>   snprintf(buf, sizeof(buf), "%s%s/tasks", cgbase, name);
> 
>   fd = open(buf, O_WRONLY);
>   if (fd > 0) {
>     if (write(fd, "0\n", 2) != 2)
>       perror("write");
>     close(fd);
>   }
> }
> 
> void create_sub_cgroup(int idx) {
>   char buf[128];
> 
>   snprintf(buf, sizeof(buf), "/sub/cgrp%d", idx);
>   mkcgrp(buf);
> }
> 
> void remove_sub_cgroup(int idx) {
>   char buf[128];
> 
>   snprintf(buf, sizeof(buf), "/sub/cgrp%d", idx);
>   rmcgrp(buf);
> }
> 
> void set_sub_cgroup(int idx) {
>   char buf[128];
> 
>   snprintf(buf, sizeof(buf), "/sub/cgrp%d", idx);
>   setcgrp(buf);
> }
> 
> void set_task_name(int idx) {
>   char buf[16];
> 
>   snprintf(buf, sizeof(buf), "looper%d", idx);
>   prctl(PR_SET_NAME, buf, 0, 0, 0);
> }
> 
> void loop(unsigned max) {
>   volatile unsigned int count = 1;
> 
>   while (count++ != max) {
>     asm volatile ("pause");
>   }
> }
> 
> void worker(int idx, unsigned cnt, int new_ns) {
>   int oldns;
> 
>   create_sub_cgroup(idx);
>   set_sub_cgroup(idx);
> 
>   if (new_ns) {
>     if (unshare(CLONE_NEWCGROUP) < 0)
>       perror("unshare");
> 
> #if 0  /* FIXME */
>     if (unshare(CLONE_NEWNS) < 0)
>       perror("unshare");
> 
>     if (mount("none", "/sys", NULL, MS_REMOUNT | MS_REC | MS_SLAVE, NULL) < 0)
>       perror("mount --make-rslave");
> 
>     sleep(1);
>     if (umount("/sys/fs/cgroup/perf_event") < 0)
>       perror("umount");
> 
>     if (mount("cgroup", "/sys/fs/cgroup/perf_event", "cgroup",
>               MS_NODEV | MS_NOEXEC | MS_NOSUID, "perf_event") < 0)
>       perror("mount again");
> #endif
>   }
> 
>   if (fork() == 0) {
>     set_task_name(idx);
>     loop(cnt);
>     exit(0);
>   }
>   wait(NULL);
> }
> 
> int main(int argc, char *argv[])
> {
>   int i, nr = 2;
>   int new_ns = 1;
>   unsigned cnt = 1000000;
>   int fd;
> 
>   if (argc > 1)
>     nr = atoi(argv[1]);
>   if (argc > 2)
>     cnt = atoi(argv[2]);
>   if (argc > 3)
>     new_ns = atoi(argv[3]);
> 
>   mkcgrp("/sub");
>   setcgrp("/sub");
> 
>   for (i = 0; i < nr; i++) {
>     if (fork() == 0) {
>       worker(i+1, cnt, new_ns);
>       exit(0);
>     }
>   }
> 
>   set_task_name(0);
>   loop(cnt);
> 
>   for (i = 0; i < nr; i++)
>     wait(NULL);
> 
>   for (i = 0; i < nr; i++)
>     remove_sub_cgroup(i+1);
> 
>   setcgrp("/");
>   rmcgrp("/sub");
> 
>   return 0;
> }
> -------8<-----------------------------------------8<----------------
> 
> 
> Namhyung Kim (9):
>   perf/core: Add PERF_RECORD_CGROUP event
>   perf/core: Add PERF_SAMPLE_CGROUP feature
>   perf tools: Basic support for CGROUP event
>   perf tools: Maintain cgroup hierarchy
>   perf report: Add 'cgroup' sort key
>   perf record: Support synthesizing cgroup events
>   perf record: Add --all-cgroups option
>   perf top: Add --all-cgroups option
>   perf script: Add --show-cgroup-events option
> 
>  include/linux/perf_event.h                |   1 +
>  include/uapi/linux/perf_event.h           |  16 ++-
>  init/Kconfig                              |   3 +-
>  kernel/events/core.c                      | 133 ++++++++++++++++++++++
>  tools/include/uapi/linux/perf_event.h     |  16 ++-
>  tools/lib/perf/include/perf/event.h       |   7 ++
>  tools/perf/Documentation/perf-record.txt  |   5 +-
>  tools/perf/Documentation/perf-report.txt  |   1 +
>  tools/perf/Documentation/perf-script.txt  |   3 +
>  tools/perf/Documentation/perf-top.txt     |   4 +
>  tools/perf/builtin-diff.c                 |   1 +
>  tools/perf/builtin-record.c               |  10 ++
>  tools/perf/builtin-report.c               |   1 +
>  tools/perf/builtin-script.c               |  41 +++++++
>  tools/perf/builtin-top.c                  |   9 ++
>  tools/perf/tests/sample-parsing.c         |   6 +-
>  tools/perf/util/cgroup.c                  |  80 +++++++++++++
>  tools/perf/util/cgroup.h                  |  17 ++-
>  tools/perf/util/env.c                     |   2 +
>  tools/perf/util/env.h                     |   6 +
>  tools/perf/util/event.c                   |  18 +++
>  tools/perf/util/event.h                   |   6 +
>  tools/perf/util/evsel.c                   |  17 ++-
>  tools/perf/util/evsel.h                   |   1 +
>  tools/perf/util/hist.c                    |  13 +++
>  tools/perf/util/hist.h                    |   1 +
>  tools/perf/util/machine.c                 |  19 ++++
>  tools/perf/util/machine.h                 |   3 +
>  tools/perf/util/perf_event_attr_fprintf.c |   2 +
>  tools/perf/util/record.h                  |   1 +
>  tools/perf/util/session.c                 |   4 +
>  tools/perf/util/sort.c                    |  37 ++++++
>  tools/perf/util/sort.h                    |   2 +
>  tools/perf/util/synthetic-events.c        | 121 ++++++++++++++++++++
>  tools/perf/util/synthetic-events.h        |   1 +
>  tools/perf/util/tool.h                    |   2 +
>  36 files changed, 598 insertions(+), 12 deletions(-)
> 
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 

-- 

- Arnaldo
