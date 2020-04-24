Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B728EC2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9332E20715
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgDXCqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 22:46:16 -0400
Received: from mga17.intel.com ([192.55.52.151]:10178 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgDXCqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:46:16 -0400
IronPort-SDR: Ek3EacB7RPeY9CBQrY1XOJ2rlIxnvXyx0vRMokItaZDGPNW0gCMTf6SvvK8/dIPHqUiLwZvL2R
 1bzQqYn0PJZw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 19:46:16 -0700
IronPort-SDR: fFqGCE8bJogeRWjJevLA+X/Q55LKy24BPWiLC3aTrj7yu9DseBFagquD1OUY/YJaemiThYiTeb
 fYe3AECb8adA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,310,1583222400"; 
   d="scan'208";a="366206939"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.151]) ([10.238.4.151])
  by fmsmga001.fm.intel.com with ESMTP; 23 Apr 2020 19:46:12 -0700
Subject: Re: [PATCH v2 00/11] perf metric fixes and test
To:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
References: <20200422220430.254014-1-irogers@google.com>
 <20200423112825.GD1136647@krava>
 <1dd2e280-d711-2dda-61b1-b81609af6467@linux.intel.com>
 <20200423140249.GA1199027@krava>
 <CAP-5=fUO5sA8g2qv=Bg5LSSbG3nnhm57cBR7PsraH9+thph5qQ@mail.gmail.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <3f88ebf8-633a-83b4-cd02-aca0922e1a6b@linux.intel.com>
Date:   Fri, 24 Apr 2020 10:46:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAP-5=fUO5sA8g2qv=Bg5LSSbG3nnhm57cBR7PsraH9+thph5qQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/23/2020 10:31 PM, Ian Rogers wrote:
> On Thu, Apr 23, 2020 at 7:03 AM Jiri Olsa <jolsa@redhat.com> wrote:
>>
>> On Thu, Apr 23, 2020 at 09:44:24PM +0800, Jin, Yao wrote:
>>> Hi Jiri,
>>>
>>> On 4/23/2020 7:28 PM, Jiri Olsa wrote:
>>>> On Wed, Apr 22, 2020 at 03:04:19PM -0700, Ian Rogers wrote:
>>>>> Add a test that all perf metrics (for your architecture) are
>>>>> parsable. Fix bugs in the expr parser and in x86 metrics. Untested on
>>>>> architectures other than x86.
>>>>>
>>>>> v2 adds Fixes tags to commit messages for when broken metrics were
>>>>>     first added. Adds a debug warning for division by zero in expr, and
>>>>>     adds a workaround for id values in the expr test necessary for
>>>>>     powerpc. It also fixes broken power8 and power9 metrics.
>>>>
>>>> looks good to me
>>>>
>>>> Jin Yao, is there a metric that's not working for you with this patchset
>>>> applied?
>>>>
>>>> thanks,
>>>> jirka
>>>>
>>>
>>> Let me look for a CLX for testing, but maybe need some time.
>>>
>>> BTW, suppose this patchset can work well, does it mean we will change the
>>> json file format in future?
>>>
>>> For example,
>>>
>>> before:
>>> cha@event\\=0x36\\\\\\
>>>
>>> after:
>>> cha@event\\=0x36\\
>>>
>>> "\\\\" are removed.
>>>
>>> If so, we need to change our event generation script.
>>
>> ok, maybe I got the wrong idea that the extra \\\\ were just
>> superfluous, what was the actual error there? and what's the
>> reason for that many '\' in there?
> 
> I believe they are superfluous and break even before the flex change.
> I commented on it here with a reproduction of a parse events error on
> skylake:
> https://lore.kernel.org/lkml/CAP-5=fUnWAycQehCJ9=btquV2c3DVDX+tTEc85H8py9Kfehq4w@mail.gmail.com/
> 
> Fixing the script that generates this would be great! With the test
> landed it should be much harder for this to be broken in the future.
> 
> Thanks,
> Ian
> 

Tested on CLX and the error disappeared.

BTW, I will post the latest version of event list once the testing is 
completed.

Thanks
Jin Yao

> 
>> jirka
>>
