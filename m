Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D658C4332D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 03:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CC5206F9
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 03:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgCVDqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 23:46:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:29728 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727700AbgCVDqP (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 23:46:15 -0400
IronPort-SDR: Q7oM/iu5wL7A2TzNXVhwKvDgYPrpbQ4S6vk77nqM8aiCliK7eQpNoqh7ndLKXPhFYHmg41R9AG
 Vu2J1Nfv6kIw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2020 20:46:14 -0700
IronPort-SDR: 7qN0CZEiwWR/Ru1ObUomsLXS63ne1Y5GOd3jJWmfR/v2oYY41Y8oX6B3Zj5+BekzQut8yJy/j/
 sWRnmdDB8eYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,291,1580803200"; 
   d="scan'208";a="292271670"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.254.212.250]) ([10.254.212.250])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Mar 2020 20:46:10 -0700
Subject: Re: [PATCH 2/2] perf top: support hotkey to change sort order
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20200320072414.25551-1-yao.jin@linux.intel.com>
 <20200320072414.25551-2-yao.jin@linux.intel.com>
 <20200320135106.GB29833@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <813229ae-0ab4-5d23-e38a-846c6fccd642@linux.intel.com>
Date:   Sun, 22 Mar 2020 11:46:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200320135106.GB29833@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/20/2020 9:51 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Mar 20, 2020 at 03:24:14PM +0800, Jin Yao escreveu:
>> It would be nice if we can use a hotkey in perf top browser to
>> select a event for sorting.
>>
>> For example,
>> perf top --group -e cycles,instructions,cache-misses
>>
>> Samples
>>                  Overhead  Shared Object             Symbol
>>    40.03%  45.71%   0.03%  div                       [.] main
>>    20.46%  14.67%   0.21%  libc-2.27.so              [.] __random_r
>>    20.01%  19.54%   0.02%  libc-2.27.so              [.] __random
>>     9.68%  10.68%   0.00%  div                       [.] compute_flag
>>     4.32%   4.70%   0.00%  libc-2.27.so              [.] rand
>>     3.84%   3.43%   0.00%  div                       [.] rand@plt
>>     0.05%   0.05%   2.33%  libc-2.27.so              [.] __strcmp_sse2_unaligned
>>     0.04%   0.08%   2.43%  perf                      [.] perf_hpp__is_dynamic_en
>>     0.04%   0.02%   6.64%  perf                      [.] rb_next
>>     0.04%   0.01%   3.87%  perf                      [.] dso__find_symbol
>>     0.04%   0.04%   1.77%  perf                      [.] sort__dso_cmp
>>
>> When user press hotkey '2' (event index, starting from 0), it indicates
>> to sort output by the third event in group (cache-misses).
>>
>> Samples
>>                  Overhead  Shared Object               Symbol
>>     4.07%   1.28%   6.68%  perf                        [.] rb_next
>>     3.57%   3.98%   4.11%  perf                        [.] __hists__insert_output
>>     3.67%  11.24%   3.60%  perf                        [.] perf_hpp__is_dynamic_e
>>     3.67%   3.20%   3.20%  perf                        [.] hpp__sort_overhead
>>     0.81%   0.06%   3.01%  perf                        [.] dso__find_symbol
>>     1.62%   5.47%   2.51%  perf                        [.] hists__match
>>     2.70%   1.86%   2.47%  libc-2.27.so                [.] _int_malloc
>>     0.19%   0.00%   2.29%  [kernel]                    [k] copy_page
>>     0.41%   0.32%   1.98%  perf                        [.] hists__decay_entries
>>     1.84%   3.67%   1.68%  perf                        [.] sort__dso_cmp
>>     0.16%   0.00%   1.63%  [kernel]                    [k] clear_page_erms
>>
>> Now the output is sorted by cache-misses.
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/builtin-top.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
>> index 144043637cec..b39f6ffb874e 100644
>> --- a/tools/perf/builtin-top.c
>> +++ b/tools/perf/builtin-top.c
>> @@ -616,6 +616,7 @@ static void *display_thread_tui(void *arg)
>>   		.arg		= top,
>>   		.refresh	= top->delay_secs,
>>   	};
>> +	int ret;
>>   
>>   	/* In order to read symbols from other namespaces perf to  needs to call
>>   	 * setns(2).  This isn't permitted if the struct_fs has multiple users.
>> @@ -626,6 +627,7 @@ static void *display_thread_tui(void *arg)
>>   
>>   	prctl(PR_SET_NAME, "perf-top-UI", 0, 0, 0);
>>   
>> +repeat:
>>   	perf_top__sort_new_samples(top);
>>   
>>   	/*
>> @@ -638,13 +640,17 @@ static void *display_thread_tui(void *arg)
>>   		hists->uid_filter_str = top->record_opts.target.uid_str;
>>   	}
>>   
>> -	perf_evlist__tui_browse_hists(top->evlist, help, &hbt,
>> +	ret = perf_evlist__tui_browse_hists(top->evlist, help, &hbt,
>>   				      top->min_percent,
>>   				      &top->session->header.env,
>>   				      !top->record_opts.overwrite,
>>   				      &top->annotation_opts);
>>   
>> -	stop_top();
>> +	if (ret == K_RELOAD)
>> +		goto repeat;
>> +	else
>> +		stop_top();
>> +
> 
> That is really nice and small, but shouldn't we flush all the histograms
> that were in place, sorted by the previous key? I think we have a 'z'
> for zeroing samples that may be what we need, take a look, please,
> 
> - Arnaldo
> 

Set top->zero to true if return key is K_RELOAD. So that in 
perf_top__resort_hists(), it will delete hists entries by calling 
hists__delete_entries(hists).

+repeat:
         perf_top__sort_new_samples(top);

         /*
@@ -638,13 +640,18 @@ static void *display_thread_tui(void *arg)
                 hists->uid_filter_str = top->record_opts.target.uid_str;
         }

-       perf_evlist__tui_browse_hists(top->evlist, help, &hbt,
+       ret = perf_evlist__tui_browse_hists(top->evlist, help, &hbt,
                                       top->min_percent,
                                       &top->session->header.env,
                                       !top->record_opts.overwrite,
                                       &top->annotation_opts);

-       stop_top();
+       if (ret == K_RELOAD) {
+               top->zero = true;
+               goto repeat;
+       } else
+               stop_top();
+

Is this OK?

Thanks
Jin Yao

>>   	return NULL;
>>   }
>>   
>> -- 
>> 2.17.1
>>
> 
