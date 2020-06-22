Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8A9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C01D206C1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aRPLOTkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgFVI4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:56:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27465 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgFVI4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592816171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XLtzd2u4aH0M4atxAdxeqUNujIW+HCg1u9PVTEKGfzk=;
        b=aRPLOTkUo90gi9uzO487UCH2my9PxpS0HGs4XNLWce34gzpxKZGbkI3ejflPsmDIMU2RW8
        Of5IGz0whvjvkUHHM4BrfDAp5g1xa9k7W0dxNmoWRcHdI3AFQo7IbaHK1EsQmjk8td5pvS
        yNa0L8yNUwiwdmgFE+RVG188C3N5KyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-Qq8gnHdKMwarfRUH_mxY7g-1; Mon, 22 Jun 2020 04:56:02 -0400
X-MC-Unique: Qq8gnHdKMwarfRUH_mxY7g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5901418FE861;
        Mon, 22 Jun 2020 08:56:01 +0000 (UTC)
Received: from krava (unknown [10.40.193.171])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4D7B95C240;
        Mon, 22 Jun 2020 08:55:59 +0000 (UTC)
Date:   Mon, 22 Jun 2020 10:55:58 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 00/13] perf: support enable and disable commands in
 stat and record modes
Message-ID: <20200622085558.GB2556590@krava>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
 <4a55f340-0d7a-7dd6-9bd9-7a0d98d63d01@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a55f340-0d7a-7dd6-9bd9-7a0d98d63d01@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 06:38:34AM +0300, Alexey Budankov wrote:
> 
> Hi,
> 
> On 17.06.2020 11:30, Alexey Budankov wrote:
> > 
> > Changes in v8:
> > - avoided moving of fds at fdarray__filter() call
> > - skipped counting of fds with zeroed revents at fdarray__filter() call
> > - converted explicit --ctl-fd[-ack] into --control fd:ctl-fd[,ack-fd option 
> > - updated docs to accommodate --control fd:ctl-fd[,ack-fd] option
> 
> Are there any questions or thoughts so far?

hi,
I'm waiting on some comment for:
  https://lore.kernel.org/lkml/20200615165802.GD2088119@krava/

jirka

> 
> Thanks,
> Alexey
> 
> > 
> > v7: https://lore.kernel.org/lkml/5de4b954-24f0-1e8d-5a0d-7b12783b8218@linux.intel.com/
> > 
> > Changes in v7:
> > - added missing perf-record.txt changes 
> > - adjusted docs wording for --ctl-fd,ctl-fd-ack options 
> >   to additionally mention --delay=-1 effect
> > 
> > v6: https://lore.kernel.org/lkml/f8e3a714-d9b1-4647-e1d2-9981cbaa83ec@linux.intel.com/
> > 
> > Changes in v6:
> > - split re-factoring of events handling loops for stat mode
> >   into smaller incremental parts
> > - added parts missing at v5
> > - corrected v5 runtime issues
> > 
> > v5: https://lore.kernel.org/lkml/e5cac8dd-7aa4-ec7c-671c-07756907acba@linux.intel.com/
> > 
> > Changes in v5:
> > - split re-factoring of events handling loops for stat mode
> >   into smaller incremental parts
> > 
> > v4: https://lore.kernel.org/lkml/653fe5f3-c986-a841-1ed8-0a7d2fa24c00@linux.intel.com/
> > 
> > Changes in v4:
> > - made checking of ctlfd state unconditional in record trace streaming loop
> > - introduced static poll fds to keep evlist__filter_pollfd() unaffected
> > - handled ret code of evlist__initialize_ctlfd() where need
> > - renamed and structured handle_events() function
> > - applied anonymous structs where needed
> > 
> > v3: https://lore.kernel.org/lkml/eb38e9e5-754f-d410-1d9b-e26b702d51b7@linux.intel.com/
> > 
> > Changes in v3:
> > - renamed functions and types from perf_evlist_ to evlist_ to avoid
> >   clash with libperf code;
> > - extended commands to be strings of variable length consisting of
> >   command name and also possibly including command specific data;
> > - merged docs update with the code changes;
> > - updated docs for -D,--delay=-1 option for stat and record modes;
> > 
> > v2: https://lore.kernel.org/lkml/d582cc3d-2302-c7e2-70d3-bc7ab6f628c3@linux.intel.com/
> > 
> > Changes in v2:
> > - renamed resume and pause commands to enable and disable ones, renamed
> >   CTL_CMD_RESUME and CTL_CMD_PAUSE to CTL_CMD_ENABLE and CTL_CMD_DISABLE
> >   to fit to the appropriate ioctls and avoid mixing up with PAUSE_OUTPUT
> >   ioctl;
> > - factored out event handling loop into a handle_events() for stat mode;
> > - separated -D,--delay=-1 into separate patches for stat and record modes;
> > 
> > v1: https://lore.kernel.org/lkml/825a5132-b58d-c0b6-b050-5a6040386ec7@linux.intel.com/
> > 
> > repo: tip of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
> > 
> > The patch set implements handling of 'start disabled', 'enable' and 'disable'
> > external control commands which can be provided for stat and record modes
> > of the tool from an external controlling process. 'start disabled' command
> > can be used to postpone enabling of events in the beginning of a monitoring
> > session. 'enable' and 'disable' commands can be used to enable and disable
> > events correspondingly any time after the start of the session.
> > 
> > The 'start disabled', 'enable' and 'disable' external control commands can be
> > used to focus measurement on specially selected time intervals of workload
> > execution. Focused measurement reduces tool intrusion and influence on
> > workload behavior, reduces distortion and amount of collected and stored
> > data, mitigates data accuracy loss because measurement and data capturing
> > happen only during intervals of interest.
> > 
> > A controlling process can be a bash shell script [1], native executable or
> > any other language program that can directly work with file descriptors,
> > e.g. pipes [2], and spawn a process, specially the tool one.
> > 
> > -D,--delay <val> option is extended with -1 value to skip events enabling
> > in the beginning of a monitoring session ('start disabled' command).
> > --control fd:ctl-fd[,ack-fd] command line option is introduced to provide the
> > tool with a pair of file descriptors to listen to control commands and reply
> > to the controlling process on the completion of received commands.
> > 
> > The tool reads control command message from ctl-fd descriptor, handles the
> > command and optionally replies acknowledgement message to ack-fd descriptor,
> > if it is specified on the command line. 'enable' command is recognized as
> > 'enable' string message and 'disable' command is recognized as 'disable'
> > string message both received from ctl-fd descriptor. Completion message is
> > 'ack\n' and sent to ack-fd descriptor.
> > 
> > Example bash script demonstrating simple use case follows:
> > 
> > #!/bin/bash
> > 
> > ctl_dir=/tmp/
> > 
> > ctl_fifo=${ctl_dir}perf_ctl.fifo
> > test -p ${ctl_fifo} && unlink ${ctl_fifo}
> > mkfifo ${ctl_fifo} && exec {ctl_fd}<>${ctl_fifo}
> > 
> > ctl_ack_fifo=${ctl_dir}perf_ctl_ack.fifo
> > test -p ${ctl_ack_fifo} && unlink ${ctl_ack_fifo}
> > mkfifo ${ctl_ack_fifo} && exec {ctl_fd_ack}<>${ctl_ack_fifo}
> > 
> > perf stat -D -1 -e cpu-cycles -a -I 1000       \
> >           --control fd:${ctl_fd},${ctl_fd_ack} \
> >           -- sleep 40 &
> > perf_pid=$!
> > 
> > sleep 5  && echo 'enable' >&${ctl_fd} && read -u ${ctl_fd_ack} e1 && echo "enabled(${e1})"
> > sleep 10 && echo 'disable' >&${ctl_fd} && read -u ${ctl_fd_ack} d1 && echo "disabled(${d1})"
> > sleep 5  && echo 'enable' >&${ctl_fd} && read -u ${ctl_fd_ack} e2 && echo "enabled(${e2})"
> > sleep 10 && echo 'disable' >&${ctl_fd} && read -u ${ctl_fd_ack} d2 && echo "disabled(${d2})"
> > 
> > exec {ctl_fd_ack}>&- && unlink ${ctl_ack_fifo}
> > exec {ctl_fd}>&- && unlink ${ctl_fifo}
> > 
> > wait -n ${perf_pid}
> > exit $?
> > 
> > 
> > Script output:
> > 
> > [root@host dir] example
> > Events disabled
> > #           time             counts unit events
> >      1.001101062      <not counted>      cpu-cycles                                                  
> >      2.002994944      <not counted>      cpu-cycles                                                  
> >      3.004864340      <not counted>      cpu-cycles                                                  
> >      4.006727177      <not counted>      cpu-cycles                                                  
> > Events enabled
> > enabled(ack)
> >      4.993808464          3,124,246      cpu-cycles                                                  
> >      5.008597004          3,325,624      cpu-cycles                                                  
> >      6.010387483         83,472,992      cpu-cycles                                                  
> >      7.012266598         55,877,621      cpu-cycles                                                  
> >      8.014175695         97,892,729      cpu-cycles                                                  
> >      9.016056093         68,461,242      cpu-cycles                                                  
> >     10.017937507         55,449,643      cpu-cycles                                                  
> >     11.019830154         68,938,167      cpu-cycles                                                  
> >     12.021719952         55,164,101      cpu-cycles                                                  
> >     13.023627550         70,535,720      cpu-cycles                                                  
> >     14.025580995         53,240,125      cpu-cycles                                                  
> > disabled(ack)
> >     14.997518260         53,558,068      cpu-cycles                                                  
> > Events disabled
> >     15.027216416      <not counted>      cpu-cycles                                                  
> >     16.029052729      <not counted>      cpu-cycles                                                  
> >     17.030904762      <not counted>      cpu-cycles                                                  
> >     18.032073424      <not counted>      cpu-cycles                                                  
> >     19.033805074      <not counted>      cpu-cycles                                                  
> > Events enabled
> > enabled(ack)
> >     20.001279097          3,021,022      cpu-cycles                                                  
> >     20.035044381          6,434,367      cpu-cycles                                                  
> >     21.036923813         89,358,251      cpu-cycles                                                  
> >     22.038825169         72,516,351      cpu-cycles                                                  
> > #           time             counts unit events
> >     23.040715596         55,046,157      cpu-cycles                                                  
> >     24.042643757         78,128,649      cpu-cycles                                                  
> >     25.044558535         61,052,428      cpu-cycles                                                  
> >     26.046452785         62,142,806      cpu-cycles                                                  
> >     27.048353021         74,477,971      cpu-cycles                                                  
> >     28.050241286         61,001,623      cpu-cycles                                                  
> >     29.052149961         61,653,502      cpu-cycles                                                  
> > disabled(ack)
> >     30.004980264         82,729,640      cpu-cycles                                                  
> > Events disabled
> >     30.053516176      <not counted>      cpu-cycles                                                  
> >     31.055348366      <not counted>      cpu-cycles                                                  
> >     32.057202097      <not counted>      cpu-cycles                                                  
> >     33.059040702      <not counted>      cpu-cycles                                                  
> >     34.060843288      <not counted>      cpu-cycles                                                  
> >     35.000888624      <not counted>      cpu-cycles                                                  
> > [root@host dir]# 
> > 
> > [1] http://man7.org/linux/man-pages/man1/bash.1.html
> > [2] http://man7.org/linux/man-pages/man2/pipe.2.html
> > 
> > ---
> > Alexey Budankov (13):
> >   tools/libperf: avoid moving of fds at fdarray__filter() call
> >   perf evlist: introduce control file descriptors
> >   perf evlist: implement control command handling functions
> >   perf stat: factor out body of event handling loop for system wide
> >   perf stat: move target check to loop control statement
> >   perf stat: factor out body of event handling loop for fork case
> >   perf stat: factor out event handling loop into dispatch_events()
> >   perf stat: extend -D,--delay option with -1 value
> >   perf stat: implement control commands handling
> >   perf stat: introduce --control fd:ctl-fd[,ack-fd] options
> >   perf record: extend -D,--delay option with -1 value
> >   perf record: implement control commands handling
> >   perf record: introduce --control fd:ctl-fd[,ack-fd] options
> > 
> >  tools/lib/api/fd/array.c                 |  11 +-
> >  tools/perf/Documentation/perf-record.txt |  44 +++++-
> >  tools/perf/Documentation/perf-stat.txt   |  44 +++++-
> >  tools/perf/builtin-record.c              |  65 ++++++++-
> >  tools/perf/builtin-stat.c                | 176 ++++++++++++++++++-----
> >  tools/perf/builtin-trace.c               |   2 +-
> >  tools/perf/tests/fdarray.c               |  20 +--
> >  tools/perf/util/evlist.c                 | 136 ++++++++++++++++++
> >  tools/perf/util/evlist.h                 |  25 ++++
> >  tools/perf/util/record.h                 |   4 +-
> >  tools/perf/util/stat.h                   |   4 +-
> >  11 files changed, 458 insertions(+), 73 deletions(-)
> > 
> 

