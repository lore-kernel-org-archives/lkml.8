Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACD2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35A68206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgETPFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:05:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:28224 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgETPFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:05:37 -0400
IronPort-SDR: 6q+v6PHB1NxjTvtEybu5Kv1UF6gWFnkRKNe1YNuiFP4joUWAQ5gN3sT1H5yS7V+Rrv//VRtMwE
 Ul/21l3yYHRw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 08:05:36 -0700
IronPort-SDR: 8YdepVrVeMetoOFxmVGKO/3+DexPOg8DJ9/k6EODfGDXpbR5TAMfIYdoSEeUrlps1Uczv2asS1
 mdv69UiZTquA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; 
   d="scan'208";a="264712940"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 20 May 2020 08:05:36 -0700
Received: from [10.249.231.6] (abudanko-mobl.ccr.corp.intel.com [10.249.231.6])
        by linux.intel.com (Postfix) with ESMTP id 2087C580613;
        Wed, 20 May 2020 08:05:33 -0700 (PDT)
Subject: Re: [PATCH v3 6/9] perf stat: introduce --ctl-fd[-ack] options
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <eb38e9e5-754f-d410-1d9b-e26b702d51b7@linux.intel.com>
 <6b8f7e1f-f89c-2c96-95ac-2a128b365a81@linux.intel.com>
 <20200520123819.GE157452@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <7dcbbca7-b99e-025e-91b4-71c45e746a7b@linux.intel.com>
Date:   Wed, 20 May 2020 18:05:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520123819.GE157452@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20.05.2020 15:38, Jiri Olsa wrote:
> On Wed, May 13, 2020 at 11:03:03AM +0300, Alexey Budankov wrote:
>>
>> Introduce --ctl-fd[-ack] options to pass open file descriptors numbers
>> from command line. Extend perf-stat.txt file with --ctl-fd[-ack] options
>> description. Document possible usage model introduced by --ctl-fd[-ack]
>> options by providing example bash shell script.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/Documentation/perf-stat.txt | 40 ++++++++++++++++++++++++++
>>  tools/perf/builtin-stat.c              | 10 +++++++
>>  tools/perf/util/stat.h                 |  2 ++
>>  3 files changed, 52 insertions(+)
>>
>> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
>> index 3b91b30d7672..7f7a0019fbfc 100644
>> --- a/tools/perf/Documentation/perf-stat.txt
>> +++ b/tools/perf/Documentation/perf-stat.txt
>> @@ -164,6 +164,46 @@ with it.  --append may be used here.  Examples:
>>       3>results  perf stat --log-fd 3          -- $cmd
>>       3>>results perf stat --log-fd 3 --append -- $cmd
>>  
>> +--ctl-fd::
>> +--ctl-fd-ack::
>> +
>> +Listen on ctl-fd descriptor for command to control measurement ('enable': enable events,
>> +'disable': disable events). Optionally send control command completion ('ack') to fd-ack
>> +descriptor to synchronize with the controlling process. Example of bash shell script
>> +to enable and disable events during measurements:
>> +
>> +#!/bin/bash
>> +
>> +ctl_dir=/tmp/
>> +
>> +ctl_fifo=${ctl_dir}perf_ctl.fifo
>> +test -p ${ctl_fifo} && unlink ${ctl_fifo}
>> +mkfifo ${ctl_fifo}
>> +exec {ctl_fd}<>${ctl_fifo}
>> +
>> +ctl_ack_fifo=${ctl_dir}perf_ctl_ack.fifo
>> +test -p ${ctl_ack_fifo} && unlink ${ctl_ack_fifo}
>> +mkfifo ${ctl_ack_fifo}
>> +exec {ctl_fd_ack}<>${ctl_ack_fifo}
>> +
>> +perf stat -D -1 -e cpu-cycles -a -I 1000                \
>> +          --ctl-fd ${ctl_fd} --ctl-fd-ack ${ctl_fd_ack} \
>> +          -- sleep 30 &
>> +perf_pid=$!
>> +
>> +sleep 5  && echo 'enable' >&${ctl_fd} && read -u ${ctl_fd_ack} e1 && echo "enabled(${e1})"
>> +sleep 10 && echo 'disable' >&${ctl_fd} && read -u ${ctl_fd_ack} d1 && echo "disabled(${d1})"
>> +
>> +exec {ctl_fd_ack}>&-
>> +unlink ${ctl_ack_fifo}
>> +
>> +exec {ctl_fd}>&-
>> +unlink ${ctl_fifo}
>> +
>> +wait -n ${perf_pid}
>> +exit $?
>> +
>> +
>>  --pre::
>>  --post::
>>  	Pre and post measurement hooks, e.g.:
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index abea82a1ba24..88055aaf670f 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -187,6 +187,8 @@ static struct perf_stat_config stat_config = {
>>  	.metric_only_len	= METRIC_ONLY_LEN,
>>  	.walltime_nsecs_stats	= &walltime_nsecs_stats,
>>  	.big_num		= true,
>> +	.ctl_fd			= -1,
>> +	.ctl_fd_ack		= -1
>>  };
>>  
>>  static inline void diff_timespec(struct timespec *r, struct timespec *a,
>> @@ -984,6 +986,10 @@ static struct option stat_options[] = {
>>  		    "Use with 'percore' event qualifier to show the event "
>>  		    "counts of one hardware thread by sum up total hardware "
>>  		    "threads of same physical core"),
>> +	OPT_INTEGER(0, "ctl-fd", &stat_config.ctl_fd,
>> +		    "Listen on fd descriptor for command to control measurement ('enable': enable events, 'disable': disable events)"),
>> +	OPT_INTEGER(0, "ctl-fd-ack", &stat_config.ctl_fd_ack,
>> +		    "Send control command completion ('ack') to fd ack descriptor"),
>>  	OPT_END()
>>  };
>>  
>> @@ -2180,6 +2186,8 @@ int cmd_stat(int argc, const char **argv)
>>  	signal(SIGALRM, skip_signal);
>>  	signal(SIGABRT, skip_signal);
>>  
>> +	evlist__initialize_ctlfd(evsel_list, stat_config.ctl_fd, stat_config.ctl_fd_ack);
> 
> please check the return value

Accepted in v4.

~Alexey
