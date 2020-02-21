Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC336C3566F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D5520722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbgBUXhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 18:37:55 -0500
Received: from mga17.intel.com ([192.55.52.151]:33763 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbgBUXhx (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 18:37:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 15:37:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,470,1574150400"; 
   d="scan'208";a="409286033"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.254.209.190]) ([10.254.209.190])
  by orsmga005.jf.intel.com with ESMTP; 21 Feb 2020 15:37:50 -0800
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
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <6bb8c073-4a10-8e49-05dc-819b671a875d@linux.intel.com>
Date:   Sat, 22 Feb 2020 07:37:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221144531.GA657629@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/2020 10:45 PM, Jiri Olsa wrote:
> On Fri, Feb 21, 2020 at 10:46:08AM +0800, Jin Yao wrote:
> 
> SNIP
> 
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/ui/browsers/hists.c | 51 +++++++++++++++++++++++++++++-----
>>   tools/perf/util/annotate.h     |  2 ++
>>   2 files changed, 46 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
>> index f36dee499320..5144528b2931 100644
>> --- a/tools/perf/ui/browsers/hists.c
>> +++ b/tools/perf/ui/browsers/hists.c
>> @@ -2465,13 +2465,47 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
>>   	return 0;
>>   }
>>   
>> +static struct symbol *new_annotate_sym(u64 addr, struct map *map,
>> +				       struct annotation_options *opts)
>> +{
>> +	struct symbol *sym;
>> +	struct annotated_source *src;
>> +	char name[64];
>> +
>> +	snprintf(name, sizeof(name), "%-#.*lx", BITS_PER_LONG / 4, addr);
>> +
>> +	sym = symbol__new(addr,
>> +			  opts->annotate_dummy_len ?
>> +			  opts->annotate_dummy_len : ANNOTATION_DUMMY_LEN,
> 
> I can't see annotate_dummy_len being set anywhere..
> 

Yes, annotate_dummy_len is not set in this patch. Currently we just use 
the default value. While maybe in future we will provide a perf report 
option or set it in perf config. Now I just leave an interface here.

Thanks
Jin Yao

> jirka
> 
