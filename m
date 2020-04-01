Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF54C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD3C2071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732298AbgDAQHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:07:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:6018 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgDAQHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:07:33 -0400
IronPort-SDR: jFfpH1Z+2ed/KKelmgGFEKiDGL/NyodNvNqCZgHeewpCoxC3ZeOdPofI0OxSvQniMtDXUSG/9k
 HLGGiYg1Iunw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 09:07:21 -0700
IronPort-SDR: 26Mh/4il0CeqDONtrBddi36G8ooIwKOshTckiqWBw49GE5QVDQ90R5qdM+YjDtgZCCVZPbsV3j
 8IrPCc3wXugw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,332,1580803200"; 
   d="scan'208";a="252677034"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 01 Apr 2020 09:07:21 -0700
Received: from [10.249.229.253] (abudanko-mobl.ccr.corp.intel.com [10.249.229.253])
        by linux.intel.com (Postfix) with ESMTP id 4118558077B;
        Wed,  1 Apr 2020 09:07:19 -0700 (PDT)
Subject: Re: [PATCH v1 0/8] perf: support resume and pause commands in stat
 and record modes
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <825a5132-b58d-c0b6-b050-5a6040386ec7@linux.intel.com>
 <20200401140106.GF2518490@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <2d117fd2-47dc-ead8-d12b-427a88115d0b@linux.intel.com>
Date:   Wed, 1 Apr 2020 19:07:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401140106.GF2518490@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 01.04.2020 17:01, Jiri Olsa wrote:
> On Fri, Mar 27, 2020 at 11:34:54AM +0300, Alexey Budankov wrote:
>>
>> The patch set implements handling of 'start paused', 'resume' and 'pause'
>> external control commands which can be provided for stat and record modes
>> of the tool from an external controlling process. 'start paused' command
>> can be used to postpone enabling of events in the beginning of a monitoring
>> session. 'resume' and 'pause' commands can be used to enable and disable
>> events correspondingly any time after the start of the session.
>>
>> The 'start paused', resume and 'pause' external control commands can be
>> used to focus measurement on specially selected time intervals of workload
>> execution. Focused measurement reduces tool intrusion and influence on
>> workload behavior, reduces distortion and amount of collected and stored
>> data, mitigates data accuracy loss because measurement and data capturing
>> happen only during intervals of interest.
>>
>> A controlling process can be a bash shell script [1], native executable or
>> any other language program that can directly work with file descriptors,
>> e.g. pipes [2], and spawn a process, specially the tool one.
>>
>> -D,--delay <val> option is extended with -1 value to skip events enabling
>> in the beginning of a monitoring session ('start paused' command). --ctl-fd
>> and --ctl-fd-ack command line options are introduced to provide the tool
>> with a pair of file descriptors to listen to 'resume' and 'pause' commands
>> and reply to an external controlling process on the completion of received
>> commands processing.
>>
>> The tool reads two byte control command message from ctl-fd descriptor,
>> handles the command and optionally replies two bytes acknowledgement message
>> to fd-ack descriptor, if it is specified on the command line. 'resume' command
>> is recognized as 'r' character message and 'pause' command is recognized as
>> 'p' character message both received from ctl-fd descriptor. Completion message
>> is 'a''\n' and sent to fd-ack descriptor.
>>
>> Bash script demonstrating simple use case follows:
>>
>> #!/bin/bash
>>
>> ctl_dir=/tmp/
>>
>> ctl_fifo=${ctl_dir}perf_ctl.fifo
>> test -p ${ctl_fifo} && unlink ${ctl_fifo}
>> mkfifo ${ctl_fifo} && exec {ctl_fd}<>${ctl_fifo}
>>
>> ctl_ack_fifo=${ctl_dir}perf_ctl_ack.fifo
>> test -p ${ctl_ack_fifo} && unlink ${ctl_ack_fifo}
>> mkfifo ${ctl_ack_fifo} && exec {ctl_fd_ack}<>${ctl_ack_fifo}
>>
>> perf stat -D -1 -e cpu-cycles -a -I 1000                \
>>           --ctl-fd ${ctl_fd} --ctl-fd-ack ${ctl_fd_ack} \
>>           -- sleep 40 &
> 
> hi,
> is fifo the best choice? do you need it for plug perf in somewhere?
> what's your use case for this?

fifo is just an example to demonstrate the simplest usage model
and evaluate the feature using basic shell environment.

Our use case is to fork/exec perf binary from a controlling c++ process
and the process creates, duplicates and passes open fds' numbers into
the forked perf process using --ctl-fd, --ctl-fd-ack command line arguments.

> 
> fifos seem complicated because you need to create 2 of them, would

The patch set allows omitting ack fd on the command line and in this case
perf tool will just receive and process commands from ctl fd without confirmation.
So it will also work without specifying --ctl-fd-ack option like this:

#!/bin/bash

ctl_dir=/tmp/

ctl_fifo=${ctl_dir}perf_ctl.fifo
test -p ${ctl_fifo} && unlink ${ctl_fifo}
mkfifo ${ctl_fifo} && exec {ctl_fd}<>${ctl_fifo}

perf stat -D -1 -e cpu-cycles -a -I 1000 --ctl-fd ${ctl_fd} -- sleep 40 &
perf_pid=$!

sleep 5  && echo 'r' >&${ctl_fd} && read -u ${ctl_fd_ack} r1 && echo "resumed(${r1})"
sleep 10 && echo 'p' >&${ctl_fd} && read -u ${ctl_fd_ack} p1 && echo "paused(${p1})"

exec {ctl_fd}>&- && unlink ${ctl_fifo}

wait -n ${perf_pid}
exit $?

> unix socket be better maybe? and do we really need that ack fd?

Tool reads from already open fd whose number is provided via --ctl-fd option.
Controlling process can create, open or pass objects of various types 
(anon pipe, fifo, unix or TCP socket, something else) as fds in the forked
perf process so unix sockets are likely already supported too.

For our use case ack fd is really required to make sure counters are really 
paused, resumed and synchronize in the controlling process on changed counters
state otherwise there will be races in the process's code.

> 
> also you could pass just path and perf could create fifos from them
> 
>   # perf stat --control-fifo /tmp/...
> 
> or to get really creazy, we could add option that would make perf
> to listen on socket or whatever and we would control it via another
> perf command ;-)
> 
>   # perf stat --control ....
>   control socket: /tmp/xxx
> 
>   # perf stat control -s /tmp/xxx disable
>   # perf stat control -s /tmp/xxx  enable
> 
> but ATM I can't see too much use for this, so would be great to
> know your usecase ;-)

Mentioned use cases and design approaches do make sense and have been
considered prior the patch set implementation. These use cases can be 
supported on demand on top of the changes provided by the patch set.
Extending stat and record modes with a pair of open fd numbers and its
processing is currently enough for our use cases.

Thanks,
Alexey

> 
> thanks,
> jirka
> 
