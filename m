Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED0FC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC3720714
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgEKXHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 19:07:48 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:35407 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbgEKXHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 19:07:48 -0400
Received: from [192.168.0.3] (ip5f5af07e.dynamic.kabel-deutschland.de [95.90.240.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id A02A82002EE22;
        Tue, 12 May 2020 01:07:44 +0200 (CEST)
Subject: Re: ftrace: function radeon_init not traceable
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
References: <01e29852-c9db-8181-e4fa-dda50f774cf6@molgen.mpg.de>
 <20200511145812.7206b095@gandalf.local.home>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <d38aacb6-58ef-b1e5-431b-c945380d20cc@molgen.mpg.de>
Date:   Tue, 12 May 2020 01:07:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200511145812.7206b095@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Steven,


Thank you for your quick response.

Am 11.05.20 um 20:58 schrieb Steven Rostedt:
> On Sat, 9 May 2020 12:16:30 +0200 Paul Menzel wrote:

>> Linux master and Linux 5.6.7 (from Debian Sid/unstable) are used.
>>
>> Instrumenting Linux’ start-up time, I’d like to trace the init function
>> of the Radeon graphics driver `radeon_init()` (built as a module).
>>
>>       drivers/gpu/drm/radeon/radeon_drv.c:static int __init radeon_init(void)
>>       drivers/gpu/drm/radeon/radeon_drv.c:module_init(radeon_init);
>>
>> With `initcall_debug` I can see:
>>
>>       [    1.079920] calling  radeon_init+0x0/0x1000 [radeon] @ 138
>>       [    1.663200] initcall radeon_init+0x0/0x1000 [radeon] returned 0
>> after 129346 usecs
>>
>> With `function_graph` as the trace, I am adding the string below to the
>> Linux kernel CLI.
>>
>>       initcall_debug log_buf_len=32M trace_buf_size=57074K trace_clock=global trace_options=nooverwrite,funcgraph-abstime,funcgraph-cpu,funcgraph-duration,funcgraph-proc,funcgraph-tail,nofuncgraph-overhead,context-info,graph-time ftrace=function_graph ftrace_graph_max_depth=1 ftrace_graph_filter=radeon_init
>>
>> But ftrace “rejects” that:
>>
>>       [    0.075538] ftrace: allocating 30958 entries in 61 pages
>>       [    0.084542] ftrace: allocated 61 pages with 5 groups
>>       [    0.094184] ftrace: function radeon_init not traceable
>>
>> I believe it worked in the past. Is there a way to trace that init function?
> 
> Did it every work for modules? radeon_init() isn't in the symbol table at
> boot up.
> 
> [   15.066951] systemd-journald[124]: Successfully sent stream file descriptor to service manager.
> [   15.098265] hub 1-0:1.0: USB hub found
> [   15.104006] systemd-journald[124]: Successfully sent stream file descriptor to service manager.
> [   15.112965] hub 1-0:1.0: 2 ports detected
> [   15.118116] probe of 1-0:1.0 returned 1 after 19873 usecs
> [   15.124007] calling  radeon_init+0x0/0x1000 [radeon] @ 133
> 
> The radeon_init is called after systemd is running, so it is definitely
> from a module.
> 
> Perhaps you had it built in before?

You are right. Probably I did. Can you suggest how to set up ftrace to 
trace a module?

>> Despite the function not being traceable, the trace file is still
>> filled. I’d would have expected to be empty.
>>
>> ```
>> # tracer: function_graph
>> #
>> #     TIME        CPU  TASK/PID         DURATION FUNCTION CALLS
>> #      |          |     |    |           |   |                     |   |     |   |
>>       2.910887 |   0)    <idle>-0    |   2.662 us    |  local_touch_nmi();
>>       2.910888 |   0)    <idle>-0    |   0.497 us    |  local_touch_nmi();
>>       2.910888 |   0)    <idle>-0    |   0.346 us    |  local_touch_nmi();
>>       2.910888 |   1)   systemd-1    |   1.440 us    |  __text_poke();
>>       2.910888 |   1)   systemd-1    |   0.588 us    |  __text_poke();
>>       2.910888 |   1)   systemd-1    |   0.556 us    |  __text_poke();
>>       2.910888 |   1)   systemd-1    |   0.489 us    |  __text_poke();
>> […]
>>       2.910889 |   1)   systemd-1    |   0.530 us    |  __text_poke();
>>       2.910889 |   0)    <idle>-0    |   0.473 us    |  do_sync_core();
>>       2.910889 |   1)   systemd-1    |   0.572 us    |  do_sync_core();
>>       2.910889 |   0)    <idle>-0    |   0.365 us    | arch_cpu_idle_enter();
>>       2.910889 |   1)   systemd-1    |   0.830 us    |  __text_poke();
>>       2.910889 |   0)    <idle>-0    | ! 278.143 us  |  arch_cpu_idle();
>>       2.910889 |   1)   systemd-1    |   0.582 us    |  __text_poke();
>> […]
>> ```
> 
> Probably because the filtering failed, so there is no filter.

Is that the intended behavior? Or should nothing be traced?


Kind regards,

Paul
