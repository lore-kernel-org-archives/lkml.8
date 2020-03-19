Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759A2C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52AD320767
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgCSBkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 21:40:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:37900 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgCSBks (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 21:40:48 -0400
IronPort-SDR: N6QU4ROxhW9+dPU1noxjlhfweBqyry6vMO7vdOxxj/x0aBZsSlw32UA0gIW9DZsSi41szHzLSd
 UtjCkpON/Ycw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 18:40:48 -0700
IronPort-SDR: htIjTPfj0aP6OXwXi5SQwb3unCCY2yNChsp8GBR03loqMvPZy/teg1WHrjohxOtvYbUy2qhJ5w
 DhP77AlK0kWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,569,1574150400"; 
   d="scan'208";a="236801530"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.151]) ([10.238.4.151])
  by fmsmga007.fm.intel.com with ESMTP; 18 Mar 2020 18:40:45 -0700
Subject: Re: [PATCH v7 2/3] perf report: Support a new key to reload the
 browser
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20200220013616.19916-1-yao.jin@linux.intel.com>
 <20200220013616.19916-3-yao.jin@linux.intel.com>
 <20200318185238.GL11531@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <88c6ab5c-3daf-112d-e33e-f65f634fea88@linux.intel.com>
Date:   Thu, 19 Mar 2020 09:40:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318185238.GL11531@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/2020 2:52 AM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Feb 20, 2020 at 09:36:15AM +0800, Jin Yao escreveu:
>> Sometimes we may need to reload the browser to update the output since
>> some options are changed.
>>
>> This patch creates a new key K_RELOAD. Once the __cmd_report() returns
>> K_RELOAD, it would repeat the whole process, such as, read samples from
>> data file, sort the data and display in the browser.
>>
>>   v7:
>>   ---
>>   Rebase to perf/core, no other change.
>>
>>   v6:
>>   ---
>>   No change.
>>
>>   v5:
>>   ---
>>   1. Fix the 'make NO_SLANG=1' error. Define K_RELOAD in util/hist.h.
>>   2. Skip setup_sorting() in repeat path if last key is K_RELOAD.
>>
>>   v4:
>>   ---
>>   Need to quit in perf_evsel_menu__run if key is K_RELOAD.
>>
>>   v3:
>>   ---
>>   No change.
>>
>>   v2:
>>   ---
>>   This is a new patch created in v2.
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/builtin-report.c    | 6 +++---
>>   tools/perf/ui/browsers/hists.c | 1 +
>>   tools/perf/ui/keysyms.h        | 1 +
>>   tools/perf/util/hist.h         | 1 +
>>   4 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
>> index 862c7f8853dc..842ef92c3598 100644
>> --- a/tools/perf/builtin-report.c
>> +++ b/tools/perf/builtin-report.c
>> @@ -635,7 +635,7 @@ static int report__browse_hists(struct report *rep)
>>   		 * Usually "ret" is the last pressed key, and we only
>>   		 * care if the key notifies us to switch data file.
>>   		 */
>> -		if (ret != K_SWITCH_INPUT_DATA)
>> +		if (ret != K_SWITCH_INPUT_DATA && ret != K_RELOAD)
>>   			ret = 0;
>>   		break;
>>   	case 2:
>> @@ -1469,7 +1469,7 @@ int cmd_report(int argc, const char **argv)
>>   		sort_order = sort_tmp;
>>   	}
>>   
>> -	if ((last_key != K_SWITCH_INPUT_DATA) &&
>> +	if ((last_key != K_SWITCH_INPUT_DATA && last_key != K_RELOAD) &&
>>   	    (setup_sorting(session->evlist) < 0)) {
>>   		if (sort_order)
>>   			parse_options_usage(report_usage, options, "s", 1);
>> @@ -1548,7 +1548,7 @@ int cmd_report(int argc, const char **argv)
>>   	sort__setup_elide(stdout);
>>   
>>   	ret = __cmd_report(&report);
>> -	if (ret == K_SWITCH_INPUT_DATA) {
>> +	if (ret == K_SWITCH_INPUT_DATA || ret == K_RELOAD) {
>>   		perf_session__delete(session);
>>   		last_key = K_SWITCH_INPUT_DATA;
> 
> Are you sure this shouldn't be:
> 	
> 		last_key = ret;
> 
> ?
> 

Yes, it should not be. We can reuse original flow for processing 
K_SWITCH_INPUT_DATA.

> I'm applying it to test now anyway,
> 
> - Arnaldo
> 

Thanks!

Thanks
Jin Yao

>>   		goto repeat;
>> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
>> index f36dee499320..7c091fa51a5c 100644
>> --- a/tools/perf/ui/browsers/hists.c
>> +++ b/tools/perf/ui/browsers/hists.c
>> @@ -3440,6 +3440,7 @@ static int perf_evsel_menu__run(struct evsel_menu *menu,
>>   					pos = perf_evsel__prev(pos);
>>   				goto browse_hists;
>>   			case K_SWITCH_INPUT_DATA:
>> +			case K_RELOAD:
>>   			case 'q':
>>   			case CTRL('c'):
>>   				goto out;
>> diff --git a/tools/perf/ui/keysyms.h b/tools/perf/ui/keysyms.h
>> index fbfac29077f2..04cc4e5c031f 100644
>> --- a/tools/perf/ui/keysyms.h
>> +++ b/tools/perf/ui/keysyms.h
>> @@ -25,5 +25,6 @@
>>   #define K_ERROR	 -2
>>   #define K_RESIZE -3
>>   #define K_SWITCH_INPUT_DATA -4
>> +#define K_RELOAD -5
>>   
>>   #endif /* _PERF_KEYSYMS_H_ */
>> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
>> index 0aa63aeb58ec..bb994e030495 100644
>> --- a/tools/perf/util/hist.h
>> +++ b/tools/perf/util/hist.h
>> @@ -536,6 +536,7 @@ static inline int block_hists_tui_browse(struct block_hist *bh __maybe_unused,
>>   #define K_LEFT  -1000
>>   #define K_RIGHT -2000
>>   #define K_SWITCH_INPUT_DATA -3000
>> +#define K_RELOAD -4000
>>   #endif
>>   
>>   unsigned int hists__sort_list_width(struct hists *hists);
>> -- 
>> 2.17.1
>>
> 
