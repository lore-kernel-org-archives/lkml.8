Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96897C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6594820789
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406227AbgFYSoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 14:44:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:33033 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728204AbgFYSoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 14:44:00 -0400
IronPort-SDR: rIUllYmNahFG2m25SkZOMUB7eLy6lRlx+DbnbLOlLGyWA7QfPYnUe96q0BbUPdNOOFswlVZIVF
 efSOtjdcsoGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="124682849"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="124682849"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 11:44:00 -0700
IronPort-SDR: 7VFDsXUtH/V25cueaVbWkXpwsCSEhRRssv1kpfVQ8dl/rAyQ5IkKFTU+g1VaMJrYqNZ0OhR3jG
 /fs6vLc62dpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="319813773"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Jun 2020 11:44:00 -0700
Received: from [10.249.229.54] (abudanko-mobl.ccr.corp.intel.com [10.249.229.54])
        by linux.intel.com (Postfix) with ESMTP id 3AE3C5804B4;
        Thu, 25 Jun 2020 11:43:55 -0700 (PDT)
Subject: Re: [PATCH v8 04/13] perf stat: factor out body of event handling
 loop for system wide
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
 <eeeff629-925a-530b-9803-f274337ae473@linux.intel.com>
 <20200623145630.GK2619137@krava>
 <51d5511a-e9a7-2865-c81b-57488e820f8d@linux.intel.com>
 <20200625121719.GI2719003@krava>
 <fdaba173-a046-beae-f8f2-07840c879475@linux.intel.com>
 <20200625171300.GK2719003@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <78a2f7cf-3f5c-decc-fd91-5a2c38548f52@linux.intel.com>
Date:   Thu, 25 Jun 2020 21:43:54 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625171300.GK2719003@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25.06.2020 20:13, Jiri Olsa wrote:
> On Thu, Jun 25, 2020 at 07:01:08PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>>>>
>>>> Well, ok.
>>>>
>>>> I will rename process_interval() to __process_interval() and
>>>> then print_interval() to process_interval().
>>>>
>>>> Regarding timeout let's have it like this:
>>>>
>>>> static bool process_timeout(int timeout)
>>>> {
>>>> 	return timeout ? true : false;
>>>> }
>>>
>>> can't this just stay as value check after finished poll?
>>>
>>> 	if (timeout)
>>> 		break;
>>>
>>> and then separate call to process_interval(interval, times)?
>>
>> Like this? Still makes sense to have it in a single function.
>>
>> static bool process_timing_settings(int timeout, unsigned int interval, int *times)
>> {
>> 	bool res = timeout ? true : false;
>>         if (!res)
>>  		res = process_interval(interval, times);
>>  	return res;
>> }
> 
> I don't see the connection between timeout and interval
> IMO this just complicates things, is there a problem to
> keep it separated as it is now?

Not a problem. Can duplicate it in dispatch_events().

~Alexey
