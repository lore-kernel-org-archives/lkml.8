Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C70C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AF4C20728
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgDWNoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:44:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:9257 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728133AbgDWNod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 09:44:33 -0400
IronPort-SDR: XUBracUH37YRJYZ7P6IhjLIWnWX3/dJ4/ViMNpbsw8yTK4ese53SqvxwuW/WB8/bVa8lfXvhC4
 Hze8exDh47XQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 06:44:32 -0700
IronPort-SDR: WHdWbl2GqfQM+K45kBrFbrokU8MzOLK4SpFfchLdHtEh00ib73GswQ9PAtRpSb6MyMeLJqLSCQ
 h1DcKTt/BS/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,307,1583222400"; 
   d="scan'208";a="366005248"
Received: from yulin-mobl.ccr.corp.intel.com (HELO [10.254.208.30]) ([10.254.208.30])
  by fmsmga001.fm.intel.com with ESMTP; 23 Apr 2020 06:44:26 -0700
Subject: Re: [PATCH v2 00/11] perf metric fixes and test
To:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>
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
        Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
References: <20200422220430.254014-1-irogers@google.com>
 <20200423112825.GD1136647@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <1dd2e280-d711-2dda-61b1-b81609af6467@linux.intel.com>
Date:   Thu, 23 Apr 2020 21:44:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423112825.GD1136647@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 4/23/2020 7:28 PM, Jiri Olsa wrote:
> On Wed, Apr 22, 2020 at 03:04:19PM -0700, Ian Rogers wrote:
>> Add a test that all perf metrics (for your architecture) are
>> parsable. Fix bugs in the expr parser and in x86 metrics. Untested on
>> architectures other than x86.
>>
>> v2 adds Fixes tags to commit messages for when broken metrics were
>>    first added. Adds a debug warning for division by zero in expr, and
>>    adds a workaround for id values in the expr test necessary for
>>    powerpc. It also fixes broken power8 and power9 metrics.
> 
> looks good to me
> 
> Jin Yao, is there a metric that's not working for you with this patchset
> applied?
> 
> thanks,
> jirka
> 

Let me look for a CLX for testing, but maybe need some time.

BTW, suppose this patchset can work well, does it mean we will change 
the json file format in future?

For example,

before:
cha@event\\=0x36\\\\\\

after:
cha@event\\=0x36\\

"\\\\" are removed.

If so, we need to change our event generation script.

Thanks
Jin Yao

>>
>> Ian Rogers (11):
>>    perf expr: unlimited escaped characters in a symbol
>>    perf metrics: fix parse errors in cascade lake metrics
>>    perf metrics: fix parse errors in skylake metrics
>>    perf expr: allow ',' to be an other token
>>    perf expr: increase max other
>>    perf expr: parse numbers as doubles
>>    perf expr: debug lex if debugging yacc
>>    perf metrics: fix parse errors in power8 metrics
>>    perf metrics: fix parse errors in power9 metrics
>>    perf expr: print a debug message for division by zero
>>    perf test: add expr test for pmu metrics
>>
>>   .../arch/powerpc/power8/metrics.json          |  4 +-
>>   .../arch/powerpc/power9/metrics.json          |  2 +-
>>   .../arch/x86/cascadelakex/clx-metrics.json    | 10 +-
>>   .../arch/x86/skylakex/skx-metrics.json        |  4 +-
>>   tools/perf/tests/builtin-test.c               |  5 +
>>   tools/perf/tests/expr.c                       | 96 ++++++++++++++++++-
>>   tools/perf/tests/tests.h                      |  2 +
>>   tools/perf/util/expr.c                        |  1 +
>>   tools/perf/util/expr.h                        |  2 +-
>>   tools/perf/util/expr.l                        | 16 ++--
>>   tools/perf/util/expr.y                        | 16 +++-
>>   11 files changed, 135 insertions(+), 23 deletions(-)
>>
>> -- 
>> 2.26.2.303.gf8c07b1a785-goog
>>
> 
