Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F3EC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC79208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgCYOZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:25:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:42723 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727620AbgCYOZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:25:43 -0400
IronPort-SDR: 0aLkYhUQi+VwFxxj0HxjaG3zk891wjJw2ojjykEDDhXJnU6uB3X+AUUGeiusx0+SJoPiNDjDFi
 V4LctI9L4cWQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 07:25:42 -0700
IronPort-SDR: htzfHXoUNkSPBbUSnLZHWBq9wNDEgBuzYWwWMQXGZksyQ0Thixhmdz5iYDavm1+rJ+cLyTgv8g
 0/tVzvrEYiLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; 
   d="scan'208";a="240631483"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by orsmga008.jf.intel.com with ESMTP; 25 Mar 2020 07:25:40 -0700
Subject: Re: [PATCH] perf tools: Add missing Intel CPU events to parser
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org
References: <20200324150443.28832-1-adrian.hunter@intel.com>
 <20200325103345.GA1856035@krava> <20200325131549.GB14102@kernel.org>
 <20200325135350.GA1888042@krava> <20200325142214.GD14102@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ea516b26-6249-e870-20bf-819ea1a2d2c2@intel.com>
Date:   Wed, 25 Mar 2020 16:24:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200325142214.GD14102@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/20 4:22 pm, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 25, 2020 at 02:53:50PM +0100, Jiri Olsa escreveu:
>> On Wed, Mar 25, 2020 at 10:15:49AM -0300, Arnaldo Carvalho de Melo wrote:
>>> Em Wed, Mar 25, 2020 at 11:33:45AM +0100, Jiri Olsa escreveu:
>>>> On Tue, Mar 24, 2020 at 05:04:43PM +0200, Adrian Hunter wrote:
>>>>> perf list expects CPU events to be parseable by name, e.g.
>>>
>>>>>     # perf list | grep el-capacity-read
>>>>>       el-capacity-read OR cpu/el-capacity-read/          [Kernel PMU event]
>>>
>>>>> But the event parser does not recognize them that way, e.g.
>>>
>>>>>     # perf test -v "Parse event"
>>>>>     <SNIP>
>>>>>     running test 54 'cycles//u'
>>>>>     running test 55 'cycles:k'
>>>>>     running test 0 'cpu/config=10,config1,config2=3,period=1000/u'
>>>>>     running test 1 'cpu/config=1,name=krava/u,cpu/config=2/u'
>>>>>     running test 2 'cpu/config=1,call-graph=fp,time,period=100000/,cpu/config=2,call-graph=no,time=0,period=2000/'
>>>>>     running test 3 'cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp'
>>>>>     -> cpu/event=0,umask=0x11/
>>>>>     -> cpu/event=0,umask=0x13/
>>>>>     -> cpu/event=0x54,umask=0x1/
>>>>>     failed to parse event 'el-capacity-read:u,cpu/event=el-capacity-read/u', err 1, str 'parser error'
>>>>>     event syntax error: 'el-capacity-read:u,cpu/event=el-capacity-read/u'
>>>>>                            \___ parser error test child finished with 1
>>>>>     ---- end ----
>>>>>     Parse event definition strings: FAILED!
>>>
>>>>> Fix by adding missing Intel CPU events to the event parser.
>>>>> Missing events were found by using:
>>>
>>>>>     grep -r EVENT_ATTR_STR arch/x86/events/intel/core.c
>>>>>
>>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>>
>>>> Acked-by: Jiri Olsa <jolsa@redhat.com>
>>>
>>> So, I'm not being able to reproduce this, what an I missing?
>>
>> I think you need to be on some really recent intel
>> which defines events which we did not covered yet
>> like el-capacity-write in icelake
> 
> That is why I tried with el-capacity, which is moved to the parser as
> well, I've replaced el-capacity-read, which I don't have in this Kaby
> Lake machine, with el-capacity, that is present:
> 
> [root@seventh ~]# perf list | grep el-capacity
>   el-capacity OR cpu/el-capacity/                    [Kernel PMU event]
> [root@seventh ~]#

I just checked that and it seems to be a "feature" of the parser that it
gets confused between el-capacity and el-capacity-read.

Making them explicit in parse-events.l makes the problem go away, but I
wonder now if the parser could be better in this regard.

Any ideas?
