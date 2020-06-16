Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C22C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D498206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgFPG15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:27:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:51208 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgFPG15 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:27:57 -0400
IronPort-SDR: 5eOPHaDCTbsPzvF0hejHh4zbSMiWOwIg7OLlCUUd4GMTk7yd+rrjgfgb2Mf/Rmyq1JAxJ58JBG
 xfO9sgGG1iYw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 23:27:49 -0700
IronPort-SDR: A8zZRZHK9dTTHrJZtsTX7gURTIUSi6xJI4rIiFwT1pibBIYx3LfvFlvOjuWyLtrVmern4jZi8N
 l7qjvWyDgFUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="382778335"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2020 23:27:41 -0700
Subject: Re: [PATCH 0/2] Update CascadelakeX and SkylakeX events list
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, kan.liang@intel.com,
        "Jin, Yao" <yao.jin@intel.com>
References: <20200603021818.27028-1-yao.jin@linux.intel.com>
 <911b4132-d1a1-f3c4-a2ed-2fcfe9a28fc6@linux.intel.com>
 <CAP-5=fW3OCuVkQ8csYfHXj5c_pCSY5-6vDrj2r=MNDZmpo0f8g@mail.gmail.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <c7edd282-f58a-4efe-5961-6c1369b6b77b@linux.intel.com>
Date:   Tue, 16 Jun 2020 14:27:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAP-5=fW3OCuVkQ8csYfHXj5c_pCSY5-6vDrj2r=MNDZmpo0f8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian, Arnaldo,

On 6/16/2020 2:16 PM, Ian Rogers wrote:
> On Mon, Jun 15, 2020 at 6:00 PM Jin, Yao <yao.jin@linux.intel.com> wrote:
>>
>> Hi Andi,
>>
>> Can I get an ACK for this patchset?
>>
>> Thanks
>> Jin Yao
>>
>> On 6/3/2020 10:18 AM, Jin Yao wrote:
>>> This patchset updates CascadelakeX events to v1.08 and
>>> updates SkylakeX events to v1.21.
>>>
>>> The events have been tested on CascadelakeX and SkylakeX
>>> servers with latest perf/core branch.
> 
> Hi Jin Yao,
> 
> could you rebase this on Arnaldo's tmp.perf/core tree?
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf/core
> I tried using git am but get:
> Applying: perf vendor events: Update CascadelakeX events to v1.08
> error: patch fragment without header at line 279: @@ -213,14 +220,14 @@
> error: could not build fake ancestor
> Patch failed at 0001 perf vendor events: Update CascadelakeX events to v1.08
> 
> Thanks,
> Ian
> 

The patchset are applied OK on perf/core branch.

As far as I understand, the patch for posting should be based on perf/core branch, is it right?

Thanks
Jin Yao

>>> Jin Yao (2):
>>>     perf vendor events: Update CascadelakeX events to v1.08
>>>     perf vendor events: Update SkylakeX events to v1.21
>>>
>>>    .../arch/x86/cascadelakex/cache.json          |   28 +-
>>>    .../arch/x86/cascadelakex/clx-metrics.json    |  153 +-
>>>    .../arch/x86/cascadelakex/frontend.json       |   34 +
>>>    .../arch/x86/cascadelakex/memory.json         |  704 ++---
>>>    .../arch/x86/cascadelakex/other.json          | 1100 ++++----
>>>    .../arch/x86/cascadelakex/pipeline.json       |   10 -
>>>    .../arch/x86/cascadelakex/uncore-other.json   |   21 +
>>>    .../pmu-events/arch/x86/skylakex/cache.json   | 2348 +++++++++--------
>>>    .../arch/x86/skylakex/floating-point.json     |   96 +-
>>>    .../arch/x86/skylakex/frontend.json           |  656 ++---
>>>    .../pmu-events/arch/x86/skylakex/memory.json  | 1977 +++++++-------
>>>    .../pmu-events/arch/x86/skylakex/other.json   |  172 +-
>>>    .../arch/x86/skylakex/pipeline.json           | 1206 +++++----
>>>    .../arch/x86/skylakex/skx-metrics.json        |  141 +-
>>>    .../arch/x86/skylakex/uncore-memory.json      |   26 +-
>>>    .../arch/x86/skylakex/uncore-other.json       |  730 ++++-
>>>    .../arch/x86/skylakex/virtual-memory.json     |  358 +--
>>>    17 files changed, 5198 insertions(+), 4562 deletions(-)
>>>
