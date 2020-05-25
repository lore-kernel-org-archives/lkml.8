Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3052CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11200207C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403950AbgEYOL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:11:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:31255 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403936AbgEYOLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:11:25 -0400
IronPort-SDR: z3T3d45YYAhIwhfUA7yrFEUBZV83tow0D1DY9yMkPUsQTWzxgw7xJ/UHGTZKW0Z1V2NHPkueNx
 9MjPPBrXs4Og==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 07:11:24 -0700
IronPort-SDR: wWPewJR+uX6jdeAzH/lVAWKiAIe0OBpEvgtBy87mR9ZFex8tOzAJyqcnxDX9GPJG+7NVFSI/n2
 OJg7C47XrXaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,433,1583222400"; 
   d="scan'208";a="254917036"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 25 May 2020 07:11:23 -0700
Received: from [10.249.227.191] (abudanko-mobl.ccr.corp.intel.com [10.249.227.191])
        by linux.intel.com (Postfix) with ESMTP id 4647A580101;
        Mon, 25 May 2020 07:11:21 -0700 (PDT)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v4 00/10] perf: support enable and disable commands in stat
 and record modes
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Organization: Intel Corp.
Message-ID: <653fe5f3-c986-a841-1ed8-0a7d2fa24c00@linux.intel.com>
Date:   Mon, 25 May 2020 17:11:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Changes in v4:
- made checking of ctlfd state unconditional in record trace streaming loop
- introduced static poll fds to keep evlist__filter_pollfd() unaffected
- handled ret code of evlist__initialize_ctlfd() where need
- renamed and structured handle_events() function
- applied anonymous structs where needed

v3: https://lore.kernel.org/lkml/eb38e9e5-754f-d410-1d9b-e26b702d51b7@linux.intel.com/

Changes in v3:
- renamed functions and types from perf_evlist_ to evlist_ to avoid
  clash with libperf code;
- extended commands to be strings of variable length consisting of
  command name and also possibly including command specific data;
- merged docs update with the code changes;
- updated docs for -D,--delay=-1 option for stat and record modes;

v2: https://lore.kernel.org/lkml/d582cc3d-2302-c7e2-70d3-bc7ab6f628c3@linux.intel.com/

Changes in v2:
- renamed resume and pause commands to enable and disable ones, renamed
  CTL_CMD_RESUME and CTL_CMD_PAUSE to CTL_CMD_ENABLE and CTL_CMD_DISABLE
  to fit to the appropriate ioctls and avoid mixing up with PAUSE_OUTPUT
  ioctl;
- factored out event handling loop into a handle_events() for stat mode;
- separated -D,--delay=-1 into separate patches for stat and record modes;

v1: https://lore.kernel.org/lkml/825a5132-b58d-c0b6-b050-5a6040386ec7@linux.intel.com/

repo: tip of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core

The patch set implements handling of 'start disabled', 'enable' and 'disable'
external control commands which can be provided for stat and record modes
of the tool from an external controlling process. 'start disabled' command
can be used to postpone enabling of events in the beginning of a monitoring
session. 'enable' and 'disable' commands can be used to enable and disable
events correspondingly any time after the start of the session.

The 'start disabled', 'enable' and 'disable' external control commands can be
used to focus measurement on specially selected time intervals of workload
execution. Focused measurement reduces tool intrusion and influence on
workload behavior, reduces distortion and amount of collected and stored
data, mitigates data accuracy loss because measurement and data capturing
happen only during intervals of interest.

A controlling process can be a bash shell script [1], native executable or
any other language program that can directly work with file descriptors,
e.g. pipes [2], and spawn a process, specially the tool one.

-D,--delay <val> option is extended with -1 value to skip events enabling
in the beginning of a monitoring session ('start disabled' command).
--ctl-fd and --ctl-fd-ack command line options are introduced to provide the
tool with a pair of file descriptors to listen to control commands and reply
to the controlling process on the completion of received commands.

The tool reads control command message from ctl-fd descriptor, handles the
command and optionally replies acknowledgement message to fd-ack descriptor,
if it is specified on the command line. 'enable' command is recognized as
'enable' string message and 'disable' command is recognized as 'disable'
string message both received from ctl-fd descriptor. Completion message is
'ack\n' and sent to fd-ack descriptor.

Example bash script demonstrating simple use case follows:

#!/bin/bash

ctl_dir=/tmp/

ctl_fifo=${ctl_dir}perf_ctl.fifo
test -p ${ctl_fifo} && unlink ${ctl_fifo}
mkfifo ${ctl_fifo} && exec {ctl_fd}<>${ctl_fifo}

ctl_ack_fifo=${ctl_dir}perf_ctl_ack.fifo
test -p ${ctl_ack_fifo} && unlink ${ctl_ack_fifo}
mkfifo ${ctl_ack_fifo} && exec {ctl_fd_ack}<>${ctl_ack_fifo}

perf stat -D -1 -e cpu-cycles -a -I 1000                \
          --ctl-fd ${ctl_fd} --ctl-fd-ack ${ctl_fd_ack} \
          -- sleep 40 &
perf_pid=$!

sleep 5  && echo 'enable' >&${ctl_fd} && read -u ${ctl_fd_ack} e1 && echo "enabled(${e1})"
sleep 10 && echo 'disable' >&${ctl_fd} && read -u ${ctl_fd_ack} d1 && echo "disabled(${d1})"
sleep 5  && echo 'enable' >&${ctl_fd} && read -u ${ctl_fd_ack} e2 && echo "enabled(${e2})"
sleep 10 && echo 'disable' >&${ctl_fd} && read -u ${ctl_fd_ack} d2 && echo "disabled(${d2})"

exec {ctl_fd_ack}>&- && unlink ${ctl_ack_fifo}
exec {ctl_fd}>&- && unlink ${ctl_fifo}

wait -n ${perf_pid}
exit $?


Script output:

[root@host dir] example
Events disabled
#           time             counts unit events
     1.001101062      <not counted>      cpu-cycles                                                  
     2.002994944      <not counted>      cpu-cycles                                                  
     3.004864340      <not counted>      cpu-cycles                                                  
     4.006727177      <not counted>      cpu-cycles                                                  
Events enabled
enabled(ack)
     4.993808464          3,124,246      cpu-cycles                                                  
     5.008597004          3,325,624      cpu-cycles                                                  
     6.010387483         83,472,992      cpu-cycles                                                  
     7.012266598         55,877,621      cpu-cycles                                                  
     8.014175695         97,892,729      cpu-cycles                                                  
     9.016056093         68,461,242      cpu-cycles                                                  
    10.017937507         55,449,643      cpu-cycles                                                  
    11.019830154         68,938,167      cpu-cycles                                                  
    12.021719952         55,164,101      cpu-cycles                                                  
    13.023627550         70,535,720      cpu-cycles                                                  
    14.025580995         53,240,125      cpu-cycles                                                  
disabled(ack)
    14.997518260         53,558,068      cpu-cycles                                                  
Events disabled
    15.027216416      <not counted>      cpu-cycles                                                  
    16.029052729      <not counted>      cpu-cycles                                                  
    17.030904762      <not counted>      cpu-cycles                                                  
    18.032073424      <not counted>      cpu-cycles                                                  
    19.033805074      <not counted>      cpu-cycles                                                  
Events enabled
enabled(ack)
    20.001279097          3,021,022      cpu-cycles                                                  
    20.035044381          6,434,367      cpu-cycles                                                  
    21.036923813         89,358,251      cpu-cycles                                                  
    22.038825169         72,516,351      cpu-cycles                                                  
#           time             counts unit events
    23.040715596         55,046,157      cpu-cycles                                                  
    24.042643757         78,128,649      cpu-cycles                                                  
    25.044558535         61,052,428      cpu-cycles                                                  
    26.046452785         62,142,806      cpu-cycles                                                  
    27.048353021         74,477,971      cpu-cycles                                                  
    28.050241286         61,001,623      cpu-cycles                                                  
    29.052149961         61,653,502      cpu-cycles                                                  
disabled(ack)
    30.004980264         82,729,640      cpu-cycles                                                  
Events disabled
    30.053516176      <not counted>      cpu-cycles                                                  
    31.055348366      <not counted>      cpu-cycles                                                  
    32.057202097      <not counted>      cpu-cycles                                                  
    33.059040702      <not counted>      cpu-cycles                                                  
    34.060843288      <not counted>      cpu-cycles                                                  
    35.000888624      <not counted>      cpu-cycles                                                  
[root@host dir]# 

[1] http://man7.org/linux/man-pages/man1/bash.1.html
[2] http://man7.org/linux/man-pages/man2/pipe.2.html

---
Alexey Budankov (10):
  tools/libperf: introduce static poll file descriptors
  perf evlist: introduce control file descriptors
  perf evlist: implement control command handling functions
  perf stat: factor out event handling loop into a function
  perf stat: extend -D,--delay option with -1 value
  perf stat: implement control commands handling
  perf stat: introduce --ctl-fd[-ack] options
  perf record: extend -D,--delay option with -1 value
  perf record: implement control commands handling
  perf record: introduce --ctl-fd[-ack] options

 tools/lib/api/fd/array.c                 |  42 +++++-
 tools/lib/api/fd/array.h                 |   7 +
 tools/lib/perf/evlist.c                  |  11 ++
 tools/lib/perf/include/internal/evlist.h |   2 +
 tools/perf/Documentation/perf-record.txt |  44 ++++++-
 tools/perf/Documentation/perf-stat.txt   |  45 ++++++-
 tools/perf/builtin-record.c              |  38 +++++-
 tools/perf/builtin-stat.c                | 155 +++++++++++++++++------
 tools/perf/builtin-trace.c               |   2 +-
 tools/perf/util/evlist.c                 | 131 +++++++++++++++++++
 tools/perf/util/evlist.h                 |  25 ++++
 tools/perf/util/record.h                 |   4 +-
 tools/perf/util/stat.h                   |   4 +-
 13 files changed, 459 insertions(+), 51 deletions(-)

-- 
2.24.1

