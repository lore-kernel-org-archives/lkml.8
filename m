Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEFDC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3203220705
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgC0Ie7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:34:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:6740 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgC0Ie7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 04:34:59 -0400
IronPort-SDR: 67hGsmMF248xdKsRSyKtAxK9DsFK0Jm03Tv06qcZVGuuukk8cWSLt0H9lutLGZi2ZaeCoA4RVP
 17UyR9N8va+w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 01:34:58 -0700
IronPort-SDR: mzDVh6j8Mi3kFMFdk50eBBhd0tntbLAVPhxHvtFHVaMmS25+q+PPH0ur1glItZ+aHsYXom4Dlk
 Gj56+ThjmEWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,311,1580803200"; 
   d="scan'208";a="266145640"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 27 Mar 2020 01:34:57 -0700
Received: from [10.249.36.56] (abudanko-mobl.ccr.corp.intel.com [10.249.36.56])
        by linux.intel.com (Postfix) with ESMTP id 89644580479;
        Fri, 27 Mar 2020 01:34:55 -0700 (PDT)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v1 0/8] perf: support resume and pause commands in stat and
 record modes
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Organization: Intel Corp.
Message-ID: <825a5132-b58d-c0b6-b050-5a6040386ec7@linux.intel.com>
Date:   Fri, 27 Mar 2020 11:34:54 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The patch set implements handling of 'start paused', 'resume' and 'pause'
external control commands which can be provided for stat and record modes
of the tool from an external controlling process. 'start paused' command
can be used to postpone enabling of events in the beginning of a monitoring
session. 'resume' and 'pause' commands can be used to enable and disable
events correspondingly any time after the start of the session.

The 'start paused', resume and 'pause' external control commands can be
used to focus measurement on specially selected time intervals of workload
execution. Focused measurement reduces tool intrusion and influence on
workload behavior, reduces distortion and amount of collected and stored
data, mitigates data accuracy loss because measurement and data capturing
happen only during intervals of interest.

A controlling process can be a bash shell script [1], native executable or
any other language program that can directly work with file descriptors,
e.g. pipes [2], and spawn a process, specially the tool one.

-D,--delay <val> option is extended with -1 value to skip events enabling
in the beginning of a monitoring session ('start paused' command). --ctl-fd
and --ctl-fd-ack command line options are introduced to provide the tool
with a pair of file descriptors to listen to 'resume' and 'pause' commands
and reply to an external controlling process on the completion of received
commands processing.

The tool reads two byte control command message from ctl-fd descriptor,
handles the command and optionally replies two bytes acknowledgement message
to fd-ack descriptor, if it is specified on the command line. 'resume' command
is recognized as 'r' character message and 'pause' command is recognized as
'p' character message both received from ctl-fd descriptor. Completion message
is 'a''\n' and sent to fd-ack descriptor.

Bash script demonstrating simple use case follows:

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

sleep 5  && echo 'r' >&${ctl_fd} && read -u ${ctl_fd_ack} r1 && echo "resumed(${r1})"
sleep 10 && echo 'p' >&${ctl_fd} && read -u ${ctl_fd_ack} p1 && echo "paused(${p1})"
sleep 5  && echo 'r' >&${ctl_fd} && read -u ${ctl_fd_ack} r2 && echo "resumed(${r2})"
sleep 10 && echo 'p' >&${ctl_fd} && read -u ${ctl_fd_ack} p2 && echo "paused(${p2})"

exec {ctl_fd_ack}>&- && unlink ${ctl_ack_fifo}
exec {ctl_fd}>&- && unlink ${ctl_fifo}

wait -n ${perf_pid}
exit $?


Script output:

[root@host acme] example
Monitoring paused
#           time             counts unit events
     1.001101062      <not counted>      cpu-cycles                                                  
     2.002994944      <not counted>      cpu-cycles                                                  
     3.004864340      <not counted>      cpu-cycles                                                  
     4.006727177      <not counted>      cpu-cycles                                                  
Monitoring resumed
resumed(a)
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
paused(a)
    14.997518260         53,558,068      cpu-cycles                                                  
Monitoring paused
    15.027216416      <not counted>      cpu-cycles                                                  
    16.029052729      <not counted>      cpu-cycles                                                  
    17.030904762      <not counted>      cpu-cycles                                                  
    18.032073424      <not counted>      cpu-cycles                                                  
    19.033805074      <not counted>      cpu-cycles                                                  
Monitoring resumed
resumed(a)
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
paused(a)
    30.004980264         82,729,640      cpu-cycles                                                  
Monitoring paused
    30.053516176      <not counted>      cpu-cycles                                                  
    31.055348366      <not counted>      cpu-cycles                                                  
    32.057202097      <not counted>      cpu-cycles                                                  
    33.059040702      <not counted>      cpu-cycles                                                  
    34.060843288      <not counted>      cpu-cycles                                                  
    35.000888624      <not counted>      cpu-cycles                                                  
[root@host acme]# 

repo: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
sha1: fe2413eefd7f21aade7eca7272332a1845c11837

[1] http://man7.org/linux/man-pages/man1/bash.1.html
[2] http://man7.org/linux/man-pages/man2/pipe.2.html

---
Alexey Budankov (8):
  perf evlist: introduce control file descriptors
  perf evlist: implement control command handling functions
  perf stat: introduce control descriptors and --ctl-fd[-ack] options
  perf stat: implement resume and pause control commands handling
  perf docs: extend stat mode docs with info on --ctl-fd[-ack] options
  perf record: introduce control descriptors and --ctl-fd[-ack] options
  perf record: implement resume and pause control commands handling
  perf docs: extend record mode docs with info on --ctl-fd[-ack] options

 tools/perf/Documentation/perf-record.txt |  37 ++++++
 tools/perf/Documentation/perf-stat.txt   |  38 +++++++
 tools/perf/builtin-record.c              |  39 ++++++-
 tools/perf/builtin-stat.c                | 138 ++++++++++++++++-------
 tools/perf/builtin-trace.c               |   2 +-
 tools/perf/util/evlist.c                 | 103 +++++++++++++++++
 tools/perf/util/evlist.h                 |  18 +++
 tools/perf/util/record.h                 |   4 +-
 tools/perf/util/stat.h                   |   4 +-
 9 files changed, 335 insertions(+), 48 deletions(-)

