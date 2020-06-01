Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7AFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27E9B206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgFAQKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:10:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:29708 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgFAQKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:10:40 -0400
IronPort-SDR: DWsjnQqXwoaQ/bfzlveifQpL0nch8I4/c/0GAalQoL4B7LjFCTWJKJ1NX3TBgPf8mdmbFpD+le
 tWS1OpMRDTqg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 09:10:38 -0700
IronPort-SDR: ZPJE5U+525shpNbMA5Dz+2ejoOqQBle4L0fAcJgpaaXBJs2S0OBulYLfWMcPU5XksttKdDkQBM
 dfyiHg3WV4LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,461,1583222400"; 
   d="scan'208";a="312000597"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Jun 2020 09:10:38 -0700
Received: from [10.249.230.65] (abudanko-mobl.ccr.corp.intel.com [10.249.230.65])
        by linux.intel.com (Postfix) with ESMTP id 7FAA9580378;
        Mon,  1 Jun 2020 09:10:36 -0700 (PDT)
Subject: Re: [PATCH v4 04/10] perf stat: factor out event handling loop into a
 function
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <653fe5f3-c986-a841-1ed8-0a7d2fa24c00@linux.intel.com>
 <5f42c6c5-c301-accd-928e-4304fb1c15d0@linux.intel.com>
 <20200531181905.GB881900@krava>
 <63f1e2dd-ca1d-125a-cb83-d89f40433edc@linux.intel.com>
Organization: Intel Corp.
Message-ID: <47d1cde8-5bc9-cdd3-6f04-b9c5a659f736@linux.intel.com>
Date:   Mon, 1 Jun 2020 19:10:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <63f1e2dd-ca1d-125a-cb83-d89f40433edc@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.06.2020 10:38, Alexey Budankov wrote:
> 
> On 31.05.2020 21:19, Jiri Olsa wrote:
>> On Mon, May 25, 2020 at 05:19:45PM +0300, Alexey Budankov wrote:
>>
>> SNIP
>>
>>> @@ -544,12 +598,10 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
<SNIP>
>>>  static int __run_perf_stat(int argc, const char **argv, int run_idx)
>>> +		dispatch_events(-1, &stat_config);
>>
>> hum, from the discussion we had on v3  I expected more smaller patches
>> with easy changes, so the change is more transparent and easy to review
>>
>> as I said before this part really makes me worried and needs to be as clear
>> as possible.. please introdce the new function first and replace the factored
>> places separately, also more verbose changelog would help ;-)
> 
> Ok. Will try to reshape the patch that way.

Please see v5.
It puts this refactoring part into several smaller consecutive changes to make
review and possible bisecting activity easier. Let me know if some other parts
of the patch set also require similar breakdown.

~Alexey

