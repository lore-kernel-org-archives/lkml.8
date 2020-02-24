Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDCBC35673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8522067D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgBXA2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 19:28:15 -0500
Received: from mga06.intel.com ([134.134.136.31]:61331 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgBXA2P (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 19:28:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 16:28:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,478,1574150400"; 
   d="scan'208";a="349808261"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.151]) ([10.238.4.151])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2020 16:28:11 -0800
Subject: Re: [PATCH v2 2/2] perf annotate: Support interactive annotation of
 code without symbols
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200221024608.1847-1-yao.jin@linux.intel.com>
 <20200221024608.1847-3-yao.jin@linux.intel.com>
 <20200221144531.GA657629@krava>
 <6bb8c073-4a10-8e49-05dc-819b671a875d@linux.intel.com>
 <20200223195030.GB16664@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <f5fe3519-3c16-7913-f422-ddc874678979@linux.intel.com>
Date:   Mon, 24 Feb 2020 08:28:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200223195030.GB16664@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/2020 3:50 AM, Jiri Olsa wrote:
> On Sat, Feb 22, 2020 at 07:37:49AM +0800, Jin, Yao wrote:
>>
>>
>> On 2/21/2020 10:45 PM, Jiri Olsa wrote:
>>> On Fri, Feb 21, 2020 at 10:46:08AM +0800, Jin Yao wrote:
>>>
>>> SNIP
>>>
>>>>
>>>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>>>> ---
>>>>    tools/perf/ui/browsers/hists.c | 51 +++++++++++++++++++++++++++++-----
>>>>    tools/perf/util/annotate.h     |  2 ++
>>>>    2 files changed, 46 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
>>>> index f36dee499320..5144528b2931 100644
>>>> --- a/tools/perf/ui/browsers/hists.c
>>>> +++ b/tools/perf/ui/browsers/hists.c
>>>> @@ -2465,13 +2465,47 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
>>>>    	return 0;
>>>>    }
>>>> +static struct symbol *new_annotate_sym(u64 addr, struct map *map,
>>>> +				       struct annotation_options *opts)
>>>> +{
>>>> +	struct symbol *sym;
>>>> +	struct annotated_source *src;
>>>> +	char name[64];
>>>> +
>>>> +	snprintf(name, sizeof(name), "%-#.*lx", BITS_PER_LONG / 4, addr);
>>>> +
>>>> +	sym = symbol__new(addr,
>>>> +			  opts->annotate_dummy_len ?
>>>> +			  opts->annotate_dummy_len : ANNOTATION_DUMMY_LEN,
>>>
>>> I can't see annotate_dummy_len being set anywhere..
>>>
>>
>> Yes, annotate_dummy_len is not set in this patch. Currently we just use the
>> default value. While maybe in future we will provide a perf report option or
>> set it in perf config. Now I just leave an interface here.
> 
> if that's just 'maybe in future we will provide' then please keep just the
> ANNOTATION_DUMMY_LEN, the abandoned opts->annotate_dummy_len var is confusing
> 
> thanks,
> jirka
> 

OK, I will keep just the ANNOTATION_DUMMY_LEN and remove the 
opts->annotate_dummy_len in next version.

Thanks
Jin Yao
