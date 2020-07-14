Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32B1C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE9BE21D7A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594728326;
	bh=8iXNilz0TNOU211xoxSHlwqS5zZDDTvmedUNxRNHdnA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ToTbfmKp0HqS4Vi67nxSCtvZpVwEQXv0Kp0eNRpD2lKoNepV0hVyhs1EdJu0gDUbo
	 e64FSDPOAv5fsppwi8NumeE5o89J612/7HAaKmuPfPYscFu83PXpKMU4WnCayVCEBX
	 8zdlwRnnZ6UmRXlosfBsEcJqo74Uip38ujPcFbow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgGNMFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:05:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50965 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgGNMFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:05:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id c80so2691181wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 05:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dzy9fQbHOYjm2qLJauX/sLV0iRg8LrQk0R+xG1F0+1E=;
        b=gyaAtOnMDgiXqXnbrx3SQnwxAgcI6f03y+S2kAq98T5LMAVaQShejyy/kFVKaJM2Zg
         l0dJfHJ5TqcD7h4YuKHmGTYEOQjjmUIt3VJipMQmknYedrNHzkROGVft+6is6KxAzGA6
         0Ky1sdCzQ4lt+ezHLFa63k2YzpDScYGQzlZKp+kaNXLDv5JCVPNCGag5ePVm4b9uf0fF
         xs0MsFgbo4ptTWRnpezMnooJauQWKEyXXSjst2tMh0PxZ51hzh6l5uRlj1ngwwhtEgDO
         /5AtxPLv0p3NJRAuUw6QrXqiFcKhPm/AgLh+pBaYLBdXuLTRygzfXbMxsTh6k0BIojhO
         +Wng==
X-Gm-Message-State: AOAM532bODpQCrDuySbkNmjHM8eP8Y1j/eSux0DsH2zpY2BW6SezRVBZ
        e+5WqT/iBQOAsv0ojAqk2rrAumqexd9kyQ2xNsXrMw==
X-Google-Smtp-Source: ABdhPJw63AdFcehEYBgS1/i5wJQvXGmOt1pN3Nb+VnWSK+0vYu2urzCjNT3Elk3/qdyRB4sdpOHxosQH2Mv3OSNqfxw=
X-Received: by 2002:a05:600c:258:: with SMTP id 24mr4081746wmj.70.1594728321823;
 Tue, 14 Jul 2020 05:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <037d737f-0ada-a9f0-9686-f7521ca6fbc3@linux.intel.com>
In-Reply-To: <037d737f-0ada-a9f0-9686-f7521ca6fbc3@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 14 Jul 2020 21:05:10 +0900
Message-ID: <CAM9d7cgv1dbLMmtUYWXEvoSUC_NQuBpJ9JRBn3tXJ+S5PX+8TQ@mail.gmail.com>
Subject: Re: [PATCH v11 00/15] perf: support enable and disable commands in
 stat and record modes
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jul 14, 2020 at 5:37 PM Alexey Budankov
<alexey.budankov@linux.intel.com> wrote:
>
>
> Changes in v11:
> - added comments to struct ctl_fd
> - explicitly coded data_size decrement
>
> v10: https://lore.kernel.org/lkml/4af50c95-36f6-7a61-5a22-2949970fe7a5@linux.intel.com/
>
> Changes in v10:
> - reused struct priv, renamed props into flags and used unsigned int type as a storage
> - implemented and adopted usage of evlist__ctlfd_initialized() function
> - updated while condition with checking !(done || stop)
> - implemented compute_tts() to calculate the remainder of timeout to wait in poll()
>
> v9: https://lore.kernel.org/lkml/a4d5db4a-f25c-38dc-1c41-321a886cb122@linux.intel.com/
>
> Changes in v9:
> - avoided screwing of fds by fdarray__filter() to fix staleness of pos returned by fdarray__add()
> - implemented notion of properties for fds kept by fdarray object and introduced nonfilterable
>   property for control fd
> - avoided counting of nonfilterable fds by fdarray__filter()
> - replaced strlen() with sizeof(str)-1 for CMD_TAGS
> - avoided mixing timeout and interval processing in one function
> - renamed child to child_exited variable
> - processed time_to_sleep < time_diff condition
> - placed evlist__ctlfd_process() call after evlist__poll() and evlist__filter_pollfd()
>   calls in record mode
>
> v8: https://lore.kernel.org/lkml/0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com/
>
> Changes in v8:
> - avoided moving of fds at fdarray__filter() call
> - skipped counting of fds with zeroed revents at fdarray__filter() call
> - converted explicit --ctl-fd[-ack] into --control fd:ctl-fd[,ack-fd option
> - updated docs to accommodate --control fd:ctl-fd[,ack-fd] option
>
> v7: https://lore.kernel.org/lkml/5de4b954-24f0-1e8d-5a0d-7b12783b8218@linux.intel.com/
>
> Changes in v7:
> - added missing perf-record.txt changes
> - adjusted docs wording for --ctl-fd,ctl-fd-ack options
>   to additionally mention --delay=-1 effect
>
> v6: https://lore.kernel.org/lkml/f8e3a714-d9b1-4647-e1d2-9981cbaa83ec@linux.intel.com/
>
> Changes in v6:
> - split re-factoring of events handling loops for stat mode
>   into smaller incremental parts
> - added parts missing at v5
> - corrected v5 runtime issues
>
> v5: https://lore.kernel.org/lkml/e5cac8dd-7aa4-ec7c-671c-07756907acba@linux.intel.com/
>
> Changes in v5:
> - split re-factoring of events handling loops for stat mode
>   into smaller incremental parts
>
> v4: https://lore.kernel.org/lkml/653fe5f3-c986-a841-1ed8-0a7d2fa24c00@linux.intel.com/
>
> Changes in v4:
> - made checking of ctlfd state unconditional in record trace streaming loop
> - introduced static poll fds to keep evlist__filter_pollfd() unaffected
> - handled ret code of evlist__initialize_ctlfd() where need
> - renamed and structured handle_events() function
> - applied anonymous structs where needed
>
> v3: https://lore.kernel.org/lkml/eb38e9e5-754f-d410-1d9b-e26b702d51b7@linux.intel.com/
>
> Changes in v3:
> - renamed functions and types from perf_evlist_ to evlist_ to avoid
>   clash with libperf code;
> - extended commands to be strings of variable length consisting of
>   command name and also possibly including command specific data;
> - merged docs update with the code changes;
> - updated docs for -D,--delay=-1 option for stat and record modes;
>
> v2: https://lore.kernel.org/lkml/d582cc3d-2302-c7e2-70d3-bc7ab6f628c3@linux.intel.com/
>
> Changes in v2:
> - renamed resume and pause commands to enable and disable ones, renamed
>   CTL_CMD_RESUME and CTL_CMD_PAUSE to CTL_CMD_ENABLE and CTL_CMD_DISABLE
>   to fit to the appropriate ioctls and avoid mixing up with PAUSE_OUTPUT
>   ioctl;
> - factored out event handling loop into a handle_events() for stat mode;
> - separated -D,--delay=-1 into separate patches for stat and record modes;
>
> v1: https://lore.kernel.org/lkml/825a5132-b58d-c0b6-b050-5a6040386ec7@linux.intel.com/
>
> repo: tip of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
>
> The patch set implements handling of 'start disabled', 'enable' and 'disable'
> external control commands which can be provided for stat and record modes
> of the tool from an external controlling process. 'start disabled' command
> can be used to postpone enabling of events in the beginning of a monitoring
> session. 'enable' and 'disable' commands can be used to enable and disable
> events correspondingly any time after the start of the session.
>
> The 'start disabled', 'enable' and 'disable' external control commands can be
> used to focus measurement on specially selected time intervals of workload
> execution. Focused measurement reduces tool intrusion and influence on
> workload behavior, reduces distortion and amount of collected and stored
> data, mitigates data accuracy loss because measurement and data capturing
> happen only during intervals of interest.
>
> A controlling process can be a bash shell script [1], native executable or
> any other language program that can directly work with file descriptors,
> e.g. pipes [2], and spawn a process, specially the tool one.
>
> -D,--delay <val> option is extended with -1 value to skip events enabling
> in the beginning of a monitoring session ('start disabled' command).
> --control fd:ctl-fd[,ack-fd] command line option is introduced to provide the
> tool with a pair of file descriptors to listen to control commands and reply
> to the controlling process on the completion of received commands.
>
> The tool reads control command message from ctl-fd descriptor, handles the
> command and optionally replies acknowledgement message to ack-fd descriptor,
> if it is specified on the command line. 'enable' command is recognized as
> 'enable' string message and 'disable' command is recognized as 'disable'
> string message both received from ctl-fd descriptor. Completion message is
> 'ack\n' and sent to ack-fd descriptor.
>
> Example bash script demonstrating simple use case follows:
>
> #!/bin/bash
>
> ctl_dir=/tmp/
>
> ctl_fifo=${ctl_dir}perf_ctl.fifo
> test -p ${ctl_fifo} && unlink ${ctl_fifo}
> mkfifo ${ctl_fifo} && exec {ctl_fd}<>${ctl_fifo}
>
> ctl_ack_fifo=${ctl_dir}perf_ctl_ack.fifo
> test -p ${ctl_ack_fifo} && unlink ${ctl_ack_fifo}
> mkfifo ${ctl_ack_fifo} && exec {ctl_fd_ack}<>${ctl_ack_fifo}
>
> perf stat -D -1 -e cpu-cycles -a -I 1000       \
>           --control fd:${ctl_fd},${ctl_fd_ack} \
>           -- sleep 40 &
> perf_pid=$!
>
> sleep 5  && echo 'enable' >&${ctl_fd} && read -u ${ctl_fd_ack} e1 && echo "enabled(${e1})"
> sleep 10 && echo 'disable' >&${ctl_fd} && read -u ${ctl_fd_ack} d1 && echo "disabled(${d1})"
> sleep 5  && echo 'enable' >&${ctl_fd} && read -u ${ctl_fd_ack} e2 && echo "enabled(${e2})"
> sleep 10 && echo 'disable' >&${ctl_fd} && read -u ${ctl_fd_ack} d2 && echo "disabled(${d2})"
>
> exec {ctl_fd_ack}>&- && unlink ${ctl_ack_fifo}
> exec {ctl_fd}>&- && unlink ${ctl_fifo}
>
> wait -n ${perf_pid}
> exit $?
>
>
> Script output:
>
> [root@host dir] example
> Events disabled
> #           time             counts unit events
>      1.001101062      <not counted>      cpu-cycles
>      2.002994944      <not counted>      cpu-cycles
>      3.004864340      <not counted>      cpu-cycles
>      4.006727177      <not counted>      cpu-cycles
> Events enabled
> enabled(ack)
>      4.993808464          3,124,246      cpu-cycles
>      5.008597004          3,325,624      cpu-cycles
>      6.010387483         83,472,992      cpu-cycles
>      7.012266598         55,877,621      cpu-cycles
>      8.014175695         97,892,729      cpu-cycles
>      9.016056093         68,461,242      cpu-cycles
>     10.017937507         55,449,643      cpu-cycles
>     11.019830154         68,938,167      cpu-cycles
>     12.021719952         55,164,101      cpu-cycles
>     13.023627550         70,535,720      cpu-cycles
>     14.025580995         53,240,125      cpu-cycles
> disabled(ack)
>     14.997518260         53,558,068      cpu-cycles
> Events disabled
>     15.027216416      <not counted>      cpu-cycles
>     16.029052729      <not counted>      cpu-cycles
>     17.030904762      <not counted>      cpu-cycles
>     18.032073424      <not counted>      cpu-cycles
>     19.033805074      <not counted>      cpu-cycles
> Events enabled
> enabled(ack)
>     20.001279097          3,021,022      cpu-cycles
>     20.035044381          6,434,367      cpu-cycles
>     21.036923813         89,358,251      cpu-cycles
>     22.038825169         72,516,351      cpu-cycles
> #           time             counts unit events
>     23.040715596         55,046,157      cpu-cycles
>     24.042643757         78,128,649      cpu-cycles
>     25.044558535         61,052,428      cpu-cycles
>     26.046452785         62,142,806      cpu-cycles
>     27.048353021         74,477,971      cpu-cycles
>     28.050241286         61,001,623      cpu-cycles
>     29.052149961         61,653,502      cpu-cycles
> disabled(ack)
>     30.004980264         82,729,640      cpu-cycles
> Events disabled
>     30.053516176      <not counted>      cpu-cycles
>     31.055348366      <not counted>      cpu-cycles
>     32.057202097      <not counted>      cpu-cycles
>     33.059040702      <not counted>      cpu-cycles
>     34.060843288      <not counted>      cpu-cycles
>     35.000888624      <not counted>      cpu-cycles
> [root@host dir]#
>
> [1] http://man7.org/linux/man-pages/man1/bash.1.html
> [2] http://man7.org/linux/man-pages/man2/pipe.2.html

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung

>
> ---
> Alexey Budankov (15):
>   tools/libperf: avoid internal moving of fdarray fds
>   tools/libperf: add flags to fdarray fds objects
>   tools/libperf: avoid counting of nonfilterable fdarray fds
>   perf evlist: introduce control file descriptors
>   perf evlist: implement control command handling functions
>   perf stat: factor out body of event handling loop for system wide
>   perf stat: move target check to loop control statement
>   perf stat: factor out body of event handling loop for fork case
>   perf stat: factor out event handling loop into dispatch_events()
>   perf stat: extend -D,--delay option with -1 value
>   perf stat: implement control commands handling
>   perf stat: introduce --control fd:ctl-fd[,ack-fd] options
>   perf record: extend -D,--delay option with -1 value
>   perf record: implement control commands handling
>   perf record: introduce --control fd:ctl-fd[,ack-fd] options
>
>  tools/lib/api/fd/array.c                 |  17 ++-
>  tools/lib/api/fd/array.h                 |  16 +-
>  tools/lib/perf/evlist.c                  |   6 +-
>  tools/lib/perf/include/internal/evlist.h |   2 +-
>  tools/perf/Documentation/perf-record.txt |  44 +++++-
>  tools/perf/Documentation/perf-stat.txt   |  44 +++++-
>  tools/perf/builtin-record.c              |  65 +++++++-
>  tools/perf/builtin-stat.c                | 183 ++++++++++++++++++-----
>  tools/perf/builtin-trace.c               |   2 +-
>  tools/perf/tests/fdarray.c               |  22 +--
>  tools/perf/util/evlist.c                 | 145 +++++++++++++++++-
>  tools/perf/util/evlist.h                 |  26 ++++
>  tools/perf/util/record.h                 |   4 +-
>  tools/perf/util/stat.h                   |   4 +-
>  14 files changed, 495 insertions(+), 85 deletions(-)
>
> --
> 2.24.1
>
