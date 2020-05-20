Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19C6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C97206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgETPV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:21:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:50125 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgETPV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:21:28 -0400
IronPort-SDR: xl7P38bRimQ5E/biykcrN1G+mkARblP6QpVLF1IRikvOKnMGwpwaufGEa6ueRNZiin4cmnQ8e8
 xOJCj0ZzTscw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 08:21:26 -0700
IronPort-SDR: oDJDMK0rHWpZV0Lh1+EcD41Rt3g/1p1wBflN7dT+77Mf/swjq6IXd2kDBrDo3PVIUZc8lL6kYJ
 t/hyMiwHDl1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; 
   d="scan'208";a="264718095"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 20 May 2020 08:21:25 -0700
Received: from [10.249.231.6] (abudanko-mobl.ccr.corp.intel.com [10.249.231.6])
        by linux.intel.com (Postfix) with ESMTP id 532C9580100;
        Wed, 20 May 2020 08:21:23 -0700 (PDT)
Subject: Re: [PATCH v3 9/9] perf record: introduce --ctl-fd[-ack] options
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <eb38e9e5-754f-d410-1d9b-e26b702d51b7@linux.intel.com>
 <8df14d46-42c6-2f14-8842-5d0f40a78fbb@linux.intel.com>
 <20200520123842.GH157452@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <b3ace8d1-68c4-9da7-c78f-382cf6ce61a9@linux.intel.com>
Date:   Wed, 20 May 2020 18:21:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520123842.GH157452@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20.05.2020 15:38, Jiri Olsa wrote:
> On Wed, May 13, 2020 at 11:05:08AM +0300, Alexey Budankov wrote:
>>
>> Introduce --ctl-fd[-ack] options to pass open file descriptors numbers
>> from command line. Extend perf-record.txt file with --ctl-fd[-ack]
>> options description. Document possible usage model introduced by
>> --ctl-fd[-ack] options by providing example bash shell script.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/Documentation/perf-record.txt | 39 ++++++++++++++++++++++++
>>  tools/perf/builtin-record.c              |  9 ++++++
>>  tools/perf/util/record.h                 |  2 ++
>>  3 files changed, 50 insertions(+)
>>
>> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
>> index c2c4ce7ccee2..5c012cfe68a4 100644
>> --- a/tools/perf/Documentation/perf-record.txt
>> +++ b/tools/perf/Documentation/perf-record.txt
>> @@ -614,6 +614,45 @@ appended unit character - B/K/M/G
>>  	The number of threads to run when synthesizing events for existing processes.
>>  	By default, the number of threads equals 1.
>>  
>> +--ctl-fd::
>> +--ctl-fd-ack::
>> +Listen on ctl-fd descriptor for command to control measurement ('enable': enable events,
>> +'disable': disable events. Optionally send control command completion ('ack') to fd-ack
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
>> +perf record -D -1 -e cpu-cycles -a                        \
>> +            --ctl-fd ${ctl_fd} --ctl-fd-ack ${ctl_fd_ack} \
>> +            -- sleep 30 &
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
>>  SEE ALSO
>>  --------
>>  linkperf:perf-stat[1], linkperf:perf-list[1], linkperf:perf-intel-pt[1]
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index 72f388623364..218cfaafaf10 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -1713,6 +1713,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>  		perf_evlist__start_workload(rec->evlist);
>>  	}
>>  
>> +	evlist__initialize_ctlfd(rec->evlist, opts->ctl_fd, opts->ctl_fd_ack);
> 
> please check return value in here

Accepted in v4.

~Alexey
