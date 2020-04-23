Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AE9C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18F4821569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgDWHv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:51:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:15587 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbgDWHvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:51:25 -0400
IronPort-SDR: zfJQnbgWlJ9P/yHgngSLguC0w6uAKYh6VJR8ts/mrx8n2b3uoxppx8nIiwq36irAsc+/dFBmLR
 XtF/6hdy7E7Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 00:51:24 -0700
IronPort-SDR: VZJ3h40CylMLMY4yzOF4dRiVGNw6kRdB1xKBOyS/9OL5eXseuoUuNTl2pA+bAdWCUxoG/qWyb1
 stSML4Hfoe5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,306,1583222400"; 
   d="scan'208";a="365930195"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.151]) ([10.238.4.151])
  by fmsmga001.fm.intel.com with ESMTP; 23 Apr 2020 00:51:19 -0700
Subject: Re: [PATCH 2/8] perf metrics: fix parse errors in cascade lake
 metrics
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
References: <20200422074809.160248-1-irogers@google.com>
 <20200422074809.160248-3-irogers@google.com>
 <20200422143840.GJ608746@tassilo.jf.intel.com>
 <CAP-5=fUnWAycQehCJ9=btquV2c3DVDX+tTEc85H8py9Kfehq4w@mail.gmail.com>
 <CAP-5=fUMFqiSFLbKA-XWStrePwxiYfq7Jk6mS9=F56Q9y-KVsA@mail.gmail.com>
 <46e803f3-80a4-0d37-9d39-b625b947ac7f@linux.intel.com>
 <cb5fcb4b-3ac6-66b5-9f9e-7943f4a6dadf@linux.intel.com>
 <CAP-5=fXVF_ExxVuiivF0JY3MwgxrQZqyFoPwn-p7DPf6Gbdh0g@mail.gmail.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <abec8f03-ecb5-9bfe-c8ab-2c6d2aad2a60@linux.intel.com>
Date:   Thu, 23 Apr 2020 15:51:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAP-5=fXVF_ExxVuiivF0JY3MwgxrQZqyFoPwn-p7DPf6Gbdh0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On 4/23/2020 2:09 PM, Ian Rogers wrote:
> On Wed, Apr 22, 2020 at 10:54 PM Jin, Yao <yao.jin@linux.intel.com> wrote:
>>
>> Hi Jiri,
>>
>> Bisected to this commit which introduced the regression.
>>
>> 26226a97724d ("perf expr: Move expr lexer to flex")
>>
>> Would you like to look at that?
> 
> Hi Jin,
> 
> that commit breaks parsing of things like ','. See fixes in this patch
> set such as:
> https://lore.kernel.org/lkml/20200422220430.254014-5-irogers@google.com/
> Fixing the lex issues then exposes other bugs that need to be
> corrected in the json. I've added Fixes to the commit message of:
> https://lore.kernel.org/lkml/20200422220430.254014-3-irogers@google.com/
> https://lore.kernel.org/lkml/20200422220430.254014-4-irogers@google.com/
> and would be glad of a review. If we can land:
> https://lore.kernel.org/lkml/20200422220430.254014-12-irogers@google.com/
> then expr as the source of parse errors can go away :-) The next
> problem is the parse events code, but some of that logic is dependent
> on the machine it is running on. It'd be good to add a test that
> parsed events code can handle the events in metrics too, filtering out
> things like duration_time that are special to metrics.
> 
> Thanks,
> Ian
> 

Only with the fix 
"https://lore.kernel.org/lkml/20200422220430.254014-5-irogers@google.com/" 
(without other json modifications), the issue was still there.

localhost:~ # perf stat -M DRAM_Read_Latency
event syntax error: 
'../event=0x36,,umask=0x21/,cha/event=0x35,cha_0/event=0x0/}:W,duration_time'
                                   \___ parser error

  Usage: perf stat [<options>] [<command>]

     -M, --metrics <metric/metric group list>
                           monitor specified metrics or metric groups 
(separated by ,)

So you added other commits which changed the json to let the parse work. 
But I don't know if we have to do with this way because it should be a 
regression issue.

In my opinion, we'd better fix the issue in 26226a97724d ("perf expr: 
Move expr lexer to flex") and try not to change the json if possible.

Thanks
Jin Yao

>> Thanks
>> Jin Yao
>>
>> On 4/23/2020 9:08 AM, Jin, Yao wrote:
>>>
>>>
>>> On 4/23/2020 12:18 AM, Ian Rogers wrote:
>>>> On Wed, Apr 22, 2020 at 8:34 AM Ian Rogers <irogers@google.com> wrote:
>>>>>
>>>>> On Wed, Apr 22, 2020 at 7:38 AM Andi Kleen <ak@linux.intel.com> wrote:
>>>>>>
>>>>>> On Wed, Apr 22, 2020 at 12:48:03AM -0700, Ian Rogers wrote:
>>>>>>> Remove over escaping with \\.
>>>>>>> Remove extraneous if 1 if 0 == 1 else 0 else 0.
>>>>>>
>>>>>> So where do these parse errors happen exactly? Some earlier
>>>>>> patches introduced them as regressions?
>>>>>
>>>>> I'll work to track down a Fixes tag. I can repro the Skylakex errors
>>>>> without the test in this series, by doing:
>>>>>
>>>>> $ perf stat -M DRAM_Read_Latency sleep 1
>>>>> Error:
>>>>> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
>>>>> for event (cha/event=0x36\,uma
>>>>> sk=0x21/).
>>>>> /bin/dmesg | grep -i perf may provide additional information.
>>>>>
>>>
>>> I also think some patches introduced this regression. When we rollback
>>> to commit 61ec07f5917e (perf vendor events intel: Update all the Intel
>>> JSON metrics from TMAM 3.6.), there is no this error on CLX.
>>>
>>> Thanks
>>> Jin Yao
>>>
>>>>> This was just the escaping issue. I'm less clear on the other cascade
>>>>> lake issue, and it is a bit more work for me to test on cascade lake.
>>>>> What is "if 1 if 0 == 1 else 0 else 0" trying to do? Perhaps hunting
>>>>> for the Fixes will let me know, but it looks like a copy-paste error.
>>>>>
>>>>>> The original metrics worked without parse errors as far as I know.
>>>>>
>>>>> The skylake issue above repros on 5.2.17 and so it seems like it is
>>>>> broken for a while. The test in this series will prevent this in the
>>>>> future, but without this patch that test fails.
>>>>
>>>> The parse errors were introduced with the metrics, so they've never
>>>> worked:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=fd5500989c8f3c3944ac0a144be04bae2506f7ba
>>>>
>>>>
>>>> I will send out a v2 with Fixes in the commit message but wanted to
>>>> wait in case there was any more feedback. In particular the fixes to
>>>> the new test and expr parser lex code. The lex code wasn't broken at
>>>> the time the metrics were added and should be working again after this
>>>> patch set.
>>>>
>>>> Thanks,
>>>> Ian
>>>>
>>>>>> If it fixes something earlier it would need Fixes: tags.
>>>>>
>>>>> Working on it. Thanks for the input!
>>>>>
>>>>> Ian
>>>>>
>>>>>> -Andi
